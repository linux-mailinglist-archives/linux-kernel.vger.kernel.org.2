Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6363A221D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 04:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJCGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 22:06:22 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49810 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 22:06:21 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 15A249gX001734;
        Thu, 10 Jun 2021 11:04:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 15A249gX001734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1623290650;
        bh=rm9Djr4WdlFHkftclLH40/YooROTedjrpz+eDOHOrcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TpGYPe5Uf7c1NYcWuLgGTpYrNvoFtofbDbQuTNwbNJ7eJXq7b7Ux1y0TBMGSVO+wq
         KPj0ZMjWsSKN2fuTjHAD05rUPDbSGE9hAape7W4ER5KBc8fCljjhoChobohFvJMtts
         VVu5jQgWQEt/Cpnk/3Hp17ubLFOBD2AMwtw/h3DIgCmWcO2PkgGu9YdFnKXM4/mHHK
         FeFjToi7773PrSMYL84tqJRbL3b0xX/TcfaUWENY3bhKP3steKoGOLZYYiAeTdp51I
         NKnaw06NT7frJnAfqA3XsqQySwDHwD2dZAGrwjswRaUTThJ+nqiWR6THzqHwcrrWWw
         U8osCScf/KHqA==
X-Nifty-SrcIP: [209.85.215.179]
Received: by mail-pg1-f179.google.com with SMTP id j12so21282924pgh.7;
        Wed, 09 Jun 2021 19:04:09 -0700 (PDT)
X-Gm-Message-State: AOAM532VcEPSdvcXMU80sU9DHIVnGMoFn/VWHV1DeP8AKn5DPTNfLk1K
        44A4DHw5AJnawaieiExU7KGwuWADj82eLXyeepQ=
X-Google-Smtp-Source: ABdhPJzuC0PRj07bmjql5kCYvt57Vwjnsr8YFtHMyiydC1Bs2Y8l8YeXM5uSByx5lB1/dWCBMezdjrdCnwYuHRf5Z08=
X-Received: by 2002:a63:6841:: with SMTP id d62mr2613776pgc.7.1623290648993;
 Wed, 09 Jun 2021 19:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee> <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
In-Reply-To: <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Jun 2021 11:03:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
Message-ID: <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
Subject: Re: linux-parisc compile failure in current git
To:     Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008039e105c45fceaf"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008039e105c45fceaf
Content-Type: text/plain; charset="UTF-8"

Hi Helge,


On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
>
> On 6/1/21 12:21 PM, Meelis Roos wrote:
> > Upstream Linux git fails to compile on gentoo hppa -  .config below.
> > I have 2 gcc-s as always:
> > $ gcc-config -l
> >   [1] hppa2.0-unknown-linux-gnu-9.3.0
> >   [2] hppa2.0-unknown-linux-gnu-10.2.0 *
> >
> >   [3] hppa64-unknown-linux-gnu-10.2.0 *
>
>
> I see the same issue too, but only when compiling natively on a parisc machine.
> Cross-compiling on a x86 box works nicely.
>
> First I thought it's a problem with setting the "cross_compiling" flag in ./Makefile.
> But that's not sufficient.
>
> On a x86 machine (which builds fine) I get
> SRCARCH=parisc SUBARCH=x86 UTS_MACHINE=parisc
> The arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
> hppa64-linux-gnu-gcc
>
> On a native 32bit parisc machine I have:
> SRCARCH=parisc SUBARCH=parisc UTS_MACHINE=parisc
> Here the arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
> gcc
> Instead here the native hppa64-linux-gnu-gcc (cross compiler) should have been used too, since
> we build a 64-bit hppa kernel (CONFIG_64BIT is set).
> Note, on hppa we don't have an "-m64" compiler flag as on x86.

I see.
hppa is not a bi-arch compiler, in other words,
http- and hppa64- are separate compilers.



>
> Mashahiro, do you maybe have an idea what gets wrong here, or which
> patch has changed the behaviour how the asm-offsets.c file gets preprocessed?


Presumably, commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3

Prior to that commit, arch/parisc/Makefile was like this:

ifneq ($(SUBARCH),$(UTS_MACHINE))
        ifeq ($(CROSS_COMPILE),)
                    ...

Now I understand why arch/parisc/Makefile was written this way.

Reverting the change in arch/parisc/Makefile will restore the original behavior.

But, please keep in mind that there is an issue remaining.

Please see this code:

ifdef CONFIG_64BIT
UTS_MACHINE := parisc64
CHECKFLAGS += -D__LP64__=1
CC_ARCHES = hppa64
LD_BFD := elf64-hppa-linux
else # 32-bit
CC_ARCHES = hppa hppa2.0 hppa1.1
LD_BFD := elf32-hppa-linux
endif


UTS_MACHINE is determined by CONFIG_64BIT.

CONFIG_64BIT is defined only after Kconfig is finished.
When you are trying to configure the .config,
CONFIG_64BIT is not defined yet.
So UTS_MACHINE is always 'parisc'.

As you know, Kconfig files now have a bunch of 'cc-option' syntax
to check the compiler capability in Kconfig time.
Hence, you need to provide a proper compiler in Kconfig time too.

When you build a 64-bit parisc kernel on a 32-bit parisc machine,
Kconfig is passed with CC=gcc since SUBARCH==UTS_MACHINE==parisc.
After Kconfig, CROSS_COMPILE=hppa64-* is set,
and the kernel is built by CC=hppa64-*-gcc.
So, Kconfig evaluated a compiletely different compiler. This is pointless.


There are some options

[option 1]
  revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
  This will restore the functionality you may want, but
  as I said above, Kconfig is doing pointless things.

[option 2]
   Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
   This is what many architectures including arm, arm64 do.
   You need to explicitly pass CROSS_COMPILE=aarch64-linux-gnu- etc.
   if you are cross-compiling arm64.

[option 3]
   Introduce ARCH=parisc64.

   When you are building 64-bit kernel, you can pass ARCH=parisc64

    A patch attached.  (but not tested much)



--
Best Regards

Masahiro Yamada

--0000000000008039e105c45fceaf
Content-Type: application/x-patch; name="parisc64.diff"
Content-Disposition: attachment; filename="parisc64.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kpq940k00>
X-Attachment-Id: f_kpq940k00

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggN2I2NDNhMWE3ODg2Li5mYTM3
NjE1ZjUzMzIgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC00MDYsNiAr
NDA2LDExIEBAIGlmZXEgKCQoQVJDSCksc3BhcmM2NCkKICAgICAgICBTUkNBUkNIIDo9IHNwYXJj
CiBlbmRpZgogCisjIEFkZGl0aW9uYWwgQVJDSCBzZXR0aW5ncyBmb3IgcGFyaXNjCitpZmVxICgk
KEFSQ0gpLHBhcmlzYzY0KQorICAgICAgIFNSQ0FSQ0ggOj0gcGFyaXNjCitlbmRpZgorCiBleHBv
cnQgY3Jvc3NfY29tcGlsaW5nIDo9CiBpZm5lcSAoJChTUkNBUkNIKSwkKFNVQkFSQ0gpKQogY3Jv
c3NfY29tcGlsaW5nIDo9IDEKZGlmZiAtLWdpdCBhL2FyY2gvcGFyaXNjL01ha2VmaWxlIGIvYXJj
aC9wYXJpc2MvTWFrZWZpbGUKaW5kZXggYWVkOGVhMjkyNjhiLi4yZDAxOWFhNzNiOGYgMTAwNjQ0
Ci0tLSBhL2FyY2gvcGFyaXNjL01ha2VmaWxlCisrKyBiL2FyY2gvcGFyaXNjL01ha2VmaWxlCkBA
IC0yNSwxOCArMjUsMTggQEAgQ0hFQ0tGTEFHUwkrPSAtRF9faHBwYV9fPTEKIGlmZGVmIENPTkZJ
R182NEJJVAogVVRTX01BQ0hJTkUJOj0gcGFyaXNjNjQKIENIRUNLRkxBR1MJKz0gLURfX0xQNjRf
Xz0xCi1DQ19BUkNIRVMJPSBocHBhNjQKIExEX0JGRAkJOj0gZWxmNjQtaHBwYS1saW51eAogZWxz
ZSAjIDMyLWJpdAotQ0NfQVJDSEVTCT0gaHBwYSBocHBhMi4wIGhwcGExLjEKIExEX0JGRAkJOj0g
ZWxmMzItaHBwYS1saW51eAogZW5kaWYKIAogIyBzZWxlY3QgZGVmY29uZmlnIGJhc2VkIG9uIGFj
dHVhbCBhcmNoaXRlY3R1cmUKLWlmZXEgKCQoc2hlbGwgdW5hbWUgLW0pLHBhcmlzYzY0KQoraWZl
cSAoJChBUkNIKSxwYXJpc2M2NCkKIAlLQlVJTERfREVGQ09ORklHIDo9IGdlbmVyaWMtNjRiaXRf
ZGVmY29uZmlnCisJQ0NfQVJDSEVTIDo9IGhwcGE2NAogZWxzZQogCUtCVUlMRF9ERUZDT05GSUcg
Oj0gZ2VuZXJpYy0zMmJpdF9kZWZjb25maWcKKwlDQ19BUkNIRVMgOj0gaHBwYSBocHBhMi4wIGhw
cGExLjEKIGVuZGlmCiAKIGV4cG9ydCBMRF9CRkQKZGlmZiAtLWdpdCBhL3NjcmlwdHMvc3ViYXJj
aC5pbmNsdWRlIGIvc2NyaXB0cy9zdWJhcmNoLmluY2x1ZGUKaW5kZXggNjUwNjgyODIxMTI2Li43
NzY4NDlhM2M1MDAgMTAwNjQ0Ci0tLSBhL3NjcmlwdHMvc3ViYXJjaC5pbmNsdWRlCisrKyBiL3Nj
cmlwdHMvc3ViYXJjaC5pbmNsdWRlCkBAIC03LDcgKzcsNyBAQAogU1VCQVJDSCA6PSAkKHNoZWxs
IHVuYW1lIC1tIHwgc2VkIC1lIHMvaS44Ni94ODYvIC1lIHMveDg2XzY0L3g4Ni8gXAogCQkJCSAg
LWUgcy9zdW40dS9zcGFyYzY0LyBcCiAJCQkJICAtZSBzL2FybS4qL2FybS8gLWUgcy9zYTExMC9h
cm0vIFwKLQkJCQkgIC1lIHMvczM5MHgvczM5MC8gLWUgcy9wYXJpc2M2NC9wYXJpc2MvIFwKKwkJ
CQkgIC1lIHMvczM5MHgvczM5MC8gXAogCQkJCSAgLWUgcy9wcGMuKi9wb3dlcnBjLyAtZSBzL21p
cHMuKi9taXBzLyBcCiAJCQkJICAtZSBzL3NoWzIzNF0uKi9zaC8gLWUgcy9hYXJjaDY0LiovYXJt
NjQvIFwKIAkJCQkgIC1lIHMvcmlzY3YuKi9yaXNjdi8pCg==
--0000000000008039e105c45fceaf--
