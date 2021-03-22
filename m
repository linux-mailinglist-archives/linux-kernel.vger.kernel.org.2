Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6042344D81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhCVRhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:37:02 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:34309 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhCVRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:36:40 -0400
Received: by mail-il1-f176.google.com with SMTP id h1so15620402ilr.1;
        Mon, 22 Mar 2021 10:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQUjNuHYH7XMWAm47YqJRg5aTzrqz/XmeXkLwUmyQa4=;
        b=OtP42r32dBlHszlNvirK9K2DtxwB0diOQqw0xqBhmrHresWXEEhgOKH6gxedaoq+JV
         +k/R3dIaUlfI4ei4YL+Rng82P+aKy3EG/qSPi5aKXVkcdfyL0LiKtzSPOG2q2TdDixhN
         u3aDHlYcQ+UG2pfL8pVmcYNgCnKs51D85Pk3nnmnaS4HS6N1pvPmIeEAdMKN8NfF+DEl
         +qosuOPXTEnRa1FRfCddUnZSS9fcqF4a6BeYnyt8WAeiCXpvNBRJhFzRo8aFa5fsScR1
         re5FZJpzRBcrjZFeVB82K06yFyKxsUriqlUB1wvbTSr8yAs3GaztRKiCnqdD1aKXyb3B
         DrlA==
X-Gm-Message-State: AOAM530MayX+fBVr6/TJyheomHIgtEF/fUQzbuQv0WIM/Tj+di50nCjO
        Ehi5VV84wE/WD69okr54Eg==
X-Google-Smtp-Source: ABdhPJz0JG49VkPhTiL2TvHFN9lMzCKwmiz4gcgj6j7qQOhQ3jUPxoFkxwEQmOy2s0WF8gnhh5Tufw==
X-Received: by 2002:a92:b003:: with SMTP id x3mr996149ilh.15.1616434599213;
        Mon, 22 Mar 2021 10:36:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m5sm8194929ilq.65.2021.03.22.10.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:36:38 -0700 (PDT)
Received: (nullmailer pid 2885394 invoked by uid 1000);
        Mon, 22 Mar 2021 17:36:36 -0000
Date:   Mon, 22 Mar 2021 11:36:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v7 2/3] devicetree: nvmem: nvmem: drop $nodename
 restriction
Message-ID: <20210322173636.GA2885364@robh.at.kernel.org>
References: <20210312062830.20548-1-ansuelsmth@gmail.com>
 <20210312062830.20548-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312062830.20548-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 07:28:20 +0100, Ansuel Smith wrote:
> Drop $nodename restriction as now mtd partition can also be used as
> nvmem provider.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
