Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02041A36E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbhI0W6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbhI0W6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:58:00 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:56:21 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so2523767oof.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKsqa3SqTL2L2BbXmeg1oJgK5GPSnartmjj/QEt/cAU=;
        b=UEEG3tZ0qWldqhn3b3u4EFt29M3asf8SGGJWMbQcra8KTSDFZMgUuhj5zckADZ9AH0
         YYI9P5KKLBBUA1SQfxQ017wUlqzK4CWJjDpiV38eiuAtnivSo3L9/fmXDqgtkKc2MFG3
         HWCpGoUis2KnNPcwMiHcfHlKD4D3g6sdShamVS0WToJBv/5jOPGXK53dKa2XOOP51vm0
         e6dClJy2lrvkQPQgE5Nn0Ln/c4AT1FuHu9Q5a4r0lnXypkRrGH6YP8MJZJ1xpGM1Qc2y
         xT5DdBJKXN08zSZ5PSi2bryv0hFRB7a9mIE23+DN0Mq1ykbQkTJTKhpKYs9LU+ojmTSQ
         0ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKsqa3SqTL2L2BbXmeg1oJgK5GPSnartmjj/QEt/cAU=;
        b=7OPpExpnuM0NxtdbxiieTs4D5gy8OGPaWiiWnmaQfUzW9N/uIiimVJ8l95EiuX7KUa
         PntKwsYBeN5+tSuXqJ7QIIatJUr59EkWSR8Vzk94S9yYoEIuPDNubGOh3d2/ajSpJ5D6
         +DwlukyRtadoTLtqSvbIjCC66b0ANi/3MgJY34LrfdrQm1EyI90P9pfVRXoc5RyQNYno
         M3EuBv5z32Jkad2XO/dCTedzapXQQjF7fboKri0q8VO4mooOWVLp4DfwuCCzo85IWzec
         CEGQJrA79Nq4cFDQoSfUfcEJI27GMr4rPfoVCbtG1tA50W09sJfGo7wDoT6lA4by+hhZ
         0XqA==
X-Gm-Message-State: AOAM533Xhz9Npu2zVU4fXdoz6Mv7mhDtAxSIlM+x4JRr/FnogjitIq1N
        3KmwdmGiMM7tSWAbfmnOtlR2vA==
X-Google-Smtp-Source: ABdhPJxIy75DMZxiDPC4qWQGvBYkGVwhM3XkxwnPrZJFtkZ3tG6smmskZ7w1qdKIeiUKIIqmzXXp6Q==
X-Received: by 2002:a05:6820:16ac:: with SMTP id bc44mr2087402oob.5.1632783380971;
        Mon, 27 Sep 2021 15:56:20 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w184sm4231084oie.35.2021.09.27.15.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:56:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        marijn.suijten@somainline.org, Hector Martin <marcan@marcan.st>,
        martin.botka@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        angelogioacchino.delregno@somainline.org,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        jamipkettunen@somainline.org
Subject: Re: [PATCH v3 01/17] dt-bindings: arm: cpus: Add Kryo 560 CPUs
Date:   Mon, 27 Sep 2021 17:56:14 -0500
Message-Id: <163278329750.1522839.9000742662436715299.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210923162204.21752-1-konrad.dybcio@somainline.org>
References: <20210923162204.21752-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 18:21:47 +0200, Konrad Dybcio wrote:
> Document Kryo 560 CPUs found in Qualcomm Snapdragon 690 (SM6350).
> 
> 

Applied, thanks!

[01/17] dt-bindings: arm: cpus: Add Kryo 560 CPUs
        commit: 55d0feb3ab3de31320db41c92eaac6d73c644a6d
[02/17] arm64: dts: qcom: Add SM6350 device tree
        commit: 5f82b9cda61e60a7f381a4aa427fa9eb472e581c
[03/17] arm64: dts: qcom: sm6350: Add LLCC node
        commit: ced2f0d75e132a611f6239846b853452c23e6176
[04/17] arm64: dts: qcom: sm6350: Add RPMHCC node
        commit: 985e02e7c0626a1e07c532bda5b6812f4ba5072c
[05/17] arm64: dts: qcom: sm6350: Add GCC node
        commit: 30de1108df222e760297ed76f1ff1b4acc960dc7
[06/17] arm64: dts: qcom: sm6350: Add TLMM block node
        commit: 538f4bcd5106aba43c5864ff86797662df8c30ec
[07/17] arm64: dts: qcom: sm6350: Add USB1 nodes
        commit: 23737b9557fea0d3069b0fbbecce3b1c09737de5
[08/17] arm64: dts: qcom: sm6350: Add cpufreq-hw support
        commit: 3cc415413f540403a0cbc36a49aa40ba764f708c
[09/17] arm64: dts: qcom: sm6350: Add TSENS nodes
        commit: 25e0ae68481905f40c41d6b588d221354fb36055
[10/17] arm64: dts: qcom: sm6350: Add AOSS_QMP
        commit: 8fe2e0d9dba8cafa98dbd6c8f3cfbc6a20bbc93a
[11/17] arm64: dts: qcom: sm6350: Add SPMI bus
        commit: 001eaf9514f22eb9a01725a0c29b3f46cd7cdc0c
[12/17] arm64: dts: qcom: sm6350: Add PRNG node
        commit: 574af54562440e7036a7b4a71d016f166ca2e830
[13/17] arm64: dts: qcom: sm6350: Add RPMHPD and BCM voter
        commit: 9264d3c8ee511b5c246f2dd96fc94230c2b588f6
[14/17] arm64: dts: qcom: sm6350: Add SDHCI1/2 nodes
        commit: 1797e1c9a95cd052ad481968e078c9f2beec0e8b
[15/17] arm64: dts: qcom: sm6350: Add apps_smmu and assign iommus prop to USB1
        commit: 4ef13f7fe4cd9e29118e09597b4fdd721fd24c11
[16/17] arm64: dts: qcom: Add device tree for Sony Xperia 10 III
        commit: ed1648d52a375e606a0c88f5bf65282686ae6541
[17/17] arm64: dts: qcom: pm6150l: Add missing include
        commit: a9a5ca5c8c37793aaf8fb99f593ac9ddad0bf0bf

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
