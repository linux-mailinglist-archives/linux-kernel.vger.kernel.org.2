Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A6375844
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhEFQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhEFQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:12:50 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98180C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 09:11:52 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso1345659ooh.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeQfKYm2bS74Zn3vvyUj9tpVPEGDUabI+L4zJ/QF7Ws=;
        b=DKmRPn6skb/CCNECeRh0U3xJqCuPavQHF1tJi/vLpW9GR0nRxKhhojPJ1ryQsp9hwL
         Fbc5GqHiGsJSt/ehqDybO9zqplZwOe0nNdTT4wFvv8kKAwb+078Dh/VH46PNklfkBbVn
         Suoix3Q5etSUC3PxBFt0OeNI5BCezcA8r2rIadoLeQKEw1RKuLnEHDnEVxgrDF2GupRc
         +tcOTBra+WLRwQeaNSgdUql5rPMblTvi75379dFGw8sZJl9udXO7JlqhiF1Oaoc/b5JP
         yN7wRK0gyYCdkX5sJZRDoOk+zspBrMQ5BqaDbE50PIlETmKkvcFQ7Qu09t4T3L1Guwsd
         p4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeQfKYm2bS74Zn3vvyUj9tpVPEGDUabI+L4zJ/QF7Ws=;
        b=i+ZrIZqKBDtxJWbF0KS+cazUhMWFiju2J/nPXBrk0ufX6rMg4s/EkN2PFu+njxpEEa
         z0cLDboluj8jdBzGf6jNBF/FPbWks+Kq02CagRwXHhLRqQjnV6av3Pl/bQkGS66Bed4+
         eT0UA6RyeeeULBkUabhUytX8LDPyTy5ryssDYmaO87mhUSI4zOjpfZpJthBn7N81A1rY
         cdXBYtJlMsSLnRF44Yisg7QuBY6n9QraLIDW9l3twJGYDMRCLwibcMHUydtzu6lWPhAa
         mdOYjfmqM3IAIWiuW28vAD/cAvYJ96vTcNY2Ugz0wXEopEsSRHTyMWteEvvRLoFNxEtr
         xhLw==
X-Gm-Message-State: AOAM533TCPh38aHSaE0sj8wuCfw+ECe1FBd1X6dt/eromDvHu/KJczpf
        wnhsuCab3Xr2Guor+vJ+elUppGiCsRJFGqcYiU4ptg==
X-Google-Smtp-Source: ABdhPJwZowjdjz6M7oOMBaQIM/f1bFeevFTXYG6HrMP8e+Q4Hrgud/16vePb/aywo7/ti11PECmx5C3WN86KsBMb8LE=
X-Received: by 2002:a4a:e715:: with SMTP id y21mr4106465oou.54.1620317511833;
 Thu, 06 May 2021 09:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210506132827.3198497-1-elver@google.com> <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
 <CAKXUXMx4dOSb8xub+JtOR8HBrLi_WtGL+L_+3c-rdQQc3XEPLw@mail.gmail.com>
In-Reply-To: <CAKXUXMx4dOSb8xub+JtOR8HBrLi_WtGL+L_+3c-rdQQc3XEPLw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 May 2021 18:11:40 +0200
Message-ID: <CANpmjNMsbyG7T2+BW2+QEtHnnznOVJQvydddOP+VLQZK8nTG2w@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: warn about direct use of send_sig_info and force_sig_info
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 at 18:02, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> On Thu, May 6, 2021 at 5:02 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > On Thu, May 6, 2021 at 6:59 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Setting up siginfo and using send_sig_info() and force_sig_info()
> > > directly is discouraged. Instead, new code wanting to generate signals
> > > should use the appropriate helper specific to the signal.
> > >
> > > Eric mentioned that he'd like to make these static at some point, but
> > > until that can happen, let's try to avoid introducing new users of them.
> > >
> > > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > > Eric,
> > >
> > > While siginfo doesn't need changing often, when it does, it's quite the
> > > adventure. We now have the various static asserts. The other thing is
> > > usage of {send,force}_sig_info.
> > >
> > > I think the best option right now is to teach checkpatch.pl about it
> > > until they become static.
> > >
> > > Fyi, I noticed one such new user here:
> > > https://lkml.kernel.org/r/20210421024826.13529-1-wangjunqiang@iscas.ac.cn
> > >
> > > Thanks,
> > > -- Marco
> > > ---
> > >  scripts/checkpatch.pl | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index ccb412a74725..3a86aafc3bcd 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -7153,6 +7153,12 @@ sub process {
> > >                              "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
> > >                 }
> > >
> > > +# check for direct use of send_sig_info(), force_sig_info()
> > > +               if ($line =~ /\b((force|send)_sig_info)\(/) {
> >
> > I think this might be a little better as:
> > if ($line =~ /\b((?:force|send)_sig_info)\(/) {
> >
> > Otherwise it's good as it is.
> > Tested-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> >
>
> Dwaipayan, do you want to also document this new rule on the
> checkpatch documentation?
> Marco, maybe you can assist us here with some pointer (lore.kernel.org
> link) to the original discussion you had.

It started somewhere here:
https://lkml.kernel.org/r/m17dkjttpj.fsf@fess.ebiederm.org

Eric has the full history here -- if I missed something, hopefully
he'll nack or ack.

Thanks,
-- Marco
