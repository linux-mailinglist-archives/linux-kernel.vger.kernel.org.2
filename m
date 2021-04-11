Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109835B26C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhDKI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:28:47 -0400
Received: from mout.web.de ([212.227.15.3]:47191 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKI2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618129701;
        bh=2ckt1f+rI93dlvOrZNcI1/4dZNPyKFvyBbigdaF7+C4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=NbR3G/QhqoVEds/ulzGvB5EOjYsAWITrBzpkLB+YuQH6loO4iiEv/TPRHqUOJGioN
         L151xNO5j6ejePK6UmTCmiCKOx95HCrFhwathjjYvznxjE3RzfkdPtTJBALbDxA67N
         jS6nsOMIR6UtuCEPQX99Ek39D0gXpqwuTqD/gAvs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGzFy-1lHhq32GjS-00DrNA; Sun, 11
 Apr 2021 10:22:21 +0200
Subject: Re: [PATCH v2] x86: pat: Do not compile stubbed functions when
 X86_PAT is off
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
 <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
 <a2788ff7-c524-52de-3f45-82613410f872@siemens.com>
 <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
Message-ID: <802cefc7-b475-c6d6-ece7-8232d7f3891d@web.de>
Date:   Sun, 11 Apr 2021 10:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a9351615-7a0d-9d47-af65-d9e2fffe8192@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7cUiODngEyb67AZXSzX9NnIuKfYRJl9/UAOm7HtTkJn1FFEVys/
 PfUMmTdaPUfIeSNIfGgiWwZsrmPIEn9DI95s1ENfEx9wRYMcN8OKJXC0dxIxDIPrzm9xusx
 NRolWA7vUay/7xgNFjrsR7BG+wqE6rdzaNuP0m8fROL0Iu0A15KyHfldkTrBn8gs7uHHKJw
 mek0sJ/GAVbCv/LLp61Ow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WbgiMBI2ofQ=:L+N0ksEG3oJuKH38H67GEL
 Hsx78jVaUlea+YJ12cw+ulNOTxw3OhUAo9S9iwc0Qnru3Y25GEHD7kLz9jxeqCgC/O8YxV942
 ckUIYP9Js7d7wSPHK5j5jFCcJHH3ZkFdhYVIGnJtzfBI7vJAtntihRksenOpjWNVTbRe+WDdp
 VlY2/Su22m2L9vXGW5be55fhfaE/NFZKQQ2qg70ZpHN8rd3juZgA/uq2P8DRbcIbKTjX//0oo
 fTVOGWf/wh8a7dC3Bgu3UBKQnnPG82jJUR9tTfGtJMfBzpWvFcY8ctfgodmHkB+UR35w9p+qO
 6eATdCYjFQl8oPfchdtL8dDKOCL1dAYleDjwp19ss7u0UvsExKwyjg4MT3slIk/fg6GottEls
 zkuDNrXiPzFWOcWLZLNIKLVFYRBhvWEqZ2IxERJ9qsuFm3/8pW+/lrateRf/u3ADZMi94XQ1f
 0m6nYfZx3IPjOybu0Oz2bk+F3+ScU2Zd6fKqCk2n+IzaQm49ySPRtLy2H+DZJFtqrTVhoERG1
 ReTcJ4H+q08Yad4kehWixfxmI5B2WeH+AgmFFutrzgHmiFOszM5eZSisyjBtCKcLcgZAcRtby
 0gS1+m9JIvziX+LQnburL5ryJ5v3szzd+SClAkgTaSyUbA0Y0CKe2N76UHwdf1biaXTBr9mwR
 x3YSoE5uhJZdKbvz67dsKMmgFGOOZN4QGyiyvjqZoVP9f+mZnJtjakXrPHiKtJLR4RYE3UMan
 K46VmdPZIL/ilG0A4cQaU/CNIbHBdjm7Uc8OSYkQJ7kzvsUet225DS+RBv2v1DUKM/l7EnxXq
 bAq8iy2LSL1UffRTs/V59YdP87oS1HJbXlm8bZh+LvayHYA2hWWLOnyorEpAar1Vopjq8h3od
 6oqc6OjbWNmOUC33uAREoZvFyjPlI0lfXe+dvXXpNubF/lyYdCJKLorMYYalXs8fGjHcSfFH+
 t4uwX+Fz3ZHgxtqMLDg5sPiMbp1diQmZezodWm/sgtjT4f/4awniItMx4g1e6yDzE7D4qjtXD
 QS1ZrNwVdny2k1QHZ10r5n+0Sf5OSr+e9g+h81G4tBHGfyLyKty48Ew51+jTPuiBtPKXRSnw/
 g2IcBJ3tfTbYNzJ2mZcDY3W9A2hPxx1hgymQ1BjOFdMFSXT43iFq8R89uzq4xSQuG3pFc5GWG
 UA2hb6OuagYxFPxciB0DFZHsi06OnpY88rFX4bqPdxJT9FTZUSHJoeaif1aat28Ny9exk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.20 18:39, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Those are already provided by linux/io.h as stubs.
>
> The conflict remains invisible until someone would pull linux/io.h into
> memtype.c.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Change in v2:
>  - correct commit message
>
>  arch/x86/mm/pat/memtype.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 8f665c352bf0..41a4ac585af3 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -800,6 +800,7 @@ void memtype_free_io(resource_size_t start, resource=
_size_t end)
>  	memtype_free(start, end);
>  }
>
> +#ifdef CONFIG_X86_PAT
>  int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t s=
ize)
>  {
>  	enum page_cache_mode type =3D _PAGE_CACHE_MODE_WC;
> @@ -813,6 +814,7 @@ void arch_io_free_memtype_wc(resource_size_t start, =
resource_size_t size)
>  	memtype_free_io(start, start + size);
>  }
>  EXPORT_SYMBOL(arch_io_free_memtype_wc);
> +#endif
>
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				unsigned long size, pgprot_t vma_prot)
>

What happened to this?

Jan
