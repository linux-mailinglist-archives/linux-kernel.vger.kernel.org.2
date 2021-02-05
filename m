Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC63103D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBEDqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhBEDqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:46:32 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94FCC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 19:45:51 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id e11so4119777qtg.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 19:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYFWkDEOfBhWSHmK2jmVVB6bfwty0OAqrNhMAUCf5OE=;
        b=N44ptCLuB429yIat1IbEbc1ky15SrHFs/3Mhp4wp4JHqLlvcCvdVaYmZunuNN84Eh6
         UQdN9EHB5MBpolyUvpI2LSqV+VSTOJsNWVjWya9WsQnTT98j3fEA3vMNt1COIJ1qSKpv
         kxd+jdC9xyI6ZZe6ab36xX7419iSvjWe3F+HpVW2CWq+fjBFUis047eag9q950Svm3dH
         jOr30+Z6pDX05t847GJlZGmbFUw8mby9DMQ4AuUZphqSJ9Rz5QM2tBiBX+QhNipSnZLS
         dcGeDo+5lBsWl5PWygIqQS8KyPK/L0w8uMSxc7bP54rM+3JFx0LQLTerr4DycTKcGsrx
         g2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYFWkDEOfBhWSHmK2jmVVB6bfwty0OAqrNhMAUCf5OE=;
        b=bNOBv7JRcKrswqX8D0a7Z/6c6FiPA+3nhOztCHr8t/i/wfhV39KH3C5X3nTJDfjNpF
         ueUh5yVhcFjdf8PaIUkJo2sU2ZcYaWrCrTXlK47CcEFitzkZm0MJaoaFqUHawS6Q/FVx
         F4GKPSzBfHWwhlI6wqMi6tuWPRZ59NQSpBedN04xNY186e9HWWcKa5S/+3AmcH63Jx9K
         MI9Bf+EbdlFr9705tunRirZdhaGrCihochD/jlO3fUIbcYTIRPLp0Vr7YkRESFMjk+j1
         45Nr/iKDTyGECecFFxBiudKevx8SZlsyYHr7XkTHhAvwG6Ev65ip8+Ai5HwOg9ZSF2At
         qXhA==
X-Gm-Message-State: AOAM532wDwE1ncLN6u1DkF7Sv0FNeaH2Je6Qg7/ixnWXRuIYUnz5bTto
        0rE6YNDcpAjFa37v+Zptd8krrVLEbIPHEvQLoAQASA==
X-Google-Smtp-Source: ABdhPJy4S732UpJX4hjGhJwphJyOfFYp2hDLn+YlkOekY3Ov+E3+XzTpR9umfLEMCTBKypw6jjKmPomMFVCV8Z71bDU=
X-Received: by 2002:ac8:7143:: with SMTP id h3mr2734026qtp.101.1612496750744;
 Thu, 04 Feb 2021 19:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org> <YBv8gBSKU1MdtXuW@hirez.programming.kicks-ass.net>
In-Reply-To: <YBv8gBSKU1MdtXuW@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 4 Feb 2021 19:45:39 -0800
Message-ID: <CABk29NuS=7U4kgvGPf1=tVJxG3tiPqjr_H4ZhAFHaKSS4uqn2Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 5:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
>
> I'm thinking this is too much credit, I didn't write much of this.
>
> > Marks all tasks in a cgroup as matching for core-scheduling.
> >
> > A task will need to be moved into the core scheduler queue when the cgroup
> > it belongs to is tagged to run with core scheduling.  Similarly the task
> > will need to be moved out of the core scheduler queue when the cgroup
> > is untagged.
> >
> > Also after we forked a task, its core scheduler queue's presence will
> > need to be updated according to its new cgroup's status.
> >
> > Use stop machine mechanism to update all tasks in a cgroup to prevent a
> > new task from sneaking into the cgroup, and missed out from the update
> > while we iterates through all the tasks in the cgroup.  A more complicated
> > scheme could probably avoid the stop machine.  Such scheme will also
> > need to resovle inconsistency between a task's cgroup core scheduling
> > tag and residency in core scheduler queue.
> >
> > We are opting for the simple stop machine mechanism for now that avoids
> > such complications.
> >
> > Core scheduler has extra overhead.  Enable it only for core with
> > more than one SMT hardware threads.
>
> Very little actual words on the desired and implemented semantics of the
> interface, while the patch contains much non-obvious complication.

Ack to both, will fix in the next posting.
