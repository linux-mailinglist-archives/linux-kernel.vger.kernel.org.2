Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4AD315B21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhBJA0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:26:54 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:36055 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhBIUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:52:55 -0500
Received: by mail-oo1-f54.google.com with SMTP id x10so14967oor.3;
        Tue, 09 Feb 2021 12:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zYWOrkcsKfChRImNqLSWdyR0i73LhsnHKlqkLnp7i9w=;
        b=sJc948wv8cJRqkRlVMiNx6uEm3QIT1qewtMOs3/VUo7LRdK9up4qqdyltq78tI+thz
         SJykwy48nV2zTDX5xBTWhMi5xt5p2H3wqWGmwgaSuUvbtsvh+H3l08xHExpq56e0uzzN
         PsVGfCPY1LLCg00Pkuv8RSM6R74vZqmuio4k8Tcm6vEAavLzvYM54zdZDlZ6qHTbHkU1
         zQ/pKBmDHMkVhO/ai+sP5TDL8t19B0wLyiQMT5CeN3IDMpnfgREY64hnq0uzR8RIObXN
         2llrL/bLDcMO1RN1fuppyiFGNNkXWXO6/743BGoank25x8S2FoDhAWoOwF3csxEjOuPO
         o1QQ==
X-Gm-Message-State: AOAM5316kr0LkZcYORj8cM9WxPaeOzs2AVsf2tWPLQF8BFsGQHifcO3M
        wrbupQB/oKa7uwq8bx+y0w==
X-Google-Smtp-Source: ABdhPJzjsfC6m6597yiSi2bf2jQF3/2bD3LpwzGwpJ9MNjpY7vbQdMc+V54wsIohaWTF94Cd0VU2CA==
X-Received: by 2002:a05:6820:414:: with SMTP id o20mr17289292oou.46.1612903934493;
        Tue, 09 Feb 2021 12:52:14 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm4710017otn.18.2021.02.09.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:52:12 -0800 (PST)
Received: (nullmailer pid 158305 invoked by uid 1000);
        Tue, 09 Feb 2021 20:52:11 -0000
Date:   Tue, 9 Feb 2021 14:52:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        devicetree@vger.kernel.org, Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: arm: xilinx: Add missing Zturn boards
Message-ID: <20210209205211.GA158245@robh.at.kernel.org>
References: <f6f642d75c1b1160ed78f6de0a2944ab64017691.1612185370.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f642d75c1b1160ed78f6de0a2944ab64017691.1612185370.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 14:16:12 +0100, Michal Simek wrote:
> Add missing DT compatible strings for Zturn boards.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Patches are based on
> https://lore.kernel.org/linux-arm-kernel/20210120194033.26970-3-michael@walle.cc/
> ---
>  Documentation/devicetree/bindings/arm/xilinx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
