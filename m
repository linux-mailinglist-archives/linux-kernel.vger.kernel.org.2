Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D13DAA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhG2R2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhG2R2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:28:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A45CC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:28:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so4542894wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/gAunwpvoCnlsGFlfZ64F2HFVRDl45rSubWvgfqVIOE=;
        b=ZHqvLrzuRl2fPMTlCXNByHM3yJKn1mKrWxTMhYm6Lk8K21P9a6rdlcxZLzbSgwR9Fi
         ys1+BTLngu9CLn2+yBUc93ZO4xIIUE5t+xn6GfqoIW5s4lj3XwgPRJWIG5xeaxCsFsRb
         +rauwItGFTQS05SWTAf9k6hB0ktv6m+eqRC81Yx5aI3ZZLSCG9YJHhwjpxwEo7yCg8e/
         2CEf5IVUvHxzoJ2AT2oR2QsWSGCy5HnLyyHfVHx5+sCCCAM4VHKQGJ4bqMDk5wmTPl2P
         3YzoRQXAenu/a6gLgIxBou+Tu9/G4tlr9mUc013kEYTrbaZ0YtLR6l4HcFU2hlB1R7HE
         SRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gAunwpvoCnlsGFlfZ64F2HFVRDl45rSubWvgfqVIOE=;
        b=aCVkhkp3uxVChIe2PgyZgePkwdSRqMtUiuPgtD6S79cJV7sgfL16uFhFcMEopfwdRf
         mdPhCz6Sq9TFvI1tqnsIL6DSuxK4icZaGk5WVsk2PyNUVaNR4piR3fitjBHSSk8VPbwz
         69qtVcUCYcCu+EtdLaDxFWefy6Oc8+QA0aYKcl9dKTaN2cqmDcTYmLdiywKNG/hky3c0
         CspQYT0SJ7avgt+ls5WASP0bPB/def/hs3zBasCNS3l8ChnS6FBqEK1kuvUlXVcyAcnm
         dBpDGouhuKrnSRnMJLxUK44uSuaqTqh3HITpVy9mAuXDdH1FDg4RKftzDWoI3Df+VZmz
         fBqg==
X-Gm-Message-State: AOAM5321yJJXPPNu/UV6Pr7CE0TxKUQ2sPTyK/ih9uJbKT9vYwK4lo+e
        i78ACifkbnF88nci0dfmSIflXA==
X-Google-Smtp-Source: ABdhPJwwHTqJs6QsR/2IXseU+OjCZY+KpGegj6Ul9iDqVZLN/LFuznDeEOjjubklCOt/lVNDMdCbmw==
X-Received: by 2002:a1c:3505:: with SMTP id c5mr15203692wma.53.1627579694637;
        Thu, 29 Jul 2021 10:28:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
        by smtp.gmail.com with ESMTPSA id r4sm4183717wre.84.2021.07.29.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:28:14 -0700 (PDT)
Date:   Thu, 29 Jul 2021 18:28:11 +0100
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched: Don't report SCHED_FLAG_SUGOV in
 sched_getattr()
Message-ID: <YQLlHKFgRwLVW6rE@google.com>
References: <20210727101103.2729607-1-qperret@google.com>
 <20210727101103.2729607-3-qperret@google.com>
 <YQEfY730Sjkr3w+Y@localhost.localdomain>
 <YQEl2t2RgaB9eEOZ@google.com>
 <YQFPYIqJG5PSPH1S@localhost.localdomain>
 <97c06d07-bb6a-e8b5-b230-390edd8bcfbe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c06d07-bb6a-e8b5-b230-390edd8bcfbe@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 Jul 2021 at 19:21:03 (+0200), Dietmar Eggemann wrote:
> On 28/07/2021 14:36, Juri Lelli wrote:
> > On 28/07/21 10:39, Quentin Perret wrote:
> >> On Wednesday 28 Jul 2021 at 11:12:03 (+0200), Juri Lelli wrote:
> 
> [...]
> 
> >>> Maybe we can do this in the previous patch so that it's kept confined to
> >>> deadline bits?
> >>
> >> That works too, it just felt like this could happen again if we start
> >> using non-standard flags outside of deadline for any reason at some
> >> point in the future. But no strong opinion really.
> > 
> > Yeah, I also see this point. :)
> > 
> > So no prob with me to keep it in core.c as you do here.
> > 
> > Best,
> > Juri
> > 
> 
> I would vote for not exporting SCHED_FLAG_SUGOV from __getparam_dl() in
> patch 1/2 to underpin the idea that this flag is a hack.
> 
> @ -2759,7 +2759,7 @@ void __getparam_dl(struct task_struct *p, struct
> sched_attr *attr)
>         attr->sched_deadline = dl_se->dl_deadline;
>         attr->sched_period = dl_se->dl_period;
>         attr->sched_flags &= ~SCHED_DL_FLAGS;
> -       attr->sched_flags |= dl_se->flags;
> +       attr->sched_flags |= dl_se->flags & ~SCHED_FLAG_SUGOV;

Alright, that's 2 votes against 1, you win!
I'll post a v2 shortly.

Cheers,
Quentin
