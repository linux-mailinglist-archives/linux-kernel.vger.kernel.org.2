Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAD39BB08
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFDOnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhFDOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622817685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GT7Yzgt8GtEl514NLLVf2OF8ucixCZe8MHpPE+Hu6sc=;
        b=MOwU/00toPc0vQt8McPOr/ojZ6LaYWaXyY3a0khBQvGULtN+HeMpyXclqsJ9ynU2XuGCqY
        +ZsgeIqTtjHrgh0HGtwkmU4adIUBWO9YP0Y/HKyB4MVv42ymT4JC1u277Lw+cy8ia4qiqu
        17ABu3MzwPBnMg3++q4U4SgWAnnfiFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-XBEaa6fxMoCQ2KkCwVz77g-1; Fri, 04 Jun 2021 10:41:24 -0400
X-MC-Unique: XBEaa6fxMoCQ2KkCwVz77g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02C478042AE;
        Fri,  4 Jun 2021 14:41:23 +0000 (UTC)
Received: from localhost (ovpn-113-138.ams2.redhat.com [10.36.113.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20D935D705;
        Fri,  4 Jun 2021 14:41:21 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     ebiederm@xmission.com, christian.brauner@ubuntu.com
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] userns: automatically split user namespace extent
References: <20201203150252.1229077-1-gscrivan@redhat.com>
        <20210510172351.GA19918@mail.hallyn.com>
        <20210510185715.GA20897@mail.hallyn.com>
Date:   Fri, 04 Jun 2021 16:41:19 +0200
In-Reply-To: <20210510185715.GA20897@mail.hallyn.com> (Serge E. Hallyn's
        message of "Mon, 10 May 2021 13:57:15 -0500")
Message-ID: <87h7idbskw.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian, Eric,

are you fine with this patch or is there anything more you'd like me to
change?

Thanks,
Giuseppe



"Serge E. Hallyn" <serge@hallyn.com> writes:

> On Mon, May 10, 2021 at 12:23:51PM -0500, Serge E. Hallyn wrote:
>> On Thu, Dec 03, 2020 at 04:02:52PM +0100, Giuseppe Scrivano wrote:
>> > writing to the id map fails when an extent overlaps multiple mappings
>> > in the parent user namespace, e.g.:
>> > 
>> > $ cat /proc/self/uid_map
>> >          0       1000          1
>> >          1     100000      65536
>> > $ unshare -U sleep 100 &
>> > [1] 1029703
>> > $ printf "0 0 100\n" | tee /proc/$!/uid_map
>> > 0 0 100
>> > tee: /proc/1029703/uid_map: Operation not permitted
>> > 
>> > To prevent it from happening, automatically split an extent so that
>> > each portion fits in one extent in the parent user namespace.
>> > 
>> > $ cat /proc/self/uid_map
>> >          0       1000          1
>> >          1     110000      65536
>> > $ unshare -U sleep 100 &
>> > [1] 1552
>> > $ printf "0 0 100\n" | tee /proc/$!/uid_map
>> > 0 0 100
>> > $ cat /proc/$!/uid_map
>> >          0          0          1
>> >          1          1         99
>> > 
>> > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> 
>> The patch on the whole looks great, easy to reason about.  But I have
>> one question below:
>
> As you pointed out, I was misreading the variable name, thank you :)
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
>> 
>> > ---
>> > v2:
>> > - move the split logic when the extent are mapped to the parent map to
>> >   reduce lookup complexity.
>> > 
>> > v1: https://lkml.kernel.org/lkml/20201126100839.381415-1-gscrivan@redhat.com
>> > 
>> >  kernel/user_namespace.c | 79 +++++++++++++++++++++++++++++++++++------
>> >  1 file changed, 68 insertions(+), 11 deletions(-)
>> > 
>> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> > index 87804e0371fe..550612c6e794 100644
>> > --- a/kernel/user_namespace.c
>> > +++ b/kernel/user_namespace.c
>> > @@ -312,6 +312,55 @@ static u32 map_id_down(struct uid_gid_map *map, u32 id)
>> >  	return map_id_range_down(map, id, 1);
>> >  }
>> >  
>> > +/**
>> > + * find_and_split_extent_down - Find lower_first for the target extent
>> > + * using the specified map.
>> > + * If the extent doesn't fit in a single lower extent, split target and
>> > + * write the remaining IDs (first and count) to the overflow extent.
>> > + * If no overflow happens, overflow->count is set to 0.
>> > + */
>> > +static int find_and_split_extent_down(struct uid_gid_map *map,
>> > +				       struct uid_gid_extent *target,
>> > +				       struct uid_gid_extent *overflow)
>> > +{
>> > +	unsigned int extents = map->nr_extents;
>> > +	u32 lower_first = target->lower_first;
>> > +	struct uid_gid_extent *extent;
>> > +	u32 off, available;
>> > +
>> > +	overflow->count = 0;
>> > +
>> > +	/* Find the lower extent that includes the first ID.  */
>> > +	if (extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
>> > +		extent = map_id_range_down_base(extents, map, lower_first, 1);
>> > +	else
>> > +		extent = map_id_range_down_max(extents, map, lower_first, 1);
>> > +
>> > +	/* Could not map the first ID in the extent.  */
>> > +	if (extent == NULL)
>> > +		return -EPERM;
>> > +
>> > +	/* Offset of lower_first in the lower extent.  */
>> > +	off = target->lower_first - extent->first;
>> > +
>> > +	/* How many IDs are available in the lower extent?  */
>> > +	available = extent->count - off;
>> > +
>> > +	/* Requesting more IDs than available in the lower extent.  */
>> > +	if (target->count > available) {
>> > +		/* Move the remaining IDs to the overflow extent.  */
>> > +		overflow->first = target->first + available;
>> > +		overflow->lower_first = target->lower_first + available;
>> > +		overflow->count = target->count - available;
>> > +
>> > +		/* Shrink the initial extent to what is available.  */
>> > +		target->count = available;
>> > +	}
>> > +
>> > +	target->lower_first = extent->lower_first + off;
>> > +	return 0;
>> > +}
>> > +
>> >  /**
>> >   * map_id_up_base - Find idmap via binary search in static extent array.
>> >   * Can only be called if number of mappings is equal or less than
>> > @@ -749,6 +798,7 @@ static bool mappings_overlap(struct uid_gid_map *new_map,
>> >   * insert_extent - Safely insert a new idmap extent into struct uid_gid_map.
>> >   * Takes care to allocate a 4K block of memory if the number of mappings exceeds
>> >   * UID_GID_MAP_MAX_BASE_EXTENTS.
>> > + * The extent is appended at the position map->nr_extents.
>> >   */
>> >  static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
>> >  {
>> > @@ -968,30 +1018,37 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>> >  	if (!new_idmap_permitted(file, ns, cap_setid, &new_map))
>> >  		goto out;
>> >  
>> > -	ret = -EPERM;
>> >  	/* Map the lower ids from the parent user namespace to the
>> >  	 * kernel global id space.
>> >  	 */
>> >  	for (idx = 0; idx < new_map.nr_extents; idx++) {
>> > +		struct uid_gid_extent overflow;
>> >  		struct uid_gid_extent *e;
>> > -		u32 lower_first;
>> >  
>> >  		if (new_map.nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
>> >  			e = &new_map.extent[idx];
>> >  		else
>> >  			e = &new_map.forward[idx];
>> >  
>> > -		lower_first = map_id_range_down(parent_map,
>> > -						e->lower_first,
>> > -						e->count);
>> > -
>> > -		/* Fail if we can not map the specified extent to
>> > -		 * the kernel global id space.
>> > -		 */
>> > -		if (lower_first == (u32) -1)
>> > +		ret = find_and_split_extent_down(parent_map, e, &overflow);
>> > +		if (ret < 0)
>> >  			goto out;
>> >  
>> > -		e->lower_first = lower_first;
>> > +		/* If the extent doesn't fit in a single lower extent,
>> > +		 * move what could not be mapped to a new extent.
>> > +		 * The new extent is appended to the existing ones in
>> > +		 * new_map, it will be checked again and if necessary it
>> > +		 * is split further.
>> > +		 */
>> > +		if (overflow.count > 0) {
>> > +			if (new_map.nr_extents == UID_GID_MAP_MAX_EXTENTS) {
>> 
>> Why are you doing this?  The insert_extent() will automatically extend it
>> if needed, right?  So this condition should be fine?
>> 
>> > +				ret = -EINVAL;
>> > +				goto out;
>> > +			}
>> > +			ret = insert_extent(&new_map, &overflow);
>> > +			if (ret < 0)
>> > +				goto out;
>> > +		}
>> >  	}
>> >  
>> >  	/*
>> > -- 
>> > 2.28.0
>> 
>> Cheers,
>> Balint
>> 
>> >
>> > -serge
>> 
>> 
>> 
>> -- 
>> Balint Reczey
>> Ubuntu & Debian Developer
>> > 
>

