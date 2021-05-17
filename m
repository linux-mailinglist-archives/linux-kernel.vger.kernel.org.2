Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D86386D35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbhEQWvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhEQWvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:51:12 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CACBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:49:55 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u33so3995564qvf.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NNolo/fsBEhSMhNSEh7Crf0E+3dgho1mDpIX1QYuBZg=;
        b=O/EqdZm5Haptg+dKHm3zpWqbBoUJ3Nf1AOE7Chzg410Yev1jO1l67zpw9UC4KFvTYx
         /gNabF6BUxD/jXTJ64a0UAICfcCXpXLwjZ+reCksz3KoDN1VtcRBHV8XffdWnTwCgzJv
         QwVmCx7jNduAvyrSFGPvPAYKrpfdrSgxELe9lntbM80Gv9/PZc9zV0kBYweAfut0mZE8
         sr/nxVFKWOLSAEFX6pGMBv7H+y+0r27/KM+FXAM3dlUQZUwLKChx+Wcol+3UNqVi4zJi
         iTqmz14E4U+WrFKGqDfsp2GsALCrswWTrsWwH0MDpNW/bOGvxAYpJVWFaZBEDutAuv4B
         N6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNolo/fsBEhSMhNSEh7Crf0E+3dgho1mDpIX1QYuBZg=;
        b=LWdmr4wfa3MPE/TAHOLo+x64e0hjzdGzPNbyqPJkysv6m52UjwMsuvE93O6DvpK6iz
         oSRPGt9wgzozckZJb2Z9R+fHh2z8/wKRMGqkbUYYrTUANunfrjL3sdReL0UXqtKBiGbt
         jfnv2EpWJoYKqoUXpg/0Jfb/8zqozFjnihOYlllYc9xIhhSnjk+vrLlDCx9zuMmlSvNw
         yujsq+gHupHEdmFT51Hx68pZq/Sw04PHw0a1oMJg5x5PcFfNRDERY2bLQ5WblieAOXoq
         QqC0+6CoSVLDlnUd2GuLX9NhJmslcPHiLbSI84nJUIegPDGUQ6tzvLMyXJmjaCJpUSNH
         fbag==
X-Gm-Message-State: AOAM531ir864Lo+24qeEY5B86siI+oTm1bfKzgNvYp3d9qwXOiMgC33q
        s5G3258iPn6SOFVot2KNGCmt4O4cESc=
X-Google-Smtp-Source: ABdhPJwz4BDuFpKkWdis7NmniqQ9xl7Sf9vA0M+J8/gj+e3XCmHx2tqrp1jJuq9cwGAkFu77i0ootw==
X-Received: by 2002:a0c:f294:: with SMTP id k20mr2488297qvl.45.1621291794221;
        Mon, 17 May 2021 15:49:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a14sm6806624qtj.57.2021.05.17.15.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 15:49:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.13-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgX-4PTGAH7kRvqHYiq9wPJ-zN6jhLsuOAj6cG__g9N9A@mail.gmail.com>
 <20210517135653.GA2116459@roeck-us.net>
 <CAHk-=whUsAw7g6x4ianP1VxsADr1b+fitmQ2qecrq70d9r3ZJQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <063c62bc-e97c-72a9-491a-2de30b0b2b6a@roeck-us.net>
Date:   Mon, 17 May 2021 15:49:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whUsAw7g6x4ianP1VxsADr1b+fitmQ2qecrq70d9r3ZJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 3:31 PM, Linus Torvalds wrote:
> On Mon, May 17, 2021 at 6:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> I have seen a pull request that fixes the raspi2 problem. Hopefully that
>> fix should be in -rc3.
> 
> Hmm. That commit actually made it into rc2. We're talking about that
> commit bb4031b8af80 ("clk: Skip clk provider registration when np is
> NULL"), aren't we?
> 
> That's the patch that you reported fixed it for you.
> 
> And it got merged by me (commit 28183dbf54ed: "Merge tag
> 'driver-core-5.13-rc2' .."), and is part of rc2.
> 
> So if rc2 still has some raspi2 failures, there's something else going on..
> 
> Strange. Mind double-checking?
> 

Huh. I must have had a severe lack of coffee this morning. This is the correct
test result for v5.13-rc2:

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Guenter
