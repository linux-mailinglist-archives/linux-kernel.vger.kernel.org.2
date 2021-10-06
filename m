Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8364B4247FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhJFUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:34:38 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:38896 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhJFUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:34:37 -0400
Received: by mail-oi1-f170.google.com with SMTP id t4so3983418oie.5;
        Wed, 06 Oct 2021 13:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDd9E5T03n2vxI01yjFnKsG9jwxaRdp2EqYWdDXBjCA=;
        b=aN9OeAKEkeDbwAE8ptQt2TOSaTA8FPIPl0DoW7def9fbjfDFUNcEu/EymHIfAWJ2PT
         xBijhQf606e7Zhj/FPq8Bz+XG8joRmdFBb3p3VkhPQIhnCn2MM9HgF6Y89uvSxn6NDSV
         r0cNxcJbTHQee9OapfCIUp9tfAABlrcnTzEsx2ZAVAIuKPcPmNUMd65nCbTf9JitEHYk
         zTsvaY2bW1X4NY203+7M8RgxY0g1X69gsjK1w1nnevqX3I7H/nLQQ21a4YELdtaWFapi
         ErK8X/YINGV2e9OBCFvOqOkMQu1c7srxlaDKoYkqm6flDQw4sscP+l/muMPVBuUZVebm
         HrxQ==
X-Gm-Message-State: AOAM5320gQ8R2eie7Els2vG0KyktbswNb3pT2o7rgTUooTsxfCyhYxxH
        9rtcERGN+8Klv1w/pBD8cyMH7V8J0Q==
X-Google-Smtp-Source: ABdhPJxLc/EN5VDLn26AhpSLGvisrobQ1w/V257gxn/nXd13idnhsNNmHpUKSoG8MuEZfiWv9wZcMg==
X-Received: by 2002:aca:de8a:: with SMTP id v132mr9084524oig.61.1633552364652;
        Wed, 06 Oct 2021 13:32:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a3sm4122017oie.3.2021.10.06.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:32:44 -0700 (PDT)
Received: (nullmailer pid 2820244 invoked by uid 1000);
        Wed, 06 Oct 2021 20:32:43 -0000
Date:   Wed, 6 Oct 2021 15:32:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: regulator: Add bindings for Unisoc's
 SC2730 regulator
Message-ID: <YV4H61+4j7ItSGKT@robh.at.kernel.org>
References: <20210928073609.198975-2-zhang.lyra@gmail.com>
 <20210928084607.220457-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928084607.220457-1-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 16:46:07 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> SC2730 is used on Unisoc's UMS512 SoC, it integrates low-voltage and low
> quiescent current DCDC/LDO.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../regulator/sprd,sc2730-regulator.yaml      | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/sprd,sc2730-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
