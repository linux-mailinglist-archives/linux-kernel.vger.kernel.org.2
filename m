Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD23361103
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhDORTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbhDORT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:19:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:19:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso13107827pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8a04NZRtQScmgjBHOwbl/yFtfKtVthaZ/Hnily7UrCw=;
        b=sZMHlhHOU+xc4n8FPvxaAa+E0NTQTmyghhvxpESoKgjXzKi1k+qc9uquNBtg9hVddS
         z3M/fCvYprkqPl2LRyAECaO3XSv85TRvN4A/BFM6YjIC+xIlKa78AOMGuBMmW5axXmS9
         M9/AaXZBOFjIDDxQ0a1PdpygCWQpxryatlidL25bEAZQRjEgrVHCO6go+UFbYcco62H5
         a4I71OFriBDb8dGwAHhEhMrWaKxK4AZR5wCCN3jEVytsMXYm0KLQzqC0XqsC4Yz9rLHx
         xjtH8lPEwOsnC3VEogoNaUvnI6FktMv1krkMdxY07Q6aMr0X8Y/OOJKviqsZLO/mqZH2
         d1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8a04NZRtQScmgjBHOwbl/yFtfKtVthaZ/Hnily7UrCw=;
        b=oAbveS5O44FepssRa0oO3e1ffRzDFK1gd8WBAfjEaNLQF8AcDfPiXIxV2o5LxG3FFC
         QNFLr51mTkdp2liuRKVqbj6aIEg/yT8nCAjMBiVWz1lT3mhQg7+6M//34NxYtpN0fAoD
         mTdPYscGSETaA2XVLc0YmIrrMflI6b3Uqtm9SNRsGiWX6m7oB+F9oufFsDDqFQ2gC+Ik
         SffSKCakfrmYtdXIly6x60MM8hS1GvEdcAYwyVeI3SDWGwoOYe/s0KbDhg/jetcqH51j
         Qg55McYJcXVJWTPR92PcKetumeAdaNsIfC8s3jAUZc0oj3nqyH9soBwrWz8WFnIyrUoi
         nsJQ==
X-Gm-Message-State: AOAM531YJ4kQxIr9uf1lh1mKzY+H8fm6oDcRRBt8vP7zDkec/zQbbgJm
        jg6iW+dW6fA+D2E5KgLisV0XSmj12oogJc0JmqyWzoz6mxlFmA==
X-Google-Smtp-Source: ABdhPJzCwBCGWG/Tzyck7Lf3AD0CL7doHhTFOrbl/SO6fEKkdBuHsyBziigBUUwlbTl8K/Sogznec33DsY81TRdW8B4=
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr5256977pje.181.1618507145950;
 Thu, 15 Apr 2021 10:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210415134637.17770-1-andriy.shevchenko@linux.intel.com> <87eefblbji.fsf@vajain21.in.ibm.com>
In-Reply-To: <87eefblbji.fsf@vajain21.in.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Apr 2021 20:18:49 +0300
Message-ID: <CAHp75VcPANL+LBTxy2V8f2Ksy=FJmdbU1=r60KKO7YSUf9BCLg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] powerpc/papr_scm: Properly handle UUID types and API
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 8:10 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>
> Thanks for the patch Andy,
>
> Unfortunately ran into a compilation issue due to missing "#include
> <asm/unaligned.h>" that provides definition for
> get_unaligned_le64(). Gcc reported following error:
>
> error: implicit declaration of function =E2=80=98get_unaligned_le64=E2=80=
=99

Right, I have not tested it (as mentioned in the comments to the patch)

> After including the necessary header file, kernel compiled fine and I
> was able to test & verify the patch.

Thank you very much for the testing.

I'm not sure what the coverage of your test is. That's why I have an
additional question below. Is the byte ordering kept the same in BE
(32- and 64-bit) cases? Because I'm worrying that I might have missed
something.


--=20
With Best Regards,
Andy Shevchenko
