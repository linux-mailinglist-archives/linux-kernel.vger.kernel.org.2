Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841503C657B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhGLVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhGLVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:34:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31BD26D;
        Mon, 12 Jul 2021 14:32:03 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFFCA3F694;
        Mon, 12 Jul 2021 14:32:01 -0700 (PDT)
Subject: Re: [PATCH] drm/of: free the iterator object on failure
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20210712155758.48286-1-steven.price@arm.com>
 <YOxyvIoJcZFAgUz5@pendragon.ideasonboard.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b420a4e6-8038-6c1e-7c97-75ef3bea3c21@arm.com>
Date:   Mon, 12 Jul 2021 22:31:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOxyvIoJcZFAgUz5@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2021 17:50, Laurent Pinchart wrote:
> Hi Steven,
> 
> Thank you for the patch.
> 
> On Mon, Jul 12, 2021 at 04:57:58PM +0100, Steven Price wrote:
>> When bailing out due to the sanity check the iterator value needs to be
>> freed because the early return prevents for_each_child_of_node() from
>> doing the dereference itself.
>>
>> Fixes: 4ee48cc5586b ("drm: of: Fix double-free bug")
> 
> I don't think the Fixes tag is correct, the issue was already present
> before 4ee48cc5586b. The fix looks right though.

I'm not sure quite what you mean by "already present". As I understand
it the timeline was:

1. 6529007522de drm: of: Add drm_of_lvds_get_dual_link_pixel_order
   The function was originally added. This made the mistake twice of
   calling of_node_put() on the wrong variable (remote_port rather than
   endpoint).

2. 4ee48cc5586b drm: of: Fix double-free bug
   One of the of_node_put() calls was removed as it was a double-free.
   This left the first incorrect of_node_put() in place, and the second
   is now a straight leak.

3. b557a5f8da57 drm/of: free the right object
   This (correctly) fixes the first of_node_put() to free endpoint. And
   the post from Daniel was what caused me to look.

4. This patch
   Reintroduces the of_node_put() removed in (2) but putting endpoint
   rather than remote_port.

I've put (2) in the Fixes line as this patch is fixing the leak
introduced by that patch, but that in itself was of course 'fixing' the
double free of the original patch.

Steve

>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  drivers/gpu/drm/drm_of.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Daniel's email[1] made me take a look at this function and it appears
>> that for_each_child_of_node()'s interface had caused a bad bug fix due
>> to the hidden reference counting in the iterator.
>>
>> [1] https://lore.kernel.org/r/YOxQ5TbkNrqCGBDJ%40phenom.ffwll.local
>>
>> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
>> index 197c57477344..997b8827fed2 100644
>> --- a/drivers/gpu/drm/drm_of.c
>> +++ b/drivers/gpu/drm/drm_of.c
>> @@ -331,8 +331,10 @@ static int drm_of_lvds_get_remote_pixels_type(
>>  		 * configurations by passing the endpoints explicitly to
>>  		 * drm_of_lvds_get_dual_link_pixel_order().
>>  		 */
>> -		if (!current_pt || pixels_type != current_pt)
>> +		if (!current_pt || pixels_type != current_pt) {
>> +			of_node_put(endpoint);
>>  			return -EINVAL;
>> +		}
>>  	}
>>  
>>  	return pixels_type;
> 

