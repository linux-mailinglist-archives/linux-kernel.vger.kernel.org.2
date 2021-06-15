Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824E93A7DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFOMFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhFOMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623758581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yNF6KA8RI97gSFxhNSTM3TXkqeiJ7GynK+A3VyWY4Eo=;
        b=hYxgglzsdRxUE8fKz/x/QLfH2Eshpst+xkWvMUSRN2CyrOIsOQVEhf2c7PsldJV8Zyt21U
        3+pF1GcgmmY28I4zASx5N/y/OWnmmfSG9b2xdjgiI1w9RljQfKJctmaaAL6gsTSxtXgntw
        iSJRo6NXMqpEcXaI7O9klOvBEEgKLBY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-0OVacZyBNKqRL3FgFbnZXQ-1; Tue, 15 Jun 2021 08:02:59 -0400
X-MC-Unique: 0OVacZyBNKqRL3FgFbnZXQ-1
Received: by mail-wm1-f72.google.com with SMTP id y129-20020a1c32870000b029016920cc7087so3125114wmy.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yNF6KA8RI97gSFxhNSTM3TXkqeiJ7GynK+A3VyWY4Eo=;
        b=aOC/I5OTp1nNDN7pGyvivQi9vBawszs2oSgYK5qCcGSMjDfI698g7EBqsq+W6UCQPz
         5HLFtfzYdmPmKSMDrg0Y1fXdnGIKoiDDiOrh2ZzTV6DdIKsVzd9s2FrEQyi8Nm9dTqF2
         ujzwvi+KYmUbX6VxxVbSAuSXbNw4Ze/42ut5kOhv3iwtfakT5aJopLoF10YMjLTywsS0
         Kc7YWW1y9HPCrWQTCDcx+40Dvc11tqA2+1wVKuTSh2J7xs3eTAQ1ugnh9o7BCow1Tqne
         25TpWfcNnVkb030YZSr019T+DJq419Usgco8MDn1a90IC2Qh6Cq5Gxzr5cqrZhj8gyB0
         YV4w==
X-Gm-Message-State: AOAM531U7qzoGeZAlyryxVrjTldOJFg9zFkGWsGl8ek9dbdOXEXs1k19
        guDntDP9wwrtvDVPge4Rf2b2i9Up/FxQT0JhT3yOMtAUk4hR22V9BhBRqmBrBSi7lOfTt67zib+
        q8R1O6WirVzBkhIsld69PFuA=
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr21866785wmi.141.1623758578602;
        Tue, 15 Jun 2021 05:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG5dP8+ZXivDaieUv3qD65f9PSdFx3qdeGSIYtwDeDsYE1IvgNs2BobENDgq60ktfL6H6JMA==
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr21866761wmi.141.1623758578450;
        Tue, 15 Jun 2021 05:02:58 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id c13sm2128227wrb.5.2021.06.15.05.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:02:58 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:02:57 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, penguin-kernel@i-love.sakura.ne.jp,
        llong@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <20210615120257.zkumnojewtrqnx5k@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210612204634.1102472-1-atomlin@redhat.com>
 <6fc8beef-4dbb-b49a-4653-90fe564941a6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fc8beef-4dbb-b49a-4653-90fe564941a6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-06-13 16:47 -0700, David Rientjes wrote:
> On Sat, 12 Jun 2021, Aaron Tomlin wrote:
> 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index eefd3f5fde46..094b7b61d66f 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -160,6 +160,27 @@ static inline bool is_sysrq_oom(struct oom_control *oc)
> >  	return oc->order == -1;
> >  }
> >  
> > +/**
> > + * is_task_eligible_oom - determine if and why a task cannot be OOM killed
> > + * @tsk: task to check
> > + *
> > + * Needs to be called with task_lock().
> > + */
> > +static const char * is_task_oom_eligible(struct task_struct *p)
> 
> You should be able to just return a char.

I see, sure.

> > +{
> > +	long adj;
> > +
> > +	adj = (long)p->signal->oom_score_adj;
> > +	if (adj == OOM_SCORE_ADJ_MIN)
> > +		return "S";
> 
> The value is already printed in the task dump, this doesn't look to add 
> any information.

I understand and perhaps it does not make sense; albeit, the reader might
not understand the meaning of OOM_SCORE_ADJ_MIN.

> > +	else if (test_bit(MMF_OOM_SKIP, &p->mm->flags)
> > +		return "R";
> 
> We should be doing the task dump only when we're killing a victim (unless 
> we're panicking), so something else has been chosen.  Since we would have 
> oom killed a process with MMF_OOM_SKIP already, can we simply choose to 
> not print a line for this process?

I'd prefer not to show such tasks, when displaying potential OOM victims
(including those in_vfork()) as in my opinion, it can be misleading to the
reader. That said, a case has been made to maintain their inclusion.
However, should in_vfork() even be shown in the actual report?

> 
> > @@ -401,12 +422,13 @@ static int dump_task(struct task_struct *p, void *arg)
> >  		return 0;
> >  	}
> >  
> > -	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> > +	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %13s %s\n",
> 
> 13 characters for one char output?

This was to maintain some alignment but fair enough.

> >  static void dump_tasks(struct oom_control *oc)
> >  {
> >  	pr_info("Tasks state (memory values in pages):\n");
> > -	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> > +	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj oom eligible? name\n");
> 
> Field names are single words.

Understood.



Kind regards,

-- 
Aaron Tomlin

