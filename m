Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0734163A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbhIWQw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhIWQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:52:55 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD19C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:51:23 -0700 (PDT)
Received: from [192.168.1.101] (83.6.166.81.neoplus.adsl.tpnet.pl [83.6.166.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 41AB43F565;
        Thu, 23 Sep 2021 18:51:21 +0200 (CEST)
Message-ID: <872977d9-e920-d4c3-0022-412095ff6516@somainline.org>
Date:   Thu, 23 Sep 2021 18:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 01/17] dt-bindings: arm: cpus: Add Kryo 560 CPUs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
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
References: <20210923162204.21752-1-konrad.dybcio@somainline.org>
 <YUywQLpCjKhipZeA@robh.at.kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <YUywQLpCjKhipZeA@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.09.2021 18:50, Rob Herring wrote:
> On Thu, 23 Sep 2021 18:21:47 +0200, Konrad Dybcio wrote:
>> Document Kryo 560 CPUs found in Qualcomm Snapdragon 690 (SM6350).
>>
>> Reviewed-by:  AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>
It was an overlook from my side. Totally didn't mean to skip the acks/r-bs.

Apologies for the inconvenience caused.


Konrad

