Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19E744DD21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhKKVhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhKKVht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:37:49 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255FDC061766;
        Thu, 11 Nov 2021 13:35:00 -0800 (PST)
Received: from [192.168.1.101] (83.6.165.118.neoplus.adsl.tpnet.pl [83.6.165.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B40621F5C9;
        Thu, 11 Nov 2021 22:34:57 +0100 (CET)
Message-ID: <16a5be92-f3f5-b946-bd9f-150e6737203a@somainline.org>
Date:   Thu, 11 Nov 2021 22:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: sdm660-xiaomi-lavender: Add
 PWRKEY and RESIN
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Min <alexey.min@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Martin Botka <martin.botka@somainline.org>
References: <20211111031635.3839947-1-danct12@riseup.net>
 <20211111031635.3839947-5-danct12@riseup.net>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211111031635.3839947-5-danct12@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.11.2021 04:16, Dang Huynh wrote:
> This enables the volume down key as well as the power button.
> 
> Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> Reviewed-by: Martin Botka <martin.botka@somainline.org>
> Reviewed-by: Konrad Dybcio <konradybcio@gmail.com>
Drop.

> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
