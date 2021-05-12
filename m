Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A137EDBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388018AbhELUlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:41:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40402 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbhELUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:24:24 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgvNl-0005l3-7W
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 20:23:01 +0000
Received: by mail-vs1-f71.google.com with SMTP id e12-20020a67d80c0000b029022a88436f30so6669863vsj.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9gJsXnEr4ZIoyQYIBIzO2lxuT2xnUGyt9hpWeVeGi8I=;
        b=kbPDgC1gFod1Oj/iEzmeENUReNJndROp9Jmw7EEOWvdXfEvMt9dXts7q2bC2FO02i5
         rKp6jSWPSp4pvnGVf8QKO5TRL2ml9F5rTErw5Y7Tzehh7xZK9W7pIdulqqht9QTt1Tmu
         9B/JpG7BOV5aY6CZ5bZvKMNkO7wwkYIDRPsEEmIYO6MzfyngrVRc5QJKwCuffYShzEr5
         PAOKyeGrvQEUsZCni0WBP9iE4dWlAy++djDqxyIDfdNXOHwhlHS8x7mwgJ4rY2ow3V5f
         j72N9eHh8tDFR85ENTYor/CgqcL9RHo8u9fCCLhaSqP6YJGnM+KOxKR252YB+2einUEC
         h1GQ==
X-Gm-Message-State: AOAM533WKXvXG8vpVIHhW85Y6rSx4KYYR4EKBqo4GG+h05UF+ZRYrdC5
        +BpSEbpbXIgkswkuR9r2N2L7ItzHKghf8AENXVGKFQXIHUqxEoZbj8/pdd2/V7rumkmHSP/4CO6
        wilKzHO1Ukxwq8FALkukQ+d4V8VxGHe/rtDwXuvHX5A==
X-Received: by 2002:a67:ee4e:: with SMTP id g14mr35358349vsp.37.1620850979958;
        Wed, 12 May 2021 13:22:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo1HcgGvTIwADZqFT4FFfzTBlNKsqR3dNu8u/ryzDxJLZoeNXUQ5nAD8NmfVFGhoZFuAnWMw==
X-Received: by 2002:a67:ee4e:: with SMTP id g14mr35358331vsp.37.1620850979717;
        Wed, 12 May 2021 13:22:59 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id y4sm122078vsq.27.2021.05.12.13.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 13:22:59 -0700 (PDT)
Subject: Re: [linux-nfc] Re: [PATCH 1/2] MAINTAINERS: nfc: add Krzysztof
 Kozlowski as maintainer
To:     Mark Greer <mgreer@animalcreek.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org
References: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
 <961dc9c5-0eb0-586c-5e70-b21ca2f8e6f3@linaro.org>
 <d498c949-3b1e-edaa-81ed-60573cfb6ee9@canonical.com>
 <20210512164952.GA222094@animalcreek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <06892f2b-e4af-66d4-f033-aff49039d1a9@canonical.com>
Date:   Wed, 12 May 2021 16:22:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512164952.GA222094@animalcreek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2021 12:49, Mark Greer wrote:
> On Wed, May 12, 2021 at 11:43:13AM -0400, Krzysztof Kozlowski wrote:
>> On 12/05/2021 11:11, Daniel Lezcano wrote:
>>> On 12/05/2021 16:43, Krzysztof Kozlowski wrote:
>>>> The NFC subsystem is orphaned.  I am happy to spend some cycles to
>>>> review the patches, send pull requests and in general keep the NFC
>>>> subsystem running.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>>
>>>> ---
>>>>
>>>> I admit I don't have big experience in NFC part but this will be nice
>>>> opportunity to learn something new. 
>>>
>>> NFC has been lost in the limbos since a while. Good to see someone
>>> volunteering to take care of it.
>>>
>>> May I suggest to create a simple nfc reading program in the 'tools'
>>> directory (could be a training exercise ;)
>>>
>>
>> Noted, thanks. I also need to get a simple hardware dongle for this....
> 
> Krzysztof, the NFC portion of the kernel has a counterpart in userspace
> called neard.  I'm supposed to be maintaining it but I have next to no
> time to do so.  If you have spare cycles, any help would be appreciated.
> 
> Anyway, in neard, there are some simple test scripts (python2 - I/we need
> to update to python3).  The current home of neard is:
> 
> git://git.kernel.org/pub/scm/network/nfc/neard.git

Thanks for sharing this. Let me take a look at it first, before
committing to something too big.

Best regards,
Krzysztof
