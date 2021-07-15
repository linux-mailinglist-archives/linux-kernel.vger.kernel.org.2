Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8663C9CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhGOKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:35:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhGOKfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:35:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607D21042;
        Thu, 15 Jul 2021 03:32:53 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13A03F694;
        Thu, 15 Jul 2021 03:32:51 -0700 (PDT)
Subject: Re: [PATCH v2] drm/of: free the iterator object on failure
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>
References: <20210712155758.48286-1-steven.price@arm.com>
 <20210714143300.20632-1-steven.price@arm.com>
 <YO8CODO4TRP+qr9H@pendragon.ideasonboard.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f723a5e0-5b9a-c807-f51d-9acc57058a80@arm.com>
Date:   Thu, 15 Jul 2021 11:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO8CODO4TRP+qr9H@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2021 16:26, Laurent Pinchart wrote:
> Hi Steven,
> 
> Thank you for the patch.
> 
> On Wed, Jul 14, 2021 at 03:33:00PM +0100, Steven Price wrote:
>> When bailing out due to the sanity check the iterator value needs to be
>> freed because the early return prevents for_each_child_of_node() from
>> doing the dereference itself.
>>
>> Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks! Applied to drm-misc-next.

Steve

>> ---
>>  drivers/gpu/drm/drm_of.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> v2: Fixes now refers to the original commit as suggested by Laurent, rather
>> than 4ee48cc5586b ("drm: of: Fix double-free bug") which only fixed part of
>> the problem. Note that 4ee48cc5586b is a dependency for this patch to
>> cleanly apply.
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

