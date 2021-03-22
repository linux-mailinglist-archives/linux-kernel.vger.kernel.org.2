Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2255344859
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCVO56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhCVO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:57:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E67C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:57:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a11so12525323qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UwhIIasVnVdlHzlTomI5pRRaZe96fs8y+pLTlJCplZw=;
        b=qhe5uqLfC7EvXAnlfkhQt8AAmxROP8AJEiSsrfDC/QM6WxkV4nRlISq/zrZqrOKti8
         6KmXJCviNwuO1YtESQLIJi2dpeqT6RNhBhJ2Vy3Q6v3YiNisrS75wBr+HgNesT1mPuvq
         fnqYDaJVf5fTFIhnYNAYkuezwO8v4bY3vQB1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UwhIIasVnVdlHzlTomI5pRRaZe96fs8y+pLTlJCplZw=;
        b=QXCiD+zoHXvpyBTKnE0alEQRU6VjY7Jpmnl0QM14LJOSJP57MJ24kp2gS68eNE6+0E
         CXijovebidG7UYuvkd9XP+dlS5Dom//cq2T6XXU1gTj+/zTMKnTm1qcanguDzV2TGDlI
         ZQAIoEOOnE06kSLSmwkULAiXYpVNunORE9/qdOgrr8DCK+hlIyzj2V1PA2BjjVl4pkjq
         dfsZ/5F0THtG6m2WrcFS/FWBdk7HGfFdNOxdnkYCMa94VO1P+nzqmERrlQ86PR9EiDjJ
         ow+pMGYsUVaXRlUEuieNP/+LmJvhATAc+QGCllI4aziwPae2Y9toAGwBCLxNnIoCPErE
         UorQ==
X-Gm-Message-State: AOAM5338mzuCTiNYjHyE90U9P2YtBdvxzLEXhN18m6Oe7/1QzG7PpMy/
        EIfedEUB1FvEfCO+7c7qVeFLEA==
X-Google-Smtp-Source: ABdhPJz810wqCe4laVZnPaBYMBdXp648O5fDX//ONP41OyjYpr43HJwxqY27l7f28gDuiMY9ut1dnA==
X-Received: by 2002:a05:622a:1342:: with SMTP id w2mr242428qtk.163.1616425052945;
        Mon, 22 Mar 2021 07:57:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:ac32:f1d6:ca24:7ab])
        by smtp.gmail.com with ESMTPSA id c13sm10746617qkc.99.2021.03.22.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:57:32 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:57:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 0/6] Core scheduling remaining patches
Message-ID: <YFiwWwXctaBnPhjF@google.com>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210320154020.GY4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320154020.GY4746@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 04:40:20PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 19, 2021 at 04:32:47PM -0400, Joel Fernandes (Google) wrote:
> > Enclosed is interface related core scheduling patches and one for migration.
> > The main core scheduling patches were already pulled in by Peter with these
> > bits left.
> 
> Funny thing, they don't appear to apply to my sched/core-sched branch...
> :/ Either I really shouldn't be working weekends or something went
> wobbly on your end...

Yeah sorry. It is based on a slightly older snapshot of your queue.git
sched/core-sched branch. We will rebase again and resend ASAP.

Thanks!

 - Joel
