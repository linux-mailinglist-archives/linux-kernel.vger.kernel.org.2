Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558EC348742
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 04:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCYDAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 23:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCYDAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 23:00:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEFCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 20:00:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y1so1205761ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5B3kf9xbKigy7ZxM6DW4PEtNlwpRuZUs2AMg6RT1NHE=;
        b=ims2n46ghE5+2Ec+BAwXv9fvplWKDqXA1tdVZ/LiDEF7CeviLor8tLsYwtaj9hyPG9
         ZOttQnz+wnCRpiT8H8aINXDK/qRGZOYmzZaJsOT0OvJuRX+n37m0SqgKXa0r0nD4yiZU
         2Djp2V0fGOn+SCWfwyzI8yZD7DKZBNjDkWPUJVWJnES5rBZAt+i1etPwe6/Ca2pj/MIG
         ZIIvX9uho+m/ALaLDbREkXiJO7OGNcP2Jc+ChFVGCUpFNRYnlNLd0hfnUKYrGeAAiW7w
         HvbY5pOkcs4QEo9Y//giagnMrWEHPD2qtk1zbn+ugsXRXVOATw8W+UWHN8VHyKyZV+rP
         XvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5B3kf9xbKigy7ZxM6DW4PEtNlwpRuZUs2AMg6RT1NHE=;
        b=AZM5VOMzvpoiVjyJR8BJUXUC5A2oEH2ZNoVw1I9sjFy3P5rRwRq+fB8t8s7Ung8r8Q
         1kA9AOkeIuoOLDtAbH/Iaz+k3Xu8WJjlMRT9NxcfNqOzxfnNvsmtCLosXIXMKPdiy192
         XA//+vWUvMHaHHf5swhBMb/4ev0DLsHdFxvl7VdEFzcvYTEwQ2h4O1q4nkQPjeC13rVq
         4yaSNSBxnbgLBtjfIePLWIHfoIC+FbYwd1Gchg4/WGFQUV5B262gHPQCpt+oYGLeUook
         /bI9kxju1nqsPjbfiF3st3T4HDUTUD0CTObCP7Ks+AgNTJc0c6Az4KQwAMw6XIewvFxH
         5yRg==
X-Gm-Message-State: AOAM532ONqXpjt1xI/lUQ+BU0AL9Fyg3CyTA4gEn+XentFwPbeiyAHK4
        EazEuJ0ldLrDCg/BgJWYte9tvvpIInztkui9LEppmyxHoAg7rw==
X-Google-Smtp-Source: ABdhPJw7LVLGMXzV4WTlexgs4TaFo/8avKh8u2y7Ltq4CbC4hFbTbXG9AbJ/YDN8pUHyuHvPspaaH6NAe6sqQIRkULE=
X-Received: by 2002:a05:651c:1135:: with SMTP id e21mr4018286ljo.151.1616641223206;
 Wed, 24 Mar 2021 20:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210317143805.GA5610@redhat.com> <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com> <CAPx_LQENxx0y5mFJjwRT2qMSLt7pbAmF30=eE-QduEwRVJEJ0Q@mail.gmail.com>
 <20210319163225.GB19971@redhat.com> <CAPx_LQGLYx8gKJSkCx9hTyPPbCbU=GJL31TPb3s6zxro522U0Q@mail.gmail.com>
 <20210322163705.GD20390@redhat.com> <CAPx_LQG_5ushJkyymSsYq8FafRj7XOA217JwCyHASEqq0wyMOQ@mail.gmail.com>
 <20210323090035.GA25159@redhat.com> <CAPx_LQH0Qx7R9vNb3FHgO7V8uJ9AAh0j_TZV-VnyBF7Ys_7FTQ@mail.gmail.com>
 <20210324181209.GB13021@redhat.com>
In-Reply-To: <20210324181209.GB13021@redhat.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Thu, 25 Mar 2021 11:00:11 +0800
Message-ID: <CAPx_LQFgXy5EgP0Z48pguyDo9JH5u7a9+d-YXgfCVYFygB500A@mail.gmail.com>
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

>> But,my patch has another purpose,protect some key variables(such
>> as:task->mm,task->nsproxy,etc) to recover init coredump from
>> fulldump,if sub-threads finish do_exit(),

> Yes I know.

> But the purpose of this SIGNAL_GROUP_EXIT check is not clear and not
> documented. That is why I said it should be documented at least in the
> changelog.

Ok.
I will update the changelog as you suggest.

Oleg Nesterov <oleg@redhat.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8825=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:12=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 03/23, qianli zhao wrote:
> >
> > Hi,Oleg
> >
> > > You certainly don't understand me :/
> >
> > > Please read my email you quoted below. I didn't mean the current logi=
c.
> > > I meant the logic after your patch which moves atomic_dec_and_test() =
and
> > > panic() before exit_signals().
> >
> > Sorry, I think I see what you mean now.
> >
> > You mean that after apply my patch,SIGNAL_GROUP_EXIT no longer needs
> > to be tested or avoid zap_pid_ns_processes()->BUG().
> > Yes,your consideration is correct.
>
> OK, great
>
> > But,my patch has another purpose,protect some key variables(such
> > as:task->mm,task->nsproxy,etc) to recover init coredump from
> > fulldump,if sub-threads finish do_exit(),
>
> Yes I know.
>
> But the purpose of this SIGNAL_GROUP_EXIT check is not clear and not
> documented. That is why I said it should be documented at least in the
> changelog.
>
> Oleg.
>
