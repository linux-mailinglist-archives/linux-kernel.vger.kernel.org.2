Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3C7333388
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCJDD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:03:58 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:37943 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhCJDDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:03:31 -0500
Received: by mail-il1-f172.google.com with SMTP id f10so14171364ilq.5;
        Tue, 09 Mar 2021 19:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LksHYlIfEzV9pnoP+0yGzfGcP3EXHPwjjnl8Sebgu9s=;
        b=Po59giS4dBXCvaSGx5+xdAo9ESNp0RXmuztbsfdHGjey0VcdtXcDg/UrUacEjUgLFl
         6Qxs3A1hCkKxEsKDckkMtav37EV07fuuP93x4t3QZGvy5YzQ4BClIoF9mI10Odtm1eZx
         O+jbAGTMC8Xwtr1ejrU1weEMPMdAJGsqvmjaZkY2lF6JndWaOeHswhQt7H7HAhMrnSRA
         mhv7173SfVDKf1a5GzFgO5BohLqLo6I6XCZ1miWp7awksZpvmUW/D7QQPDGg0MROYfwq
         oJ0NbR+YPbD3wFN3Or5k0NLf58cqpzAzHU+uwYW71SNnKMkna82Lwig2NYqIiYUCUvfg
         V3CA==
X-Gm-Message-State: AOAM533cBBAUQesbf3m/gurRREzCpuop6ImHif5mY8VvRyR8WyONsPFz
        1F+44Lrb2Ww4aRBsXLguOA==
X-Google-Smtp-Source: ABdhPJwHlovanhm09rYK9MxOUzAafoA8UlPvo2TveZpStF8GsdLMIMzL1DG2MZz5qTREXlxlKO/lBA==
X-Received: by 2002:a92:940b:: with SMTP id c11mr1068894ili.132.1615345410835;
        Tue, 09 Mar 2021 19:03:30 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b5sm8561376ioq.7.2021.03.09.19.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:03:30 -0800 (PST)
Received: (nullmailer pid 1669195 invoked by uid 1000);
        Wed, 10 Mar 2021 03:03:28 -0000
Date:   Tue, 9 Mar 2021 20:03:28 -0700
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org, od@zcrc.me,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings/timer: ingenic: Add compatible
 strings for JZ4760(B)
Message-ID: <20210310030328.GA1669134@robh.at.kernel.org>
References: <20210308212302.10288-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308212302.10288-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021 21:23:00 +0000, Paul Cercueil wrote:
> Add compatible strings to support the system timer, clocksource, OST,
> watchdog and PWM blocks of the JZ4760 and JZ4760B SoCs.
> 
> Newer SoCs which behave like the JZ4760 or JZ4760B now see their
> compatible string require a fallback compatible string that corresponds
> to one of these two SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: - Fix indentation
>         - Fix example not using correct compatible strings
> 
>  .../bindings/timer/ingenic,tcu.yaml           | 30 ++++++++++++++-----
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
