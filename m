Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825CB41ABA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbhI1JX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239573AbhI1JXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:23:55 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:22:15 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D0BED8048A;
        Tue, 28 Sep 2021 11:22:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632820931;
        bh=G/OYKSqftn2mFkL3esf6uhqBFkyVI4qhxKkblOBZuSY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V+PdFXNJxWvnx7YZikqPrUzbIIXnXsfonJW1UrfO6ntXuSvCmadWSjPLZFz3N9Bl6
         IZnOorll57p7Ko9feGRwzfb5rKKJPsOYsDAcpavu3hojJ29THp0VS9hbIx+0pHcoIt
         mnHe1mS94KlP0HPoOz7aWMpsX26kd3AxX571ANGz5lX7qX2Bcvs0vBfqUVJE6Hx08l
         RVOIwiucCAEBRRwk0q0MkzWcoiHWxE79Ax5PUuzXHJNtsHNwRP1b1lsuzG6oMmrGCF
         I0zrRAkn0oH4VPZYBFpQET+jxbUvhBCSKRGo3OwFtAMcCsGBMCvJzp2tXhtYwaoYOS
         O57FIBaumSBFg==
Subject: Re: [PATCH] drm: mxsfb: Set proper default bus format when using a
 bridge
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc:     Stefan Agner <stefan@agner.ch>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <YVLYh/SgBritG/RJ@qwark.sigxcpu.org>
 <1fda3b80-7df2-2ce3-b049-6773e849e9dc@denx.de>
 <YVLeMlQWd/lBNjsX@qwark.sigxcpu.org>
From:   Marek Vasut <marex@denx.de>
Message-ID: <eb9cad24-dea6-730a-7890-feb213e080a3@denx.de>
Date:   Tue, 28 Sep 2021 11:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVLeMlQWd/lBNjsX@qwark.sigxcpu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 11:19 AM, Guido Günther wrote:
> Hi,
> On Tue, Sep 28, 2021 at 11:08:58AM +0200, Marek Vasut wrote:
>> On 9/28/21 10:55 AM, Guido Günther wrote:
>>> If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
>>> returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
>>> that case.
>>>
>>> This unbreaks e.g. using mxsfb with the nwl bridge and mipi panels.
>>>
>>> Fixes: b776b0f00f24 ("drm: mxsfb: Use bus_format from the nearest bridge if present")
>>>
>>> Signed-off-by: Guido Günther <agx@sigxcpu.org>
>>> ---
>>>
>>> I'll look at what needs to be done in nwl separately but this also
>>> unbreaks other bridge seupts that don't to format negotiation yet.
>>>
>>>    drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>> index af6c620adf6e..4ef94cf686b0 100644
>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>> @@ -369,6 +369,8 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>>>    			drm_atomic_get_new_bridge_state(state,
>>>    							mxsfb->bridge);
>>>    		bus_format = bridge_state->input_bus_cfg.format;
>>> +		if (bus_format == MEDIA_BUS_FMT_FIXED)
>>> +			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>
>> Shouldn't the NWL bridge return the correct format ?
> 
> Yes it should and I'll send a separate patch for that but we currently
> don't do anything meaningful at all if the bridge doesn't do format
> negotiation and then fail setup in mxsfb_set_formats().
> 
> I think we should at least preserve the status quo (as we do with the
> non bridge case in b776b0f00f24 too).
> 
> We could have a warning to spot drivers that don't do that yet and hence
> the generic code returns MEDIA_BUS_FMT_FIXED.

I am not gonna push back against this patch, I think you need feedback 
from the drm people on this. A warning would indeed be nice. Preserving 
the old behavior in stable releases would be good (if there are any 
releases which contain the mxsfb patch this fixes).
