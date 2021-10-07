Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA9425398
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhJGNDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:03:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35298
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232894AbhJGNDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:03:22 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 954193FFE3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633611687;
        bh=CWLF3Mwbuv27wfSQ2ZR3naLE1cJ0EA/H/ZCKfT8DDNk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ltUNq2q728kxrAGG+8SXOMIjL7Nm9WvqfAgtUYnpucWTYJNZ87SI5nA5rxRd2mxIx
         bzqeKRk6lLcghgo8LhLOVSk9spzAQDeMpN+CJqlVgc1lm/ZPAFk1fNTPbiDxxsSS0K
         8+i+ofTHgXG5NfSta/CSEX5OF9yqD77wjIMp3lTltLttyId5J3ONF8FfpA+Jd43TFy
         idHcZ1gA9qaeM6nut9Tdh/4PEfY9suOlbpwx3VOkSKUVqBJ5CNrNiP/pkZb9FgT/QB
         36Iy1QZOj+kkUU73GIFWsCfnBpquqjPgmUcbVr/SzWEXhCGmM5Jg5y5yvpq0TA+YDs
         /S5iDwO4DvVuw==
Received: by mail-ed1-f69.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso5844514edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWLF3Mwbuv27wfSQ2ZR3naLE1cJ0EA/H/ZCKfT8DDNk=;
        b=guv4X6gStbsWhW7J9vLDhCgOreH17FugOM+2mylaZLDQEd2bS5guFmd5Y5cnxdd9HY
         dDzy7Pm2nWRMlm0dvxM2TISkDIVp1N94SiU0ZQhyAXZ2+g8TSdC1DIxSx07VgvbUzwVS
         na2X5WfMo+T8xnxz8diB1KBb2Ftd3drEWZc9LKVIhUtk/Vd4JPCiRvCBL6culostr7zO
         Fwtpxcb9Hsr9Xb0wWHS8kgpZy0sXVr5vP6a6XyIJ5ARQjDQ/uBID4SZCAKdcySpoHyDE
         JFy93La5QNJEek72VhkLLVFfvk23g5PXeFV8CbwVAZq1bdOihjvLRoA4Red5Fd6L1y8r
         /y+A==
X-Gm-Message-State: AOAM533VaxxZfas0ceeAMdBKc2xhsUPEXgjSHiWybmgpacO3wrup6lPr
        KItsMh4I+FngO0pUHBvuoRH1ddHA2AkUmnOWVw8Kn/mVjfxYY37Oncu0bV9WK9BfKt/SNyXCeuL
        ZHDC/XeG6FIYOTanypO83FoH34b1WRPoMvAzvdsdfoQ==
X-Received: by 2002:a50:d98d:: with SMTP id w13mr6249806edj.51.1633611687256;
        Thu, 07 Oct 2021 06:01:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsGkLjq/HVHDfN4bAucyZ/pV1jwbbBY9M9ehNU17nvM5neTPUW/YNaP9/xGkH5n1G9eNdJaw==
X-Received: by 2002:a50:d98d:: with SMTP id w13mr6249781edj.51.1633611687059;
        Thu, 07 Oct 2021 06:01:27 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id m23sm2258674eja.6.2021.10.07.06.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:01:26 -0700 (PDT)
Subject: Re: [PATCH v2 12/15] nfc: trf7970a: drop unneeded debug prints
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Krzysztof Opasiak <k.opasiak@samsung.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Greer <mgreer@animalcreek.com>,
        linux-wireless@vger.kernel.org
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
 <20210913132035.242870-13-krzysztof.kozlowski@canonical.com>
 <20210913165757.GA1309751@animalcreek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <47eae95d-d34c-1fa7-fea9-6e77a130aa97@canonical.com>
Date:   Thu, 7 Oct 2021 15:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913165757.GA1309751@animalcreek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2021 18:57, Mark Greer wrote:
> On Mon, Sep 13, 2021 at 03:20:32PM +0200, Krzysztof Kozlowski wrote:
>> ftrace is a preferred and standard way to debug entering and exiting
>> functions so drop useless debug prints.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  drivers/nfc/trf7970a.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>

Hi Jakub and David,

Some patches from this set were applied, but rest was not. All of them
are however marked as accepted:
https://patchwork.kernel.org/project/netdevbpf/list/?series=545829&state=*

I think something got lost. Could you apply missing ones or maybe I
should rebase and resend?


Best regards,
Krzysztof
