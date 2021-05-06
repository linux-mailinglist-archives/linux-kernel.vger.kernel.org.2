Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B004375817
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhEFQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhEFQDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:03:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6F1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 09:02:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z14so5242443ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyyFN/d4NJTG7FjzVGb/ZukPiE7Lpino/p722Qy+NWE=;
        b=J5MLmkrR0heTm/3scVOESWOSptIubhXILfOXayxGx9jkbUEFC9q6R12b7vAJx/dT+8
         EpRWJ4paaPnNlVcuYDeoJC6iCQOyesfMJ6VTpyzgown2DnWTzp3FF6aYwkMCi7wPvzE0
         OR1y/96Lpw+3yTzz8MSln4XpA3EJ3erwcxMfbsVDxyKl8zoEYKnoL+vmaCOuS2Hbr6dx
         zUO55Mo+FTglr/YVCxipDbs1veG7j/K3d+Vkqa8MluKybL+2k23wNhhJp2mE3eEyfDyP
         IttiOVKJ8glfQe01OmRKXxn6UDCzaCfr/lhu07ok6ZF/uRaF0vugEqvGnL2KKo1B9L2K
         AUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyyFN/d4NJTG7FjzVGb/ZukPiE7Lpino/p722Qy+NWE=;
        b=ldxr/+iJqVggF2P4f2YzeJycb4dX1uruiFjWULZWlzJLMAMA9uHzSmvSWPZUO6DWKU
         jxIIVw328nUMYmuEgLCZna/YeK3T3in0tqiqTeY15bq2ny8EJLdUp+Tq49PbFpl+vHIm
         0/raND5cl9ntQS73jDpaBEE8TLuRwd63z1RxEKxjbCWrbIpICFZbhkxr7Sf7FUPUUQXZ
         JLEoN5PRqYlKwEW4R424ZLBFa2KN7iiw33ODt7QaRmEoOZ4A6RVosbAyVj+j+7jqaamN
         eVmfSKTiUtLNAg0GUodyn9SnCWC2EVOzxdJc23GVxX4suHk7NW4k04DRQ5TOlw07j4x3
         9pxw==
X-Gm-Message-State: AOAM532haipYVRxhrnvLiTUcEhRADppYF51rV5Bb6EFkMZZIi4tJh6nH
        FZ54tPzEFa2XFHwxlu0o/Dm9p70Pv3IbEQWkXB6nW6Zp
X-Google-Smtp-Source: ABdhPJx4Jw+kKxyWSbOVV5opMxVp9Uh+wUuuXqWs9QmxVZL/U3okjUMq+lpp1SauQRWWtQC7B9+X8LDCY/bDcJQ/QVo=
X-Received: by 2002:a05:6638:2044:: with SMTP id t4mr4821773jaj.12.1620316938285;
 Thu, 06 May 2021 09:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210506132827.3198497-1-elver@google.com> <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
In-Reply-To: <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 6 May 2021 18:02:08 +0200
Message-ID: <CAKXUXMx4dOSb8xub+JtOR8HBrLi_WtGL+L_+3c-rdQQc3XEPLw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: warn about direct use of send_sig_info and force_sig_info
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 5:02 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> On Thu, May 6, 2021 at 6:59 PM Marco Elver <elver@google.com> wrote:
> >
> > Setting up siginfo and using send_sig_info() and force_sig_info()
> > directly is discouraged. Instead, new code wanting to generate signals
> > should use the appropriate helper specific to the signal.
> >
> > Eric mentioned that he'd like to make these static at some point, but
> > until that can happen, let's try to avoid introducing new users of them.
> >
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > Eric,
> >
> > While siginfo doesn't need changing often, when it does, it's quite the
> > adventure. We now have the various static asserts. The other thing is
> > usage of {send,force}_sig_info.
> >
> > I think the best option right now is to teach checkpatch.pl about it
> > until they become static.
> >
> > Fyi, I noticed one such new user here:
> > https://lkml.kernel.org/r/20210421024826.13529-1-wangjunqiang@iscas.ac.cn
> >
> > Thanks,
> > -- Marco
> > ---
> >  scripts/checkpatch.pl | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index ccb412a74725..3a86aafc3bcd 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -7153,6 +7153,12 @@ sub process {
> >                              "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
> >                 }
> >
> > +# check for direct use of send_sig_info(), force_sig_info()
> > +               if ($line =~ /\b((force|send)_sig_info)\(/) {
>
> I think this might be a little better as:
> if ($line =~ /\b((?:force|send)_sig_info)\(/) {
>
> Otherwise it's good as it is.
> Tested-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
>

Dwaipayan, do you want to also document this new rule on the
checkpatch documentation?
Marco, maybe you can assist us here with some pointer (lore.kernel.org
link) to the original discussion you had.

Lukas
