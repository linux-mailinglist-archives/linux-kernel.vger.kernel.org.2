Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05337D1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351381AbhELSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbhELQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:26:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C1C06138C;
        Wed, 12 May 2021 08:55:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so4678015wrs.4;
        Wed, 12 May 2021 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VWsd8P+/clpyE0bHHUTPwD2kU5tZcJeb3jH59tmqXLI=;
        b=teO0yxmgWsLewvAzd7+q2EYj2Iq/RFxCoukA2Mu0QntKo39hWLFwYV85k9ADjkyU0p
         1mZKT/d72aOAiLMnmA4875PFINxbRexIs5Id0TM7+9v1ZwS7R/2c2fZOQAixvP+QJ0Lc
         6RDqNQSEN4a5luBFi3NAS40m8uTkxKtSsoL4+P7tMsKvF0nvIX0i8f/zfQc9+MAklF1z
         2Yhp/31DNBrwxS3Zs7zb7EJXNmhuH/zffM0OKe4xAh+Zmcfn6Sdb3/6LWMc/hW9NNJUu
         6mjzDzGQMVU91s3PVvBVafF+uZKPGds1tmhmWIcYf68FyeGDwPCEYuNc0uokWW+gvxcY
         UGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VWsd8P+/clpyE0bHHUTPwD2kU5tZcJeb3jH59tmqXLI=;
        b=IN5ELSxDtBaJVq7cXanC+JqTVueVz8evar7xgTXh+7SHPDNhlfcx72javVl1Or08ns
         9AG9Fmb/ccej9/Y8VTcL6YWcGxfqCT5WFU/fXSMHR+V9C3PJioAHux+YviocGJNtSpdr
         Dv4DfZ0fWB51vn2NAAtUo6LmDNgIeROwdh80I1PGZKOM/NYeTAnuXNty/CSpj/YhvqEc
         7qL9enaeV5YDFk25avgCn6Ro60+SSbU41xpALV/qaqRog/Xu49R0SzS9DnW93y3ZC+FF
         0vlhlmgFSHdcm/0H3G247+78/pBL/EhuzI0MtoWPja3l2/n3K5va9mbHEU0pzZFCNENK
         IasA==
X-Gm-Message-State: AOAM530hvTLuaUg8nUd/8UnKK+HUUCJq73drSiuFQylLNnfm9z9MAd/N
        c09qlEo06YiETwXHwKZJ9Zs=
X-Google-Smtp-Source: ABdhPJz1MaDA4gtjBPt57L7+5y/dDi6iluOMqHAbzWspXUgRbOub+cvoog0I72CcKc8Ep5AymBJhRQ==
X-Received: by 2002:adf:ed43:: with SMTP id u3mr46322177wro.334.1620834923250;
        Wed, 12 May 2021 08:55:23 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.37])
        by smtp.gmail.com with ESMTPSA id a21sm6613105wmj.34.2021.05.12.08.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 08:55:22 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] dt-bindings: mediatek: Add optional mediatek,
 gce-events property
To:     Rob Herring <robh@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20210504054612.3585017-1-hsinyi@chromium.org>
 <20210504054612.3585017-2-hsinyi@chromium.org>
 <20210506203124.GA753747@robh.at.kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a573e490-44bd-d6a1-d0c0-075b6541f720@gmail.com>
Date:   Wed, 12 May 2021 17:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506203124.GA753747@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On 06/05/2021 22:31, Rob Herring wrote:
> On Tue, 04 May 2021 13:46:12 +0800, Hsin-Yi Wang wrote:
>> This property is used by gce clients.
>>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> ---
>> v2->v3: move definition to Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>> ---
>>  .../devicetree/bindings/mailbox/mtk-gce.txt       | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Will you take this through your branch, or do you prefer me taking it through mine?

Regards,
Matthias
