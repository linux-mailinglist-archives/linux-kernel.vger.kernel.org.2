Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0EB443AC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 02:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKCBS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 21:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKCBS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:18:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 18:15:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 5so3521361edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 18:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zvCgkl8b/Wk2WXewhtHuS7jVQtKJSDpG2z1kWhZOdM=;
        b=uykTM8HxpyxLVkotdRmBgm/2SOtdLqJVMmow3Brimq1l+k1IpMMBYMQDTKbf9Uqopa
         cglMT2z4t9An9rn1HEulyGcudPudiWgrcquv4K043IbjUE4kFIWDCA18NzyXZYh5RqK1
         XHBWl+rE8w276wo6+oOmuhiIYH1ask4vFt3ZCVqyc0JDT14mCcxaXhBDTaYJwm93N2br
         /wAdiZpw3UMWJyBiDEDSe95V3IBRQrIh+Ocz+3RfJo/+Og1FiOQqwQ7dTHuGqznDFBUG
         8pxaSW0+NDWjkm2NdqKgaIxE+5XMhDfwLsyK0eIiNYyVwCHLRyROLsRmi3Fyg8Rg/D5b
         hB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zvCgkl8b/Wk2WXewhtHuS7jVQtKJSDpG2z1kWhZOdM=;
        b=fzuRbwOTPg2dlSiu5aisLvbkwpgcBR4izUOEWt017RGVbi3iSRaNun3icIM185yLBh
         eQvHSeDh00uBkM31gHIzaKdm1rCWjs/OVX1QgnYGo4pg1fB0o0RO+syycuQQFoyDgSA/
         5MmsjJ+nufVZrHzm5Sqvy5W28++d8sHMJANpJM/35B7LImzYDXO40k4h5V+yahGycqOG
         XeOxXjpHBzn8Vp6YTFfrCtwnoZypHKRV9u5qPGBJ4rvrMBTmY4M5pl1l8dK9vBUBOKkP
         mKucfim/WV/SLK9gLP8XWzdcdYM8lOedK1qe80fUuuPlPzw7pVqYxyZcViK3MCX29AVU
         WsWw==
X-Gm-Message-State: AOAM531Zlrlt/l6ss3qDyIOLdgca60wV4L/qdcNScuq4ZQz88jFhB5Gc
        nqW1+hFgoNR3dbU/Cr2cTJ2tFQ8lKAm/+D6d1Uo4
X-Google-Smtp-Source: ABdhPJw2IoBOCByQEbw64BV12T8gdoTquNYioInlmW8yGRuMELWdpjO3NsBKnoAwGpJD+HKDnG8w7r4XDNEc9GMsbLQ=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr49347316ejc.24.1635902149830;
 Tue, 02 Nov 2021 18:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
 <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com> <87a6im87tq.fsf@mpe.ellerman.id.au>
In-Reply-To: <87a6im87tq.fsf@mpe.ellerman.id.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Nov 2021 21:15:38 -0400
Message-ID: <CAHC9VhSXVc534jzZ9bSD5fbuJpaGY=mswv4crOW28y7AjhG7Tg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     patch-notifications@ellerman.id.au,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 7:19 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Nov 2, 2021 at 7:38 AM Michael Ellerman
> > <patch-notifications@ellerman.id.au> wrote:
> >>
> >> On Tue, 24 Aug 2021 13:36:13 +0000 (UTC), Christophe Leroy wrote:
> >> > Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> >> > targets") added generic support for AUDIT but that didn't include
> >> > support for bi-arch like powerpc.
> >> >
> >> > Commit 4b58841149dc ("audit: Add generic compat syscall support")
> >> > added generic support for bi-arch.
> >> >
> >> > [...]
> >>
> >> Applied to powerpc/next.
> >>
> >> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
> >>       https://git.kernel.org/powerpc/c/566af8cda399c088763d07464463dc871c943b54
> >
> > Did the test failure discussed earlier in this thread ever get
> > resolved?  If not, this really shouldn't be in linux-next IMO.
>
> It's not in next, that notification is from the b4 thanks script, which
> didn't notice that the commit has since been reverted.

Okay, thanks for the clarification.  I know we had already talked
about this so I was a little caught off guard when I saw this mail :)

-- 
paul moore
www.paul-moore.com
