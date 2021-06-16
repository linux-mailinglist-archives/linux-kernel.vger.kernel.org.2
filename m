Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB873AA2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFPSHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:07:15 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:47025 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhFPSHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:07:10 -0400
Received: by mail-io1-f48.google.com with SMTP id b14so116768iow.13;
        Wed, 16 Jun 2021 11:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nhtnuVC7x8F0RxoCVWcLwvtiTsM/g+uKT2oI1c6E/88=;
        b=Oea2304Drr8V32KZ/Jiv5z47OMz5OyBgmkdNHvwj6J+7XAi5RjWd4QotHBPPqFQra4
         DXuNhsrMyNLZwRrS4PznbwZDPVutwEzMNDUtv8cwPTz1WAivcTl51lb3SU4EvekLVj4S
         9y9dpDlirlRtirRYYM6oDykQcgiUWiR7X/UgNXuTUFflbkQli/9QsVweFGj77cwuF8n1
         XC8ieTmXC2K4TBnG9VUV9ajr2CbolB4fZCgjvCjpXEU4Yy0wUvolMigD5kDmJlsl8aOX
         fCqKUTe3PUeG6T0a2SYi7E5f/OV/NITxHjlYL09ITVarW3B0L9CmufJU18BRa4S7vgnF
         lK5Q==
X-Gm-Message-State: AOAM530xGm2EMscBl8VXeWlr4mFpfaP7g45RSFAa/kwLxGjlju0jCRq5
        pp+YhfPxoxuRLSRaHXjybFwSeYB2Ag==
X-Google-Smtp-Source: ABdhPJybX8rQs8eqkO4g6uGoYmsIFzEXphFF9HBytSufElRlNCgbbaU7NAYcEt/68rP06qeqi7BFJw==
X-Received: by 2002:a5e:a515:: with SMTP id 21mr498451iog.175.1623866703813;
        Wed, 16 Jun 2021 11:05:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p19sm1546416iob.7.2021.06.16.11.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:05:03 -0700 (PDT)
Received: (nullmailer pid 3629274 invoked by uid 1000);
        Wed, 16 Jun 2021 18:05:01 -0000
Date:   Wed, 16 Jun 2021 12:05:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/3] of: Fix truncation of memory sizes on 32-bit
 platforms
Message-ID: <20210616180501.GA3629188@robh.at.kernel.org>
References: <cover.1623835273.git.geert+renesas@glider.be>
 <4a1117e72d13d26126f57be034c20dac02f1e915.1623835273.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1117e72d13d26126f57be034c20dac02f1e915.1623835273.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 11:27:44 +0200, Geert Uytterhoeven wrote:
> Variable "size" has type "phys_addr_t", which can be either 32-bit or
> 64-bit on 32-bit systems, while "unsigned long" is always 32-bit on
> 32-bit systems.  Hence the cast in
> 
>     (unsigned long)size / SZ_1M
> 
> may truncate a 64-bit size to 32-bit, as casts have a higher operator
> precedence than divisions.
> 
> Fix this by inverting the order of the cast and division, which should
> be safe for memory blocks smaller than 4 PiB.  Note that the division is
> actually a shift, as SZ_1M is a power-of-two constant, hence there is no
> need to use div_u64().
> 
> While at it, use "%lu" to format "unsigned long".
> 
> Fixes: e8d9d1f5485b52ec ("drivers: of: add initialization code for static reserved memory")
> Fixes: 3f0c8206644836e4 ("drivers: of: add initialization code for dynamic reserved memory")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/fdt.c             | 8 ++++----
>  drivers/of/of_reserved_mem.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 

Applied, thanks!
