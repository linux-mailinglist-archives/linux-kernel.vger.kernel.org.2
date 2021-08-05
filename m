Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1C3E181C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhHEPf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHEPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:35:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1BDC061765;
        Thu,  5 Aug 2021 08:35:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l8-20020a05600c1d08b02902b5acf7d8b5so3302920wms.2;
        Thu, 05 Aug 2021 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e8yF7W5kwQSE15C2w3dwLP7AW+KLjZQaFC34eOyj880=;
        b=Px2DyqRFw+DcAzN9Se80GLd810eRZUri4kxdIHMZeKFsJfh3/6FtPXhGCV9c3s2lye
         VI8X6Wr0DsfEX/S/vS2BCJHenbX67o2jCmoOJBTgqsfqFOHwHADmduKKudoFp7R2MjGx
         IQyzhbAYlZwhQ71Zb6Cvo1QKixvMksvjDQns0i39Tchkn3CWZ6SGmGOZtDkJYmnW3VAr
         n/fmT5sn5+vScAJK705SI1CF0E3p5RFwhfHDFKkXpFViT/TcPVuY2IXHyzomdWHEDx1g
         D4gyzjLc/ys6RMSQdQva9eBlbcuqjYqikGClDyxn7hfsS7XMLW9ggv+0BzTAbLzt4Vzs
         nPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8yF7W5kwQSE15C2w3dwLP7AW+KLjZQaFC34eOyj880=;
        b=cRu29ptoGThzKXIq1UTXUipF929Nl2sew/MQK1i5d7CbkhUs3rbxyxxF0Gt5j+2zWC
         8So9DfcVdSP8yIvhqrvtWtxRqmwiLEvchlFoGrkIYAKxY6H/OGtmw/6+EpOYRQa9vks+
         jFg5NvtvInCeiJzV8GigjNBx1HQE2uFMbUdqZXs3FtwrvFQeW5ASKIcEtYMPMELf0UxV
         fyTHJHp/REuF851O9ZCW6MnZt07HGpNNd+IX+1TQj+TLp+tjBYqAlz9ThUv4ryr0c8oJ
         KpQTRHdRsdd3foGWcWIcf8iTboCMBVzSr6NBcdagngBFaa6lCutN/AVWsQEPqXF+kLe4
         esnQ==
X-Gm-Message-State: AOAM531KcmLU0ZQjsi08ASN5OwS6UUj+1m9f3MJZ2tqJnvLLv9IplLgX
        59Zjru6SJlDZ+LzqsD2uvids9oM8BLJy7g==
X-Google-Smtp-Source: ABdhPJzUbDsFxcl3SF9H4VKEhhq1IOGoLpg6RQ0UVVnvwVDJP321SBzN7VPw7laWZejK9voRoiB63Q==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr16383078wmq.47.1628177711058;
        Thu, 05 Aug 2021 08:35:11 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id w13sm7901714wru.72.2021.08.05.08.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 08:35:10 -0700 (PDT)
Subject: Re: [v14 02/21] dt-bindings: ARM: Mediatek: Add mmsys document
 binding for MT8192
To:     Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
 <20210726105719.15793-3-chun-jie.chen@mediatek.com>
 <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b98aeeee-c544-3025-cc06-ec04be7ab638@gmail.com>
Date:   Thu, 5 Aug 2021 17:35:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2021 19:53, Stephen Boyd wrote:
> Quoting Chun-Jie Chen (2021-07-26 03:57:00)
>> This patch adds the mmsys document binding for MT8192 SoC.
>>
>> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
> 
> Applied to clk-next
> 

Please drop this patch. The mmsys binding will change to yaml in this merge
window and this will create a merge conflict.

Thanks,
Matthias
