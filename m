Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA4446B57
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 00:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhKEXvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 19:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhKEXu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 19:50:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E6C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 16:48:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p18so11947005plf.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ryRN4TgQQNUidOFgzw61H/Jz4p5AOYR2K+13jgQ3gH8=;
        b=K/jshyNoys3K3DMqIRivon9zbv2INp7kKdEUBhHNXUthbTYWj58/bzhIpThA0oGXmK
         4Iefaxo5ak2ERByJAQjBtDnddBohONQiCYbLt+4ZdcV3tykYWu17muUb+nQ7mdg6s2WV
         Qo4AF3KaquyQIUHQMS/fL6+gIVpKpLFZGPTr1lxHZw3G3mYdASPKkbXyNusmU2PvGcHc
         OgfQ7NV/ElnwQDphw7DanbVCYxGnYFn+mSCeAU2OXF3hibVMNQZ5fVB07ktPxkYpILe3
         Ic2V4NiLpkZd5SpRe2wNIOtYpQkJsEcLJEHVn5UaDzWBPrjF7fFsmqrTo0ggB7zYa2SX
         /uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ryRN4TgQQNUidOFgzw61H/Jz4p5AOYR2K+13jgQ3gH8=;
        b=Et/dEtcTw2q8MSrCu8MTG90qGAv2uYS7W+gYhicKC+F0BdX/lYX+oJeD9aX5R/whQU
         DOdxqlu6bscfo8gRT77Mqs7mRPbnz7ytDUhU537PPV5JFdl2nUIzkkT6ShrIMb5YrDRn
         9492Hzw53eLlp1y7oKN1F1M0nb5lCUeuXWwgyHqk432CmFhQKCbBAhd9ETNwrBYsUN5W
         wVH8WOT+0Uju3Mdn7BsNYRI7XglXz1N+Nqs+Rb4I5v73XDYZeeEThUCWf41KvP1PMiK8
         TOIiSi5qiNxJfJWu4bQJSt504QxK+sKk5Qkl+ASrVai9n5rp6VxyvVeDBcP835Fq8AfD
         EhEw==
X-Gm-Message-State: AOAM530NJHHborxVhGDCOqj/V59u+JTIBM2Kv3oUh2fxdxt+ls85/BDf
        7NvHM3uXoylB7tITYZMr61zm/xwlYYU=
X-Google-Smtp-Source: ABdhPJzsusgq2bR6E7KX6TKl5BtV8K2tv2KsGRrQaeuOjPcYf+/9dFIva7bHmuwBBao4tqAWS2WlJg==
X-Received: by 2002:a17:90b:1947:: with SMTP id nk7mr33874976pjb.227.1636156095974;
        Fri, 05 Nov 2021 16:48:15 -0700 (PDT)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id h4sm10612499pjm.14.2021.11.05.16.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:48:15 -0700 (PDT)
Date:   Sat, 06 Nov 2021 09:48:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
To:     John Ogness <john.ogness@linutronix.de>
Cc:     =?iso-8859-1?q?Laurent=0A?= Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
References: <1636039236.y415994wfa.astroid@bobo.none>
        <87ee7vki7f.fsf@jogness.linutronix.de>
        <1636073838.qpmyp6q17i.astroid@bobo.none>
        <87r1bv2aga.fsf@jogness.linutronix.de>
        <1636111599.wwppq55w4t.astroid@bobo.none>
        <87h7cqg0xk.fsf@jogness.linutronix.de>
In-Reply-To: <87h7cqg0xk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Message-Id: <1636155848.5e41htngh5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from John Ogness's message of November 5, 2021 11:57 pm:
> On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>>> What was removed from 93d102f094b was irq_work triggering on all
>>> CPUs.
>>
>> No, it was the caller executing the flush for all remote CPUs itself.
>> irq work was not involved (and irq work can't be raised in a remote
>> CPU from NMI context).
>=20
> Maybe I am missing something. In 93d102f094b~1 I see:
>=20
> watchdog_smp_panic
>   printk_safe_flush
>     __printk_safe_flush
>       printk_safe_flush_buffer
>         printk_safe_flush_line
>           printk_deferred
>             vprintk_deferred
>               vprintk_emit (but no direct printing)
>               defer_console_output
>                 irq_work_queue

Oh I thought you meant irq_work triggering on all CPUs (i.e., including
remote CPUs) was the key.

> AFAICT, using defer_console_output() instead of your new printk_flush()
> should cause the exact behavior as before.

It does.

>> but we do need that printk flush capability back there and for
>> nmi_backtrace.
>=20
> Agreed. I had not considered this necessary side-effect when I removed
> the NMI safe buffers.
>=20
> I am just wondering if we should fix the regression by going back to
> using irq_work (such as defer_console_output()) or if we want to
> introduce something new that introduces direct printing.

irq_work works for this situation so for a minimal fix I think it's=20
fine. When you do the big rework it would be okay to do it directly
if you have such a facility for other reaons.

Thanks,
Nick
