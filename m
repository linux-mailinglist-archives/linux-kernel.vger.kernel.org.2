Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084AE331544
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhCHRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:52:36 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37848 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCHRwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:52:08 -0500
Received: by mail-qk1-f175.google.com with SMTP id s7so10161429qkg.4;
        Mon, 08 Mar 2021 09:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPB4huatYbwl80jYKwSF7UcinL+RMW/E9f/YgeQxn+Y=;
        b=n6KN6ao+MN7k1O3LlvJvQLMf6MNa/icmO8ggJ5oYTkRGN63I7OZKZO8bA43TFMWKSb
         fZZUdt6ShGDWML+Xjn+d/OqC/rnmt04JMSFZzpa5v16kobo+7iLjcCaaaoqOftE49pP3
         125AKHAFdJYkSneTMgLJfluR/nMkXKMvoAQTi9x/SQ9umU2ZT/VDkQF9T0he46IwOOxK
         fODNI7DMCuFTtUJ/EJN3exXcgd5Dk7NY6DEQ/71ugAS0mOMkZjH3UwkAhQT8L0gjIoER
         pGMvDc9vpxmFJpcIc4ALBdnpxlaZSKjjNjcaShPRtNg2UD1RNdSZxHAaX8UQ1XRTO7cD
         ZV9w==
X-Gm-Message-State: AOAM5325nhcOIjf6hKBvx61L/ZwGkG/w3H5usPMYu3wFDauM3bB05qjb
        TtP1hFcKBPq4iiRbvq89s7qZWpF6qw==
X-Google-Smtp-Source: ABdhPJxBT9iwoqUcXW65Awv827IA4yDuByiJmyRaO4420WIC/jZsQA1Tw1dirDsINRWvGXiwv/Egrw==
X-Received: by 2002:a02:7086:: with SMTP id f128mr24249918jac.104.1615225926425;
        Mon, 08 Mar 2021 09:52:06 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i3sm6208434ioq.13.2021.03.08.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:52:05 -0800 (PST)
Received: (nullmailer pid 2699399 invoked by uid 1000);
        Mon, 08 Mar 2021 17:52:03 -0000
Date:   Mon, 8 Mar 2021 10:52:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, Swapnil Jakhade <sjakhade@cadence.com>,
        linux-phy@lists.infradead.org, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 3/9] dt-bindings: ti-serdes-mux: Add defines for AM64
 SoC
Message-ID: <20210308175203.GA2699351@robh.at.kernel.org>
References: <20210222112314.10772-1-kishon@ti.com>
 <20210222112314.10772-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222112314.10772-4-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 16:53:08 +0530, Kishon Vijay Abraham I wrote:
> AM64 has a single lane SERDES which can be configured to be used
> with either PCIe or USB. Define the possilbe values for the SERDES
> function in AM64 SoC here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> ---
>  include/dt-bindings/mux/ti-serdes.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
