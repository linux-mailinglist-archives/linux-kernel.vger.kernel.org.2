Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E9406CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhIJNS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhIJNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:18:28 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471BCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:17:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r4so3774066ybp.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QUTLtwXLUjfxOMwwCkVC2MzQatgqxlfkVT2ny2bxECk=;
        b=fXaPnGcAznaUA3B1hBspE7kTkmYHXyNpZqbO3Mojt7CDWtVzBV4hLNUk3pukQe2prn
         9vUn+gIrniMOKcEMNsonsdn2J+GUFCnrlCP4T88WxMp4grhWi3C8nKzCrecoufJEQVzQ
         zwj9Ql1+uXRqZd/2OYkSj/nc8EzYramo8MjWj3utvP72bP42ScAeVpfJpOjnLmStJ6/p
         25hz/YpReJPfyNhgXCjvftR0852EnCixSytT9PJv7mgdXwuvqbN7gCiHihaBRmdtBUUJ
         siEBEouDZu3OFEig+qt/RZ/R4FF3lAVJzVbp81svg1tkCrIfkVUhqb8E5/4zyVC89fvT
         +KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUTLtwXLUjfxOMwwCkVC2MzQatgqxlfkVT2ny2bxECk=;
        b=APqKnXgoMjJ+U25lqaMUOcqP7w5OhmVQPvKpkDb+LGvtpqDJU/CdZlMDaWqD3dCbuE
         NhXsQw22NxpRMVwZqdnGQeerUxiEiJkJp5VyyLfipuhYOBFyD0j5Q87kvfWOCPqFGsRl
         +UEJgHsmRpf8D6ertPsKJo85GRXTjRn0T+eCV8ClWROjDLhXGQWLcsYuCkWMFd84bm1t
         XYTFrR+tqlhM84F7hn3Gss9XjK6AcHPr4TR+6VcOW8a1M+++30zIJ8/cfyvO1M3JDZO+
         U4Gx00pKE+Wy6mZRrqi3ZPbNYxCSoU2SrM/81hcvHMhlM02kOC9a+utcdZUrl9YrBTj2
         qB5g==
X-Gm-Message-State: AOAM530WqOBd2pECSfTWrSBh/RRDq45xHIL+D4IoeR4YIyDaM/0NRjr2
        8Ph5NfHnh/Lwufhm+9BQR0klInzwM3T9R5IjCoBHGg==
X-Google-Smtp-Source: ABdhPJzGR2cuGGSuZYVGlWtKSf5nAiDrqUef/qGoWjFGfy4YUaXHK7RGUZ4oI8AviPTrbL3tHkrV0FK//FgLBPyEZwI=
X-Received: by 2002:a25:802:: with SMTP id 2mr11014314ybi.61.1631279836534;
 Fri, 10 Sep 2021 06:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-2-mkoutny@suse.com>
 <CAKfTPtDkOcAwQtfHhQ_OZH7UZ0fDuhqoNrGLPFO3ikkWMPuSFw@mail.gmail.com> <20210910113544.GB24156@blackbody.suse.cz>
In-Reply-To: <20210910113544.GB24156@blackbody.suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Sep 2021 15:17:05 +0200
Message-ID: <CAKfTPtA+q0PEJtzkZAe=6bMFjD4JrA3k34mGMpDfmMUr5nPfiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] sched/fair: Add ancestors of unthrottled
 undecayed cfs_rq
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sept 2021 at 13:35, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello Vincent.
>
> Thank you for looking into this!
>
> On Thu, Sep 09, 2021 at 03:57:37PM +0200, Vincent Guittot <vincent.guitto=
t@linaro.org> wrote:
> > > +               /* Nothing to run but something to decay? Complete th=
e branch */
> > > +               if (cfs_rq->on_list)
> >
> > Could you use !cfs_rq_is decayed(cfs_rq) ?
>
> What needs to be checked here is whether the list was modified by adding
> the cfs_rq (and branch needs closing).
>
> It'd appear that the equal condition like in tg_unthrottle_up() would
> make do, i.e.
>         !cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running
> but the unthrottle_cfs_rq() can be called under a still throttled
> ancestor (i.e. throttle_count not dropping to zero) and in such a case
> cfs_rq should not be added to the list yet.
>
> Therefore, mere !cfs_rq_is_decayed(cfs_rq) doesn't seem correct to me.

fair enough

>
> > > +                       for_each_sched_entity(se) {
> > > +                               if (list_add_leaf_cfs_rq(group_cfs_rq=
(se)))
> > > +                                       break;
> > > +                       }
> > > +               assert_list_leaf_cfs_rq(rq);
> >
> > Instead of adding  a loop here you should better jump to unthrottle_thr=
ottle ?
>
> Oh, that looks a bit clumsy now (it's an artifact I've left when
> reordering the patch in the series to be backport-friendly).
> Jump to unthrottle_throttle seems easier indeed, there would be just the
> additional check
>         if (rq->curr =3D=3D rq->idle && rq->cfs.nr_running)
> . Besides unnecessary work, it should be harmless.

yes the condition should be always false

>
> Is the jump the preferred form?

yes compared to adding the exact same loop

>
> Michal
