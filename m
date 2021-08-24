Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53E43F6695
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbhHXRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:25:46 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41614 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbhHXRWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:22:13 -0400
Received: by mail-ot1-f50.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso33204650ota.8;
        Tue, 24 Aug 2021 10:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hlWC9+vUVVELeqKVJ2DC9hi41GL/e4i4yVESIWR4T5A=;
        b=Bpyb3Y48nlHC6qTRaCg01OZGQNZHGOrguhlp1HB4tOFGt3xeJhi/mwm40wUqrSlFlI
         UG90aHKzOHYN+f0Qk0kiov+pxgcGlKW9qLf9geGqUBJyAHbJNVUhDgebar4cnAtf8NuW
         41s2CqAwfGtfdgc0WoaT62mLH5wTWPjVd+l8lo6c4l/8ajhP4k7d3WsinOEQIQgH+FDb
         1VSLIUK3oVPVfueiaNVA6obpqxquZrlNuuGk+njkBdUAXpaAfpD/TSxaWHqRzCK5ImSJ
         adUZjjN1zbGUWIPMBQQQNsqQ/MIAIdBu7c4Wo6VWwm0YjWvycVuRbw3CiAtqjU03/E99
         LnrQ==
X-Gm-Message-State: AOAM533RHXYX9uQ8ELhWx/PWwLollXTTa2dXy1rnscmXnFAU5f0dp3j6
        KowgLgKGDFIfXO4U6aAFsw==
X-Google-Smtp-Source: ABdhPJxMsPbj7DqNPHORp0UDP+Z9S7EF7aFEMtnEsKD4R7HA5m8wOSCsNcw49YJJoVL/sV4Edu7h6A==
X-Received: by 2002:aca:2305:: with SMTP id e5mr3642749oie.36.1629825685671;
        Tue, 24 Aug 2021 10:21:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p4sm4149663ooa.35.2021.08.24.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:21:25 -0700 (PDT)
Received: (nullmailer pid 661564 invoked by uid 1000);
        Tue, 24 Aug 2021 17:21:24 -0000
Date:   Tue, 24 Aug 2021 12:21:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     tglx@linutronix.de, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: timer: remove rockchip,rk3066-timer
 compatible string from rockchip,rk-timer.yaml
Message-ID: <YSUqlE2S+YGR6680@robh.at.kernel.org>
References: <20210824095637.2547-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824095637.2547-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 11:56:37 +0200, Johan Jonker wrote:
> The Rockchip rk3066 timers have a different register layout then rk3288
> with only a 32 vs 64 bits timer channel. The timers in rk3066a.dtsi have
> "snps,dw-apb-timer" as compatible string, so remove the
> "rockchip,rk3066-timer" from rockchip,rk-timer.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
