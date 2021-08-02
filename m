Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B13DE10C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhHBUxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:53:24 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:33426 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhHBUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:53:22 -0400
Received: by mail-il1-f180.google.com with SMTP id y4so17729095ilp.0;
        Mon, 02 Aug 2021 13:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtTzEyXXQDYmugYxu9hyBCUwyXwHryBGzApYcJm8xSo=;
        b=q3sTTlB05VM31pX3OZGzfTLSdqnP2YRK8Pxca6mBjHBW3mshIA8Lglg1cQVPY6BmZu
         cX2U/D1VuVv9gk99c4NPrtdFpMHZ2rxoMQVGPIfNs/n7DHKpfT2zw6cpX3wmG+oOZekZ
         Hx5txOBA2v+toPKi9DH28ETDM37lIpJVrwvfTEvLRSmvqdJEwi1BWpTmz4i8xzOnbhdI
         p4KO5CFr/Zeowexys3mlQcP7sN//xh6/b8H7oFsYTxsNQuE31h+OW26GpycZWjEr+sA3
         zfD42UrtXYk4gphaJ4mrDOwpoHA2jCFWwH2/fQokyVBmT+CEhyQS05AOAihKHmi98fZ2
         WO0g==
X-Gm-Message-State: AOAM532gfDhIafRTjTHcyoWfOMA63P/eQeOmjBvMBlGdwFoksj3VEIrj
        wAG7gtKB6TNZB4AuzU6oUQ==
X-Google-Smtp-Source: ABdhPJyP1dFb1uB9WWjZX/x9UwcE4fY55G7IVrYUma21Lqxy8U70KGO9RFDei8VlXowxh+lhWVyrSQ==
X-Received: by 2002:a92:cd41:: with SMTP id v1mr9498589ilq.212.1627937591785;
        Mon, 02 Aug 2021 13:53:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 204sm8058096ioc.50.2021.08.02.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:53:11 -0700 (PDT)
Received: (nullmailer pid 1590051 invoked by uid 1000);
        Mon, 02 Aug 2021 20:53:09 -0000
Date:   Mon, 2 Aug 2021 14:53:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: auxdisplay: arm-charlcd: Convert to
 json-schema
Message-ID: <YQhbNWgp94o2I2mc@robh.at.kernel.org>
References: <4a63caa4136e8a31e82c7d75bb6f273498e8cccf.1627402256.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a63caa4136e8a31e82c7d75bb6f273498e8cccf.1627402256.git.geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 18:11:41 +0200, Geert Uytterhoeven wrote:
> Convert the ARM Versatile Character LCD Device Tree binding documentation
> to json-schema.
> 
> Correct compatible value.
> Document missing properties.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  .../auxdisplay/arm,versatile-lcd.yaml         | 44 +++++++++++++++++++
>  .../bindings/auxdisplay/arm-charlcd.txt       | 18 --------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 45 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
>  delete mode 100644 Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
> 

Applied, thanks!
