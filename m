Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7317401525
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 05:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbhIFDFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 23:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhIFDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 23:05:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A72C061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 20:04:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso3567497pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZGF2zuT/IfwjlCiNlmF3KBmCpKmmu4YQ08OMojkPnNs=;
        b=zMXlHYmM544wB8J8z/xn6rmKqVg4M7bwBlHaK46+3UbjE9izzXWhDn0TRdnm4+PgmF
         tQO979ysqOWZ7HVk3QEjAwv938G+DVUzWnpIi3venPPEhTLUEJYgmbVO0BnURbVmyZ5I
         1mEvcWPNfEBDetRN/SKdx1W34lAsQvaddqd7xavnL3W+elrZnc9tiLXbwO0dSzfluEiv
         Q0t9x/c6rJ2tXXTo6F744gFKTDbFEzuAKOin6uqTOr8pIpR/RKRpWEyabVuSA3x0hC7V
         c7kZ6zgcmPMDtdJVt17/LM2RGf9y7BmJyAAZdshIEFhmY+Jf/Kgmw4QqSLJlhzCjGfhh
         FHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGF2zuT/IfwjlCiNlmF3KBmCpKmmu4YQ08OMojkPnNs=;
        b=XSwyuWtxte8fPoNCrHeI/nzaMuY/ICkU0thg/Wm6EHxPmPnGb9XmhpVFK7ZN0ox9tc
         eNOJVyk0EieCyEAKOpqdgadUc8DgpSnUtbYcsIWPMfL1qaA7AwGRsJ5guK47xqCxur5e
         H74gVeQfzwWQCoQZBwQjL7XeQuQ0+4Bc3QIS9ilv28hQnavp2p3X7C+Igdh/XotBqBvR
         pnjHAoBK50zvCOxUkgmNqh88g+z9D5rpraDCdpJIKnzC/mysviIMljTIig35svxLS5GX
         dnWIByFSb6SeXTBe/y9Q2PMGXLO8h2YNbW8dicwwrjGJZvaaH+nHHT7blc/GWUlrsuod
         Pyig==
X-Gm-Message-State: AOAM533teL8HOcewaze5q3f8H9wV3c+1psowv3EvyF7FBz2+VcpXlAYw
        mICTlwDgVM4ZUlNsZ8Zxepv2gQuL2Pvnow==
X-Google-Smtp-Source: ABdhPJzapQs79H4XwgEDiI8WQ4k0n4gfxLF1psjjotY8xH+gRutuLQTEYoqBZUFP1aR80NX1DOkpSQ==
X-Received: by 2002:a17:90a:c908:: with SMTP id v8mr11928513pjt.196.1630897458806;
        Sun, 05 Sep 2021 20:04:18 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d13sm5591786pfn.114.2021.09.05.20.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 20:04:18 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but
 not used warning
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210830091128.1854266-1-geert@linux-m68k.org>
 <caf2449c-e86d-195d-3635-9be49159166a@kernel.dk>
 <20210906125605.658fe211@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0592ddf-306a-a833-785f-750a601487dd@kernel.dk>
Date:   Sun, 5 Sep 2021 21:04:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210906125605.658fe211@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/21 8:56 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Thu, 2 Sep 2021 06:35:47 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/30/21 3:11 AM, Geert Uytterhoeven wrote:
>>> If CONFIG_BLK_DEBUG_FS=n:
>>>
>>>     block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
>>>       274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>>> 	  |            ^~~~~~~~~
>>>
>>> Fix this by moving dd_queued() just before the sole function that calls
>>> it.  
>>
>> Applied, thanks.
> 
> Can we get this to Linus ASAP as he has now made warnings fatal, so
> this is causing lots of build failures.

Sure, it's actually the only branch I haven't sent off yet today. Will
do so now.

-- 
Jens Axboe

