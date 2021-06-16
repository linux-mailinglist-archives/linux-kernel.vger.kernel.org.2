Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81F3A9A73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhFPMcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFPMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:32:01 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:29:55 -0700 (PDT)
Received: from [192.168.1.101] (83.6.168.10.neoplus.adsl.tpnet.pl [83.6.168.10])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7DC893E7E1;
        Wed, 16 Jun 2021 14:29:53 +0200 (CEST)
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: sm8250-edo: Add hardware keys
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210616122708.144770-1-konrad.dybcio@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <d7584f80-8796-1ebf-0e83-8d63d707f61e@somainline.org>
Date:   Wed, 16 Jun 2021 14:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616122708.144770-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.06.2021 14:27, Konrad Dybcio wrote:
> Volume Down, GAssist (pdx206 only) and camera keys live on PMIC pins,
> with the latter kind being broken for now.. Add these and PON-connected
> Volume Up & PWR.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../qcom/sm8250-sony-xperia-edo-pdx206.dts    | 11 +++++++
>  .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 30 +++++++++++++++++++
>  2 files changed, 41 insertions(+)

Forgot to add, still depends on [1].


[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20210613124822.124039-1-konrad.dybcio@somainline.org/


Konrad

