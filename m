Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E77442D05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhKBLqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:46:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53345 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKBLqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:46:49 -0400
Received: from [127.0.0.1] (81-227-32-128-no2212.tbcn.telia.com [81.227.32.128])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 1A2BN0kw425542
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 2 Nov 2021 04:23:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 1A2BN0kw425542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021103101; t=1635852184;
        bh=zKQeGXfsP+l5tBAkLhe3Tvi3JuMR+eopIE+9EA1wQsM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=t9G1OOot4B9uuHrdKAMpalUcHST3KZcHpw4b1zNsOTmPFQzEzjgkW4i9MQCCPvQDq
         Tl7sNQ99i7b+Yy/NXeGs0sWc540J4Mxq0YVt4kBOl0yB5VBz9I+uc5Tp9Q8LPyrjz7
         lV2GoRLP6LMDOh9gkMeNYxovtOHZSNE8AnMf+2KVpqsrpxnjGNJVAA08FWqiFu18o1
         TXFFpkt9pODi0BDJm/xLoO1e43DDJf0MW14h0337K7fkxXncb4u4r/DhlxuPdHIbsy
         Yzu8cxfYydoC8lPVacveRu9yAl2L1nwIRqd7Kx23zXXsc0c25w7pOvBxRWLsLERShX
         ywQ5nXMbngBFw==
Date:   Tue, 02 Nov 2021 12:22:50 +0100
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <laijs@linux.alibaba.com>
CC:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_V4_04/50=5D_x86/xen=3A_Add_xenp?= =?US-ASCII?Q?v=5Frestore=5Fregs=5Fand=5Freturn=5Fto=5Fusermode=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YYEJuIgQukcDzy1R@zn.tnic>
References: <20211026141420.17138-1-jiangshanlai@gmail.com> <20211026141420.17138-5-jiangshanlai@gmail.com> <YYD9ohN2Zcy4EdMb@zn.tnic> <d4ae23dd-377e-8316-909b-d5bdeacc0904@linux.alibaba.com> <YYEJuIgQukcDzy1R@zn.tnic>
Message-ID: <6F6D3FEC-9AF1-40E1-A7C2-394D21C40114@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 2, 2021 10:49:44 AM GMT+01:00, Borislav Petkov <bp@alien8=2Ede=
> wrote:
>On Tue, Nov 02, 2021 at 05:19:46PM +0800, Lai Jiangshan wrote:
>> It will add a 5-byte NOP at the beginning of the native
>> swapgs_restore_regs_and_return_to_usermode=2E
>
>So?
>

It would be interesting to have an "override function with jmp" alternativ=
es macro=2E It doesn't require any changes to the alternatives mechanism pr=
oper (but possibly to objtool): it would just insert an alternatives entry =
without adding any code including nops to the main path=2E It would of cour=
se only be applicable to a jmp, so a syntax like OVERRIDE_JMP feature, targ=
et rather than open-coding the instruction would probably be a good idea=2E

That would reduce the trade-off to zero=2E

>> I avoided adding unneeded code in the native code even if it is NOPs
>> and avoided melting xenpv-one into the native one which will reduce
>> the code readability=2E
>
>How does this reduce code readability?!
>
>diff --git a/arch/x86/entry/entry_64=2ES b/arch/x86/entry/entry_64=2ES
>index e38a4cf795d9=2E=2Ebf1de54a1fca 100644
>--- a/arch/x86/entry/entry_64=2ES
>+++ b/arch/x86/entry/entry_64=2ES
>@@ -567,6 +567,10 @@ __irqentry_text_end:
>=20
> SYM_CODE_START_LOCAL(common_interrupt_return)
> SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL=
)
>+
>+	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", \
>+                X86_FEATURE_XENPV
>+
> #ifdef CONFIG_DEBUG_ENTRY
> 	/* Assert that pt_regs indicates user mode=2E */
> 	testb	$3, CS(%rsp)
>
>> I will follow your preference since a 5-byte NOP is so negligible in th=
e slow
>> path with an iret instruction=2E
>
>Yes, we do already gazillion things on those entry and exit paths=2E
>
>> Or other option that adds macros to wrap the ALTERNATIVE=2E
>> RESTORE_REGS_AND_RETURN_TO_USERMODE and
>> COND_RESTORE_REGS_AND_RETURN_TO_USERMODE (test %eax before jmp in nativ=
e case)
>
>No, the main goal is to keep the asm code as readable and as simple as
>possible=2E
>
>If macros or whatever need to be added, there better be a good reason
>for them=2E Saving a NOP is not one of them=2E
>
>Thx=2E
>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
