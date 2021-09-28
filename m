Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1697741AA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbhI1IRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhI1IRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:17:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212B1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:15:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b20so89499214lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8PbBAApAzj8vGheaDKyBd/wLCvod6F+nHg/W/gSrI7w=;
        b=hAs0lZwAeOL7X0F5HS61VyP3YvuyXU5y7IzBe5qbRefwc4e1PO5nWCG2iJbdJDeIPu
         3MJY2WKKAa6Mm9XcP4M1GogbTkE3MwDQmxsX+nIUD/Jx93fgbkesJ4QS2X4ihArwBfUh
         Lu/TvJqEWBh/D5aj1wepAaWcK5WlkOPHAuDFJ/jVtZCgOYK8zmavhpixnAxhrOZd+xeV
         exA3HKbeYkt5V2e/F2K1sBcXgKFFAYxOeKpttCRnzUh74TnNMzoJlSR0WAq62vUXDqVn
         HeSpIrfkOTLurHxQhrlDrdvk1XivtyBx9HlaNPmDanrYSxNyVr0X6hjLZSqxS1MrdrJQ
         snvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8PbBAApAzj8vGheaDKyBd/wLCvod6F+nHg/W/gSrI7w=;
        b=Bz57GnmCnip/VTzz2B5IC54RwzhDuW9YSAfp/EuhBug2rUWZQ+LkkKBqiFB6fuqBNW
         SNgcFQ2BGQm6+s4DLo8heUhCjqHI0nBaJoDtTy4JzSaWmXQsBByUz8yO7oYzv+5oeoeO
         eEmxvhXeimp0wPInVHSBGrDbYVhk/mk+TplOSwp8utTW3fIZ5Jh0JjcALL437e3lXeXS
         QhxJ/EI5383kC25CrUW5rtylJ99PUyPU23xERC+PrsTISdnaLMqN5BqY5RHKUjK1IsRs
         3xPU7TfBgSe0UVtDhxMjBwE9ULu8BfeqSMXIA3T5qBQaffsok9bpk67OKlB7W2HUXNVS
         bSNA==
X-Gm-Message-State: AOAM530KvNGKv4rlvg9IyjDq/HkDBIj2kVEyTyBw7+V90qr3VFhnlv7P
        5bNXnOFNaZ9eMDNsGWFF1BJo/W+7dAU=
X-Google-Smtp-Source: ABdhPJyx/BqQ3jfaTxiN1emcbrEocsPmPiZGJZThtGzccBPq4LGJoQ0WzgRKOFKDy3szcpUd0PKiAg==
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr4380985ljc.206.1632816926380;
        Tue, 28 Sep 2021 01:15:26 -0700 (PDT)
Received: from [172.28.2.233] ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id e15sm1849418lfs.107.2021.09.28.01.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 01:15:26 -0700 (PDT)
Message-ID: <cfec2c6f-34a9-d95e-5f07-c69e74b06450@gmail.com>
Date:   Tue, 28 Sep 2021 11:15:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [syzbot] memory leak in __mdiobus_register
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <35d0ddc1-41cd-16fb-41ea-5529d19c04d2@gmail.com>
 <0000000000005252e105ccee8e1b@google.com>
 <CAD-N9QUJWifqhNt09xDcu=w0K0o+wYUxpZyqkTs4q5eMp_kVgw@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAD-N9QUJWifqhNt09xDcu=w0K0o+wYUxpZyqkTs4q5eMp_kVgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 10:42, Dongliang Mu wrote:
> On Mon, Sep 27, 2021 at 7:44 AM syzbot
> <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>>
>> Reported-and-tested-by: syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com
>>
>> Tested on:
>>
>> commit:         5816b3e6 Linux 5.15-rc3
>> git tree:       upstream
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=41799858eb55f380
>> dashboard link: https://syzkaller.appspot.com/bug?extid=398e7dc692ddbbb4cfec
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1147b840b00000
>>
>> Note: testing is done by a robot and is best-effort only.
> 
> Hi Pavel,
> 
> Confirm the patch you posted [1] is the real fix of this bug report.
> 
> I tested the patch from Yanfei Xu [2] in my local workspace, and the
> memory leak is still triggered. In addition, I have pushed a patch
> request for that patch. The result would prove that patch is not
> working for this bug.
> 
> BTW, there occur incorrect fix commits on the syzbot dashboard
> sometimes. Maybe it should be cleaned in the future.
> 


Hi, Dongliang,

thank you for confirmation. As I said in reply to [1] Yanfei's patch is 
also correct, but it solves other memory leak in same function.

AFAIU, if my patch will be applied too there will be 2 fix patches on 
syzkaller bug report page, so no need to remove Yanfei's patch from bug 
report page :)


> [1] https://lkml.org/lkml/2021/9/27/289
> [2] https://www.spinics.net/lists/kernel/msg4089781.html
> 


With regards,
Pavel Skripkin
