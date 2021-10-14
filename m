Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F88842E24E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhJNT6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:58:20 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42755 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJNT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:58:19 -0400
Received: by mail-oi1-f182.google.com with SMTP id g125so9913878oif.9;
        Thu, 14 Oct 2021 12:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVw2OcUywIx14hWMRArZqvR7GNvEF6V1s1vijT8ztQQ=;
        b=ajr0JqIH0r0JOkdKQyYpp7ZKhpTsRLpuWTb86NtMCNNMo1ib/YVJkgPWF97gWc4cm6
         iNrpjaEhUU4VLI6vS5TMjxOpZJjG48wW9UtMB6TOjrraehGj6nTnvGJMHH/QuYhsfLt7
         5DzzhaAXc4MTKCrRDb/9pHqbHRvTmI/TTPVAADvmAV5FyO3utT30qA0DHB8NE93A2Ouz
         AscgT/FWYjmU/hzX5xpjTbS79jbpzc86XIzN1fkJ9o65IMUIAY1QtQ1RvJVdVUL3KQBO
         bhtqq0baPaglUOIRLV6yvgeIDhi0dAuRCqs6m+TIfgV8XuBW1mgmfZu/6sGks2gD3NNk
         vZYQ==
X-Gm-Message-State: AOAM531qUT4v5S7VzsHC8evNrkC3BoVRJOWivkISnJZ7qdJlIeWJWH2A
        497wO0jpjn9Jut7WuRAynw==
X-Google-Smtp-Source: ABdhPJwd7GpTHAzjFrHG4jb/om989jqnJhBvE9ajrgPRhN7g92OFLg2Q+cDnfkdCbw7wcqWuiWROyQ==
X-Received: by 2002:aca:3a06:: with SMTP id h6mr3758634oia.22.1634241373567;
        Thu, 14 Oct 2021 12:56:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 95sm759618otr.2.2021.10.14.12.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:56:13 -0700 (PDT)
Received: (nullmailer pid 3816694 invoked by uid 1000);
        Thu, 14 Oct 2021 19:56:12 -0000
Date:   Thu, 14 Oct 2021 14:56:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 6/7] dt-bindings: arm: fsl: add TQMa8Mx boards
Message-ID: <YWiLXJNchhdRx2YJ@robh.at.kernel.org>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
 <20211006132309.1239708-7-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006132309.1239708-7-alexander.stein@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 15:23:08 +0200, Alexander Stein wrote:
> TQMa8Mx is a SOM family using NXP i.MX8M[Q,QL, D] CPU
> MBa8Mx is a evaluation mainbord for this SOM
> 
> The SOM needs a mainboard, therefore we provide two compatibles here:
> 
> "tq,imx8mq-<SOM>" for the module and
> "tq,imx8mq-<SOM>-<SBC>" for the module on that mainboard
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
