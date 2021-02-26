Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79733269E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZWWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBZWV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:21:59 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAB5C061788
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:21:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c8so12329897ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1K6EFKaL76TU0vrMptcFpOpukPudyQ834mCnGUOJSJ8=;
        b=Qhtf5tMCa15jexl+5eTT5kTjnjjKcjh+MOzsBgl+VAlfoHFzs6WF9ewHaZ59fgo6AR
         OdUYAUftiv8WvzHb6IHXe0Xcy4yBfJxotfV8HMi/PcYFw3wNvGZRLi7nACTZRizzTvUx
         xTdELz+t64JchV2azQj4hqWYnobLy8HBJLebs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1K6EFKaL76TU0vrMptcFpOpukPudyQ834mCnGUOJSJ8=;
        b=EBIDCkAkfsDjkhgXw4AUeXiLRniOng5KBE9QsvUrf/lLVfl9u55kQclJN1xZGqTGgi
         xPfR1GctenrY2SEM9w1Nt6tBLabsi/h2opf6q5jTuPBPu0tHvCYvJpSnUNhNBhiTaq4W
         TkC9BT/rp16TUXvTnvLn/UhiUImO0fx7mrorJLO7rTqglI80dj9nLutQlZ7w544i1tSa
         8VdOUzsAWwjwkzLC4akC7jVrrjB5YtNyfdgRP3+aRsDdl8TbjiuHpOSt9F91VdvI/n3T
         bhNrfFosTvCg6a5SPtDmPPg2JFduvtBY4YNq/BV6FxPsjAL3aEUAz2q1ViGbzZkIyhFk
         /ljw==
X-Gm-Message-State: AOAM532l7lqy2HrNEMCNTuXUFTK1jabLEfQo4zY7BooMgaimhlSIURFD
        AHuvPCihaK4fh10QUl6GgtaEXHndOQBnmA==
X-Google-Smtp-Source: ABdhPJxfHid0rV4HFmM7Q09sXuxj7belp46LokMlq6ic6Wv+64ZsyXKCuwXjn1PYSE3DQiL5uEv9pA==
X-Received: by 2002:a2e:87c6:: with SMTP id v6mr2803925ljj.372.1614378077404;
        Fri, 26 Feb 2021 14:21:17 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t192sm1304186lff.295.2021.02.26.14.21.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 14:21:16 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id m22so16118978lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:21:16 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr2960904lfu.253.1614378075864;
 Fri, 26 Feb 2021 14:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20210226185909.100032746@goodmis.org>
In-Reply-To: <20210226185909.100032746@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Feb 2021 14:21:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
Message-ID: <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers from
 trace events
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jacob Wen <jian.w.wen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The first patch scans the print fmts of the trace events looking for
> dereferencing pointers from %p*, and making sure that they refer back
> to the trace event itself.
>
> The second patch handles strings "%s" [..]

Doing this at runtime really feels like the wrong thing to do.

It won't even protect us from what happened - people like me and
Andrew won't even run those tracepoints in the first place, so we
won't notice.

It really would be much better in every respect to have this done by
checkpatch, I think.

            Linus
