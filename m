Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712E9438CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhJYBCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:02:43 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:50224 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJYBCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:02:41 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 19P10IJD011049
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 04:00:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1635123612; x=1637715612;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XtAEwQrbUN1uwXWUYNCihcDeraLw6hJkJMDHwdBjgI0=;
        b=BCsuHO4bwRTp/6cww4IdJEe8KQPnWkY+Xw4wow8V3Vt3n3gOT/OH29TSSO2oGSlD
        liuKCKg/MKSq3nX1HXFg7su9tQg4KCWzzSx/MciSnUHALwTYe2uRN7NzAEK5TOAM
        qrnpHxZ7OD53Xzw9s1LXaSxpv77Jgsh3av1i8G7RqYtV0r7snqvu99R3k+8e5+ob
        zjwYeizB9nXS3fVTUncsFi/HLO63tTbtvw2LWOLuzQS9p3EkejPCq1ft4E3AEmYR
        OT3yzLn/14GeRjPT+6D8Y9BmYWwftuCrq/yLp6uZTnP9VH1UodbQrAM3K+7Bp5xl
        P203uvRH9I6EdOgJKv7MMA==;
X-AuditID: 8b5b014d-ba8f670000005d46-1f-6176019c5f81
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id A2.49.23878.C9106716; Mon, 25 Oct 2021 04:00:12 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 25 Oct 2021 04:00:12 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mick@ics.forth.gr, alexandre.ghiti@canonical.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Don't use va_pa_offset on kdump
Organization: FORTH
In-Reply-To: <mhng-b28fa0cb-24ee-40d1-9f02-619605a4cc9a@palmerdabbelt-glaptop>
References: <mhng-b28fa0cb-24ee-40d1-9f02-619605a4cc9a@palmerdabbelt-glaptop>
Message-ID: <d4d0d13c9fda686575f1040cd16b516f@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsXSHT1dWXcOY1miwdw2c4t1iy6wWmz9PYvd
        4vKuOWwW2z63sFk0vzvHbvHycg+zRdssfgd2j1kNvWweb16+ZPE43PGF3ePhpktMHpuX1Htc
        ar7O7vF5k1wAexSXTUpqTmZZapG+XQJXxrrGfYwFRwQq1vwVb2D8ytPFyMkhIWAisXH5XaYu
        Ri4OIYGjjBKv1ixhg0iYSsze28kIYvMKCEqcnPmEBcRmFrCQmHplPyOELS/RvHU2M4jNIqAq
        sfX7TLA4m4CmxPxLB8HqRQTUJQ68vsMMsoBZ4ASjxJSDH8AWCAtYS3T8eswOYvMLCEt8unuR
        FcTmFPCT6JizGKxGSMBX4uDB5+wQR7hIfGxpY4I4TkXiw+8HQHEODlEge/NcpQmMgrOQnDoL
        yamzkJy6gJF5FaNAYpmxXmZysV5aflFJhl560SZGcAQw+u5gvL35rd4hRiYOxkOMEhzMSiK8
        Np9KEoV4UxIrq1KL8uOLSnNSiw8xSnOwKInz8upNiBcSSE8sSc1OTS1ILYLJMnFwSjUwhauK
        vnnZcHT6dPtAL8ZjO5xedvxh2qs84/7DZb+/Ne1NCr7Rmjvp+SKdFXvmn/x4RnPq9mUGbJ/P
        2/dxpcbxnz2d5CF1afeL6Vw/LoYZXFisqlu7okXmuF1hjdet087FkqULpRgWuTzbqP3W3Z7B
        3tNxRleG8hYHDjMXnsU7rt3vfCourlO8w+Kp6LGFJznj3/7Nq/midElipZDbhDmzLlqVzNe5
        K6mxSerNzQUpaecv5z88lj9fmefMI7nI673XPvGzJuQLMn212fGpbef/SVM1Q1xu85aLbr7i
        d2//A0+VxP0tOvn57Qsf7r/lFuHbYdq71b+96F558JmYmb/WpkyS68w83FLRXq/77tDmN0os
        xRmJhlrMRcWJAGSMRAzvAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-10-23 23:14, Palmer Dabbelt έγραψε:
> On Sat, 09 Oct 2021 06:18:48 PDT (-0700), mick@ics.forth.gr wrote:
>> Στις 2021-10-06 14:13, Alexandre Ghiti έγραψε:
>>>> +
>>>> +       /* This will trigger a jump to CSR_STVEC anyway */
>>>>         jalr    zero, a2, 0
>>> 
>>> The last jump to a2 can be removed since the fault will be triggered
>>> before even reaching this instruction.
>>> 
>> 
>> Just switching SATP to zero doesn't generate a trap unless mstatus.TVM
>> is set (for visualization purposes). The hart will try and execute the
>> next instruction but it's not clear in the spec what happens in case 
>> the
>> code is cached, I don't want to rely solely on STVEC. I prefer having
>> this instruction there, note that some earlier QEMU versions also had
>> this behavior (the original kdump patch didn't set STVEC and it worked
>> fine after setting SATP to zero).
> 
> IIRC this came down to some very specific wording in the spec.
> Something along the lines of the 0 in SATP meaning "no translation",
> SFENCE.VMA ordering translations, and the general "if the spec doesn't
> mention it then it has to work" logic.  I thought I opened a spec
> issue about this for clarification, but I can't find it.
> 

I guess you mean this one:
https://github.com/riscv/riscv-isa-manual/issues/538

I couldn't find anything though regarding cached code, it's not that 
there's going to be a load after setting satp to 0 if the code has been 
cached, so even if the translation is cached we don't have a guarantee 
that the next instruction will result a trap.

> That said, I'm perfectly fine taking the safe approach here as it's
> not like the performance matters here.  Warrants a comment, though.
> 

ACK

> 
> I don't have a v2 in my inbox, did I miss something?  Also, if it's
> just the tags then it's generally not necessary to re-send something.
> The comment does, though.
> 
> LMK if you want me to deal with this, or if there's going to be a v2.
> 
> Thanks!

I'll send a v2 with the tags and the comment.

Regards,
Nick
