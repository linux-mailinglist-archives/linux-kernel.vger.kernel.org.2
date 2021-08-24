Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C223F62F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhHXQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:44:18 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34496 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhHXQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:44:08 -0400
Received: by mail-ot1-f43.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso42667032otp.1;
        Tue, 24 Aug 2021 09:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIO4yu5v3nugKX0v8qkodez5zv/ce7WRouMIzLmKhqM=;
        b=G3YvdRY320F16uYS//5Y81sqeBmha6qjML9voguNGcyWxm5C/12Yy9pbrrQqAE0y9w
         raqdlB1yur25ENe5wJr2elQ9CFDZ+DgP/BSGY1PmBIWoxthkeIf0c1PnrbDYs3x0xFZI
         u1hzgVALhDZz97ihJjW/0QzeyPYxX6wSmvEulw09HGjiz9vTbU3mgOowfYsDa1twI9CW
         FqJ4zOZHsRzMz2EnBYY/aFlyn7N5QEjn8rLRoX+of6wP2T5t8nFKYsWoOtj21VoB8ONf
         CGcM+4gxrbJeFQIVQeaaSnyUW92q6bH0KZXNlXSQIOxlRqNB9K3zRiewXIDioy8GZrna
         HtkA==
X-Gm-Message-State: AOAM531SDmDob75O9GDFTVjp+k4FtQRdCdAK9hC1z2j6P/YHNDigx4T2
        aEb40TsRJjx48DSARVok1g==
X-Google-Smtp-Source: ABdhPJwVyWdA6yD2w5J16kaywnLz1ZItCHHJW7cJL2NRfJyowHJ+/M4d3ZbP9v7YVr+4XK360URUog==
X-Received: by 2002:a05:6808:19a:: with SMTP id w26mr3597447oic.80.1629823403506;
        Tue, 24 Aug 2021 09:43:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bd27sm1438596oib.43.2021.08.24.09.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:43:22 -0700 (PDT)
Received: (nullmailer pid 600948 invoked by uid 1000);
        Tue, 24 Aug 2021 16:43:21 -0000
Date:   Tue, 24 Aug 2021 11:43:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Manivannan Sadhasivam <mani@kernel.org>,
        Souradeep Chowdhury <schowdhu@codeaurora.org>,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        angelogioacchino.delregno@somainline.org,
        martin.botka@somainline.org, devicetree@vger.kernel.org,
        jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH 4/6] dt-bindings: arm: msm: Add LLCC for SM6350
Message-ID: <YSUhqVQEhCj599wU@robh.at.kernel.org>
References: <20210820203105.229764-1-konrad.dybcio@somainline.org>
 <20210820203105.229764-5-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820203105.229764-5-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 22:31:03 +0200, Konrad Dybcio wrote:
> Add LLCC compatible for SM6350 SoC.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
