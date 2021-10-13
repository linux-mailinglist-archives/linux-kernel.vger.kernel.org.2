Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF142C8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhJMSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:48:15 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D93C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:46:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o12so3514112qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AwHUQJramerjMjPDVke9ewo/gUDLb1OY7VemPgKlrmU=;
        b=jnm+XSVRz/0T1JK6CURzmHXQjjnk4suJMNDjwgvfwc6yXIrZm+oIp2pgS1s6OslKX+
         ccDv6vKMXU41wWwTRzM/sswVjfb67zhzp0dwDiCS/RwreHYZoc01pJBjaAE634gVWx/I
         K7zp8l4Xb5p3viOyEnwzVfD9hnr/doA4xIFLaCmPIbCmwoWJx2XSy4i/BmYKZ6dGZ9PS
         mAFeNFmw88HXj3GfyBVOMWS4OMb1qPYtcP2S/XYLMt4O27gvtHwpQ4fmcly1aNziSXqn
         smB1+A8rRi/AuQF1EDOCzXwNmhT+nj2ohHyVtajLmqDYQioBZ+CiV3qi8BtkSIyH81hh
         kLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AwHUQJramerjMjPDVke9ewo/gUDLb1OY7VemPgKlrmU=;
        b=g4fsW1IdwtPUpdtbCNFpV5cMf2oY93h2Gj6EOQD+slanqLzixhn5P0IfD3s7ETgHpM
         voOOOiMBSCx+MizcUmN3sibiPjVMfIbcRyO7+hZsWpXuPFQXoS6WjUXo2Z+UZzN+K3Cd
         9WeBMeCCT6y6LBpoUVTi/U7UlPcKmHutGc4WID13OuPP6jWcwq2T4V6wyrqfxbk0OlaI
         lMQzO5Y/Lj/TgkVCEMz2JIAG9c75bFvh+UTl8y1myG57HP7e9w6FSi5XgAO7ffilCkYi
         +mJeFmsyJJVoAdFAtfr5+i0lWehq8xWybPAG+MaX55PSUvRrLCUoDLUFd4ezh3prJWrm
         AUVQ==
X-Gm-Message-State: AOAM532WgmTvlK3pzHRWFuMStRRe34UXo3/pdXPAcCRS85okbyIc8CgE
        jBOJDrJTyV1F9UFUaqqCwcOS1XWzw3TiWqPTfGeLuA==
X-Google-Smtp-Source: ABdhPJwzjBvpDQylCdVfQlBVWUY38CfJDhQVrPERAgvpvDe4rDL1fyerkjDFv7RUKDYTLKVUTnsEbDBxhwStg27GXeo=
X-Received: by 2002:a05:622a:3c9:: with SMTP id k9mr1194745qtx.170.1634150770608;
 Wed, 13 Oct 2021 11:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211011172236.11223-1-mkoutny@suse.com> <CAFpoUr1KrXKdiCp-DVQLnu-c2YS91AszZB6RdZNVLBm9sGjMEw@mail.gmail.com>
 <20211013143900.GB48428@blackbody.suse.cz>
In-Reply-To: <20211013143900.GB48428@blackbody.suse.cz>
From:   Odin Ugedal <odin@uged.al>
Date:   Wed, 13 Oct 2021 19:45:59 +0100
Message-ID: <CAFpoUr1NCA+L=+FkxJ-iRU-s0ehe__zY7PCwnEsk3BxOdrvCSw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list presence
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Odin Ugedal <odin@uged.al>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ons. 13. okt. 2021 kl. 15:39 skrev Michal Koutn=C3=BD <mkoutny@suse.com>:
>
> On Mon, Oct 11, 2021 at 08:12:08PM +0100, Odin Ugedal <odin@uged.al> wrot=
e:
>
> Yes, that's my working hypothesis but Vincent found a loophole in the
> proposed fix under this assumption.

Yes, I started to think about the same thing late yesterday afternoon as we=
ll...

Ref. your comment about reverting a7b359fc6a37
("sched/fair: Correctly insert cfs_rq's to list on unthrottle"), I
think that is fine as
long as we revert the commit it fixes as well, to avoid a regression
of that (but yeah,
that regression itself is less bad than your discovery). If we do so,
we know that the
only time we remove it from the list is when it is fully decayed,
creating way less
edge cases

In regards to the race, would a simple fix for that be to, in addition
to your patch,
set cfs_rq->on_list=3D2 inside that lock under your code change? If we
then treat on_list=3D2
as "not on list, and do not add"? We can then make constants for them.
In that case, we
would know that the cfs_rq will never again be inserted into the list,
even if it has load. Would
something like that work properly?

Thanks
Odin
