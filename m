Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB73F37956F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhEJRZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:25:16 -0400
Received: from mail.hallyn.com ([178.63.66.53]:55856 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhEJRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:24:58 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id D8F95B57; Mon, 10 May 2021 12:23:51 -0500 (CDT)
Date:   Mon, 10 May 2021 12:23:51 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, serge@hallyn.com
Subject: Re: [PATCH v2] userns: automatically split user namespace extent
Message-ID: <20210510172351.GA19918@mail.hallyn.com>
References: <20201203150252.1229077-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203150252.1229077-1-gscrivan@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 04:02:52PM +0100, Giuseppe Scrivano wrote:
> writing to the id map fails when an extent overlaps multiple mappings
> in the parent user namespace, e.g.:
> 
> $ cat /proc/self/uid_map
>          0       1000          1
>          1     100000      65536
> $ unshare -U sleep 100 &
> [1] 1029703
> $ printf "0 0 100\n" | tee /proc/$!/uid_map
> 0 0 100
> tee: /proc/1029703/uid_map: Operation not permitted
> 
> To prevent it from happening, automatically split an extent so that
> each portion fits in one extent in the parent user namespace.
> 
> $ cat /proc/self/uid_map
>          0       1000          1
>          1     110000      65536
> $ unshare -U sleep 100 &
> [1] 1552
> $ printf "0 0 100\n" | tee /proc/$!/uid_map
> 0 0 100
> $ cat /proc/$!/uid_map
>          0          0          1
>          1          1         99
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

The patch on the whole looks great, easy to reason about.  But I have
one question below:

> ---
> v2:
> - move the split logic when the extent are mapped to the parent map to
>   reduce lookup complexity.
> 
> v1: https://lkml.kernel.org/lkml/20201126100839.381415-1-gscrivan@redhat.com
> 
>  kernel/user_namespace.c | 79 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 87804e0371fe..550612c6e794 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -312,6 +312,55 @@ static u32 map_id_down(struct uid_gid_map *map, u32 id)
>  	return map_id_range_down(map, id, 1);
>  }
>  
> +/**
> + * find_and_split_extent_down - Find lower_first for the target extent
> + * using the specified map.
> + * If the extent doesn't fit in a single lower extent, split target and
> + * write the remaining IDs (first and count) to the overflow extent.
> + * If no overflow happens, overflow->count is set to 0.
> + */
> +static int find_and_split_extent_down(struct uid_gid_map *map,
> +				       struct uid_gid_extent *target,
> +				       struct uid_gid_extent *overflow)
> +{
> +	unsigned int extents = map->nr_extents;
> +	u32 lower_first = target->lower_first;
> +	struct uid_gid_extent *extent;
> +	u32 off, available;
> +
> +	overflow->count = 0;
> +
> +	/* Find the lower extent that includes the first ID.  */
> +	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> +		extent = map_id_range_down_base(extents, map, lower_first, 1);
> +	else
> +		extent = map_id_range_down_max(extents, map, lower_first, 1);
> +
> +	/* Could not map the first ID in the extent.  */
> +	if (extent == NULL)
> +		return -EPERM;
> +
> +	/* Offset of lower_first in the lower extent.  */
> +	off = target->lower_first - extent->first;
> +
> +	/* How many IDs are available in the lower extent?  */
> +	available = extent->count - off;
> +
> +	/* Requesting more IDs than available in the lower extent.  */
> +	if (target->count > available) {
> +		/* Move the remaining IDs to the overflow extent.  */
> +		overflow->first = target->first + available;
> +		overflow->lower_first = target->lower_first + available;
> +		overflow->count = target->count - available;
> +
> +		/* Shrink the initial extent to what is available.  */
> +		target->count = available;
> +	}
> +
> +	target->lower_first = extent->lower_first + off;
> +	return 0;
> +}
> +
>  /**
>   * map_id_up_base - Find idmap via binary search in static extent array.
>   * Can only be called if number of mappings is equal or less than
> @@ -749,6 +798,7 @@ static bool mappings_overlap(struct uid_gid_map *new_map,
>   * insert_extent - Safely insert a new idmap extent into struct uid_gid_map.
>   * Takes care to allocate a 4K block of memory if the number of mappings exceeds
>   * UID_GID_MAP_MAX_BASE_EXTENTS.
> + * The extent is appended at the position map->nr_extents.
>   */
>  static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
>  {
> @@ -968,30 +1018,37 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  	if (!new_idmap_permitted(file, ns, cap_setid, &new_map))
>  		goto out;
>  
> -	ret = -EPERM;
>  	/* Map the lower ids from the parent user namespace to the
>  	 * kernel global id space.
>  	 */
>  	for (idx = 0; idx < new_map.nr_extents; idx++) {
> +		struct uid_gid_extent overflow;
>  		struct uid_gid_extent *e;
> -		u32 lower_first;
>  
>  		if (new_map.nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
>  			e = &new_map.extent[idx];
>  		else
>  			e = &new_map.forward[idx];
>  
> -		lower_first = map_id_range_down(parent_map,
> -						e->lower_first,
> -						e->count);
> -
> -		/* Fail if we can not map the specified extent to
> -		 * the kernel global id space.
> -		 */
> -		if (lower_first == (u32) -1)
> +		ret = find_and_split_extent_down(parent_map, e, &overflow);
> +		if (ret < 0)
>  			goto out;
>  
> -		e->lower_first = lower_first;
> +		/* If the extent doesn't fit in a single lower extent,
> +		 * move what could not be mapped to a new extent.
> +		 * The new extent is appended to the existing ones in
> +		 * new_map, it will be checked again and if necessary it
> +		 * is split further.
> +		 */
> +		if (overflow.count > 0) {
> +			if (new_map.nr_extents == UID_GID_MAP_MAX_EXTENTS) {

Why are you doing this?  The insert_extent() will automatically extend it
if needed, right?  So this condition should be fine?

> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			ret = insert_extent(&new_map, &overflow);
> +			if (ret < 0)
> +				goto out;
> +		}
>  	}
>  
>  	/*
> -- 
> 2.28.0
> 
