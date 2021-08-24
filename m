Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841F23F630A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhHXQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:47:15 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:40758 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhHXQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:47:14 -0400
Received: by mail-oo1-f50.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so1400429ooh.7;
        Tue, 24 Aug 2021 09:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/Go7mYfTsGdoHm9R20lm5CkXSoHk7jMuDjAICMbtHM=;
        b=aOjZLKUdo2DIuY9ERBqDACuxpkWLYR+eW92ILg1Wr+8MtsgC2gBmQZNgeJl2wqnj1j
         dxpnN1XjcF8pCaOmPMTEHKYLAbQvy1UAsY/k6JOInwF7/j/KpRVeVfbtSlQusJP0yFj6
         AeUg93t2O/kIjCHGLXL84C33pH0lMJSlwJTkcFOJ37s26/SVyvLWtGxAxYVGQytbYwM5
         nQNyqQU6uGvdjEXbxSGuD5+LMr5vo9yk9X8xQaPokY8gjptQVfPyxCaEu/uhoYEH8kuM
         6Xi8Hwy+jHDDdzMbFAkPRmF3h1637HtIXs1vCdV/IMHkrvncY+j7FvuujAb0lOZ+ubCy
         1Npg==
X-Gm-Message-State: AOAM533VbL9mJQ+gS9o1gMUwZRoC9aFDbNlPpBjvFofVVUndhLK5VeFN
        T7EDYutOz1/RQGttWs494w==
X-Google-Smtp-Source: ABdhPJyRkbgoI/M8uUuVo/tXkAUtJhkRyDwN3DW6AfdYq//2HKkaQLZzqmozsgAE6Zvuu/xcW8++mg==
X-Received: by 2002:a4a:bc90:: with SMTP id m16mr30351409oop.33.1629823589757;
        Tue, 24 Aug 2021 09:46:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x8sm4138094oof.27.2021.08.24.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:46:29 -0700 (PDT)
Received: (nullmailer pid 606294 invoked by uid 1000);
        Tue, 24 Aug 2021 16:46:28 -0000
Date:   Tue, 24 Aug 2021 11:46:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     martin.botka@somainline.org, Mark Brown <broonie@kernel.org>,
        jamipkettunen@somainline.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, marijn.suijten@somainline.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hector Martin <marcan@marcan.st>,
        angelogioacchino.delregno@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 01/17] dt-bindings: arm: cpus: Add Kryo 560 CPUs
Message-ID: <YSUiZDvn6cqgKvjz@robh.at.kernel.org>
References: <20210820204926.235192-1-konrad.dybcio@somainline.org>
 <20210820204926.235192-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820204926.235192-2-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 22:49:10 +0200, Konrad Dybcio wrote:
> Document Kryo 560 CPUs found in Qualcomm Snapdragon 690 (SM6350).
> 
> Reviewed-by:  AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
