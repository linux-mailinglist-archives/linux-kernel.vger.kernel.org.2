Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12734A6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCZMMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:12:47 -0400
Received: from albireo.enyo.de ([37.24.231.21]:45740 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhCZMM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:12:26 -0400
Received: from [172.17.203.2] (port=49747 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lPlK7-0002Im-Tm; Fri, 26 Mar 2021 12:12:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1lPlK7-0008A8-Q0; Fri, 26 Mar 2021 13:12:19 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>, <libc-alpha@sourceware.org>
Subject: Re: Why does glibc use AVX-512?
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
Date:   Fri, 26 Mar 2021 13:12:19 +0100
In-Reply-To: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
        (Andy Lutomirski via Libc-alpha's message of "Thu, 25 Mar 2021
        21:38:24 -0700")
Message-ID: <87a6qqi064.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski-alpha:

> glibc appears to use AVX512F for memcpy by default.  (Unless
> Prefer_ERMS is default-on, but I genuinely can't tell if this is the
> case.  I did some searching.)  The commit adding it refers to a 2016
> email saying that it's 30% on KNL.

As far as I know, glibc only does that on KNL, and there it is
actually beneficial.  The relevant code is:

      /* Since AVX512ER is unique to Xeon Phi, set Prefer_No_VZEROUPPER
         if AVX512ER is available.  Don't use AVX512 to avoid lower CPU
         frequency if AVX512ER isn't available.  */
      if (CPU_FEATURES_CPU_P (cpu_features, AVX512ER))
        cpu_features->preferred[index_arch_Prefer_No_VZEROUPPER]
          |= bit_arch_Prefer_No_VZEROUPPER;
      else
        cpu_features->preferred[index_arch_Prefer_No_AVX512]
          |= bit_arch_Prefer_No_AVX512;

So it's not just about Prefer_ERMS.

> I think we should seriously consider solutions in which, for new
> tasks, XCR0 has new giant features (e.g. AMX) and possibly even

I think the AMX programming model will be different, yes.

> AVX-512 cleared, and programs need to explicitly request enablement.
> This would allow programs to opt into not saving/restoring across
> signals or to save/restore in buffers supplied when the feature is
> enabled.

Isn't XSAVEOPT already able to handle that?

In glibc, we use XSAVE/XSAVEC for the dynamic loader trampoline, so it
should not needlessly enable AVX-512 state today, while still enabling
AVX-512 calling conventions transparently.

There is a discussion about using the higher (AVX-512-only) %ymm
registers, to avoid the %xmm transition penalty without the need for
VZEROUPPER.  (VZEROUPPER is incompatible with RTM from a performance
point of view.)  That would perhaps negatively impact XSAVEOPT.

Assuming you can make XSAVEOPT work for you on the kernel side, my
instincts tell me that we should have markup for RTM, not for AVX-512.
This way, we could avoid use of the AVX-512 registers and keep using
VZEROUPPER, without run-time transaction checks, and deal with other
idiosyncrasies needed for transaction support that users might
encounter once this feature sees more use.  But the VZEROUPPER vs RTM
issues is currently stuck in some internal process issue on my end (or
two, come to think of it), which I hope to untangle next month.
