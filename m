Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A916030A38F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhBAIuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhBAIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:50:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC77C061756;
        Mon,  1 Feb 2021 00:49:19 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so15593033wre.13;
        Mon, 01 Feb 2021 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5quN8hgyIirr+TXubErY4OwtDxCoITlt00TDLVsUo4=;
        b=t+Dew0pqvYUsHeFn9pF7XWtG201+klBjCcn+/NsZZrV/OFPyuGvvFzJoYoXgKb073S
         0CrnmhQWlmbW141DHdeHwtCee2wYX97/nzUpd3hnxpaCfZqT/K0Z4tD76Lh4O1tW0GWK
         sv84IYnI21eOChgIUjL4HnSwuAieM46HZ89OlLlN1PJ/ZvbTao0GQfkXgQgvou5Ays2B
         EcLd8y4f4Pj2xpcoVcJPXZwGOtpkIbO9MY9SmUscn+YlMblT8zeyqLxDp3aNlKTQWlgQ
         NLlCcvlpngW2NToD5vVFUH2p282NzcPsH9wonCOxu26I6FgnDc0vvsvedLNSej+vKP5h
         EnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5quN8hgyIirr+TXubErY4OwtDxCoITlt00TDLVsUo4=;
        b=dvYQqtO70Yi1+vQ7gmwgARaS94+yYL9YvkwuBSuHTPuxkNhRDywrlaasTWS8snA8Vk
         U1obEG3SA6rUF9BT8glQrS9UaNUUXWscoHMfiJ1Beq4LidF3nbye5QFUKoTQvy/7DJH4
         5AdskVwwWJ9mPbUCwUH4V6MXxJT0t+NDDoey9cCWvp+pyCLJqeKs+pRA4C1vR5NJP4ID
         4UoqWltI3SGJVI903jay1oU/FiMCmgxOiwIZTMj+B7FtM2ckA6YvLBPOTZ84G5ajr0J+
         HZX1swf1wx69xNHHMA+eCRm8DBCG/0DhIH+0gNxOg0QeCx0JjYLPjBWa8jaArxNxlsbG
         CjPg==
X-Gm-Message-State: AOAM530NL4J/bP6CY+MjFbwnBcRYNiNA9wiG4rI98OAer2C8dU1md2WM
        hcAqWQEyyK0Yc63rimEiN1c8C7PXYwxRYXfb
X-Google-Smtp-Source: ABdhPJzbM41H3fnkeABFIvGY1igV7fKzPcE4QNnGj4BtjholB0xxbRzwTOXd6hDFTtno8iIZpSj3Pg==
X-Received: by 2002:adf:9b8c:: with SMTP id d12mr17286687wrc.51.1612169358007;
        Mon, 01 Feb 2021 00:49:18 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o14sm24788202wri.48.2021.02.01.00.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 00:49:17 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: mt8183: Fix GCE include path
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@kernel.org>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        DTML <devicetree@vger.kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210131101726.804-1-matthias.bgg@kernel.org>
 <CAAOTY_87TfpnScL+t624+FbdixosNpfoEkuMi8Y+h_RXttA7Tg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <42b6f5ae-bfa9-e28d-21b4-e3f91ad4b046@gmail.com>
Date:   Mon, 1 Feb 2021 09:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAAOTY_87TfpnScL+t624+FbdixosNpfoEkuMi8Y+h_RXttA7Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/01/2021 17:17, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> <matthias.bgg@kernel.org> 於 2021年1月31日 週日 下午6:17寫道：
>>
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> The header file of GCE should be for MT8183 SoC instead of MT8173.
>>
> 
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> 

Applied to v5.11-next/dts64

Thanks

>> Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")
>> Reported-by: CK Hu <ck.hu@mediatek.com>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>
>> ---
>>
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index 5b782a4769e7..80e466ce99f1 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -6,7 +6,7 @@
>>   */
>>
>>  #include <dt-bindings/clock/mt8183-clk.h>
>> -#include <dt-bindings/gce/mt8173-gce.h>
>> +#include <dt-bindings/gce/mt8183-gce.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/memory/mt8183-larb-port.h>
>> --
>> 2.30.0
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
