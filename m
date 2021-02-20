Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BD332042D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 07:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBTG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 01:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBTG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 01:28:33 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD640C061574;
        Fri, 19 Feb 2021 22:27:52 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u8so7966789ior.13;
        Fri, 19 Feb 2021 22:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbhfHHRIUaZy8yAJGu8fLFh9WOmxHPl60f50bXM7zwo=;
        b=HRXdEKtvf9vgz47G1cFkpU6z5Ea5Es/FYQdYNgksGTbBybgWgmNmEkp4rUNyeQZCoF
         j6O3IUwc75w4wBH7Mh1bZt9eDpgg2aqGR6cesxUI0p9xbwSq/zffQ8GHbt2PuYoJrk6I
         W7yvIBxQ3dSb7b1UItfnH1RnIHgJZDWLvBXP30LSV+PFE8SGhHTTyCS+JISfl4fC/79b
         EV3286239qCeESz+SfqysFOcyp5r7GCJw1NOaS/cl0qQnsmI/MoScMoTyO6SqpgiQLmT
         rscaBLSg2JhOjzaTEn4t++VDAds0L0ho3+jeNtiVleoC8BVL+AmKMc/vp6GCrX+urqBl
         PPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbhfHHRIUaZy8yAJGu8fLFh9WOmxHPl60f50bXM7zwo=;
        b=Zw2q+ts/WTKJWA55LWuuoxssoF1Uj9iocuCKi1a8LTyh3x0z8uVRQadnOWCwmhNL1a
         a+0D9WCxrtQMECoX1kJeQWFWh2cGJotZoLPI9/rOQ4IgCYdyCCbJ2WOTcO5yu1FJNA3c
         GR1CY/8OMoGovSfZu7xMaio2PlmKf6riz/aj1TFl8w+0I6DigL0sUSLS1ApHiSbMuV8C
         6Jy4vkNXhdgylUo6A7iOlBFPq6nBH3LawW912BSXzv1MJFFr8UPPR/qbqGiZSBTImp+i
         eoCa3VJCTCd4yRPaHa3mi0ayuryhc6Hb8A/k990eXNd74gTQTO3vm4P7W/xky0DP4aTC
         KGLg==
X-Gm-Message-State: AOAM533FJ025fLmsCA4U9vokFzgyJy5lPB/ctt+l+43bAAbHmAQiPRBt
        H3h9qhDcZeuk4Pd6Aw3vHNCkM0kD6RnrLQkzB8w=
X-Google-Smtp-Source: ABdhPJx1RfWuVeA2Vy5Otxd772m3nvFKCMmiiHWZ/qHRV3FMId+h+cZs0K/hWTNXSAQ3KtWeZysSnHoTexLEyyMZJc8=
X-Received: by 2002:a5e:8f49:: with SMTP id x9mr7220367iop.189.1613802472221;
 Fri, 19 Feb 2021 22:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20210217145625.14006-1-yashsri421@gmail.com>
In-Reply-To: <20210217145625.14006-1-yashsri421@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 20 Feb 2021 07:27:41 +0100
Message-ID: <CAKXUXMx+DEh6Mso_dxA1-NbYZaugUQ9JBfjb4+yyouw2AFPdfA@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: fix array element capture in
 pointer-to-func parsing
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 3:56 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> Currently, kernel-doc causes an unexpected error when array element (i.e.,
> "type (*foo[bar])(args)") is present as pointer parameter in
> pointer-to-function parsing.
>
> For e.g., running kernel-doc -none on kernel/gcov/gcc_4_7.c causes this
> error:
> "Use of uninitialized value $param in regexp compilation at ...", in
> combination with:
> "warning: Function parameter or member '' not described in 'gcov_info'"
>
> Here, the parameter parsing does not take into account the presence of
> array element (i.e. square brackets) in $param.
>
> Provide a simple fix by adding square brackets in the regex, responsible
> for capturing $param.
>
> A quick evaluation, by running 'kernel-doc -none' on entire kernel-tree,
> reveals that no additional warning or error has been added or removed by
> the fix.
>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> * Applies perfectly over next-20210217
>

Aditya, Jonathan,

I have tested this change with:

git ls-files | xargs ./scripts/kernel-doc -none 2>&1 | tee kernel-doc-output

Applied the patch, and re-ran that command and compared the diff.

First, I observed that ./scripts/kernel-doc is not fully deterministic
on my machine, although I could not really pinpoint it to the exact
reason where that comes in.

Secondly, more importantly, the relevant diff affected by this patch is:

< Use of uninitialized value $param in regexp compilation at
./scripts/kernel-doc line 1559, <IN_FILE> line 308.
< Use of uninitialized value $actual in substitution (s///) at
./scripts/kernel-doc line 1523, <IN_FILE> line 308.
< Use of uninitialized value $actual in substitution (s///) at
./scripts/kernel-doc line 1523, <IN_FILE> line 308.
< Use of uninitialized value $param in substitution (s///) at
./scripts/kernel-doc line 1617, <IN_FILE> line 308.
< Use of uninitialized value $param in hash element at
./scripts/kernel-doc line 1651, <IN_FILE> line 308.
< Use of uninitialized value $param in pattern match (m//) at
./scripts/kernel-doc line 1651, <IN_FILE> line 308.
< Use of uninitialized value $param in hash element at
./scripts/kernel-doc line 1652, <IN_FILE> line 308.
< Use of uninitialized value $param in pattern match (m//) at
./scripts/kernel-doc line 1654, <IN_FILE> line 308.
< Use of uninitialized value $param in concatenation (.) or string at
./scripts/kernel-doc line 1655, <IN_FILE> line 308.
< drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h:308:
warning: Function parameter or member '' not described in
'brcmf_fweh_info'
< Use of uninitialized value $param in hash element at
./scripts/kernel-doc line 1672, <IN_FILE> line 308.


< Use of uninitialized value $param in regexp compilation at
./scripts/kernel-doc line 1559, <IN_FILE> line 96.
< Use of uninitialized value $actual in substitution (s///) at
./scripts/kernel-doc line 1523, <IN_FILE> line 96.
< Use of uninitialized value $actual in substitution (s///) at
./scripts/kernel-doc line 1523, <IN_FILE> line 96.
< Use of uninitialized value $param in substitution (s///) at
./scripts/kernel-doc line 1617, <IN_FILE> line 96.
< Use of uninitialized value $param in hash element at
./scripts/kernel-doc line 1651, <IN_FILE> line 96.
< Use of uninitialized value $param in pattern match (m//) at
./scripts/kernel-doc line 1651, <IN_FILE> line 96.
< Use of uninitialized value $param in hash element at
./scripts/kernel-doc line 1652, <IN_FILE> line 96.
< Use of uninitialized value $param in pattern match (m//) at
./scripts/kernel-doc line 1654, <IN_FILE> line 96.
< Use of uninitialized value $param in concatenation (.) or string at
./scripts/kernel-doc line 1655, <IN_FILE> line 96.
< kernel/gcov/gcc_4_7.c:96: warning: Function parameter or member ''
not described in 'gcov_info'
< Use of uninitialized value $param in hash element at
./scripts/kernel-doc line 1672, <IN_FILE> line 96.

So, I can confirm that the mentioned issue is really resolved with
this patch, and that deserves a tag:

Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks, Aditya. When can we expect the next patch for ./scripts/kernel-doc?

Looking forward to running the next test :)

Lukas
