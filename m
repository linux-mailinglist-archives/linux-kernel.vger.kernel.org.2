Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF739A296
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFCN6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFCN6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:58:10 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65530C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:56:09 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id w9so3172582qvi.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFoCEkJHlYaCqbo7kftj3nQYJl4JAya0mNURfk0G9Fo=;
        b=iOGRGKMMJ7mjrGAdEcby7lsIBWbsY9FmTD/4P6CUXobrP5vRdX5NYZlmK1uLe9dvLm
         z1YBOrXjyC64sc+6mGqhkgxtKmepkCsmdBv5T1o8rkEUgNLLB3G1th843k76n+w7wHd+
         wBxBLE9mapL58Sm8CD8BxlTz4dg7g3OzYg5zu1jJpMfAT1rIWGWNmJ6u55SGUEFkKclh
         HSKpx6Dyn20lsWeyWlv8dS05FWBs9MzSCS2jCUsGC3/IyBZrQVetFMVgDLEFwVPdDCmt
         VEFQd4XCnOAdznbWTJ7tKlTjnPFWvqvNoJk32txKZ4ZL09ETySALU4AfVW13V++mNOlH
         oRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFoCEkJHlYaCqbo7kftj3nQYJl4JAya0mNURfk0G9Fo=;
        b=EyEKpA50wqrhnvwUxAgoNnnZU1YZtc48e5Dza+R71t4q+P+U9aHvddhxAoNzZL2SZP
         lXwk+R3Ywo0S7bodConn9iluLNHr1FBm9tB69XaQhRUseUMfZ/6GuwzFgb6i4GeLTkAV
         kw9PPZJs2qmp8VDkDqPPiThJU4YU7omkqgW+aANrlL/1Coa/nsvrJQ6WQvySb5gvuKRq
         nxVcO0+80c/k8r2j1tJNAtKjv/wj0AidIPk6jw6vBK0IthEhqi3ZfHx1Mm6D+VK6iyzm
         G9xFJEv1m9JyqXHSnMcA+apZbVAMcTLMJqcgCZpdDZgY9ejelmXd8W1/QPIDJ7cKIt4g
         DUDQ==
X-Gm-Message-State: AOAM531evN7LZHOIB9wgwpmb2uDMkYhd0IIJBgpvN5dhCkBQWWfjp2V/
        RJIaiYr/j4IkysUZQAj44dotDDXB3lEBGtNCA0i6cw==
X-Google-Smtp-Source: ABdhPJzgYoxPqkgvsYk9l6uq26oBNtV19sZUxDEha83osjjivigH/jyWaB4Pso/7pgj/Enw04BwYsAaKsWyd7xEPUvE=
X-Received: by 2002:a0c:fa4a:: with SMTP id k10mr12353155qvo.18.1622728568553;
 Thu, 03 Jun 2021 06:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210603113847.163512-1-odin@uged.al> <CAKfTPtAK3gEqChUmoUXo7KLqPAFo=shH4Yi=QLjrwpuu6Ow6-Q@mail.gmail.com>
 <CAFpoUr2HBexs5784nU7hyDSs0eNiEut=-4wWcnpMtSVtFeaLLA@mail.gmail.com> <CAKfTPtDLiN2GXxPG9AhxAihx++jV+W6VeBRdYgVwNmb8RiTkhQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDLiN2GXxPG9AhxAihx++jV+W6VeBRdYgVwNmb8RiTkhQ@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 3 Jun 2021 15:55:29 +0200
Message-ID: <CAFpoUr3=v9L-0QqKJeR=P_PvPnSAxrKObwj3ZS+ypMyMd17jsA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If it's only a matter of waiting other PELT patches to be merged, we
> should use cfs_rq_is_decayed().

ACK. will post a v3.

> if load_avg!=0, we will update it periodically and sync
> tg_load_avg_contrib with the former. So it's not a problem.
>
> The other way was a problem because we stop updating load_avg and
> tg_load_avg_contrib when load_avg/load_sum is null so the
> tg_load_avg_contrib is stalled with a possibly very old value

Yeah, that makes sense.

Thanks
Odin
