Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2874E4377D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhJVN04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 09:26:56 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:38446 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJVN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:26:55 -0400
Received: by mail-oo1-f51.google.com with SMTP id i1-20020a4ab241000000b002b7069d0e88so1101746ooo.5;
        Fri, 22 Oct 2021 06:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rRNhbdg2DSuhPmKmcEvYXvhzUYi1wo+w9CgilER+WOY=;
        b=auV97yI0wvbf+3PrbVZvbyuVdIvbNEbYlw1gh3g1Oou+LjLsKfCsfK47SMVnmjps9U
         DkBAH9wexEloTQrbLyIXJId7aVnPdDXRQ7LmXXIV4HuVrEkrc1fASP1KUPKQT/Lj2bXh
         qEnspAjvHFhsdqFvhth09Jg1Qk1h7jZRw+qfyGSQkdlaULRgrIQsaG1v0kzMMpCAvD7Z
         FRCp7sRroKtaFq1QHIzWgLwBqKoFGPraMrMSpKkm9c94TVnGIP2MhfIAjpFIWetu4huP
         ix2AD2HV9dF+it23hA5amSDb19bvual/HYe/+OSzddPlP9IdeWbwg3LxpxcrqoYQxhxx
         VzzA==
X-Gm-Message-State: AOAM53341EKP/eB3wXb0bi9pzFzfsnQuhlbR550GdHfSMGY8EJEwqU26
        JTY4Ln7qoBvHAkZOSql1orYgAyrb7w==
X-Google-Smtp-Source: ABdhPJz4OdatYL0OZZ1u/JwvBag0fE6+tAbXF8Bh1KkNtxb/vB+zb8WsUdn+LRpW8BPz72m+WtuPzA==
X-Received: by 2002:a4a:e292:: with SMTP id k18mr9212036oot.80.1634909077279;
        Fri, 22 Oct 2021 06:24:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t8sm1667014otc.74.2021.10.22.06.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:24:36 -0700 (PDT)
Received: (nullmailer pid 2506514 invoked by uid 1000);
        Fri, 22 Oct 2021 13:24:35 -0000
Date:   Fri, 22 Oct 2021 08:24:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/4] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <YXK7k01crkLuRfSq@robh.at.kernel.org>
References: <20210914200539.732093-1-paul.kocialkowski@bootlin.com>
 <20210914200539.732093-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914200539.732093-2-paul.kocialkowski@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 22:05:36 +0200, Paul Kocialkowski wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/xylon,logicvc-display.yaml        | 302 ++++++++++++++++++
>  1 file changed, 302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> 

Since the mfd part is already applied and it's too late for 
drm-misc, I've applied it, thanks!

Rob
