Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81238383C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbhEQSqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbhEQSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:46:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:45:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s6so8085587edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AleBjFBWk3Df8DfvZfAUw4Js6OSMy8R4ZV9LCI/pwZE=;
        b=JU135R0n5DaljOl5R2QVLhmEXd6W9BOJCDVRRcwiuF87TC1z1ppmct1rIvJjAsWl0K
         e8Cw23klCNFsqrG9MMzEvBkNtNp8AJxVEMwS1o0bgYvdTMCbcOx8MAbK8+DfbqzovsKy
         bgicDs1vJAblZa/pBKh7x7PYrlS1lPicErkJX12tpDIEzCaPLTxNSjE3N9VLEmAa7Onc
         whfRhjW/EBLUf3Q2Qg8TbBkIssSxuOJ/TEMV1DP1yvRtVLzS55wOqZKg5uM/Lxjr3t/s
         Jk/NmP9VZ2xoNPGXj+pNZ06GkB9nhLaWZFgsn9OXE7NGrZ+v43cCKz5M/I9tflPg+4QO
         8YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AleBjFBWk3Df8DfvZfAUw4Js6OSMy8R4ZV9LCI/pwZE=;
        b=uHrUDOF9/AjVXnCvkKMa+sMBx9uOb6xq9E7BXlDRuMkFOY9kmWJHuKaODVSgwLcUR+
         XAbnQsgEQ7t8VR7g8lcwr9xLdbgBzfy/lYL91uEueMMrPVQTUzKoe7J/k2QOC/cqy5AH
         eX+LJxPljaVJDcq1WMZv5vfUtyEodPeJOr8e5sI0FLYFMYbf4IIdKUk/FJFdW6XelHhQ
         zvtD2gQWUk4LwGZEauvb/mDSATCkNkZBDGkhSVegF2dbbJqaaTD/rKc4rDGjlcSaLDyC
         8HWVo3zHftxx5sEGF4uKap/PYgHAdGgakbqb7AuYUAlud7Eo9x3nTI8b+jI1hXI7rnb4
         sMpw==
X-Gm-Message-State: AOAM531eZFLAHyTI/Xaa5frpGWhrnDyoFdXdjgxrvw9uW9QHnxzI6seQ
        M2l8gJlWj9YmmnTafitX1ZraILtX0mt7H7wWl906Dg==
X-Google-Smtp-Source: ABdhPJyYnSFhvKrIC+6J8p7tw8eAU1hvyM9K2+qY9Zg5RImBa9AB3z+UWToWQLprbEdPnk0cEiJV8b4Ie6uRHi+QkAc=
X-Received: by 2002:a05:6402:13c3:: with SMTP id a3mr1824579edx.18.1621277116686;
 Mon, 17 May 2021 11:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210514201508.27967-1-chang.seok.bae@intel.com>
 <9f556d3b-49d3-5b0b-0d92-126294ea082d@kernel.org> <C08CCADB-864B-48E0-89E0-4BF6841771E8@intel.com>
In-Reply-To: <C08CCADB-864B-48E0-89E0-4BF6841771E8@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 May 2021 11:45:05 -0700
Message-ID: <CAPcyv4hkHoj5Jb6SdXyADuaFnPpW+zen-hZeJw+qisa64srOFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] x86: Support Intel Key Locker
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:21 AM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
> On May 15, 2021, at 11:01, Andy Lutomirski <luto@kernel.org> wrote:
> > On 5/14/21 1:14 PM, Chang S. Bae wrote:
> >> Key Locker [1][2] is a new security feature available in new Intel CPU=
s to
> >> protect data encryption keys for the Advanced Encryption Standard
> >> algorithm. The protection limits the amount of time an AES key is expo=
sed
> >> in memory by sealing a key and referencing it with new AES instruction=
s.
> >>
> >> The new AES instruction set is a successor of Intel's AES-NI (AES New
> >> Instruction). Users may switch to the Key Locker version from crypto
> >> libraries.  This series includes a new AES implementation for the Cryp=
to
> >> API, which was validated through the crypto unit tests. The performanc=
e in
> >> the test cases was measured and found comparable to the AES-NI version=
.
> >>
> >> Key Locker introduces a (CPU-)internal key to encode AES keys. The ker=
nel
> >> needs to load it and ensure it unchanged as long as CPUs are operation=
al.
> >
> > I have high-level questions:
> >
> > What is the expected use case?
>
> The wrapping key here is only used for new AES instructions.
>
> I=E2=80=99m aware of their potential use cases for encrypting file system=
 or disks.
>
> > My personal hypothesis, based on various
> > public Intel slides, is that the actual intended use case was internal
> > to the ME, and that KL was ported to end-user CPUs more or less
> > verbatim.
>
> No, this is a separate one. The feature has nothing to do with the firmwa=
re
> except that in some situations it merely helps to back up the key in its
> state.
>
> > I certainly understand how KL is valuable in a context where
> > a verified boot process installs some KL keys that are not subsequently
> > accessible outside the KL ISA, but Linux does not really work like this=
.
>
> Do you mind elaborating on the concern?  I try to understand any issue wi=
th
> PATCH3 [1], specifically.

If I understand Andy's concern it is the observation that the weakest
link in this facility is the initial key load. Yes, KL reduces
exposure after that event, but the key loading process is still
vulnerable. This question is similar to the concern between the Linux
"encrypted-keys" and "trusted-keys" interface. The trusted-keys
interface still has an attack window where the key is unwrapped in
kernel space to decrypt the sub-keys, but that exposure need not cross
the user-kernel boundary and can be time-limited to a given PCR state.
The encrypted-keys interface maintains the private-key material
outside the kernel where it has increased exposure. KL is effectively
"encrypted-keys" and Andy is questioning whether this makes KL similar
to the MKTME vs SGX / TDX situation.

>
> > I'm wondering what people will use it for.
>
> Mentioned above.

I don't think this answers Andy's question. There is a distinction
between what it can be used for and what people will deploy with it in
practice given the "encrypted-keys"-like exposure. Clarify the end
user benefit that motivates the kernel to carry this support.
