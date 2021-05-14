Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E23811DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhENUfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhENUfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:35:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD4DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:33:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j14so523127ejy.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrX59QZ1/MGSq2vNbx2By5swZP8oYPzINr6uYfj2CO8=;
        b=nyp39tfAJCZ0c8toT5vXkXg2jXIu/lQEydLB5sjkMBFU2klOEHXT0UnmNmONLu8Xh9
         CneCBJH5+FuvuSI2VWfDagV0TwKDjPMnLWoNZy2xGFGp+/AKRTOIQE1tImAqvgmzacsM
         0edcXvB14PQ5JYPZQMuwja78rxqhMNF14R+Z0roc8PQkETjRA2WsVF4egzbADhNelx5T
         pkgJf3q/UbezFr4a0LXxxHCffXO1OzHIjFqkNMLYwT777rBO6Neq+pH+JVHwXYVQodh7
         +KQv5vOSJRcxU7T/2c6ZDqwxvGXZuIWPyEgMuRpssr8+EFphRVUOJEy2Gsbi6tVoBQpR
         NVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrX59QZ1/MGSq2vNbx2By5swZP8oYPzINr6uYfj2CO8=;
        b=RpM4TG6hCBMBCHxryhQpl1ra0gKXhfW/yuZLHT7DMx7IxQ7Rmtd/+0F7vvCcsaQey8
         Hl2fhYK5V3Nq+rjkaslqCStO1xnljQMgWXztwHNgQXqlAGF76+CL+OLr05cKiI54+XvM
         Tz4XBqMWpFoTSEzacwXDRkzIa7N1YTJieU/u3J1TT+BFoBjlFhWqu+PkgG6HO+oTnf91
         DvAeL9+53b0GRS5h55WPnoM5jqIFcPAka+8IzWHGzYrq0K9hj4Fzbm9GEp/Q+YTWITvl
         Nal/5k1Tc3v2iFWE2i3cw7GQojCFQpmuVGUmHpZh5GOs2lxuExxdOgj93r//Wh3hspZD
         Hc6A==
X-Gm-Message-State: AOAM531407O2g9XKEyAIpgcNxttCan7rpRgSYZSCJ5DXd15/jY0ZwMZB
        b27QyAXO37jufnmtQnlkvtP4bE9tGBAxp1MYNh98
X-Google-Smtp-Source: ABdhPJwB8RPRAdS0C0k/AF/Xc097fY79a3s5nw5tE8LKViSSbbY+8jnL6yDb81DkbOCaNAaZhP3mhhneI5EJHBeDFqg=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr50090884ejb.91.1621024433985;
 Fri, 14 May 2021 13:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210423103533.30121-1-zhe.he@windriver.com> <20210423103533.30121-3-zhe.he@windriver.com>
 <CAHC9VhQXawubMsKg2F282k-bJqZFT=vNurZAeAPKLU1ZZpYKeg@mail.gmail.com>
 <c8493e20-c7fc-67e4-f2cc-81601535f21a@windriver.com> <CAHC9VhTEcp0KHHt8fNgEXXUHtL+yJh9MtjEBrnLmT-Oumo-CVA@mail.gmail.com>
 <e9f86d59-4541-d807-0b3e-df22dc650c3b@windriver.com>
In-Reply-To: <e9f86d59-4541-d807-0b3e-df22dc650c3b@windriver.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 May 2021 16:33:43 -0400
Message-ID: <CAHC9VhTZ5gUk7-HbDG6+rW5qcrksR8pcOb7wH+0HkaBy7HaHHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] audit: Use syscall_get_return_value to get syscall
 return code in audit_syscall_exit
To:     He Zhe <zhe.he@windriver.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 4:43 AM He Zhe <zhe.he@windriver.com> wrote:
> On 5/11/21 10:51 PM, Paul Moore wrote:
> > On Mon, May 10, 2021 at 11:19 PM He Zhe <zhe.he@windriver.com> wrote:
> >> On 5/11/21 6:38 AM, Paul Moore wrote:
> >>> On Fri, Apr 23, 2021 at 6:36 AM He Zhe <zhe.he@windriver.com> wrote:
> >>>> regs_return_value for some architectures like arm64 simply retrieve
> >>>> register value from pt_regs without sign extension in 32-bit compatible
> >>>> case and cause audit to have false syscall return code. For example,
> >>>> 32-bit -13 would be treated as 4294967283 below.
> >>>>
> >>>> type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
> >>>> success=yes exit=4294967283
> >>>>
> >>>> We just added proper sign extension in syscall_get_return_value which
> >>>> should be used instead.
> >>>>
> >>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >>>> ---
> >>>> v1 to v2: No change
> >>>>
> >>>>  include/linux/audit.h | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>> Perhaps I missed it but did you address the compile error that was
> >>> found by the kernel test robot?
> >> I sent a patch adding syscall_get_return_value for alpha to fix this bot warning.
> >> https://lore.kernel.org/lkml/20210426091629.45020-1-zhe.he@windriver.com/
> >> which can be found in this mail thread.
> > At the very least you should respin the patchset with the alpha fix
> > included in the patchset; it's a bit messy otherwise.
> >
> >>>> diff --git a/include/linux/audit.h b/include/linux/audit.h
> >>>> index 82b7c1116a85..135adbe22c19 100644
> >>>> --- a/include/linux/audit.h
> >>>> +++ b/include/linux/audit.h
> >>>> @@ -334,7 +334,7 @@ static inline void audit_syscall_exit(void *pt_regs)
> >>>>  {
> >>>>         if (unlikely(audit_context())) {
> >>>>                 int success = is_syscall_success(pt_regs);
> >>> Since we are shifting to use syscall_get_return_value() below, would
> >>> it also make sense to shift to using syscall_get_error() here instead
> >>> of is_syscall_success()?
> >> In [PATCH v2 1/3], is_syscall_success calls syscall_get_return_value to take
> >> care of the sign extension issue. Keeping using is_syscall_success is to not
> >> potentially changing other architectures' behavior.
> > That was only for aarch64, right?  What about all the other
> > architectures?  The comment block for syscall_get_return_value()
> > advises that syscall_get_error() should be used and that appears to be
> > what is done in the ptrace code.
>
> Yes, it was only for aarch64. No similar issue hasn't observed for other
> architectures on my side, so I was trying to minimize the impact.
>
> The "comment block" you mentioned is the following line, right?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/syscall.h#n77
> [PATCH v2 2/3] was used to cover this concern. But as we can see in
> Mark Rutland's last reply, there'are more things to be considered and we are
> still trying to find a proper solution.

It sounds like you are going to be submitting another patchset at some
point in the future - that's good - when you do please use
syscall_get_error() in conjunction with syscall_get_return_value() or
explain why doing so is wrong.  The explanation should be in a code
comment, not just an email and/or commit description.

-- 
paul moore
www.paul-moore.com
