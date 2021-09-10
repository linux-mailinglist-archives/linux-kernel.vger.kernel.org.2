Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89F406527
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhIJB0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhIJB0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:26:54 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28ADC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=AP1zZ/vEmIdYS+BpkjYpRIVz0XdIP7X4XRX+FiLpwj8=; b=EUchTFp+D0cHzj641tWHvT8h6x
        s/r5lU93njCOeDFHnCO7Z5OknEL1yJIYGukSpks4+oGOVvLmsO3i+H+ap6jOUOUfpWahH9GstOIE7
        HhtvpCaYbn7Lq21vnU+UBOdqvGpxoSyILqBjI5isgulyLcnerWp+4XwRf9rTVOanldU0Idz8FAXDx
        GJGC/T8zT4SourA57fwYWESgiYJq6CSSVwnGclh4tvHzXDJIp5eImeHEwntA6bTAL1uomgG2P5v3P
        O5mjlMwG5sHryGuNPeiE7UWbU/3dl3Z7/A4Uwo+JOXP8K+vJ/zWh31aufHEKP1hrfsGkxH8H88lxh
        rmONNikA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOVIO-00BWXJ-80; Fri, 10 Sep 2021 01:25:36 +0000
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
To:     Lukas Prediger <lumip@lumip.de>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
        phil@philpotter.co.uk
References: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
 <20210909180553.8299-1-lumip@lumip.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <10f60086-2be0-d26d-dfa6-fe128772a409@infradead.org>
Date:   Thu, 9 Sep 2021 18:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909180553.8299-1-lumip@lumip.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 11:05 AM, Lukas Prediger wrote:
>>> As this is not a packed struct, would not a smaller value still take up
>>> the same space?
>> Might as well be explicit about it and also make it obvious that there
>> is some space available for other fields.
> I had this as a __u8 in the first submission but Jens asked me to change it.
>  From his feedback on this:
> 
> "The struct layout should be modified such that there are no holes or
> padding in it. Probably just make the has_changed a flags thing, and
> make it u64 as well. Then you can define bit 0 to be HAS_CHANGED, and
> that leaves you room to add more flags in the future."
> https://lore.kernel.org/lkml/6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk/
> 
> I changed it to __u64 to address this. We could think about turning it
> back to a __u8 (or bool) and add some explicit padding members
> (a __u8 reserved[3]?), but honestly I don't see much real benefit in that
> compared to how it is now.

I have no problem with Jens's suggestion.  It would look more like this:

+{
+	__s64	last_media_change;	/* Timestamp of the last detected media
+					 * change in ms. May be set by caller, updated
+					 * upon successful return of ioctl.
+					 */
+	__u64	media_flags;		/* various <struct> flags */

#define MEDIA_CHANGED			0x1 /* Set to 1 by ioctl if last detected media */
/* other bits of media_flags available for future use */


and not having __u64 has_changed;
which is overkill for a flag.

-- 
~Randy

