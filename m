Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1A3A3277
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFJRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:52:36 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:37638 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhFJRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:52:35 -0400
Received: by mail-oo1-f53.google.com with SMTP id k10-20020a4abd8a0000b0290249ed2f2919so85392oop.4;
        Thu, 10 Jun 2021 10:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NeXPeoGgdwqVg+0zla10NtNb6Gyin6Kob8zl01r9rKA=;
        b=OHkhhK9GTu+vtbd6WgjHrWfSajoXItnq2ezndj+3sS4SA/inunkGKREeq4OIrKs3aC
         9FTGEcaU+W8J4eAZplPIR8KtwtdJ8DE0RUuktvjVMgDz6yw0y0/4fXVgjgTf3LkiATPA
         BtvzABKN0IvU+jQlxfbGKJBibA1LUrzZZ7jXCqawxkmEIVvLVCj/CBR/6IPlh0h3Jv9M
         v8idvCgiVZJzDoivXQk6YXfvKirVudSN3YiiTYF3mn6xuN/+q0dM0C3eAfc3lHpEWSSH
         3TNk+lLJWng2Mi6umg+Lyp7obubcJmc5dibUTsCqLoOeirEzTXocQf4e6oMLWQJqZApN
         pWgQ==
X-Gm-Message-State: AOAM5300WCVT9VHsbAs6TARe526vtuAdKSwk5q7V5jrIkpQ20BFV8HpJ
        BEPVG0dbtKjRHhoYfwu+hQ==
X-Google-Smtp-Source: ABdhPJzqi1ApRbqW5KOE33CLWJkfrZffEQeEfH/il8Xk71CokpwyU/VQWSx8856WyKsOFoDCkjQDbg==
X-Received: by 2002:a4a:9b0f:: with SMTP id a15mr3224210ook.4.1623347438659;
        Thu, 10 Jun 2021 10:50:38 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id n127sm664477oif.55.2021.06.10.10.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:50:37 -0700 (PDT)
Received: (nullmailer pid 2331980 invoked by uid 1000);
        Thu, 10 Jun 2021 17:50:34 -0000
Date:   Thu, 10 Jun 2021 11:50:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: clk: zynqmp: convert bindings to YAML
Message-ID: <20210610175034.GA2294595@robh.at.kernel.org>
References: <20210602001449.780075-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602001449.780075-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:14:49AM +0900, Nobuhiro Iwamatsu wrote:
> Convert common clock for Xilinx Zynq MPSoC SoC bindings documentation
> to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
> 
> v2: Fix warning with DT_CHECKER_FLAGS=-m.
> 
>  .../bindings/clock/xlnx,zynqmp-clk.txt        |  63 ---------
>  .../bindings/clock/xlnx,zynqmp-clk.yaml       |  63 +++++++++
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------

Why is this removed?

Otherwise, looks fine.

>  3 files changed, 63 insertions(+), 190 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
