Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9043AC11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhJZGOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:14:18 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49808 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232553AbhJZGOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:14:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UtkSRIK_1635228711;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UtkSRIK_1635228711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Oct 2021 14:11:52 +0800
Subject: Re: [PATCH v11 2/3] tty: hvc: pass DMA capable memory to put_chars()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
 <208f7a41-a9fa-630c-cb44-c37c503f3a72@kernel.org>
 <cd195483-93c7-23be-8f4c-9cf7f25a3065@linux.alibaba.com>
 <YXebzdZz8oN6w+T0@kroah.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <8f78c1b8-c736-748d-d08b-3d6121eb5af8@linux.alibaba.com>
Date:   Tue, 26 Oct 2021 14:11:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YXebzdZz8oN6w+T0@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/26 下午2:10, Greg KH 写道:
> On Tue, Oct 26, 2021 at 02:02:21PM +0800, Xianting Tian wrote:
>> 在 2021/10/26 下午1:10, Jiri Slaby 写道:
>>> On 15. 10. 21, 4:46, Xianting Tian wrote:
>>>> @@ -151,9 +142,11 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
>>>>    static void hvc_console_print(struct console *co, const char *b,
>>>>                      unsigned count)
>>>>    {
>>>> -    char c[N_OUTBUF] __ALIGNED__;
>>>> +    char *c;
>>>>        unsigned i = 0, n = 0;
>>>>        int r, donecr = 0, index = co->index;
>>>> +    unsigned long flags;
>>>> +    struct hvc_struct *hp;
>>>>          /* Console access attempt outside of acceptable console
>>>> range. */
>>>>        if (index >= MAX_NR_HVC_CONSOLES)
>>>> @@ -163,6 +156,13 @@ static void hvc_console_print(struct console
>>>> *co, const char *b,
>>>>        if (vtermnos[index] == -1)
>>>>            return;
>>>>    +    hp = cons_hvcs[index];
>>>> +    if (!hp)
>>>> +        return;
>>> You effectively make the console unusable until someone calls
>>> hvc_alloc() for this device, correct? This doesn't look right. Neither
>>> you describe this change of behaviour in the commit log.
>> I mentioned such info in the commit log:
>> 'Introduce another array(cons_hvcs[]) for hvc pointers next to the
>> cons_ops[] and vtermnos[] arrays. With the array, we can easily find
>> hvc's cons_outbuf and its lock.'
>>
>> After you pointed it out, I just found what you said make sense, I checked the code hvc_console_print() can support print before hvc_alloc() is called when someone use hvc_instantiate() for an early console discovery method.
>> I send a patch to fix the issue?  or these serial pathches reverted fisrtly then I resend new version patches? thanks
> Let me revert these now and you can send an updated version.
OK, thanks.
>
> thanks,
>
> greg k-h
