Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77C39C08D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFDToG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:44:06 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44860 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:44:04 -0400
Received: by mail-oi1-f177.google.com with SMTP id d21so10823570oic.11;
        Fri, 04 Jun 2021 12:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iwpzyxd5CbOxhvxW+jNhnkZOEathw49CJTutBIFswjg=;
        b=mgXRBtlEPgEos2UPa8Xos7/pfws1yHgC8GnHsakpstT4VfUGVC0A8k1EgGmAyU9YIf
         xVthvEwSfpnzZxGV3nhziXHSErd8le9txs0fNW+HfNEh4aBm/21rKDwnFQb+vNZCflAo
         /YEP2NLPu9EA19L778VvYYBaCVtwhMa+2Lw2EOAzbZNhZYALcyI3hZWWom2RsPMtWYIe
         B31kulzH9RWZcfgJ0VyBAi4ZACyCqQ5+CbOtzFICSiqGIs0+zLLJVdSI02+yIc4aq9Pq
         rY9zsabS7BmUIGbRPCd/XSAY2ETJTHgEyH6B0Wxn1S7WHUTAzB5ThNuTWaGUcAQKISIC
         D00g==
X-Gm-Message-State: AOAM532XS/G0TOzTbbPt1A1bg7EhuBEQJqwOVMR/aEb9XfjcSm7Zz3hX
        zOYKhBkQ4m2J5gIaJppXxA==
X-Google-Smtp-Source: ABdhPJxk36X+Us47SDRHve7A3Vu/JYp33N4YfM8CDgQaSY5bZK2wPJxk6oKzTRt618XcHomnaEhQRQ==
X-Received: by 2002:a05:6808:3a7:: with SMTP id n7mr11938789oie.140.1622835721393;
        Fri, 04 Jun 2021 12:42:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t15sm661221oie.14.2021.06.04.12.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:42:00 -0700 (PDT)
Received: (nullmailer pid 3786315 invoked by uid 1000);
        Fri, 04 Jun 2021 19:41:59 -0000
Date:   Fri, 4 Jun 2021 14:41:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] Documentation: dt-bindings: Fix incorrect statement
Message-ID: <20210604194159.GA3781429@robh.at.kernel.org>
References: <20210521095720.5592-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521095720.5592-1-wangyanan55@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 05:57:20PM +0800, Yanan Wang wrote:
> It's found when reading the Doc.

Please improve the subject so we have some clue as to what the change is 
and what it applies to.
 
> In a SMP system, the hierarchy of CPUs now can be defined through
> four not three entities (socket/cluster/core/thread), so correct
> the statement to avoid possible confusion.
> 
> Since we are already there, also drop an extra space and tweak
> the title alignment. No real context change at all.

Since already here, converting to schema would be preferred over trivial 
fixes.

> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  Documentation/devicetree/bindings/cpu/cpu-topology.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpu/cpu-topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> index 9bd530a35d14..8b23a98c283c 100644
> --- a/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> @@ -6,7 +6,7 @@ CPU topology binding description
>  1 - Introduction
>  ===========================================
>  
> -In a SMP system, the hierarchy of CPUs is defined through three entities that
> +In a SMP system, the hierarchy of CPUs is defined through four entities that
>  are used to describe the layout of physical CPUs in the system:
>  
>  - socket
> @@ -75,7 +75,7 @@ whose bindings are described in paragraph 3.
>  
>  The nodes describing the CPU topology (socket/cluster/core/thread) can
>  only be defined within the cpu-map node and every core/thread in the
> -system must be defined within the topology.  Any other configuration is
> +system must be defined within the topology. Any other configuration is
>  invalid and therefore must be ignored.
>  
>  ===========================================
> @@ -91,9 +91,9 @@ cpu-map child nodes which do not share a common parent node can have the same
>  name (ie same number N as other cpu-map child nodes at different device tree
>  levels) since name uniqueness will be guaranteed by the device tree hierarchy.
>  
> -===========================================
> +============================================
>  3 - socket/cluster/core/thread node bindings
> -===========================================
> +============================================
>  
>  Bindings for socket/cluster/cpu/thread nodes are defined as follows:
>  
> -- 
> 2.19.1
