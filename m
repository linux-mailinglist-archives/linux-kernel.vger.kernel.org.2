Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86F406698
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhIJEw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:52:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47033 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhIJEwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:52:25 -0400
Received: from [IPv6:::1] ([IPv6:2601:646:8600:3c71:fdf9:cf28:325e:596])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18A4omM7316701
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 9 Sep 2021 21:50:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18A4omM7316701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631249450;
        bh=zqsyicqOh+MoTU5jCeHGmjPTmKLmQbQguskMRBEEIbA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nQ8MItUsO/m8BIY3s2OE4H64CcQD4Tx1zLG84eW+qkGCD6Id2aCVPtDIJdYdjeXII
         JyoMB5lS4XXbksjjb1IXAAL3PYLAKGKQEqRBIP3zTEshD2kXyd3uRNpUyu+jvXvrSX
         o9VqpvfoKJiX6wAZ9xzpQvjdYikrVc8uUoMxv48PV/sFM5GFnlt6HQZR2+7qFOzWPi
         h2n2EjAqMDamz92YrEJyGIdfJaGZSRMPQruTjJkWRrqXdmp2mQGL1MEUpzvyYnrw+e
         Ri6NxabGHYmsL2IxuLsJ1q5b1zQeblzcktNkeyGDiYl7PJCUE0O2PskRJuHFLllYaW
         ZUWtboSFTI99g==
Date:   Thu, 09 Sep 2021 21:50:40 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 17/24] x86/entry: Introduce struct ist_regs
User-Agent: K-9 Mail for Android
In-Reply-To: <eb294b5d-82f2-be80-b3e3-db556c155d95@linux.alibaba.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com> <20210831175025.27570-18-jiangshanlai@gmail.com> <eb294b5d-82f2-be80-b3e3-db556c155d95@linux.alibaba.com>
Message-ID: <286DCB70-B36E-4229-966E-BE45F2AEA703@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may affect your design, I don't know, but FRED exception delivery (as cu=
rrently architected per draft 2=2E0; it is subject to change still) pushes =
several fields above the conventional stack frame (and thus above pt_regs=
=2E)

On September 9, 2021 5:18:47 PM PDT, Lai Jiangshan <laijs@linux=2Ealibaba=
=2Ecom> wrote:
>
>
>On 2021/9/1 01:50, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux=2Ealibaba=2Ecom>
>>=20
>> struct ist_regs is the upmost stack frame for IST interrupt, it
>> consists of struct pt_regs and other fields which will be added in
>> later patch=2E
>>=20
>> Make vc_switch_off_ist() take ist_regs as its argument and it will swit=
ch
>> the whole ist_regs if needed=2E
>>=20
>> Make the frame before calling paranoid_entry() and paranoid_exit() be
>> struct ist_regs=2E
>>=20
>> This patch is prepared for converting paranoid_entry() and paranoid_exi=
t()
>> into C code which will need the additinal fields to store the results i=
n
>> paranoid_entry() and to use them in paranoid_exit()=2E
>
>This patch was over designed=2E
>
>In ASM code, we can easily save results in the callee-saved registers=2E
>For example, rc3 is saved in %r14, gsbase info is saved in %rbx=2E
>
>And in C code, we can't save results in registers=2E  And I thought there=
 was
>no place to save the results because the CR3 and gsbase are not kernel's=
=2E
>So I extended the pt_regs to ist_regs to save the results=2E
>
>But it was incorrect=2E  The results can be saved in percpu data at the e=
nd of
>paranoid_entry() after the CR3/gsbase are settled down=2E  And the result=
s
>can be read at the beginning of paranoid_exit() before the CR3/gsbase are
>switched to the interrupted context's=2E
>
>sigh=2E
>
>>=20
>> The C interrupt handlers don't use struct ist_regs due to they don't ne=
ed
>> the additional fields in the struct ist_regs, and they still use pt_reg=
s=2E
>>=20
>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
