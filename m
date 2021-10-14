Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB942E249
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhJNT5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:57:18 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38822 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhJNT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:57:17 -0400
Received: by mail-oi1-f179.google.com with SMTP id t4so9920327oie.5;
        Thu, 14 Oct 2021 12:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQo11y+PtYmWXH/qREqXNNJ8rPsV/G16fKSFghghkWc=;
        b=r2UY89yE5nuYq1fk50itu+2w2CTh2O8r67+14DA7w5ZXpW0tVKccb4aIFB9BP920ox
         FK8AfIDDBY2bmNblKem/zBDfW0nxFJVODnpZNSGV3S8ad8HXe58Y2f4pV8LiYIjsw0VZ
         bDU8aG07MwyPXsMeEPzHhbilvgAG9+NTYeXBwb7GwDgVIFj3caGo/GWs1wMoZKYsXDm2
         pzVpQ9sWyjjG5QmTSvoP0VNQkBlhrrqBskp7ylj1UoZ/lVv+uCwqa4OZZCbkNxszZJBS
         rjL/kR8zkLMbUiz3QbPGNA4FKBcN1/o3e/Z3/HkfW4VnMl5bC4m9CE70fOGnRTQpjA/a
         IqQA==
X-Gm-Message-State: AOAM531x1d+LxCT/2nIiqnP1GS0c+x4g4jCMph8mk8e82wH1aZsv43F/
        ltpRjizHbnGrVTfD5g7sCA==
X-Google-Smtp-Source: ABdhPJwm7fGCl+f804VscVb8iYPMGAvdtTg+TVPBFWuHVK7AmRqgqWeDwjCRhLP9omZ/LllVPzgJXw==
X-Received: by 2002:aca:b10b:: with SMTP id a11mr14669068oif.177.1634241311857;
        Thu, 14 Oct 2021 12:55:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o2sm722158otl.34.2021.10.14.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:55:11 -0700 (PDT)
Received: (nullmailer pid 3814957 invoked by uid 1000);
        Thu, 14 Oct 2021 19:55:10 -0000
Date:   Thu, 14 Oct 2021 14:55:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Will Deacon <will@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/7] dt-bindings: arm: fsl: add TQMa8MxML boards
Message-ID: <YWiLHhnY1K/rrw2S@robh.at.kernel.org>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
 <20211006132309.1239708-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006132309.1239708-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 15:23:03 +0200, Alexander Stein wrote:
> TQMa8MxML is a SOM family using NXP i.MX8MM[Q,QL,DL,S,SL] CPU
> MBa8Mx is an evaluation mainbord for this SOM
> 
> The SOM needs a mainboard, therefore we provide two compatibles here:
> 
> "tq,imx8mm-<SOM>" for the module and
> "tq,imx8mm-<SOM>-<SBC>" for the module on that mainboard
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
