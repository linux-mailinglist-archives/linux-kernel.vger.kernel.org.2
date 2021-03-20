Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF108342F60
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 20:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhCTTtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 15:49:10 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:52489 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCTTsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:48:36 -0400
Received: from [192.168.1.101] (abac242.neoplus.adsl.tpnet.pl [83.6.166.242])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 743991F53D;
        Sat, 20 Mar 2021 20:48:31 +0100 (CET)
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: tsens: qcom: Document MDM9607
 compatible
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210319220802.198215-1-konrad.dybcio@somainline.org>
 <5733a2bf-8a75-2224-b821-eeb8556c6914@somainline.org>
 <a7018d4d-7c95-370e-9d47-615f63a65a22@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <fafa8304-2445-8413-b98c-8269ee033776@somainline.org>
Date:   Sat, 20 Mar 2021 20:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a7018d4d-7c95-370e-9d47-615f63a65a22@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20.03.2021 20:47, Daniel Lezcano wrote:
> On 20/03/2021 20:01, Konrad Dybcio wrote:
>> Add the compatible for MDM9607.
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>> v4: separate from the main patch
>>>
>>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>> This change was previously a-b Rob Herring, I forgot to add the ack back in after separating the patch, sorry for that.
> Can you point it to a lkml@ archive ?
>

Sure, it's been acked here [1].


[1] https://lore.kernel.org/patchwork/patch/1372052/


Konrad

