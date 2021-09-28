Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E2741ACAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbhI1KNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:13:31 -0400
Received: from phobos.denx.de ([85.214.62.61]:42888 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239952AbhI1KN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:13:29 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0045D82EE0;
        Tue, 28 Sep 2021 12:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632823908;
        bh=1gm+yBwSErE6FWepgFfoEKRGOP1Aqja96WsJs8n3Kfk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jvWr/TPom7aGUWl+KtLdSBBJ7nY1DfLQaEzCVaoaTOSE56JtEgOhRwfiW7o2gjOKT
         UaYcbQWPp0K3YJFJtJ4IUNR9EAN6A3rLcCuv9PWbCw9W4jk1sshOW8qZeFPJV5m+H9
         vUMCzd/tYnCsuSpGkw34E+K6S1+g/8vOmJ578K4iUbWhV33/oNB0d+6idXc9TIHEx9
         HWw6FFWr8auLkX0zJoMjcDYeLxCwFApjWzbngSlZxUINLLRKt8FNhDrtjQlAIuG0P8
         CDIMS99VQjkvEvJBGVpo0PDleOVHv7BKm2I0pCwiupWXbPn5RdiIoXnXfRdgMmFCMX
         5g00qzOtbgfYQ==
Subject: Re: [PATCH] drm: mxsfb: Set proper default bus format when using a
 bridge
To:     Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc:     Stefan Agner <stefan@agner.ch>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <YVLYh/SgBritG/RJ@qwark.sigxcpu.org>
 <1fda3b80-7df2-2ce3-b049-6773e849e9dc@denx.de>
 <YVLeMlQWd/lBNjsX@qwark.sigxcpu.org>
 <3ebcbc4dba56011ddf4761dc47513dbb66fe656d.camel@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <d9760c02-1b73-5703-7964-a2918e16af94@denx.de>
Date:   Tue, 28 Sep 2021 12:11:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3ebcbc4dba56011ddf4761dc47513dbb66fe656d.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 11:27 AM, Lucas Stach wrote:
> Am Dienstag, dem 28.09.2021 um 11:19 +0200 schrieb Guido Günther:
>> Hi,
>> On Tue, Sep 28, 2021 at 11:08:58AM +0200, Marek Vasut wrote:
>>> On 9/28/21 10:55 AM, Guido Günther wrote:
>>>> If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
>>>> returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
>>>> that case.
>>>>
>>>> This unbreaks e.g. using mxsfb with the nwl bridge and mipi panels.
>>>>
>>>> Fixes: b776b0f00f24 ("drm: mxsfb: Use bus_format from the nearest bridge if present")
>>>>
>>>> Signed-off-by: Guido Günther <agx@sigxcpu.org>
>>>> ---
>>>>
>>>> I'll look at what needs to be done in nwl separately but this also
>>>> unbreaks other bridge seupts that don't to format negotiation yet.
>>>>
>>>>    drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>>> index af6c620adf6e..4ef94cf686b0 100644
>>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>>> @@ -369,6 +369,8 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>>>>    			drm_atomic_get_new_bridge_state(state,
>>>>    							mxsfb->bridge);
>>>>    		bus_format = bridge_state->input_bus_cfg.format;
>>>> +		if (bus_format == MEDIA_BUS_FMT_FIXED)
>>>> +			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>>
>>> Shouldn't the NWL bridge return the correct format ?
>>
>> Yes it should and I'll send a separate patch for that but we currently
>> don't do anything meaningful at all if the bridge doesn't do format
>> negotiation and then fail setup in mxsfb_set_formats().
>>
>> I think we should at least preserve the status quo (as we do with the
>> non bridge case in b776b0f00f24 too).
>>
>> We could have a warning to spot drivers that don't do that yet and hence
>> the generic code returns MEDIA_BUS_FMT_FIXED.
>>
> That sounds sensible. Using a default format if we don't know what to
> do is going to be a unpleasant surprise for those with a display
> pipeline that doesn't work with the default format. So please add a
> dev_warn when we are doing this fallback.
> 
> Also I would argue that the NWL fix is the patch that should go in the
> stable tree. This one should only be a additional safety net, so I
> would drop the Fixes tag.

Indeed
