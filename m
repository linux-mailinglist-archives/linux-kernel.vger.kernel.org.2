Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6894B392E27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhE0MmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbhE0MmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:42:13 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F10C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:40:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id h7so2455233qvs.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNiQoWn/9OHCszXvyBqQo+oFAxQxF89SUvYeB9IA70I=;
        b=jyNj5GwSxQNwfAKTy3gtmVCcmwrkUBb3JuWQPt37kUBY8+vtkcmYgiu6qbIlKFTffk
         E/9Irp8l8MnV9c+4Eoe/NM1V233e6y5vOr2tVdKvQHoU4HsM69G1quOBvLYRII2JV/Ki
         RSI6U3EtNmFREjJ82VIQ/njctZuuFWI9M9cq/fSU0e9Y2nCC6ZCUPnzBr4p2TMxlxLnE
         DG+c+1zleTR+YOJpCDBCMA5rll/J9LOTxmGXfZ7cf2SJ3WH4rlbTGibikytVWLcnXUBa
         K6MNzLl6hzbefsereyfuX4gBRygBS7Z48hBSUooL1cHMkUxZkgKQ5Fpbz86P8QLRt0bO
         akFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNiQoWn/9OHCszXvyBqQo+oFAxQxF89SUvYeB9IA70I=;
        b=WChp5MFMh27ruDxkqvAJ1UZBGUIKXCRKo7cAva1wP940Ct70fgPU6PRm01MFEmJ9pp
         NK2Z5AKSGKXY43qOsBDacj3O5A6aSkEajs1fHtMLESFLi8QnWx7r9mTkfLOH8qMfMUet
         hOl7NphQzCbI5VzCkbrozb2vTTmF+aEDn21jYhlqqgI3nf+wc0zeYr+S0kkJnJAkjEBS
         WamRE05vgRjbzl4YhnoD6lAY04VldPTO/5KauX3+rpz67q1Gdzu+UK9UBjym6HVByk7z
         GQ8KBN5vmZgETX0oTJFa9N2p6JjTvJMpgCfRtBsN5kQB/u5sItUEMQgbIc1emN9lQC+F
         WUcg==
X-Gm-Message-State: AOAM531tTIMP2Xi/2KI0IJ/cL/yOjSi2TI/fwwNav1iiEO9N+s+b9ak7
        BnQ/wqCRoQ9WtBpbhgIGdLT+m0GJHCye0SOH5Ku5Ag==
X-Google-Smtp-Source: ABdhPJx+MEW0CnUf1F8oex/JTgIpam9ZjnGBwdbyusEV5nw1jR1q2ZnyzDK2NqKAuuCcEqUrWBUKMkArkBfDXyRn5VY=
X-Received: by 2002:ad4:420b:: with SMTP id k11mr3590073qvp.18.1622119238064;
 Thu, 27 May 2021 05:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
 <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com>
 <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
 <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com> <CAFpoUr2NM9RHE=jdbi5aNj2LeVr4iKJ3thMPUNhp_SnCe7tnfg@mail.gmail.com>
In-Reply-To: <CAFpoUr2NM9RHE=jdbi5aNj2LeVr4iKJ3thMPUNhp_SnCe7tnfg@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 27 May 2021 14:39:59 +0200
Message-ID: <CAFpoUr0mTQym4cmN98Er=4byRo9wqYcuOsbMLDJEnjvD-2ZbMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Odin Ugedal <odin@uged.al>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
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

> For 1st problem, the way we were updating load_avg and load_sum, we
> were losing the sync between both value

Yeah, that would be a natural way to fix that.

> In fact, the update was already there but not always called (see the
> patchset i just sent)

Yeah, that was my exact point.

Odin
