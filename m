Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0443AA4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhFPTxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:53:04 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:46685 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFPTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:53:03 -0400
Received: by mail-il1-f170.google.com with SMTP id i12so3337307ila.13;
        Wed, 16 Jun 2021 12:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=phu7v1JTWvxVrKFYkYrGvzIHVYTPjSMRARDstuVxMZM=;
        b=HaSrRfVyXFls/R3h1UQzmR/Fm88D/FynoKsGKm4/ZaWdnjyno0MMztt2o38iLYMonf
         g9R2JTZGpA2oWGNvE2AklxYK6KNtk9Da0FTauOFKYuZo38FQxMyPX8NZwL3gBhMC+J9r
         jk1ukurtOHzq7VcIGXIE1MFrKFDq7kVGzmzLgXxbjcXyOn1d6sv2Db6dgMPXKQVNaTO0
         BMBbfVrzadbEjXrdNCaZXblNrV/M600A7kTiXW/uIyCrAVw7aYalek8qd7mVSGPVZcxe
         yxkNKhnbpy/IOxN0QwVO0lHDPely4XX1a+oQt4tpSz8+kITKKn/KJsNJ0yYmT/ngYTao
         KjZg==
X-Gm-Message-State: AOAM533jwGtSwgBfqeblMhUDSXdvTgTaAjMXHKZDhpDJm2FsEO1JIW+N
        cyvMth+gYdpj1T9bCgvvStlBfcaHow==
X-Google-Smtp-Source: ABdhPJw7DOClzWysJiLbJ/t+5Yrp5CWxy4JZjxk3+USZ7GS7k+SoLaqDvhZW9W9Nkx8K2G9Xya7qkA==
X-Received: by 2002:a92:6b06:: with SMTP id g6mr887033ilc.270.1623873055362;
        Wed, 16 Jun 2021 12:50:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f16sm1148488ilc.53.2021.06.16.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:50:54 -0700 (PDT)
Received: (nullmailer pid 3827255 invoked by uid 1000);
        Wed, 16 Jun 2021 19:50:50 -0000
Date:   Wed, 16 Jun 2021 13:50:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] of: Remove superfluous casts when printing u64 values
Message-ID: <20210616195050.GA3827179@robh.at.kernel.org>
References: <cover.1623835273.git.geert+renesas@glider.be>
 <ef3f4f78385b43230695ba0855d078290c958192.1623835273.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3f4f78385b43230695ba0855d078290c958192.1623835273.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 11:27:45 +0200, Geert Uytterhoeven wrote:
> "u64" is "unsigned long long" on all architectures now.  Hence there is
> no longer a need to use casts when formatting using the "ll" length
> modifier.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/address.c | 14 ++++----------
>  drivers/of/fdt.c     |  6 ++----
>  2 files changed, 6 insertions(+), 14 deletions(-)
> 

Applied, thanks!
