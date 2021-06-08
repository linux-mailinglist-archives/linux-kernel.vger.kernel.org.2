Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2639ECFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhFHDTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:19:44 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:40062
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S231496AbhFHDTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Message-ID:Subject:From:To:Cc:
        Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
        Content-Transfer-Encoding; bh=TOknHDrVac1kVhzkBo89jM77VoeuLtkISz
        iTQzH0sMg=; b=s6FLEYSGrxe+NyEJuukRjh2coDC3vzTDZ5RpYhuBfMzcAhSnFd
        tFsxC5a1okW0nHelmt/bQGoxnMTcjwWQddEi4zCb3b7lCBQ/uLkZlPvimCN1bNMZ
        1ZVl0IHVIjlmgArTaq+ShXLdm0j12sTIPXZlYZcGBjFnl7sa4buOKHTM0=
Received: from [172.31.209.97] (unknown [162.105.163.121])
        by front01 (Coremail) with SMTP id 5oFpogDX388l4b5gf363AA--.47399S2;
        Tue, 08 Jun 2021 11:16:53 +0800 (CST)
Message-ID: <774b6e6c8cb1be4923048bb1bb18753a6854758f.camel@pku.edu.cn>
Subject: Re: arch_set_user_pkey_access only works on the current task_struct
From:   liangjs <liangjs@pku.edu.cn>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Date:   Tue, 08 Jun 2021 11:16:53 +0800
In-Reply-To: <a9d538c4-b4aa-9a5b-5f8e-1a7baf8424b8@intel.com>
References: <b3762e3bc45d77869231271ffe0e259be118ad57.camel@pku.edu.cn>
         <a9d538c4-b4aa-9a5b-5f8e-1a7baf8424b8@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogDX388l4b5gf363AA--.47399S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr45Ary8CF1UKw45ur13CFg_yoWxuFbEgF
        n7GF4vya1vyFn7Zw13KF4UAry0qr4DuFyUZa1Dt3y7tr93JaykAwnY9FZ3JFn0ga1FyrZr
        uFZ5Xr9Yy3ZI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbO8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8AryU
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY02Avz4vE14v_Gr4l42xK82
        IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0x
        vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IUjU3ktUUUUU==
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwEGBVPy7ry4lwACsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 10:52 -0700, Dave Hansen wrote:
> On 6/5/21 6:10 AM, Jiashuo Liang wrote:
> > I am learning the kernel implementation of the x86 PKU feature. I find the
> > arch_set_user_pkey_access function in arch/x86/kernel/fpu/xstate.c does not
> > use its first parameter. So it is perhaps a bug?
> 
> I wouldn't really call it a bug.  But, yes, it is something we should
> clean up.

Should we remove the tsk parameter, or allow it to change the PKRU of tsk?

By the way, we are calling write_pkru, which changes both the CPU's PKRU
and the xsave one. Why is this necessary?

If I want to change PKRU of a task_struct other than current, do I still
need to call __write_pkru?

Thank you!
liangjs

