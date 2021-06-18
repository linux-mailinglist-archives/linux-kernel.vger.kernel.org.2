Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0A3AC751
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhFRJYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:24:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhFRJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:24:48 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1luAhy-0003gi-PP
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 09:22:38 +0000
Received: by mail-ed1-f72.google.com with SMTP id u26-20020a05640207dab02903935beb5c71so3230326edy.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNehzQA0MI+hKa/2pR6+rQYLDJIB9kiItKJEMtj8iQ0=;
        b=AKCRQFZW+WjjY3OpMcMFsleGN/2biGBIq31lbt4iQ0XE06/CIM+tGRMJehuQkmns8F
         Ex/At6ovUTo6Bv8w0dPnyL5JFrkwp1SweupyaCzDAjZugdBaauraMT77GBevurjXheWj
         4xIVfmB5I2kznEsaDA9o6Y6RlEd/Pi0Vfd6tTrE/bVsrcMYV+q1GqP7zRtVoLaNhT2bf
         nTd3Khrk+AGqE9izbEq1iOYXKIRIfuiHIC5LBrOmUBHpWEw4P+2XUuhFF3lWpSLfcXbD
         /xT2tFVZbzTnHNVTbdRi5hUzCWJYrcA/E57vQu/T8CVKjE4Ph3h4MkyiIcg/n9xK/iPn
         35+g==
X-Gm-Message-State: AOAM5336hEtPIzdIWxoeOII5zS2NxzCdUNr60Y9DPi1C7ogJjAHerxrD
        qt0wktrOnJMYLXCQQFsPJGz+SK3QFLs3V1NESi7S4CT5WGBADZXNpGW+Ld89JWQjfdkkeHSC3uL
        bcc3yW1M/Dq6ndS547zUOnAFK1iyg8+ntwwA/pUGxSQ==
X-Received: by 2002:a17:907:9618:: with SMTP id gb24mr10257820ejc.111.1624008158434;
        Fri, 18 Jun 2021 02:22:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1ZMGbhvpM2BsQ4X/Yv1NjF2KduGfbVSuyAS7Y52+/73gjyoOIibKnA3XPBMm5vyUW2rUHuw==
X-Received: by 2002:a17:907:9618:: with SMTP id gb24mr10257802ejc.111.1624008158293;
        Fri, 18 Jun 2021 02:22:38 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id f5sm793382ejj.45.2021.06.18.02.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 02:22:37 -0700 (PDT)
Subject: Re: [PATCH 5.4 031/184] modules: inherit TAINT_PROPRIETARY_MODULE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>, Jessica Yu <jeyu@kernel.org>
References: <20210510101950.200777181@linuxfoundation.org>
 <20210510101951.249384110@linuxfoundation.org>
 <8edc6f45-6c42-19c7-6f40-6f1a49cc685b@canonical.com>
 <YMxlP2EMTaG9+2y6@kroah.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e56625df-dda3-01f3-0f9d-f4dffdbd6690@canonical.com>
Date:   Fri, 18 Jun 2021 11:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMxlP2EMTaG9+2y6@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 11:19, Greg Kroah-Hartman wrote:
> On Fri, Jun 18, 2021 at 10:57:23AM +0200, Krzysztof Kozlowski wrote:
>> On 10/05/2021 12:18, Greg Kroah-Hartman wrote:
>>> From: Christoph Hellwig <hch@lst.de>
>>>
>>> commit 262e6ae7081df304fc625cf368d5c2cbba2bb991 upstream.
>>>
>>> If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the taint flag
>>> for all modules importing these symbols, and don't allow loading
>>> symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
>>> imported gplonly symbols.  Add a anti-circumvention devices so people
>>> don't accidentally get themselves into trouble this way.
>>>
>>> Comment from Greg:
>>>   "Ah, the proven-to-be-illegal "GPL Condom" defense :)"
>>
>> Patch got in to stable, so my comments are quite late, but can someone
>> explain me - how this is a stable material? What specific, real bug that
>> bothers people, is being fixed here? Or maybe it fixes serious issue
>> reported by a user of distribution kernel? IOW, how does this match
>> stable kernel rules at all?
>>
>> For sure it breaks some out-of-tree modules already present and used by
>> customers of downstream stable kernels. Therefore I wonder what is the
>> bug fixed here, so the breakage and annoyance of stable users is justified.
> 
> It fixes a reported bug in that somehow symbols are being exported to
> modules that should not have been.  This has been in mainline and newer
> stable releases for quite some time, it should not be a suprise that
> this was backported further as well.

This is vague. What exactly is the bug? How exporting symbols which
should not be exported, causes it? Is there OOPs? Some feature does not
work?

Best regards,
Krzysztof
