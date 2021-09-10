Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33B40669A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhIJExk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:53:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56575 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhIJExj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:53:39 -0400
Received: from [IPv6:::1] ([IPv6:2601:646:8600:3c71:fdf9:cf28:325e:596])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18A4q2Zi317027
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 9 Sep 2021 21:52:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18A4q2Zi317027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631249523;
        bh=FUbYLNLfsxkmBYIgXCMzE84jXrwtgqyNfIq/wOODqQE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Z0ZiLjKXdZdQA8DKbafgAvQ5t2kt+k0LVHhE9fVO7rDbuKE3q8LaLCcrN/Ye9IBL6
         uvFqvFobu6rkbndRod4IBSFFOn7UWB89pCCb5XyyO2XrIp3KrxNGGtn32XlENfKSbP
         mXSUCfRTnPQrw5pRNsdTT+BKsb/2DjttLHE5DnborKbx3YnzX5ymnqIhQpwf6G/e/v
         jouQ2xHH0boP4q8NIBITd3UAFfDver3osDGZESlYSRZJJTGQBoTUbzLFgWxhWsz3X+
         7rCfZRx/x99jDv3iY+tv3vM6q4Al+nOZ7uUx/N1bacoiK6oYwlPGVBeer3BKGr1r8F
         /7B+aqB+sqo/Q==
Date:   Thu, 09 Sep 2021 21:51:55 -0700
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
In-Reply-To: <286DCB70-B36E-4229-966E-BE45F2AEA703@zytor.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com> <20210831175025.27570-18-jiangshanlai@gmail.com> <eb294b5d-82f2-be80-b3e3-db556c155d95@linux.alibaba.com> <286DCB70-B36E-4229-966E-BE45F2AEA703@zytor.com>
Message-ID: <4C8A910F-679F-4F49-AAA5-AA3B9BE5F2BD@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: with FRED paranoid entry is no longer needed since the hardware enfor=
ces gs_base mode consistency=2E

On September 9, 2021 9:50:40 PM PDT, "H=2E Peter Anvin" <hpa@zytor=2Ecom> =
wrote:
>It may affect your design, I don't know, but FRED exception delivery (as =
currently architected per draft 2=2E0; it is subject to change still) pushe=
s several fields above the conventional stack frame (and thus above pt_regs=
=2E)
>
>On September 9, 2021 5:18:47 PM PDT, Lai Jiangshan <laijs@linux=2Ealibaba=
=2Ecom> wrote:
>>
>>
>>On 2021/9/1 01:50, Lai Jiangshan wrote:
>>> From: Lai Jiangshan <laijs@linux=2Ealibaba=2Ecom>
>>>=20
>>> struct ist_regs is the upmost stack frame for IST interrupt, it
>>> consists of struct pt_regs and other fields which will be added in
>>> later patch=2E
>>>=20
>>> Make vc_switch_off_ist() take ist_regs as its argument and it will swi=
tch
>>> the whole ist_regs if needed=2E
>>>=20
>>> Make the frame before calling paranoid_entry() and paranoid_exit() be
>>> struct ist_regs=2E
>>>=20
>>> This patch is prepared for converting paranoid_entry() and paranoid_ex=
it()
>>> into C code which will need the additinal fields to store the results =
in
>>> paranoid_entry() and to use them in paranoid_exit()=2E
>>
>>This patch was over designed=2E
>>
>>In ASM code, we can easily save results in the callee-saved registers=2E
>>For example, rc3 is saved in %r14, gsbase info is saved in %rbx=2E
>>
>>And in C code, we can't save results in registers=2E  And I thought ther=
e was
>>no place to save the results because the CR3 and gsbase are not kernel's=
=2E
>>So I extended the pt_regs to ist_regs to save the results=2E
>>
>>But it was incorrect=2E  The results can be saved in percpu data at the =
end of
>>paranoid_entry() after the CR3/gsbase are settled down=2E  And the resul=
ts
>>can be read at the beginning of paranoid_exit() before the CR3/gsbase ar=
e
>>switched to the interrupted context's=2E
>>
>>sigh=2E
>>
>>>=20
>>> The C interrupt handlers don't use struct ist_regs due to they don't n=
eed
>>> the additional fields in the struct ist_regs, and they still use pt_re=
gs=2E
>>>=20
>>
>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
