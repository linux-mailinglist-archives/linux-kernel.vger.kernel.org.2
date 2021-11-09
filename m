Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246B044B251
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhKISHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241503AbhKISHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636481103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tec7Xd5TXBMhfq8SH++uO6SEozr8c0XF6LBCKmYuU6Y=;
        b=iCMSNRkzOlze6ghxx67pcHTG46KSXjvZ2kh2RN8yJmQrSkSRMB2czmPHBOjM1ZhjPbVh1I
        WQs8iu1V0Isdmmt4BrdRrpmx85eTRDcaqSJFNoxVOsUiRqQw8fDpL0ag56mVL0L6ywCBIB
        me6omwuicc74uGAsQFhyymhEQNQjOOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-34aRryttMaS5OJYjTouHww-1; Tue, 09 Nov 2021 13:05:02 -0500
X-MC-Unique: 34aRryttMaS5OJYjTouHww-1
Received: by mail-wm1-f72.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so8104579wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tec7Xd5TXBMhfq8SH++uO6SEozr8c0XF6LBCKmYuU6Y=;
        b=xmJBrzaZFkL0CufPFrkPx1jPUYL8241mJiODAGyorEBUklczKCqmFf7jgkyPanWrjM
         qbtjHDhIHB6YL/Ib8ttMHbI5mBtoVsSj5cLH0pX9JTiLSFB/SYTirCNP133ucqdARb0b
         /YYd7hWR0IYNL7hLDgJunZEe4SiApnRFBrTH4tSgCzap6qOSBfY2u4PmkbW+sr5zZSz9
         ZlZvt2kEbI0XnwymjbpX7Fli/RbqTVW8rqvA5cEUOgMJ+nmB6Wl5tAZxhbt+FD1qZfH9
         fnYZjulgB5p1c0151/m3E6HkczcMxUEj81K/UU2VsxdTPQ50DkUnrLqVAmtAzKVGlwpE
         K7rg==
X-Gm-Message-State: AOAM532Iwlg/YoO5VSUb1bRGwLchPI05YRL9tJ3yqyozX7W4qzWfyzvo
        kutcrC+qsT3aLzwT5x3WAMoUkQjxo2iJjrRSdC070eCOKT/7w4MIGXk3QsxL3QMUlhE/KUtc+PD
        q+m8lyfcDsyYRE/u6E1VdBN3n
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr11547867wrw.57.1636481101225;
        Tue, 09 Nov 2021 10:05:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0bJNSgJfrYfAR1GKvjDAZiKadBlY4FBFvmVarxhxi0h4kNA137LZfdYRHh61nITz+dr7CLA==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr11547835wrw.57.1636481101035;
        Tue, 09 Nov 2021 10:05:01 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k27sm3596333wms.41.2021.11.09.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 10:05:00 -0800 (PST)
Date:   Tue, 9 Nov 2021 19:04:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace/direct: Fix lockup in modify_ftrace_direct_multi
Message-ID: <YYq4S1peUqh/remN@krava>
References: <20211109114217.1645296-1-jolsa@kernel.org>
 <20211109110237.4f5d7ef3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109110237.4f5d7ef3@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 11:02:37AM -0500, Steven Rostedt wrote:
> On Tue,  9 Nov 2021 12:42:17 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > We can't call unregister_ftrace_function under ftrace_lock.
> 
> Ouch. 
> 
> Do you have a sample module that triggers this?
> 
> I thought we had something that tested this code, but I don't see it in my
> tree.

I triggered that with my bpf batch changes

there's not test for modify at the moment,
just register/unregister I'll add one

jirka

> 
> -- Steve
> 
> > 
> > Fixes: ed29271894aa ("ftrace/direct: Do not disable when switching direct callers")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/ftrace.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index b4ed1a301232..fc49e8809a56 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -5602,10 +5602,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> >  		}
> >  	}
> >  
> > +	mutex_unlock(&ftrace_lock);
> > +
> >  	/* Removing the tmp_ops will add the updated direct callers to the functions */
> >  	unregister_ftrace_function(&tmp_ops);
> >  
> > -	mutex_unlock(&ftrace_lock);
> >   out_direct:
> >  	mutex_unlock(&direct_mutex);
> >  	return err;
> 

