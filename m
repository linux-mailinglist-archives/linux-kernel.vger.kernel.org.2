Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D056C3DAB58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhG2StR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:49:17 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:41911 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhG2StQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:49:16 -0400
Received: by mail-il1-f175.google.com with SMTP id j18so3908482ile.8;
        Thu, 29 Jul 2021 11:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=swWGPTaEmlMPitLKWy04fjbN8VIFqtCKvu+vGSUDoUI=;
        b=rrb61vcvToeha3ZYN/uYRrY5yGX6fx8jtXi8jsfFJ/oVKtBbh3b5DuDgra03Vf5hun
         m0WU24HOv3Cygfk6D8ZaTaq/BACuamM+erT8DQtdb7+9QXjpjkwLYoUkiu9+KxbcVkrd
         Mt0G/0HJzSFYPSxhQY/a2lihkMD3kAr+wW7pCYahi4SShetVP3Po/sU19zRCde+5OLgN
         VqtWERl7dZ/e6tNql1/B8cQeDpEzEdHoAVltCMmbAdDliwjW0X2oqoCXytzib3F0f1Hc
         mqcyA5xtrstbpLcGypZVwi3vPw7M/k8ofUvhjPb1vhpWxjfo/4XwatMjvKhLjhZ3weCs
         gRLg==
X-Gm-Message-State: AOAM530fwF9H18WrDvNTciyMwNsxjXlkrTKe475VhU6+s0PA+G5wmvC2
        iwNK5Ktl+yk5al3Lbluz3A==
X-Google-Smtp-Source: ABdhPJxKXkWsezcjv7tKkzf55irbX8RvS15PDIKgI9ghrbqvu0eCcOE6gzQE+mL+cSyCtjOHhtV2tA==
X-Received: by 2002:a92:dad0:: with SMTP id o16mr4643242ilq.65.1627584552299;
        Thu, 29 Jul 2021 11:49:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z10sm2214039iln.8.2021.07.29.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:49:11 -0700 (PDT)
Received: (nullmailer pid 674429 invoked by uid 1000);
        Thu, 29 Jul 2021 18:49:10 -0000
Date:   Thu, 29 Jul 2021 12:49:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: nvmem: Convert UniPhier eFuse
 bindings to json-schema
Message-ID: <YQL4Jtbq/Yu5j1r8@robh.at.kernel.org>
References: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1626661864-15473-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626661864-15473-3-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 11:31:04 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier eFuse binding to DT schema format.
> 
> Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/nvmem/socionext,uniphier-efuse.yaml   | 95 ++++++++++++++++++++++
>  .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 49 -----------
>  2 files changed, 95 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> 

Applied, thanks!
