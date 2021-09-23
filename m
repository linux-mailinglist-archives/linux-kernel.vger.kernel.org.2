Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A741639F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbhIWQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:51:43 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41925 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbhIWQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:51:42 -0400
Received: by mail-oi1-f171.google.com with SMTP id s24so7956528oij.8;
        Thu, 23 Sep 2021 09:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+3tojMz0oyw8FqGzN1wz11Os587TDZQGTeSsmPPlxM=;
        b=s6lYI+Ivi49s8cZjd0OrVqhSzXrckjGUR5qOxyo8yQIBdBr+p5lv1ly4EO/v6Wht04
         +l6fi8N/elRo1Mi2XH0Was6NL066biSLaypNE39w3J50FrY5pwcSt4PG1Li3RVZ1HJu+
         jjtIMFzWQMkLMU1eNPl9DHmxpJES8NxkZDDbxeVjOBi1Np2qO9NLHBUoYBQgLByIiynA
         +S6VxxFqtCBqxcEPc9AkspIDijB2UHrHJl5uPE/gtVYDQPkyKeN9rRKyUe69qz2kfuPh
         o2o0ujtk9ip1xVASCJPBfi3FSyFpqGDRJw9n801OGfZxcidO7t7eMCuU/5YlpoDycmDl
         fW5w==
X-Gm-Message-State: AOAM532Bhcxh9388SujCcuUKRcR9/06uiX1EGvlUkijZbmi6d6NlZ8VH
        JZyrWAUxGW+A8BUkvArUMg==
X-Google-Smtp-Source: ABdhPJzoDjVkVqr/4jmmFSGvnqfFFjB0oTLcCVk7E2haCrEZkfMCKDYIxie4myybjMPIZn0g2j/98Q==
X-Received: by 2002:aca:3d07:: with SMTP id k7mr4565904oia.6.1632415810433;
        Thu, 23 Sep 2021 09:50:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n4sm1403468otr.59.2021.09.23.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:50:09 -0700 (PDT)
Received: (nullmailer pid 3155331 invoked by uid 1000);
        Thu, 23 Sep 2021 16:50:08 -0000
Date:   Thu, 23 Sep 2021 11:50:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, jamipkettunen@somainline.org,
        Hector Martin <marcan@marcan.st>,
        Sudeep Holla <sudeep.holla@arm.com>,
        angelogioacchino.delregno@somainline.org,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, martin.botka@somainline.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        marijn.suijten@somainline.org, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 01/17] dt-bindings: arm: cpus: Add Kryo 560 CPUs
Message-ID: <YUywQLpCjKhipZeA@robh.at.kernel.org>
References: <20210923162204.21752-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923162204.21752-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 18:21:47 +0200, Konrad Dybcio wrote:
> Document Kryo 560 CPUs found in Qualcomm Snapdragon 690 (SM6350).
> 
> Reviewed-by:  AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

