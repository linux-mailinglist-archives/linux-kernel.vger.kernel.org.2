Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F493DB9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhG3OD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:03:58 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41376
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239141AbhG3ODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:03:48 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 8ADC83F224
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627653817;
        bh=/Gja+i0Dvjadolanru2/enXX4OvFq4ZgMqAnNw717vc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=oP4EGFHbuM8HS4pOQxnH9iULeVWfme2ZJ8xcYQ0LIo7UrTLG4zBT5yAE49NR1V768
         btPaRhXEY7j+T2h/j1yq2xBcg8x8qekZTCg6h+5E06+VROclcOn4VKIuXeZgomD+ts
         +E4cvh5Q3/kNwhkKmpttzbZyb0nKESOn+jezeiYe8XiIA5nq93fivLqk+YSlVX75vI
         7ik8E2uhpzUQs9DrJQZA+YLgYJlI0PAHY8R5nLpM+H5P5RBtck2CQgchyK6snAkC6L
         /wWnibRLgsQptTiDrnbVNcjlDmhkB3Bt2iVt0yZ8C+zEBj2vsRmLVLaQ1BrxTzWc0H
         2IzwhpnttFctg==
Received: by mail-ed1-f69.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso4641126edh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Gja+i0Dvjadolanru2/enXX4OvFq4ZgMqAnNw717vc=;
        b=DWC8wN+xYDxTNxjsfF33C5KazXzmUqCMy2Ki15kxa00l3wgZCBfZXRBcSo/3GRjbtD
         5WFwkGsPryPeuleCiL2Tn2USoeDk0A4fQOX4NmjgZ56ts/5gR/z0OduNrM97QQE6u0IV
         lio+44MkPRmBRUOMwP54+w7AV7ec/j4UGCFfT/cPkfUMoinZ3af6fmadbSWaCl91L2nk
         3nJjMf0cosl1sGI1WwLEA+C6Z9F5iwvP+IWfodLV1hCLOIKNsRILrKH7+krv20G2WKIw
         6LFhTpgVNnH7OfbowAwfdKb2aKjnTiU70MuUchYyl1TZjSqjk8KwprS19tqyjEMQpI4o
         JFPQ==
X-Gm-Message-State: AOAM5333K1qD0nZPGpA0wcABez+s1KgLEWgbShx896dOUnYO0ISKwKWb
        gYwJg5pa7AnoCEbPCNUlClTBAydmaSs8xy6fCn0WogccMx9O3/JGeKUBsqVWz42JfDymPC6tmO8
        wEOoZ/eCutstoxcSLWfj4BNGZ8Kj9rR/v+FKYsmhdDA==
X-Received: by 2002:a17:907:c26:: with SMTP id ga38mr2672503ejc.38.1627653814543;
        Fri, 30 Jul 2021 07:03:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWNcPSq0sChCf8yeGm1VCDTCj5y7YK0ZOAnQUkLnjkO9q0Hq9IldEhamlXvjbuzBlZKUTmgQ==
X-Received: by 2002:a17:907:c26:: with SMTP id ga38mr2672213ejc.38.1627653809436;
        Fri, 30 Jul 2021 07:03:29 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id w6sm765114edd.22.2021.07.30.07.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 07:03:28 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nfc: hci: pass callback data param as pointer in
 nci_request()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
 <20210730065625.34010-8-krzysztof.kozlowski@canonical.com>
 <20210730064922.078bd222@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <53f89bae-fcb5-8e7c-0b03-effa156584fe@canonical.com>
 <20210730065830.547df546@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6f609952-cf76-58f9-1917-f06f3f376843@canonical.com>
Date:   Fri, 30 Jul 2021 16:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730065830.547df546@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 15:58, Jakub Kicinski wrote:
> On Fri, 30 Jul 2021 15:56:19 +0200 Krzysztof Kozlowski wrote:
>> On 30/07/2021 15:49, Jakub Kicinski wrote:
>>> This generates a bunch of warnings:
>>>
>>> net/nfc/nci/core.c:381:51: warning: Using plain integer as NULL pointer
>>> net/nfc/nci/core.c:388:50: warning: Using plain integer as NULL pointer
>>> net/nfc/nci/core.c:494:57: warning: Using plain integer as NULL pointer
>>> net/nfc/nci/core.c:520:65: warning: Using plain integer as NULL pointer
>>> net/nfc/nci/core.c:570:44: warning: Using plain integer as NULL pointer
>>> net/nfc/nci/core.c:815:34: warning: Using plain integer as NULL pointer
>>> net/nfc/nci/core.c:856:50: warning: Using plain integer as NULL pointer  
>>
>> Indeed. Not that code before was better - the logic was exactly the
>> same. I might think more how to avoid these and maybe pass pointer to
>> stack value (like in other cases).
>>
>> The 7/8 and 8/8 could be skipped in such case.
> 
> We don't usually take parts of series, would you mind resending first 6
> or respinning with the warnings addressed?

Sure, no problem.


Best regards,
Krzysztof
