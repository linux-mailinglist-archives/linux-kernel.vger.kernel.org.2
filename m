Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581F53D1C33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 05:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGVCY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:24:27 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:46939 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhGVCY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:24:26 -0400
Received: by mail-il1-f182.google.com with SMTP id y6so4084065ilj.13;
        Wed, 21 Jul 2021 20:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qRC4i9IC5fmogXiHA+XMn95xo6OUhdJon7l31DRv27U=;
        b=eB6gJ8xiEfkufi6jSD1xUIonYvYmITFc917NovJpvcA1xvQBXEvHPThef8HyymM+XE
         RVqJ/odn7Xy3lN8rSYBZ8/Te9BSR7Xsn4BPT3iUnQkLyQ+miBhZ4u74wbXAytMc0Hbfd
         Yxvk1PP95EgISGay4TJT1TBd3UrwpXoE5N5/uMfeM6MYmplFFZ9UF4TMVpfFWAPqKhKI
         M9XFVoJSMwLu0OWRIcx0gYNFVfWr4b7JkxBml+8cwgbFbDPji82DHYKT1ajyJiQnyni3
         Gvoai/Bl7Cys6XXK6Kh0IcmGvY8xFLTu67xGT55ascg4Srkg5Lf4vweyci1hDUBfJPab
         Ng7A==
X-Gm-Message-State: AOAM533KguOSGhYLkxQvhATdS6r4Jkx1qHlZywnNhD23NyoTGDG6+Nwo
        m4AnhSELI94tuANAVVU0tQ==
X-Google-Smtp-Source: ABdhPJwIIBszKvNLzbrWQ9Pc+iqwT5r+K+S0a6LFvfZ8CBjdst/QTKBOi4qyDVad4aeO2nxsamvo2g==
X-Received: by 2002:a05:6e02:d93:: with SMTP id i19mr13978285ilj.72.1626923101275;
        Wed, 21 Jul 2021 20:05:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p8sm8863092iol.49.2021.07.21.20.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 20:05:00 -0700 (PDT)
Received: (nullmailer pid 3221816 invoked by uid 1000);
        Thu, 22 Jul 2021 03:04:58 -0000
Date:   Wed, 21 Jul 2021 21:04:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     dongsheng.qiu@ingenic.com, jun.jiang@ingenic.com,
        daniel.lezcano@linaro.org, sihui.liu@ingenic.com,
        linux-kernel@vger.kernel.org, aric.pzqi@ingenic.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com
Subject: Re: [PATCH] dt-bindings: timer: Add ABIs for new Ingenic SoCs.
Message-ID: <20210722030458.GA3221766@robh.at.kernel.org>
References: <1626370605-120775-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1626370605-120775-1-git-send-email-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 01:36:45 +0800, 周琰杰 (Zhou Yanjie) wrote:
> 1.Add OST_CLK_EVENT_TIMER for new XBurst®1 SoCs.
> 2.Add OST_CLK_EVENT_TIMER0 to OST_CLK_EVENT_TIMER15 for new XBurst®2 SoCs.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  include/dt-bindings/clock/ingenic,sysost.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
