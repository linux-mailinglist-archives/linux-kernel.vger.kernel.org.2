Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A13A3F6560
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhHXRML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239689AbhHXRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629824912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAkVl4muzdQPrWqv3jT8cULrRk2pHmerwmwahfAa5XM=;
        b=coLFN8eYdEYyDyr08wZ5fHSuOfdx9XB3QU36UvtT5ImeNr0tw9F8zQvO/TGa5ybbypaTKV
        qFdAnwbQw+7e2OFO2NJtQp5BfWDPQ5ZoHOhYriYqWbeni1R20MX+WuxwtsvIRRTark+dB2
        G1cshcof04ZRdu9XrBM3Hj/SRusSKdU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-qr2k4J2GN3-t94yyVXrf_w-1; Tue, 24 Aug 2021 13:08:30 -0400
X-MC-Unique: qr2k4J2GN3-t94yyVXrf_w-1
Received: by mail-qk1-f199.google.com with SMTP id h10-20020a05620a284a00b003d30e8c8cb5so14753758qkp.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dAkVl4muzdQPrWqv3jT8cULrRk2pHmerwmwahfAa5XM=;
        b=VTQw23S+l1Hwyq+p4Xb0mKsiC7RLIuXPKy+aXVbjDc+wxUO68xeSNhZYbFM3czei+S
         mDCDMDKMhm34fwSVmqxfFwx9DKOWccjJTRZxxJvJxGJ+CZvzunIQonfseCY/WQVy8UIk
         FDuF2jY9v5hsuZ/wNc6mW7DyXwdFNk7EyI1bEGVdZ53QN35NsACqIYxYYAWUSqMhRV/+
         XlvqJwSNI3R3H/cz9EhyRuOyp+UOahfwS2oMNlphpPivh9c42MdT7gDCo3uKyXkGUFYH
         ZcB5E0GjQssb/5IFlsAPuCa0rfk9NsWvEnMQX8h0fdQMyZ9SYuXjJqIyE3F/uypLelsu
         ciZA==
X-Gm-Message-State: AOAM530WGkeeBZfMlyhtThg4Fnb/0gbAlhZHHprIbwRRSXgy0k1aD1IG
        UsbV/v2f2q7emBxigrS1Ap1/UqGDOIWE164tMLP7rQzO0muVmf6iIFH/imDeWTX57eXdky6Ighn
        0FXs4t0bSO2BHMVh+O5NBfFO4
X-Received: by 2002:a05:620a:4ed:: with SMTP id b13mr27114976qkh.26.1629824910284;
        Tue, 24 Aug 2021 10:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8V/5mLfM4VrGrXcWlxoFrrEreLpKoBkx2IpdnRG8q7Idvub+fuLWIIz3F/ZFCXaE8qPhBlg==
X-Received: by 2002:a05:620a:4ed:: with SMTP id b13mr27114963qkh.26.1629824910148;
        Tue, 24 Aug 2021 10:08:30 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id l4sm11354108qkd.77.2021.08.24.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:08:29 -0700 (PDT)
Message-ID: <6607dde4207eb7ad1666b131c86f60a57a2a193c.camel@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.13 20/26] drm/nouveau: recognise GA107
From:   Lyude Paul <lyude@redhat.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Date:   Tue, 24 Aug 2021 13:08:28 -0400
In-Reply-To: <20210824005356.630888-20-sashal@kernel.org>
References: <20210824005356.630888-1-sashal@kernel.org>
         <20210824005356.630888-20-sashal@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is more hardware enablement, I'm not sure this should be going into
stable either. Ben?

On Mon, 2021-08-23 at 20:53 -0400, Sasha Levin wrote:
> From: Ben Skeggs <bskeggs@redhat.com>
> 
> [ Upstream commit fa25f28ef2cef19bc9ffeb827b8ecbf48af7f892 ]
> 
> Still no GA106 as I don't have HW to verif.
> 
> Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../gpu/drm/nouveau/nvkm/engine/device/base.c | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> index b930f539feec..93ddf63d1114 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> @@ -2624,6 +2624,26 @@ nv174_chipset = {
>         .dma      = { 0x00000001, gv100_dma_new },
>  };
>  
> +static const struct nvkm_device_chip
> +nv177_chipset = {
> +       .name = "GA107",
> +       .bar      = { 0x00000001, tu102_bar_new },
> +       .bios     = { 0x00000001, nvkm_bios_new },
> +       .devinit  = { 0x00000001, ga100_devinit_new },
> +       .fb       = { 0x00000001, ga102_fb_new },
> +       .gpio     = { 0x00000001, ga102_gpio_new },
> +       .i2c      = { 0x00000001, gm200_i2c_new },
> +       .imem     = { 0x00000001, nv50_instmem_new },
> +       .mc       = { 0x00000001, ga100_mc_new },
> +       .mmu      = { 0x00000001, tu102_mmu_new },
> +       .pci      = { 0x00000001, gp100_pci_new },
> +       .privring = { 0x00000001, gm200_privring_new },
> +       .timer    = { 0x00000001, gk20a_timer_new },
> +       .top      = { 0x00000001, ga100_top_new },
> +       .disp     = { 0x00000001, ga102_disp_new },
> +       .dma      = { 0x00000001, gv100_dma_new },
> +};
> +
>  static int
>  nvkm_device_event_ctor(struct nvkm_object *object, void *data, u32 size,
>                        struct nvkm_notify *notify)
> @@ -3049,6 +3069,7 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
>                 case 0x168: device->chip = &nv168_chipset; break;
>                 case 0x172: device->chip = &nv172_chipset; break;
>                 case 0x174: device->chip = &nv174_chipset; break;
> +               case 0x177: device->chip = &nv177_chipset; break;
>                 default:
>                         if (nvkm_boolopt(device->cfgopt,
> "NvEnableUnsupportedChipsets", false)) {
>                                 switch (device->chipset) {

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

