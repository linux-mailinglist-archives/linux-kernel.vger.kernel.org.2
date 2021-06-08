Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6662E3A0445
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhFHT2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhFHTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:13:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE54C0619F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:05:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623179148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+w9OZSy/tuT6bCBI/BxcA4l48P6W/e1+AUtLckclNk=;
        b=ORlE5DdYHnuqJ040MrRE95bCLJ3L3lPfXeXN7pyRLfnU1mp7qC8jGFX06TIggIXu47EJE/
        ogdcApksdTeP/YQ2fZ9hN582jhES0c2u8iiVxZ1ucltIIxfcDn9++MsJGhlWjhfZEUuhMw
        U9rERpnzajMmTfa9KMqTI+wnzeiYMFjZWRYxHt886wg7AQRA8g0QyqJfMtbgf3CJLjsnDU
        CvRqxyi1XCiuqgkkIZ8AY4K+uwflfnEzbEeGsX3kSpseZgCtYdoP4IfEn2xOo7BuUpb2iR
        BvlV1xIw7OzZhHssHNeRsczPhHmQLe/18M/0Pf/oiP5Y7zv8CpBr3ePuTkT3Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623179148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+w9OZSy/tuT6bCBI/BxcA4l48P6W/e1+AUtLckclNk=;
        b=oukyLLGYebLr6ejvRS0iux+t4yiroZCouqL4iG1zFxDzxY6P06Xo7FuBTfQkxxnMtBwX3I
        jPs/jSbDSaZO0XCw==
To:     liangjs <liangjs@pku.edu.cn>, Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: arch_set_user_pkey_access only works on the current task_struct
In-Reply-To: <774b6e6c8cb1be4923048bb1bb18753a6854758f.camel@pku.edu.cn>
References: <b3762e3bc45d77869231271ffe0e259be118ad57.camel@pku.edu.cn> <a9d538c4-b4aa-9a5b-5f8e-1a7baf8424b8@intel.com> <774b6e6c8cb1be4923048bb1bb18753a6854758f.camel@pku.edu.cn>
Date:   Tue, 08 Jun 2021 21:05:48 +0200
Message-ID: <87zgw0xjlf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08 2021 at 11:16, liangjs wrote:
> On Mon, 2021-06-07 at 10:52 -0700, Dave Hansen wrote:
>> On 6/5/21 6:10 AM, Jiashuo Liang wrote:
>> > I am learning the kernel implementation of the x86 PKU feature. I find=
 the
>> > arch_set_user_pkey_access function in arch/x86/kernel/fpu/xstate.c doe=
s not
>> > use its first parameter. So it is perhaps a bug?
>>=20
>> I wouldn't really call it a bug.=C2=A0 But, yes, it is something we shou=
ld
>> clean up.
>
> Should we remove the tsk parameter, or allow it to change the PKRU of tsk?
>
> By the way, we are calling write_pkru, which changes both the CPU's PKRU
> and the xsave one. Why is this necessary?

Because PKRU is xstate managed and there is the requirement to keep both
up to to date. There is work in progress to clean this up.

> If I want to change PKRU of a task_struct other than current, do I still
> need to call __write_pkru?

Of course not, but you _cannot_ safely update a different tasks PKRU
value except through ptrace which guarantees that the task is scheduled
out and stays that way until ptrace releases it again.

So tsk !=3D current cannot work which means the function argument can just
go away.

Thanks,

        tglx
