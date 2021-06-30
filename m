Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821883B81A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhF3MI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhF3MIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:08:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73DC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:05:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u20so2899896ljo.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BtORUJyjB87YtTBYfSfGySn25Jv/2+Q+hPA+h56ovV4=;
        b=uEErsoTpFGyOctEjTypHQEJluWwAK6BYJM2LKVNY3L0vIf+zPVu9uFT1NihntKgAey
         T8zz5XlezEThkQ2ldlwjBKB7BZuSE6F22hnouvRE6+MC3Xeu0h3z5YPldJkYa0bGQ1kJ
         g2BWst75rh376V4ikLWzQf5msoFSqiCV6Z144aHgChiFdy5LH2IksLK9F/aQwUVkTdAV
         J1Py5HKSV3v2j99FdQC3wEzfcdCkgLYy1nlcpi9WPY09tNkJjhTcDXtufj6K1361Qxjm
         p58jUxcpOyQysb5kqSsCzhsOg+GTsx465r62ysG4Yrj77Rv8HqjqAhdst5rZYlr7pqra
         Netg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BtORUJyjB87YtTBYfSfGySn25Jv/2+Q+hPA+h56ovV4=;
        b=pP/ervF/XLdpgfjPk3J7QC0DzUglQLNJfPCXHq7PjVMMzTTd+/DxUO81z1WgeBd9v1
         5co5fAhJboePHuQomLHm+x1nU++J38+i/zettETRMkMkhT6w+MncneuyclxZdJqQ2MqV
         ji0mohq0+zgsD3T5NUYLWlrJxNNUdks0JHxcOmw7icEJCUVAFiOqPirs1mtuiUdRLBY1
         ibyLeO/2G8np2Xxedgg0McmiCjgic5tIE5b19MPXgNDT18TE8Gab3aP+pHqFt7T5jAG0
         OfIZUdQozD+ZMg58G5UoBqRP5I5AI1UocKOxyQglbozXpQA9x+dDFlQT9FcoPOVapre8
         4lqQ==
X-Gm-Message-State: AOAM531/fEE+ACJ00CnoLW/JP/1sVkDxiZPJ7BBvp9snV+F2tnE2mMwv
        /LAgkgyDhFy7fUFqRwzm+DmfiRISUCQxibN0EuYuXDwE3TA=
X-Google-Smtp-Source: ABdhPJxoFl60qtawGlI8nuGvULLl+HzEKw1KTJwO0t4M3sRm/QUVigLYAXXO3Zp0+3Rf/GzafVyL2I5rMfC77/P8ir0=
X-Received: by 2002:a2e:700f:: with SMTP id l15mr7624471ljc.52.1625054753967;
 Wed, 30 Jun 2021 05:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210618072349.503-1-xuewen.yan94@gmail.com> <87fsx093vm.mognet@arm.com>
 <CAB8ipk9TMTbw2WGrbLuewk_CaYxrvMOp2Ui5xiHiwYB4NmoRhA@mail.gmail.com> <87czs38u72.mognet@arm.com>
In-Reply-To: <87czs38u72.mognet@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 30 Jun 2021 20:05:37 +0800
Message-ID: <CAB8ipk8tdA7tB3yJQSeVW1vz6W9PDzqWoU3tv2XdDcoSrhbEqA@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Fix getting unreasonable ucalmp_max when rq
 is idle
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 7:31 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 30/06/21 09:24, Xuewen Yan wrote:
> > On Tue, Jun 29, 2021 at 9:50 PM Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >> +       min_util =3D max_t(unsigned long, min_util, READ_ONCE(rq->ucla=
mp[UCLAMP_MIN].value));
> >> +       max_util =3D max_t(unsigned long, max_util, READ_ONCE(rq->ucla=
mp[UCLAMP_MAX].value));
> >
> > Is it necessary to use max_t here? although it is not the main problem.=
..
> >
>
> I got comparison warnings when using a regular max() - the RQ clamp value=
s
> are unsigned int, whereas the local variable is unsigned long.

Yes=EF=BC=8CI miss the rq clamp value's type.

Thanks!
xuewen
