Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8F416282
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbhIWPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbhIWPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:55:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C80C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:53:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c33so2633216ljr.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAIf9S9YD0oFbCvz8QEsqa7/B46ooiou6kW4WrW11es=;
        b=edcnJ+kYTFajOV6YWgCkDRJ7tuME3jDCu388x+5IygYwj23a8bZILaBVzhLYkO588z
         ljxnaGKMshQurnuGfYg4HBwiC3Ym6JVEffomTleMBklg9nYJ1H9ODcw++lFapFP+L7Zw
         y7IPRTqhyiGYRNXvP5nhI306iiITGHRqHb9Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAIf9S9YD0oFbCvz8QEsqa7/B46ooiou6kW4WrW11es=;
        b=1pujat3c9s9UmayAtYaIW4dItOihErEHNF+XJTAYtADYaiUWBVFPPvCpUGFLDEpT7v
         cHiVpVAEtoLDEYzT5/p4ql9N1Ih7L20QNhYvqfsjNOrwokb6Q9X/LANbhHmsg5HuO2tT
         EPrN+5IXytNrcXBT3q1j6rMesuDJSmj2H04ROX9p+NUGOMK5ga7yFplbmgXx3D85WY5E
         lKKfMtdJwF82UD4k4K8JvET3ykeD2WGPnJuAQULdqju9+vCnKBtCAM7qI5+YB4hMvAc9
         Ao2mkXFvf6m3eedVWFkLjAV8JaApjHnlEVlEszzDcAEOuUGklm/zEmr38j5Jeq2+Q8rv
         kA0w==
X-Gm-Message-State: AOAM531C0QlqxZNrTZXbWGRjWpSPN1tT0/JR+Co36Wec+OhOiF1iRPxu
        Q94WnLYy7lrwNy69Kipa7whhlaqTp6Qp5HDh2Wo=
X-Google-Smtp-Source: ABdhPJzo9D0nE2zILdj8p5WY5FaaNYD78NbqGZ5vrVAtimN1N1bdmDJhOXaKnJsG2R7q+ihYwNUedw==
X-Received: by 2002:a2e:7804:: with SMTP id t4mr6019719ljc.346.1632412410076;
        Thu, 23 Sep 2021 08:53:30 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n11sm680416ljg.72.2021.09.23.08.53.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 08:53:29 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g14so2742405ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:53:29 -0700 (PDT)
X-Received: by 2002:a2e:4e01:: with SMTP id c1mr5757554ljb.31.1632412408652;
 Thu, 23 Sep 2021 08:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
 <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
 <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com> <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com>
In-Reply-To: <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 08:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com>
Message-ID: <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 8:43 AM Paul Moore <paul@paul-moore.com> wrote:
>
> However, we have the LSM framework because there is never one way to
> solve a problem,

The thing is, the lockdown patches were merged because they were allegedly sane.

As far as I can tell, this is purely a SELinux internal bug.

SELinux did something wrong. Stop doing it. Stop sending patches to
then screw up the generic security layer, and violate the rules under
which these patches were accepted.

We have now this week have two discussions about the selinux doing
completely invalid and incorrect things, and both were related to just
thinking that it's ok to just randomly access thread data.

At some point, you just have to look at the SELinux code and say
:"this does something wrong".

Instead of this kind of "no, everybody else is wrong, I will modify
them to do what I mistakenly did".

IOW, just make the patch be

   diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
   index 6517f221d52c..4e93bf5dc8ef 100644
   --- a/security/selinux/hooks.c
   +++ b/security/selinux/hooks.c
   @@ -7016,7 +7016,8 @@ static void selinux_bpf_prog_free(struct
bpf_prog_aux *aux)
    static int selinux_lockdown(enum lockdown_reason what)
    {
        struct common_audit_data ad;
   -    u32 sid = current_sid();
   +    /* Lockdown requests come in non-thread context, can't use
'current_sid()' */
   +    u32 sid = SECINITSID_UNLABELED;
        int invalid_reason = (what <= LOCKDOWN_NONE) ||
                             (what == LOCKDOWN_INTEGRITY_MAX) ||
                             (what >= LOCKDOWN_CONFIDENTIALITY_MAX);

and stop accessing random security ID's from random contexts.

And stop thinking it's ok for SELinux to just do bad things.

               Linus
