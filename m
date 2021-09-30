Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46C741DACD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350841AbhI3NSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:18:46 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39348
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350632AbhI3NSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:18:44 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C71940264
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633007821;
        bh=RCNF115QrSenyhS4+VUmTb+/09HgZQVEEH62W5zhJ9o=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NPBdil4tQLTdbn/InaRcY28R5pI15hbMigaqlVuDNvUHKLUI4t/k6TQ84trvRfQS2
         f23JmlvnVzvCcIduDKPldzYvsS/b21/um2jRTsF3CZymQ5CPiK9ZVGDIoZBEAk+xhW
         Fjbh+U19j8uXrSGlu8e0ugo337FaRr9czHMconAkylmLZLB4jVHcvvjJ08G7eJvXnx
         Kn1GifhLbxK/7I3+slh9wtQtBoj/CJjphNSpDgFXLE0LzHy1hmyIsVlkQypv74mpqv
         pHc2VdIR7O1X1zOuVXj7R+M2g4bHnW11VAXJlGR2k1Q1sNoMo0uKWUroM3Hom7gZzf
         5/oEBpi2r1eSA==
Received: by mail-lf1-f70.google.com with SMTP id h27-20020a0565123c9b00b003fca9e11144so5548942lfv.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCNF115QrSenyhS4+VUmTb+/09HgZQVEEH62W5zhJ9o=;
        b=zIcXgRCbLl/evkM/8U5hDS3jmlLuaC+XvRNhvGiO8SDlVe4fX3FX22VJziaQq3IeEt
         /T6YiL3ev8lbKkB0OJ2YcRjnbWmfPwbntddsvIMROWyhc4etoJeJ6beaLW9iXpYgv4rb
         6lyTJdl26Wzg/LSrNRrKNrBf6GW1jmrehKF0YB4NZ0MbxN+Mu67rvk72fltGflh0peR0
         PCq+IjxR+wlv6VJcsYT+y+C4OzG5Cqia5cYSjdogDfjFl03YFibsqTruXrVuhBwJnxCT
         QN45FkNzGOKku7mmKffnzvOMRkS4a8qNO3jVNXEYGs+ojMOBxy6qyue4q3ueG/rdwhkX
         iccw==
X-Gm-Message-State: AOAM5311XG9tp1ROgWVSlErBNFDglH9sVyEaREPHJkijcrb2JJSXoE6c
        VjNv3E0AAvbPP+08SmedtFwvH9ssgPovK9Y01dCWwhKvAM+ygXgkmx0bk6KkOpQ2GMO+7BRvaP1
        /IyURjkb5qL3hlLhRsUTMGKdl+fKKHS6Znt4oWGyKZA==
X-Received: by 2002:a2e:a596:: with SMTP id m22mr6316943ljp.262.1633007820686;
        Thu, 30 Sep 2021 06:17:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy09YmqEMO9K/DkFa/bZTei75H3U3dhuXPBwEhVk4C2y92R9e/R2akQYKqXZiF/L9tEarb/qQ==
X-Received: by 2002:a2e:a596:: with SMTP id m22mr6316925ljp.262.1633007820526;
        Thu, 30 Sep 2021 06:17:00 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id f26sm341405ljj.82.2021.09.30.06.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 06:17:00 -0700 (PDT)
Subject: Re: [PATCH 10/12] mfd: dt-bindings: samsung,s5m8767: document buck
 and LDO supplies
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
 <20210928084949.27939-11-krzysztof.kozlowski@canonical.com>
 <YVWx+08egbGPiYYt@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e5ab2ba9-e4ae-30db-8e54-8af42d7f3bf1@canonical.com>
Date:   Thu, 30 Sep 2021 15:16:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVWx+08egbGPiYYt@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 14:47, Lee Jones wrote:
> On Tue, 28 Sep 2021, Krzysztof Kozlowski wrote:
> 
>> Document the properties with regulator supplies for bucks and LDOs.  At
>> least one board uses it (Exynos5250 Arndale).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/mfd/samsung,s5m8767.yaml         | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
> 
> These all need Rob's Ack.

Correct.

> 
> But can you start with reworking the subject line please.
> 
> It should be:
> 
>   "dt-bindings: mfd: <component>: <Subject starting with an uppercase char>"

Sure, just have in mind that Mark wants them the other way around for
regulator. :)

Best regards,
Krzysztof
