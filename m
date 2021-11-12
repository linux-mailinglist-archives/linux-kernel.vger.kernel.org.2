Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB844ED7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhKLTsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 14:48:09 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:43687 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhKLTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:48:08 -0500
Received: by mail-oi1-f169.google.com with SMTP id o4so19790929oia.10;
        Fri, 12 Nov 2021 11:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o9jrDKQ4fjNCOUEJ8zhk4VvvXrOjUmo60wVpBZ9U9F8=;
        b=PsOmqcYqz+3dBBuL3XR6w50gqq50ZB4xHpE4GKkkBYy89Qqq+J30sLVx4RmgtlK1bO
         VM21QpNoUz0jIED9Rt6UQ+AyAkZKCFwpk26SOFgLfpMK/2owdM9goR4H2NVSg7WHRT5S
         H850kmOF7SBLfHbleOpCFJyjaitwSDG29fWVhz8EFa4DL3TcB6zAeAoX8jxWfY3WhgOX
         rwt2mLVqHG9mbw0OMvzt1Z6UokqVBWRoNVuV1Bozp+l+G4BMjsh2EkLshgYwiHXEIHvl
         kESd7QpcPXxHXLpglqSia9RPWG4MXnvDzAkmjNWRsczvqwg9uy43OO6zjBWbkZ51DWVg
         KAQA==
X-Gm-Message-State: AOAM532ottV5wkwoI30OqB0XnOc2mz3nJje8tBiUGVZxsOZ4A9rZedL6
        /IGrR2m+TzVlNaN8uf1bEA==
X-Google-Smtp-Source: ABdhPJx7UiZWuIIzis3sJr5PzLy6sye+NuATX+XCzj4kjnL1/QRPGd1ZXk5+V8nbpJJnSbNEH1rxwA==
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr15277616oie.11.1636746317276;
        Fri, 12 Nov 2021 11:45:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 64sm1385919otm.37.2021.11.12.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 11:45:16 -0800 (PST)
Received: (nullmailer pid 3249418 invoked by uid 1000);
        Fri, 12 Nov 2021 19:45:15 -0000
Date:   Fri, 12 Nov 2021 13:45:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     guoren@kernel.org
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add T-Head Semiconductor
Message-ID: <YY7ESxm59ARj1J8h@robh.at.kernel.org>
References: <20211103020921.3870764-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103020921.3870764-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021 10:09:21 +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add vendor prefix for T-Head Semiconductor [1] [2]
> 
> [1] https://github.com/T-head-Semi
> [2] https://www.t-head.cn/
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree <devicetree@vger.kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
