Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379C5452FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhKPLJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:09:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57588
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234737AbhKPLIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:08:34 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F0B563F32D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637060734;
        bh=Z3pn3GdeY94Crx51QDkqArGQtoPgeuK++dovgb7tusc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uQZNjVReOuX8AQAzNGB0W40oeAquOKjXPihcM/An9joug0njfRgycO71CGBPyGp9q
         YwgiBAZlyYZgDUf59oDd94+OcC07ZX6TcrYiusR3YSi8eEMep9m23k5J0PuM9t5jsi
         QUmU/V84HViEx2vm5RRVSKyfC4H+ocdwpmt8dnzuII9a16GAVoAthmKQhRJioqtXqc
         KPtA3dC2S3uQ6ycR4a7FPcRPmCs3BJf6Ao1Fqrod7LpOnLn+3vOtkhVqm9kmy1mxWF
         mjXih8lKRZ1OJRKzCcAoNW1a9mCKa/BsvxPHFqm+kEA0j6az6Ju2BhwusBX9YeRThL
         J5YuidkmP4tSg==
Received: by mail-lf1-f70.google.com with SMTP id d2-20020a0565123d0200b0040370d0d2fbso8028388lfv.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z3pn3GdeY94Crx51QDkqArGQtoPgeuK++dovgb7tusc=;
        b=52TYrKBe6avzgdsI1JFcbRovgedCDD8uuWUutnBzUOBWKdz7MNEwD4HRG4rS+So3UC
         9el0Y/VBOTGUVqKRNCLyNYnJCWMCY37MoWRI+esDdmwfc2neW5D7X7VZZPNTubCNPcLJ
         J8kFwoLELQGSsa55aecBcu28D2T6lAKZ5X69oNL1b4lE39ExH/CG8gJZ5IMNeelRodO0
         Y84wmVp7ZoltLvxqx53BVZGON8XesU080oPnMpW5A5SZGnIBIIEgwk61map/EBs6W/wb
         GwVsQgdZ/xvB1mVPqi3ex36IDqgpcUWvYqKVGJlGXJRppYTxvE5YeQsvjazTHhHPgJk5
         So1w==
X-Gm-Message-State: AOAM533AJZle58LbE393ZKg4aSRi2qySEIIKxOX3qUK/k+7vfhOhe+CS
        AY/8sq/zu8oXL1MYVCRQYETZ72O941+UyLH52x6KQ90Rl2Zs0rNeP/N22ac1MbeG6J75PYtma3S
        8hgnpUQTAs564LNNvrCOdUMBlcURoEAAGPCObeUTszQ==
X-Received: by 2002:a2e:a726:: with SMTP id s38mr4983303lje.415.1637060734286;
        Tue, 16 Nov 2021 03:05:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGsVBgU4j2SaQSu3RItSe0Dm79nyIMrOE90s4v9rVKeB/zfelrLbFZad1bqrUOnXEdWDNpVg==
X-Received: by 2002:a2e:a726:: with SMTP id s38mr4983289lje.415.1637060734138;
        Tue, 16 Nov 2021 03:05:34 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bt11sm1725283lfb.208.2021.11.16.03.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:05:33 -0800 (PST)
Message-ID: <ce1618f9-3b56-8670-387c-bca6181089b1@canonical.com>
Date:   Tue, 16 Nov 2021 12:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Name gpio lines.
Content-Language: en-US
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
 <11612716.TMCrJ2abzX@diego> <20211116101713.77a0df69@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211116101713.77a0df69@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2021 11:17, Vincent Pelletier wrote:
> Hello,
> 
> On Tue, 16 Nov 2021 10:39:04 +0100, Heiko Stübner <heiko@sntech.de> wrote:
>> Hi Vincent,
>>
>> Am Dienstag, 16. November 2021, 01:52:56 CET schrieb Vincent Pelletier:
>>> Follow the pin descriptions given in the version 3 of the board schematics.
>>>
>>> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>  
>>
>> when sending a patch series with "git format-patch -6" and friends will
>> automcatically generate x/y additions like "[PATCH 1/6]" and so on.
>>
>> Please try to keep them around when sending, as automated tools for patch
>> handling like "b4", stumble when they encounter a patch series without them.
> 
> Actually my intent was to not make this a series, as in my understanding
> independent patches should/may be submitted separately from each other.
> They just happen to be stacked, and in this order, in my working copy,
> but should not functionally have any dependency on one another (I
> believe they should even apply cleanly in any order).
> 

This should be a series because the patches, even though independent,
are logically connected/grouped as one work.

Best regards,
Krzysztof
