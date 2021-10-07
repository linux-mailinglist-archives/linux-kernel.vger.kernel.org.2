Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A442562D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbhJGPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbhJGPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:11:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F5C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 08:09:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso6650795pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwBFVgL0rWbgcfbyCDG1TsRp9Ifys2zsPzP9eEcQnP8=;
        b=Lt2MndVhQ6hEVWM3iH8Kh6Tp3WCXCBYbRdJJD8TrlN5XO4q9z1/5o39ICKHnf+oO/p
         Ug5Vv2y8LHjMCYy6uVFN03eFh0AyYJsueTHlrT7Fo+UGvzUwDY4310poHgxXfOtOTTTN
         tilWf03y6mHUBEzx9gTWv+ASxy76ndmGWfKqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwBFVgL0rWbgcfbyCDG1TsRp9Ifys2zsPzP9eEcQnP8=;
        b=huZI59jEn4EJcxG3BhLGtZhUG4OPq2AkA7/em6ULiLNygHkZK0sHkeVH2JWtNINLNv
         h5GUHFbAxrIrrSuP2rrPyyrsMOnUJEP1OmePqs8CKMc0TW49i6vZ5SwAF81X4/4uJWMl
         85piDAl3A4j8q1nWJAiwZHXdMoRFV8YlNKmkk5F0jgdqjlzIWWFpDcNiNS/c0p8Vpydl
         1vR0XMQF0vaMb4l59odAZMzMLacEqKlHordGWi5BAQCHxSU65Zlm5LbuECqR6yZR/D7N
         f4yfU2VHhN9rRam/9sZgpuYwQzE5lkSf4ojbLXohv8c2P4hTLEZSMPgWPDNVptq7CKI+
         jh/A==
X-Gm-Message-State: AOAM531z0g5kE/2lCLH6aD24gX77ayGIrnX5iBJtdyX696wUFuwVE6Tc
        I3L81G6yS7jGs0Sc+MqzS4ladA==
X-Google-Smtp-Source: ABdhPJwgJRDpyE4ODOGMol25UhHL7pnQaUCFbPzPAocJvk3WdlZI3UQNRLhj6geomI4URbu2NaOb6Q==
X-Received: by 2002:a17:90a:9f91:: with SMTP id o17mr6036386pjp.225.1633619393507;
        Thu, 07 Oct 2021 08:09:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n207sm15374608pfd.143.2021.10.07.08.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:09:53 -0700 (PDT)
Date:   Thu, 7 Oct 2021 08:09:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: Re: [PATCH v2 1/4] cn_proc.h: use TASK_COMM_LEN instread of 16 in
 struct proc_event
Message-ID: <202110070808.43B5AAEB9@keescook>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
 <20211007120752.5195-2-laoar.shao@gmail.com>
 <202110070750.8754AA33@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110070750.8754AA33@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 07:51:35AM -0700, Kees Cook wrote:
> On Thu, Oct 07, 2021 at 12:07:49PM +0000, Yafang Shao wrote:
> > struct comm_proc_event was introduced in commit
> > f786ecba4158 ("connector: add comm change event report to proc connector").
> > It seems that there is no strong reason we must define the comm as a
> > hardcode 16 bytes. So we can use TASK_COMM_LEN instead.
> > 
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/uapi/linux/cn_proc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> > index db210625cee8..351d02786350 100644
> > --- a/include/uapi/linux/cn_proc.h
> > +++ b/include/uapi/linux/cn_proc.h
> > @@ -110,7 +110,7 @@ struct proc_event {
> >  		struct comm_proc_event {
> >  			__kernel_pid_t process_pid;
> >  			__kernel_pid_t process_tgid;
> > -			char           comm[16];
> > +			char           comm[TASK_COMM_LEN];
> >  		} comm;
> 
> Hrmm. This is UAPI -- we can't change it without potentially breaking
> things (i.e. userspace binaries have this size built in, so we can't
> just change the size). This will either need to stay truncated, or may
> need a new interface with a variable-sized structure...

Specifically, this is needed for this series:


diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 646ad385e490..34bcba25c488 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -230,7 +230,9 @@ void proc_comm_connector(struct task_struct *task)
 	ev->what = PROC_EVENT_COMM;
 	ev->event_data.comm.process_pid  = task->pid;
 	ev->event_data.comm.process_tgid = task->tgid;
-	get_task_comm(ev->event_data.comm.comm, task);
+	/* This may get truncated. */
+	__get_task_comm(ev->event_data.comm.comm,
+			sizeof(ev->event_data.comm.comm), task);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */

-- 
Kees Cook
