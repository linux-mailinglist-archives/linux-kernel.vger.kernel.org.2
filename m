Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BC442505
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhKBBUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 21:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhKBBUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 21:20:39 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6CC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 18:18:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso21336630otj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 18:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PzGNcPgh/OyDH+zMOkFMCYuGyrvziyRj5gQ48PelaTQ=;
        b=X4Kh4RwnuhFR+dAPJjLMfQRlNxRFQeooBuLxQ/5NCh4oBJA99x8GdH0cc/48T6lS2k
         LQ4jY7vKHWpxLeWOn1ar3LUk1HXxHt9csi4zjFT6jc1pxrn7QrJnpQ3YE9Zmcd5ZgbEh
         Pnw153ReRlugPofIZgl3m8rRP1aMhY0iotngtn96Qn9Hi63HhgUBlOrQnqQ7B6PC0IxG
         8mktZhZmk8Nlt3ARrU/Zfu6VugdZgSR1UkkQ/Pu5vofOwiVn0l7OISjF+kdO9ERJV2Sy
         8dRk+wKm7mu1fbkue5EtAKSc/w0E25n3K3HDMjNXgo/aL6VEIzBt/xN2soUTHksmzHZY
         QTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzGNcPgh/OyDH+zMOkFMCYuGyrvziyRj5gQ48PelaTQ=;
        b=Y5s/5C6MbGHyK998H87f6Cse1r08ZiHdUwriyjOjyVTJlBtKzWzwFXQjohmSh7aF3J
         QYigIOnUUj6w3v5Z++HfUfgGGfJaSnXM2N+fYNpwtAJdel8ngkAcAZyaAetcxISfpuU1
         Qj28mkRWuBLTa3zXm7bZvZnWfzpmN+x6HRxoWa1VGRCHf52XjJXjKDLQwwes15z9VfjV
         ZJmS7TNYB9XkVQdXYl9waj1qL0sLngyfoe0xfuPbiGnczH2O474CJ31aVTptNoJeCBMN
         dIV+vfTSBtIVSssMi8KQO8aFqMJzwgEzL4WxAY8ecr+NyBXmKZcHwES+6QcrD/neBiw7
         KFSA==
X-Gm-Message-State: AOAM5338pxMH5awOfnA8RF0qrieRk8+Vyjz0EWy+ixFOndk8YodJyfLf
        aIYXJ0b1Hl8O3Q9BbsD6/dhjoBi3Wps=
X-Google-Smtp-Source: ABdhPJwMGp3plTmnbyYDeaE75O7wp7qzgQN9spyzwBTsrlSozWmAcqnbky2WF26jqrtPIOE8lTAicA==
X-Received: by 2002:a9d:d02:: with SMTP id 2mr24100880oti.358.1635815884654;
        Mon, 01 Nov 2021 18:18:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4sm4488349oic.48.2021.11.01.18.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 18:18:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <20211101002346.GA304515@roeck-us.net>
 <CAMuHMdWBgGvt8q9suk6tysgga7sJ4v74eJHHO=ifg2Rc3S9A9Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.15
Message-ID: <89a3686d-1ef6-4677-5d9f-f5e15a77c50e@roeck-us.net>
Date:   Mon, 1 Nov 2021 18:17:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWBgGvt8q9suk6tysgga7sJ4v74eJHHO=ifg2Rc3S9A9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 1:13 AM, Geert Uytterhoeven wrote:
> Hi Günter.
> 
> On Mon, Nov 1, 2021 at 1:28 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Sun, Oct 31, 2021 at 02:09:07PM -0700, Linus Torvalds wrote:
>> Building m68k:allmodconfig ... failed
>> --------------
>> Error log:
>> In file included from include/linux/string.h:20,
>>                   from include/linux/bitmap.h:10,
>>                   from include/linux/cpumask.h:12,
>>                   from include/linux/smp.h:13,
>>                   from include/linux/lockdep.h:14,
>>                   from include/linux/spinlock.h:63,
>>                   from include/linux/mmzone.h:8,
>>                   from include/linux/gfp.h:6,
>>                   from include/linux/slab.h:15,
>>                   from drivers/nvme/target/discovery.c:7:
>> In function 'memcpy_and_pad',
>>      inlined from 'nvmet_execute_disc_identify' at drivers/nvme/target/discovery.c:268:2:
>> arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 8 bytes from a region of size 7
>>
>> Another instance of the same problem:
>>
>> In function 'memcpy_and_pad',
>>      inlined from 'nvmet_execute_identify_ctrl' at drivers/nvme/target/admin-cmd.c:372:2:
>> arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 8 bytes from a region of size 7
>>
>> This is seen with gcc 11.1 and 11.2. gcc 10.3 builds fine.
>> The code in question is
>>
>>          memcpy_and_pad(id->fr, sizeof(id->fr),
>>                         UTS_RELEASE, strlen(UTS_RELEASE), ' ');
>>
>> and UTS_RELEASE is "5.15.0". I have no idea what might be wrong with the code.
> 
> Me neither.  That warning (now error) has been seen with all point
> releases (i.e. strlen(UTS_RELEASE) < 8) since v5.0.
> 

Ah yes, I can see that now. I guess I didn't notice earlier because it was
only reported as warning.

>> Does anyone have an idea ?
> 
> We had a discussion in
> https://lore.kernel.org/all/CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com
> but without any definitive conclusion.
> 
>> Do I need to revert to gcc 10.3 for m68k ?
> 
> I'm not sure that might help, as the issue has been seen with
> e.g. 8.1.0 and 8.2.0, too, with a slightly different message:
> warning: ‘__builtin_memcpy’ forming offset 8 is out of the bounds [0,
> 7] [-Warray-bounds]
> 
> Any suggestions? Thanks!
> 

Replacing "strlen(UTS_RELEASE)" with "sizeof(UTS_RELEASE) - 1" seems to do
the trick, at least with gcc 11.2 and v5.15. I just wonder if that would be
acceptable. Any idea ?

Thanks,
Guenter
