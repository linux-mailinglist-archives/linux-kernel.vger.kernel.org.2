Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3532419015
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhI0Hig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:38:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46837 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233166AbhI0Hif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:38:35 -0400
Received: from [IPv6:::1] ([IPv6:2601:646:8600:3c71:edf3:dc61:b4b3:3bb7])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18R7aI3P201807
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 27 Sep 2021 00:36:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18R7aI3P201807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1632728181;
        bh=Y/bYplV6xrdSPC3/Y7g5lzWQAtpi7XAdYDrpyihyABE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=N41MGeP8KpfdYFWQl49+/WNc/bU/3v79lq43lI0urS5kL3LHm3vken4Qgg45lJa7U
         Ht4IHrijPZXD6+yz1XtSWFGbJSjUwFroIrvE65+40PvAWkzb67dNUhNAPn1sd5rygR
         UYucgjAvjvtG592aUqJkZfN5RjzsQ8QOSvOjZ++lM8eF8A3Te6H5BuGGs6wRqnqRjl
         NP5TH5uQDnQ3Qqd65+z6lW34ZW+r/JEn7X5CUXjXR/pKAUJeld7s+IUb5dIg8gknqR
         s3wGCoacvIMaORF1gnygpy+CpOCBFmOwgc/UcNjVMm29UrNmNOG3B5WCHyBtWimXFZ
         Cww0jCjLb3fnw==
Date:   Mon, 27 Sep 2021 00:36:12 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Laight <David.Laight@aculab.com>
CC:     Numfor Mbiziwo-Tiapo <nums@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_x86/insn=2C_tools/x86=3A_F?= =?US-ASCII?Q?ix_some_potential_undefined_behavior=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20210923161843.751834-1-irogers@google.com>
References: <20210923161843.751834-1-irogers@google.com>
Message-ID: <28DFA0E7-0761-4664-86DA-4ABD5902E95E@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have get_unaligned() for a reason=2E

On September 23, 2021 9:18:43 AM PDT, Ian Rogers <irogers@google=2Ecom> wr=
ote:
>From: Numfor Mbiziwo-Tiapo <nums@google=2Ecom>
>
>Don't perform unaligned loads in __get_next and __peek_nbyte_next as
>these are forms of undefined behavior=2E
>
>These problems were identified using the undefined behavior sanitizer
>(ubsan) with the tools version of the code and perf test=2E Part of this
>patch was previously posted here:
>https://lore=2Ekernel=2Eorg/lkml/20190724184512=2E162887-4-nums@google=2E=
com/
>
>v4=2E Fixes a typo=2E
>
>v3=2E Is a rebase picking up a fix for big endian architectures=2E
>
>v2=2E removes the validate_next check and merges the 2 changes into one a=
s
>requested by Masami Hiramatsu <mhiramat@kernel=2Eorg>
>
>Signed-off-by: Ian Rogers <irogers@google=2Ecom>
>Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google=2Ecom>
>Acked-by: Masami Hiramatsu <mhiramat@kernel=2Eorg>
>---
> arch/x86/lib/insn=2Ec       | 4 ++--
> tools/arch/x86/lib/insn=2Ec | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/x86/lib/insn=2Ec b/arch/x86/lib/insn=2Ec
>index 058f19b20465=2E=2Ec565def611e2 100644
>--- a/arch/x86/lib/insn=2Ec
>+++ b/arch/x86/lib/insn=2Ec
>@@ -37,10 +37,10 @@
> 	((insn)->next_byte + sizeof(t) + n <=3D (insn)->end_kaddr)
>=20
> #define __get_next(t, insn)	\
>-	({ t r =3D *(t*)insn->next_byte; insn->next_byte +=3D sizeof(t); leXX_t=
o_cpu(t, r); })
>+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=3D si=
zeof(t); leXX_to_cpu(t, r); })
>=20
> #define __peek_nbyte_next(t, insn, n)	\
>-	({ t r =3D *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
>+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r)=
; })
>=20
> #define get_next(t, insn)	\
> 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t=
, insn); })
>diff --git a/tools/arch/x86/lib/insn=2Ec b/tools/arch/x86/lib/insn=2Ec
>index c41f95815480=2E=2E797699462cd8 100644
>--- a/tools/arch/x86/lib/insn=2Ec
>+++ b/tools/arch/x86/lib/insn=2Ec
>@@ -37,10 +37,10 @@
> 	((insn)->next_byte + sizeof(t) + n <=3D (insn)->end_kaddr)
>=20
> #define __get_next(t, insn)	\
>-	({ t r =3D *(t*)insn->next_byte; insn->next_byte +=3D sizeof(t); leXX_t=
o_cpu(t, r); })
>+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=3D si=
zeof(t); leXX_to_cpu(t, r); })
>=20
> #define __peek_nbyte_next(t, insn, n)	\
>-	({ t r =3D *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
>+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); leXX_to_cpu(t, r)=
; })
>=20
> #define get_next(t, insn)	\
> 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t=
, insn); })

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
