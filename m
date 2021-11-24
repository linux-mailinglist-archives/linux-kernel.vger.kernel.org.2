Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B722745CC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbhKXSfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:35:46 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45722
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229645AbhKXSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:35:38 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8256A40745
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637778747;
        bh=Bf1uh3YWXL2H4r1xsTDTAIBjjlx/QrqVMPemALuj4fo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=U8KC0+abP9KtobO1VFeEigAOE4mqsnLeaCZgYkHvMfH5+IFqOPCJEq2gLPchoYSIq
         oqxCerqdsqjZggxYuCrfGpkA38uSizrj+/RyZkwTb1N8TH5KXZxqxlZqaf5FEeNuHd
         EysXyT4oEN1OdZQE7aJEKNKhCnRQfuB2TJnV+63M/bcN7jkkSwn2nfxnJxoRnRgMnV
         TtDXdSrVIEGKlMGL1d3bEXDm3caJlB7NkAKPl7PHmG/u04a+EOU7JppubXbrseUC5K
         T4ZAVirqiQuJ0zJIp2sB8vBxFM46ljMxYAWHwpBVuKpIe0NRu0gei2xZaV5LuagzVU
         FVePy+KupU0gA==
Received: by mail-wr1-f70.google.com with SMTP id k15-20020adfe8cf000000b00198d48342f9so702126wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bf1uh3YWXL2H4r1xsTDTAIBjjlx/QrqVMPemALuj4fo=;
        b=PTuTBX1fG95DAA7Flhw4oMDgve5rjTgKS6cdACLz5ObXhAcAiCq3N/WuJbHeQB9IPr
         ODM6q+IkOOEsRtGPIM+rbcCB9FtAPwWZJRsDSfczX/C2Y8Xgujqtccw/nLudlyvhqGeq
         zvY6qqV4pn7wovHxg2VJfuH8TWPgUX7WoMWvrilgWOxHZFfawVrV7u9xF826nuDPIFRW
         XgYMRXhdWCpJsbU2SqnG9xVHbCG0DJ4ClPbZoc41ksnP4+9RX+2a7rAXYCbhU3NAn1mb
         e9AYj3jhPkrmoTCRY7iFuT9CHc1qDLU7weCkhqKdTQ4gi8/M16q+c/qnTeK8yA6KZdjC
         Iexw==
X-Gm-Message-State: AOAM531364uwl2L9NFyXrEe2Ccsss84f3iJgkRtpewHbnx0O6UiIh7di
        CRO7yp591geGquFIVGX31RNBc7pY6SZPoNVYEmPKi/Fa6LJDACglU/wzoVZ0IOo1NyUU1dfJh73
        /uhzQKn17zG5prWvQBtdvgSjatZuyhpo9HCmm1EuZuw==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr348296wrw.517.1637778747219;
        Wed, 24 Nov 2021 10:32:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPjesaQytFy9KXRteaHUSEUjaucTMGJcMRDlJ/uL9gDuFjulTL+Etd84c2+ov8BHcBal9YIw==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr348262wrw.517.1637778747063;
        Wed, 24 Nov 2021 10:32:27 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id m3sm523251wrv.95.2021.11.24.10.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:32:26 -0800 (PST)
Message-ID: <6fb932ea-3a3b-9a7e-4d72-276c9975eccc@canonical.com>
Date:   Wed, 24 Nov 2021 19:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 0/2] mfd/regulator: dt-bindings: max77686: convert to
 dtschema
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211008123552.191384-1-krzysztof.kozlowski@canonical.com>
 <YZ5ayQBtPYiSconZ@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YZ5ayQBtPYiSconZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2021 16:31, Lee Jones wrote:
> On Fri, 08 Oct 2021, Krzysztof Kozlowski wrote:
> 
>>  MAINTAINERS                                   |   2 +-
>>  5 files changed, 216 insertions(+), 98 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
>>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
>>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
> 
> Tired to hoover these up, but they do not apply cleanly.  Would you be
> kind enough to rebase this onto at least v5.16-rc1 and resubmit please?
> 

Sure, I'll send a rebase.

Best regards,
Krzysztof
