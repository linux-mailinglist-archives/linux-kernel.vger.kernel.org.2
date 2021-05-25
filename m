Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFA39055A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhEYP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhEYP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:27:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C8C061574;
        Tue, 25 May 2021 08:25:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so13376591pjb.2;
        Tue, 25 May 2021 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jL+DBxWN5edIJOrVtHSuYvmFZqk3JNDdtDmQJkkStO8=;
        b=ADsWXFPQuNNtwHEJoJyXj5LyZS40qB6RUp/8KdRTz+SQQiOqa8lPfdkQHPDPKrCTkC
         57WkUmg43+E1w/Tv4GssLcUeeQ3ruJGpOVJIzWiVkVd+vOJFeCdy+S76xch1GFZGW1Vk
         HZnJvLO+oME00P5s5Ljv09YiSEXvjrcjGTTQv+80Cpn2zh9zZCIpTLdVPdWfy14un5zK
         6qrdGICT2DDsaTi+9xvggt6WpE8VwTWY9y389K6wcE2VjFJQ2nAw+om9OChuhy1NIkQ1
         4ETtFDx7gN8gP4PNo49FXBG5sEs6QVNWagv1L8oI/nJhoDVDkGuNOwg6nO039jt/ne0S
         mANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jL+DBxWN5edIJOrVtHSuYvmFZqk3JNDdtDmQJkkStO8=;
        b=RU45qL25OovZxqNVSNfsDa8A3ejA6148TAHSTyWfnj5LqChKqXzySvBeIk05s9KBor
         SQKf3P+dzei8K2Uzq9zn/mw/Prt1+8MSu3Nqp1ewY3fdORPM4wghwTFn2ikjLhwxNBXH
         09Ju5aDXsGkHk2EMLTD4yLJzQsFoyRAeB/mlTPJFtWQ7/XDnP2UxRkgZtXd9KAAVreao
         7CKAz5+8z/8qLk2Iplo2BRzUI9P++8jl7XEB24yqy4oJcwE4ePvZR1/LleWt4gd5hTcL
         /trYRZHOqPTEeoyS7po4sypILVEgZoGn/s10MqDTiniiTvzijQW56PtiCVhvrTmiWjkl
         VEDw==
X-Gm-Message-State: AOAM533JPEDQ+/xwjqrLPa4B+PuTS3774T/XybHdUnnsGZxLfPycYvgc
        zZdzusp4TXy10OcbF2Jvqsw=
X-Google-Smtp-Source: ABdhPJys9nI4J83yBrIv1q0rF+gkI0iY2Ixso6WRntsxUf21NpnE4gjcHDdIeLCDFoCqGYe/yhkc0Q==
X-Received: by 2002:a17:90a:9486:: with SMTP id s6mr5455853pjo.192.1621956340125;
        Tue, 25 May 2021 08:25:40 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id w15sm2311678pjy.1.2021.05.25.08.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:25:39 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] ARM: dts: bcm2711: Tune DMA parameters for HDMI
 audio
To:     Maxime Ripard <maxime@cerno.tech>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-doc@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dom Cobley <popcornmix@gmail.com>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-13-maxime@cerno.tech>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fa063d1b-c23c-c29c-f9b4-c77be4626fd5@gmail.com>
Date:   Tue, 25 May 2021 08:25:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525132354.297468-13-maxime@cerno.tech>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/2021 6:23 AM, Maxime Ripard wrote:
> From: Dom Cobley <popcornmix@gmail.com>
> 
> Enable NO_WAIT_RESP, DMA_WIDE_SOURCE, DMA_WIDE_DEST, and bump the DMA
> panic and AXI priorities to avoid any DMA transfer error with HBR audio
> (8 channel, 192Hz).
> 
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  arch/arm/boot/dts/bcm2711.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index 720beec54d61..9d1dde973680 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -344,7 +344,7 @@ hdmi0: hdmi@7ef00700 {
>  			interrupt-names = "cec-tx", "cec-rx", "cec-low",
>  					  "wakeup", "hpd-connected", "hpd-removed";
>  			ddc = <&ddc0>;
> -			dmas = <&dma 10>;
> +			dmas = <&dma (10 | (1 << 27) | (1 << 24)| (15 << 20) | (10 << 16))>;

This uses DT as a configuration language rather than a description here,
but this is most certainly an established practice that the bcm283-dma.c
supports, with no validation of the various arguments.. great.

Is there at least an option to move the meaning of this bitfields into
include/dt-bindings/dma/bcm2835-dma.h or something like that?
-- 
Florian
