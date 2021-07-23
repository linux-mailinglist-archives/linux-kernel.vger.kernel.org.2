Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E393D3DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhGWPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGWPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:51:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEAFC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=AJR4Uwi2twf+SqV3Z1Vf6OE1gwqoYjBswhC7GZxo0Zk=; b=DR8TH5p8tSmZN+rEb8dwHCUOaX
        hDANAh3CZGcYYS/mJ7ctrM3KkFNFb6vpT+5Q5ORTTNgbwzdgqTVoHZncRkq9KgTSeoac+6++u42xz
        +JKg6ni/pFSh704KbFdxwLBkOYQRl8Q2L4xHvNbHrLlz63VONrrdpih4hzTVi5TeKmnb4PG7Bn5ZG
        IYjMPpR0w7iuqajisWTNvwfoMTZS9NFEJrQ+DxZiX1vVujNBz/EHmYVesXU+LeUDZsYz5pPL5Uz3F
        3DFjtTSonKSPbHFEb9r3Ig0iw1dVA4DjLXXANvEc9XXQ68dxxEh7arlCGBUgIG213/YHQcb9DJtfr
        kAfjfLEg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6y5G-005Lel-VX; Fri, 23 Jul 2021 16:31:35 +0000
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: fix build failure with
 CONFIG_BACKLIGHT=n
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>
References: <20210723091534.1730564-1-arnd@kernel.org>
 <a618e29a-e4b7-bda4-a3e0-7dfd67d64e92@infradead.org>
 <CACO55tvQoCnjQWRJhrJ+8TzY5MuDDSUSnwd5AU8G1qsQYCSCBg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ddd0c7c-9bdc-9ea3-c635-f1d141d1e870@infradead.org>
Date:   Fri, 23 Jul 2021 09:31:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACO55tvQoCnjQWRJhrJ+8TzY5MuDDSUSnwd5AU8G1qsQYCSCBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/21 8:15 AM, Karol Herbst wrote:
> On Fri, Jul 23, 2021 at 5:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 7/23/21 2:15 AM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> When the backlight support is disabled, the driver fails to build:
>>>
>>> drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_sor_atomic_disable':
>>> drivers/gpu/drm/nouveau/dispnv50/disp.c:1665:59: error: 'struct nouveau_connector' has no member named 'backlight'
>>>  1665 |         struct nouveau_backlight *backlight = nv_connector->backlight;
>>>       |                                                           ^~
>>> drivers/gpu/drm/nouveau/dispnv50/disp.c:1670:35: error: invalid use of undefined type 'struct nouveau_backlight'
>>>  1670 |         if (backlight && backlight->uses_dpcd) {
>>>       |                                   ^~
>>> drivers/gpu/drm/nouveau/dispnv50/disp.c:1671:64: error: invalid use of undefined type 'struct nouveau_backlight'
>>>  1671 |                 ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
>>>       |                                                                ^~
>>>
>>> The patch that introduced the problem already contains some #ifdef
>>> checks, so just add another one that makes it build again.
>>>
>>> Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>>> index 093e1f7163b3..fcf53e24db21 100644
>>> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
>>> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>>> @@ -1659,20 +1659,23 @@ static void
>>>  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
>>>  {
>>>       struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>>> -     struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
>>>       struct nouveau_crtc *nv_crtc = nouveau_crtc(nv_encoder->crtc);
>>>       struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
>>> -     struct nouveau_backlight *backlight = nv_connector->backlight;
>>>       struct drm_dp_aux *aux = &nv_connector->aux;
>>> -     int ret;
>>>       u8 pwr;
>>>
>>> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
>>> +     struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
>>> +     struct nouveau_backlight *backlight = nv_connector->backlight;
>>> +
>>>       if (backlight && backlight->uses_dpcd) {
>>> -             ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
>>> +             int ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
>>> +
>>>               if (ret < 0)
>>>                       NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
>>>                                nv_connector->base.base.id, nv_connector->base.name, ret);
>>>       }
>>> +#endif
>>>
>>>       if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
>>>               int ret = drm_dp_dpcd_readb(aux, DP_SET_POWER, &pwr);
>>>
>>
>> Hm, only Lyude Paul replied to this patch:
>>
>> https://lore.kernel.org/lkml/20210714171523.413-1-rdunlap@infradead.org/
>>
> 
> what's actually the use case of compiling with
> CONFIG_DRM_NOUVEAU_BACKLIGHT=n anyway?

Dunno. In this case it was just a randconfig. Still, it needs to be
handled in some way - such as the other suggestion in this thread.

