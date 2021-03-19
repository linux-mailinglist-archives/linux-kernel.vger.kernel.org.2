Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB717341487
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhCSFJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCSFJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:09:08 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:09:08 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e8so4809618iok.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wxiszw2drMvmD7rMCrqyxvMPA5cWYCVt77mNQDKPxfA=;
        b=dBAvAxhPJpQ1B5LQP3Xpsz3rdrt3babd8kz8Fkf1so7iIlHJ2JKNVUdPuh0lu50WzA
         YBj6/Kvu15vRWdta1CCFkLZAkZHqe8lhOz03cXSp29Ik+lFIl5wXHgo4uQ41Ur0AVnFY
         cyyPJGhNSbzKeliYPDJ3Xm/Z80Z9XIgfaWsiUEusZVlVr+0SFSIGGn7pa/+v4E9avYUr
         Rg+v7IpN44Zr1pp/xOY6pueXktPrkst/X1Z6a8fRaFOoyJYYBUyl2Ayk9OxOGkZ0MN6l
         P69hk8XJb+oZoYv06eWBHZ0q8Zsd2fneSeo8Ow5mHS+k73NMQBXxtRg8Z9lRdCf//V+q
         yh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wxiszw2drMvmD7rMCrqyxvMPA5cWYCVt77mNQDKPxfA=;
        b=g/E9aGDikAY9BvYj3ARrJcMk/lgrxVs5vsrSqLX8BwjTiwSV10+Pb1/stdY0e6Q8Xo
         PBYoBteAH5/uytgK1ZyyVTTCHj9jBGMkekNZjkrWT9gtETwNvU9p2DuYDI1yE6nyer5r
         1ghT+qgkSn3das74SZtCQGExwGmMv1P67As+EgisDEWzS8Sb6DnFxrPK09dnlquT8S8M
         3xThS3hwLggh76NO/WC0q6jYS2YpsOpqePGrnd9sDEkByoUNY/F/wjQkTpwRIFLuEuPq
         mj7j18/iBwVpkr50tCimaAWvDBjOW3yGXCYQ4N0pRQyLadE9BKQ9SucqR48bSROxAwoB
         /GNA==
X-Gm-Message-State: AOAM532C8xWrytbKkWLseIlkNC/jT3cDxvXCHpbTCccdCZQ+ixJZ+wHc
        6Mg64hg6J7z18HJWo9wK7QGuyk9xzTe2J5goWMMUPXYXSYvZtg==
X-Google-Smtp-Source: ABdhPJxQvo9MhltZ6KTauPE4wRuWZsIIXIzg6KowTEhnPE0j9J/UnKwG770PEOeeOnIaWhWIEY3CMxs7BfWsdnH4+GM=
X-Received: by 2002:a05:6602:2102:: with SMTP id x2mr1551399iox.83.1616130546505;
 Thu, 18 Mar 2021 22:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com> <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com>
In-Reply-To: <20210318180450.GA9977@redhat.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Fri, 19 Mar 2021 13:08:55 +0800
Message-ID: <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     christian@brauner.io, axboe@kernel.dk,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Oleg

> But then I don't understand the SIGNAL_GROUP_EXIT check added by your
> patch. Do we really need it if we want to avoid zap_pid_ns_processes()
> when the global init exits?

I think check SIGNAL_GROUP_EXIT is necessary,or panic() will happen
after all init sub-threads do_exit(),so the following two situations
will happen:
1.According to the timing in the changelog,
zap_pid_ns_processes()->BUG() maybe happened.
2.The key variables of each init sub-threads will be in the exit
state(such task->mm=3DNULL,task->flags=3DPF_EXITING,task->nsproxy=3DNULL),r=
esulting
in the failure to parse coredump from fulldump.

So i think check SIGNAL_GROUP_EXIT is a simple and effective way to
prevent these

> Does this connect to SIGNAL_GROUP_EXIT check? Do you mean that you want
> to panic earlier, before other init's sub-threads exit?

Yes, my patch just want panic earlier before other init's sub-threads exit

Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On 03/18, qianli zhao wrote:
> >
> > Hi,Oleg
> >
> > Thank you for your reply.
> >
> > >> When init sub-threads running on different CPUs exit at the same tim=
e,
> > >> zap_pid_ns_processe()->BUG() may be happened.
> >
> > > and why do you think your patch can't prevent this?
> >
> > > Sorry, I must have missed something. But it seems to me that you are =
trying
> > > to fix the wrong problem. Yes, zap_pid_ns_processes() must not be cal=
led in
> > > the root namespace, and this has nothing to do with CONFIG_PID_NS.
> >
> > Yes, i try to fix this exception by test SIGNAL_GROUP_EXIT and call
> > panic before setting PF_EXITING to prevent zap_pid_ns_processes()
> > being called when init do_exit().
>
> Ah, I didn't notice your patch does atomic_dec_and_test(signal->live)
> before exit_signals() which sets PF_EXITING. Thanks for correcting me.
>
> So yes, I was wrong, your patch can prevent this. Although I'd like to
> recheck if every do-something-if-group-dead action is correct in the
> case we have a non-PF_EXITING thread...
>
> But then I don't understand the SIGNAL_GROUP_EXIT check added by your
> patch. Do we really need it if we want to avoid zap_pid_ns_processes()
> when the global init exits?
>
> > In addition, the patch also protects the init process state to
> > successfully get usable init coredump.
>
> Could you spell please?
>
> Does this connect to SIGNAL_GROUP_EXIT check? Do you mean that you want
> to panic earlier, before other init's sub-threads exit?
>
> Thanks,
>
> Oleg.
>
