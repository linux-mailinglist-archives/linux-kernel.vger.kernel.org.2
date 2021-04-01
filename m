Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B27351E84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhDASm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbhDASUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:20:42 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089DC02FEA6;
        Thu,  1 Apr 2021 09:12:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso2602292otq.3;
        Thu, 01 Apr 2021 09:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q6dkaX8MCC1QWlhms6LKLDJBhv8fv/w3cbDi9ipTADQ=;
        b=VkgbthkXc2HqBSrdop+tgqbqroR4hghxywA0i5NC9MI5fy0VRTmHUeM2U8n/bmVFqB
         dcf6N7ZmgkbLmLXhdmkBtitwclAJhi2CpCGNAf2GROuHGSXTgvCDn+4RYN79OMSpwk/O
         IrT0PhmYHLdZKoycZABOFDTSAfifh2S/bT0MgekHNGrNWt4pwgZ6Vutz6ldtw4aZHIGi
         nds4/Cw9rCx6n2PawhJiiUPhNToTrNeH/2fmPLL7CF9mglGPPWnl0+iwD9M2YD8rOGPK
         C6urzCvVgm80cSYpPF35xSTT5ODSmxLUuBkz8wJtzfgjlq8Ncc/4E2KehZSFCW4gTdY/
         ZbIw==
X-Gm-Message-State: AOAM533Kb0eabITxD/GiQueyqpsMLJPa2mde56ebv1lLRQAJ2rqeALSG
        bOUUHzCnC/3cZ7I/pg40oOx6dPY4Tw==
X-Google-Smtp-Source: ABdhPJyQS8ZYJmHSsmQe0gtNV4ljM0aMybfxwE16FwmOSPgDHIGJQ6KTnf9NOVhz5wJMxvHIf5PcFg==
X-Received: by 2002:a9d:70cf:: with SMTP id w15mr7805191otj.283.1617293542965;
        Thu, 01 Apr 2021 09:12:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e15sm1210740otk.64.2021.04.01.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:12:22 -0700 (PDT)
Received: (nullmailer pid 530912 invoked by uid 1000);
        Thu, 01 Apr 2021 16:12:21 -0000
Date:   Thu, 1 Apr 2021 11:12:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devicetree@vger.kernel.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, kraxel@redhat.com, airlied@linux.ie,
        tzimmermann@suse.de, zhangxuezhi1@yulong.com, robh+dt@kernel.org,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] dt-bindings: display: sitronix, st7789v-dbi: Add
 Waveshare 2inch LCD module
Message-ID: <20210401161221.GA530733@robh.at.kernel.org>
References: <20210331030550.119493-1-zhangxuezhi3@gmail.com>
 <20210331030550.119493-3-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331030550.119493-3-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 03:05:50 +0000, Carlis wrote:
> From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> 
> Document support for the Waveshare 2inch LCD module display, which is a
> 240x320 2" TFT display driven by a Sitronix ST7789V TFT Controller.
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> ---
> v2:change compatible value.
> v3:change author name.
> v4:delete a maintainer.
> ---
>  .../display/sitronix,st7789v-dbi.yaml         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
