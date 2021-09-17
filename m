Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B86040F8C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhIQNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:05:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60008
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239218AbhIQNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:05:15 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D485B40262
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631883831;
        bh=BtPQgu/JVrGaxOIwp6e1J+UI80xieldZPRf8MxNQimw=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=OsV44peeh5X8zHmmW9MwMKrZGTD++HZUCuDHma+K46MeNRxIFtDmyk3fAy9wc8zOK
         CWdrPrzGM1w6Gpa1E/YldOHsqRBG7pLtFI5k1Ieq/Yi+iYG0OK/C54mK07po9m1WyM
         JYE9RRQc0DAbEWVY7leFAECJSKf7WVV9TZv7y4Q2fM/YuNDyXXTPm1SXpAsfoAsr9h
         mhN1VfAsli0KSCtzPKFKvTJGiYbz6Hv7OMeMfR8M/08qDnSIJ9rIW2FaOxeJZMfjFA
         5fTJQaKlP2gEHmWZW+soFaCCpR55NrMpHZ+D651eN3eMcPF8CZvvFyIsh/cCKsNY+H
         xFr9X4UJroW0g==
Received: by mail-ed1-f69.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so6228983edy.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BtPQgu/JVrGaxOIwp6e1J+UI80xieldZPRf8MxNQimw=;
        b=GovQduxNqjpHlRaEeX4obrNfcK6sdZ5GbnYx5NlTK0jT70Q+jIb60xf4OpXPa8rHc2
         JUVNH5noFDcvd/s4Zk9UsmNKr0Q9azGySzTuDNCfZY0slv0gUFqGftBqQHcRlL1cSBrx
         f9u3nJM/7Nk8QSHXEnux5Jvcxg8mmG4Rp0jL57hPcy0zcm6jGHeX71pp7QyJy/jezU+D
         TiWMHS2OM+bQgdmthksHJAGIro8jBY60JxnSKbz7ZbJo8XXujUb+fdGjf8Ltd+9L81Ge
         J01j26f5GD/zNW4QAMNQ/k96CACCWyLmsF45VyLe3hDuy2lkCJHCr4QaJCc0qtmby0LH
         vDuw==
X-Gm-Message-State: AOAM532jo1fLFf4DDf/VTJowtEKe0UGPMIsrmoZwo4sPUJFFfyqkYR6g
        Qk+Df1qDl0CmWPmgd+XviitOy+UNsUchgneJA6bk8dl5uIEn10Q1XBUcxxHjeqGBxGlJt4rOzLD
        azgyr76hGcrfbTJVCO1vQyh8Uz6GKtxACNIjLMtSZ2w==
X-Received: by 2002:a17:907:8693:: with SMTP id qa19mr11652863ejc.497.1631883829639;
        Fri, 17 Sep 2021 06:03:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb9h8Q/Swzmu6LP3OJVFY5jF/ihVwDVg7z0XJ3AD8ulIfVhJIwCXH2O+TEtyHUlKtGsmSq0Q==
X-Received: by 2002:a17:907:8693:: with SMTP id qa19mr11652719ejc.497.1631883827947;
        Fri, 17 Sep 2021 06:03:47 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id e21sm2619082edj.47.2021.09.17.06.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 06:03:47 -0700 (PDT)
Subject: Re: [PATCH] ahci: remove duplicated PCI device IDs
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandra Yates <alexandra.yates@linux.intel.com>,
        Shaohua Li <shaohua.li@intel.com>
References: <20210917102442.24818-1-krzysztof.kozlowski@canonical.com>
 <dbfab8de-487d-a5ea-6397-7e16c5eb5185@opensource.wdc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <649b7c3b-0e01-0d26-ed03-c5ac66e32bce@canonical.com>
Date:   Fri, 17 Sep 2021 15:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dbfab8de-487d-a5ea-6397-7e16c5eb5185@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2021 13:21, Damien Le Moal wrote:
> On 2021/09/17 19:24, Krzysztof Kozlowski wrote:
>> Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
>> as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
>> has board_ahci_nosntf (for ICH8).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> Not tested.
> 
> I cannot test this either. I do not have this hardware. No chance of getting
> this tested by someone ?
> 
> Changes for 0x2823, 0x2826 and 0x2827 seem OK, but 0x2822 is weird.
> Since it is replicated, I think that the second entry was in fact never used as
> the first one would be a hit before the second. So shouldn't we keep the first
> entry with board_ahci_nosntf and remove the second one with board_ahci ?

The second 0x2822 entry was added by Alexandra Yates
<alexandra.yates@linux.intel.com>.

However first entry was added with much bigger explanation by Shaohua Li
<shaohua.li@intel.com>, where he/she tested it.

Indeed it points to using board_ahci_nosntf.

Best regards,
Krzysztof
