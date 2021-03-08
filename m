Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66133183C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhCHUMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:12:12 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:38460 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhCHULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:11:46 -0500
Received: by mail-il1-f174.google.com with SMTP id f10so10018836ilq.5;
        Mon, 08 Mar 2021 12:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QpbDs8aiZXfIsuQ/5DPkHrIH9XnSKt6WGe3vBO4wbZk=;
        b=akGotcVAdui+wwXN21O9zHYGuH5Xpgd6zoYhCxRoBX/hq7RjsHgB78FVjZ9Oma9rHW
         FpnwSI3/IX20aAovjhWPq+/SXEn29dOKxAgdRwNB0PROcGZLHjiW4ZeM2gfAgRv43NFA
         4KQSClTzs8gJH/dZX3s1HJwn9/rAWTJUXuYrCJEp//QHcwE1IfqSrqXZqEvMRrw2l+FY
         bJwsiSHMNCvsmiLe/jnBLNjsqiImE1nJC353Bx4RRC9ZG5zmynOjn6eE1qs6RJzc4WOS
         WieGl9jvLTW7B+YDmVjLYA3VDrHChKUhxJ2EAF3T5f+6ElBlQDMmV/iyyhIBwWmH5zSU
         i4+A==
X-Gm-Message-State: AOAM531g7C9RKow0/iQcMQsDaqnjLxaM6AbqcGb/dzg3Ka1q2LWPP7DN
        vBe4I+zPCn0wuflpc/X68w==
X-Google-Smtp-Source: ABdhPJy1v1gp365lFTBHUVGJNK4dZ9aUhoTBhe/Jx60UxTgiblBfbdL8fUjqlBldQdF55LQH3hKPUw==
X-Received: by 2002:a92:4a07:: with SMTP id m7mr20291705ilf.51.1615234305373;
        Mon, 08 Mar 2021 12:11:45 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g3sm6429469ile.10.2021.03.08.12.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:11:44 -0800 (PST)
Received: (nullmailer pid 2883952 invoked by uid 1000);
        Mon, 08 Mar 2021 20:11:42 -0000
Date:   Mon, 8 Mar 2021 13:11:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Ivan.Griffin@microchip.com, Anup Patel <anup.patel@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor.Dooley@microchip.com, linux-kernel@vger.kernel.org,
        Lewis.Hanly@microchip.com, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: riscv: microchip: Add YAML
 documentation for the PolarFire SoC
Message-ID: <20210308201142.GA2883896@robh.at.kernel.org>
References: <20210303200253.1827553-1-atish.patra@wdc.com>
 <20210303200253.1827553-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303200253.1827553-3-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021 12:02:50 -0800, Atish Patra wrote:
> Add YAML DT binding documentation for the Microchip PolarFire SoC.
> It is documented at:
> 
> https://www.microsemi.com/products/fpga-soc/polarfire-soc-icicle-quick-start-guide
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/riscv/microchip.yaml  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
