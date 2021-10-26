Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F7743BC38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhJZVVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:21:46 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36822 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbhJZVVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:21:19 -0400
Received: by mail-ot1-f45.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so615586otk.3;
        Tue, 26 Oct 2021 14:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=goMSID9C5MFCMICxa57PTxLv5m9FDLARzUx3oz1FuHk=;
        b=bi4AV8HnrvzIyE7GyWTgetiMc8T5jJTPh98ylC1HZ6JqlLh9mVvJHUFedX6c0c96Sk
         jaOSVWBOIB/ev6hnnNzg+bIn+es0Bk0w2st0sjm3my9Ibr4wWVk9phKDQM71WAvNb8wB
         kskjWJz3L0wBEQCDkyFZYVZAcrexbCpnEzi5ucX3olU59YL+LQcofL+LSh3BNo8tXJOj
         d6Fp8aAXCc+31UBlmQ4myIBKpgVT9wib3GGrWVBncAiTFQ97gUneCKhbA5paKYOwE4jR
         radZ7nCw+rTM05Yl5QoPAfuLIPvguza9M13oZTE/TdHDf57FCbLThbWuK9swBxuvP6rq
         BwJQ==
X-Gm-Message-State: AOAM531M6a8Q9h+VK6ilJ6RiQdQkOcHUEOJyTs1WqT9EjsxhUdkc2YeP
        HQMLai+nYOs2MlWH6f2rZQ==
X-Google-Smtp-Source: ABdhPJyvapCYR0gZYgSBZpqnyFlqzWhQmWd3KD8vvfIyHD8p0Hn3fw0cyMxvC/ZnpB8MPdcBBp4epw==
X-Received: by 2002:a05:6830:4488:: with SMTP id r8mr21302132otv.272.1635283135283;
        Tue, 26 Oct 2021 14:18:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c17sm5276717ots.35.2021.10.26.14.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:18:54 -0700 (PDT)
Received: (nullmailer pid 3270967 invoked by uid 1000);
        Tue, 26 Oct 2021 21:18:53 -0000
Date:   Tue, 26 Oct 2021 16:18:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, monstr@monstr.eu
Subject: Re: [PATCH] dt-bindings: timer: cadence_ttc: Add power-domains
Message-ID: <YXhwvaFpaab6LFut@robh.at.kernel.org>
References: <cc655a72b20790f6d7408b1aaf81c4bf878aafb4.1634286552.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc655a72b20790f6d7408b1aaf81c4bf878aafb4.1634286552.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 10:29:14 +0200, Michal Simek wrote:
> Describe optional power-domain property to fix dts_check warnings.
> The similar change was done by commit 8c0aa567146b ("dt-bindings: gpio:
> fsl-imx-gpio: Add power-domains").
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/timer/cdns,ttc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
