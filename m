Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6323103F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 05:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhBEEIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 23:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBEEIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 23:08:11 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C4BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 20:07:30 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t17so4163674qtq.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ohk/C5oFiMM+Cgctb+9cVBX5KjZwpMPY1LRWrhVM8c=;
        b=vyxicpSlUPsEl6l5LRz1yPe/qzaA1irn4iqjmpwBOJby/PIu0RSE95qGOI3ZFOURqB
         4jGPT7Wj/r6Bps8JTWJ78VFjfrHPPrtWxJlPnYfXXXzeO6KsbzfFebXjuXDqIvfUc1qt
         degfQf7jXZw52VJ5FrvwNjJfTfs4JiPu3T0gC0PnNBTnPuqwpAn8y6LHe3A4DvdPKGuU
         8gauJND+bMO8+h3MAiBhK1M2qkWvsOlaw6DT5VNk/uq9/Ls5AG33axnFzVclCVaO18Ja
         YYtg3h3RE0fwX7WNegtg172Oo/2IiC9Kuas/4umX/NIcnugPzuI8i5EjcvbdrY1IVhVJ
         GcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ohk/C5oFiMM+Cgctb+9cVBX5KjZwpMPY1LRWrhVM8c=;
        b=rSXz5pqRHsD/CEjT+dRNKp0BCX0Q9a/NGg0RTi6fM3Sv7jPlFS0TB1FMMScOId//+y
         SqguxTruDxH+uEF7RoDyskJOOoArbwor7GT39BQ9F1cQ7sDE7P1arp93E9cQZ8TD9dFM
         uZn7sgL2JTbTz+v8YrOsmRftWaxtGZTPqjoPlhn1Dl1eXBvZEUyFKywcCtbkrUgsNW+V
         IzV0b7ZPSup5mlzjffIuEjay7/XyVYq4bNQKosRQ8619/+6xG/v2MBoXnhVBd/JoqVR1
         weWQMFoeMDhJ2sv2aJDyat4YzKJySxOrgxFJHLpedhe8vHTn/fmeAO9C5BGX/mI7iiMi
         EqDg==
X-Gm-Message-State: AOAM530cCB3HNEuEuWKyMz4JJfGRr1wsHBykcbnr80HjCCTFgqnFSOp+
        oPMXfPNlyOkbNN/9kC/BT66m7v510I3iZS9yDKyaVw==
X-Google-Smtp-Source: ABdhPJz5lfup8LlrNrVU4+brmUupz23YGginL0sbtzeDArJX36dPhprF9+i6BUTizu+x8ifV+iJCp56DAbhn9r5p6j4=
X-Received: by 2002:ac8:7654:: with SMTP id i20mr2800547qtr.143.1612498049828;
 Thu, 04 Feb 2021 20:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org> <YBwGRpnISmwkJ2i8@hirez.programming.kicks-ass.net>
In-Reply-To: <YBwGRpnISmwkJ2i8@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 4 Feb 2021 20:07:18 -0800
Message-ID: <CABk29NukDGbO3V4MW8MMSkevjsbUfii0Scc9mpXsi+yRQmWxMA@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 6:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> refcount_dec_and_lock() avoids that complication.

There isn't currently an interface for raw_spin_locks. Certainly could
add a new interface in a separate patch as part of this series, but
doesn't seem that bad to do the locking inline.
