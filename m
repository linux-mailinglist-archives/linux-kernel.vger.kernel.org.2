Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78114346AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhCWVWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhCWVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:22:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F5CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:22:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z10so15982391qkz.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S396biM8o8RPLnciZxIEy80rbyRdWgEBUKF0cvQlSyo=;
        b=EvWRn0T2iIHkgup69AHMODGgJNzl7irkfXK8uWTlZ5TF9x9IKYzaNwTcrXuDUQVnfW
         NouWO6dRY6SaqiRCPfvIcX14yw/3fJanUY/e3G/QFYoxs/da8CuKESqkbdlVc9mbWiST
         F2R3g8K2sFx3DORbEvBUi2lFJ3k1JOUaCpSFhQ0NmfOZS2VDiYBRVnCzi+H8EC5P6Xz8
         Vwixz07G8GftkSLucF0u1O8uytqjFdYWalTYwRLuKC+noQNrwa/oQVcFT6/yne8yexxi
         4QlYg5Q5wtVmWRmj5m4OXVv8VIQcydUwrSZf0zKFLZPLPkkYnw+sb5+PRyYlvCzwrI6j
         EkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S396biM8o8RPLnciZxIEy80rbyRdWgEBUKF0cvQlSyo=;
        b=YM1gokNR/PexAigyCRExpHq/+IHX/XG+oY5P9qBLXTGudBepFHQGZOV9NbR/O/QLjJ
         z/MyrVmdC+kJfFKP14anZJJFKdvzI5uFIttZhoVLaHAJSDT286zkub/+T4bnGKloXQsO
         C0zdNFjO6HoL2Y807QMMhY3+g9UFihp3Yo5Ck1wVytlggQDExfaFk0EUdHgfrs6yHbiF
         iWs4rbkQR8v/E2utTJeov5D/qKld34hEuTa4Ej/BJbFIwR0VZZUmFc2bYKIwHhSHZYCp
         14MZLl62dmLzV6sjSQ8BCzn8XP9Vn27N0JoTduCan+IrcOZZQy1c11BukDeExN9jNG7I
         fskQ==
X-Gm-Message-State: AOAM53246xO86vByj3q9EIqx/WUbLFCf/0pQpVC44p/NPS598SrMWn+9
        MTZh6tWp1Hcr5XbTbu5VglsLdBG4Pjcohsuv9aPF0Q==
X-Google-Smtp-Source: ABdhPJy26bR5ZlPqxp7UrO0LaZBkYxaJ+tVPh6tPxECcrVYO/x1K2HtP1CLppz7I8eci1kQEZm1n7HWBomBf/qxo5v8=
X-Received: by 2002:a37:a350:: with SMTP id m77mr58325qke.146.1616534528531;
 Tue, 23 Mar 2021 14:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-2-joel@joelfernandes.org> <20210320153457.GX4746@worktop.programming.kicks-ass.net>
 <28e13609-c526-c6ee-22a3-898652aed5e6@linux.intel.com> <YFhL4CMPB+Pfo965@hirez.programming.kicks-ass.net>
 <af3f6ea6-2c71-233f-fc6b-af039b004923@linux.intel.com> <YFhcD/jz7kC8jaXa@hirez.programming.kicks-ass.net>
 <bb075bed-150c-8ea0-3035-0a8c3c98e572@linux.intel.com> <YFiT4/mmisnBFJ96@hirez.programming.kicks-ass.net>
 <e21e7ce1-d9b3-63d7-bda2-a643294518a3@linux.intel.com>
In-Reply-To: <e21e7ce1-d9b3-63d7-bda2-a643294518a3@linux.intel.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 23 Mar 2021 14:21:57 -0700
Message-ID: <CABk29NsL4SmUQ1G0ULnvJp3xqoKO_J8iKOvQOKJhz4CWL8PE=w@mail.gmail.com>
Subject: Re: [PATCH 1/6] sched: migration changes for core scheduling
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        fweisbec@gmail.com, Kees Cook <keescook@chromium.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Steven Rostedt <rostedt@goodmis.org>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 8:54 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> On 2021/3/22 20:56, Peter Zijlstra wrote:
> > On Mon, Mar 22, 2021 at 08:31:09PM +0800, Li, Aubrey wrote:
> >> Please let me know if I put cookie match check at the right position
> >> in task_hot(), if so, I'll obtain some performance data of it.
> >>

Will be sending out a rebased stack soon, with this updated patch included.
