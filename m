Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46B1351064
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhDAHv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhDAHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:50:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF7C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 00:50:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so1017006pgs.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=srm3JYP08enw1OQnuuA5mkOdjEGKLES8Og7DhbuwbI4=;
        b=PgHKbUtSrY36oOnPfjKXXrgGBXkkckGVLxVvkql/X96Hx0nTTDMhwUqbxY1c9Eg9Al
         6/K/TOQi7ZawAtFr2tgVJwYgfcOw0gUXeg5GpMa/1f3CO9lt9SK8QjaCQ6aKBnWNVHIu
         Qpq/wKkDn72r5+Gfc4023ELGnQ0rSD2AC+r9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=srm3JYP08enw1OQnuuA5mkOdjEGKLES8Og7DhbuwbI4=;
        b=kmBMPn5u5OnVGfmUUx19HdynOK581Pfu9fZ0ACzB/X2UCJeXJYwyz6aJXzLibXwitJ
         k2C6sEPW+uIR2Y6SkVsH1quaKBzbs7QjJq6U4BtQkVwBx4GFaBedgEhC/S5YA1Ilt5Bc
         jRDcv6yUXvWIFyFzucxLJ8j5uiYKNTrIYxnGpkivEdowZkjj9Rh9HVzaaCe3dkr1YxwL
         uxXlRuTUe9RQWnG8b9XWEC6AGsfxb3gn/nVFaZS+Ieajeh/570E6Y1c6fMLXu/bnl7Z5
         NlLtOW519/8DNU33lNw9a3GaqV/Vpccu4USOUF0rLsF/hj33VQCIdmFPCVafm+2EEBa5
         vRsQ==
X-Gm-Message-State: AOAM532aynzNnoDwQpzPtWI5xghhAWxKsruGLXjRcgEspTTDZzJ2xhH+
        BmT5wkaaepguINePhogkNtVDKEFl0qVNFg==
X-Google-Smtp-Source: ABdhPJyc3+pKVPUyh2uuaRmrgOjclsv3uRKTHOeoCU2R4RLPumjVf5lB/2lkZSUdGDn6Clln3OeN3Q==
X-Received: by 2002:a65:40c7:: with SMTP id u7mr6476330pgp.29.1617263458857;
        Thu, 01 Apr 2021 00:50:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm4444479pgj.86.2021.04.01.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 00:50:58 -0700 (PDT)
Date:   Thu, 1 Apr 2021 00:50:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Josh Hunt <johunt@akamai.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: allow unprivileged users with CAP_SYS_RESOURCE to
 write psi files
Message-ID: <202104010039.A134EC56@keescook>
References: <20210401033156.7262-1-johunt@akamai.com>
 <m15z16r583.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15z16r583.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:36:28PM -0500, Eric W. Biederman wrote:
> Josh Hunt <johunt@akamai.com> writes:
> 
> > Currently only root can write files under /proc/pressure. Relax this to
> > allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
> > able to write to these files.
> 
> The test for CAP_SYS_RESOURCE really needs to be in open rather
> than in write.
> 
> Otherwise a suid root executable could have stdout redirected
> into these files.

Right. Or check against f_cred. (See uses of kallsyms_show_value())
https://www.kernel.org/doc/html/latest/security/credentials.html#open-file-credentials

-Kees

> 
> Eric
> 
> 
> > Signed-off-by: Josh Hunt <johunt@akamai.com>
> > ---
> >  kernel/sched/psi.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index b1b00e9bd7ed..98ff7baf1ba8 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1270,6 +1270,9 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
> >  	if (!nbytes)
> >  		return -EINVAL;
> >  
> > +	if (!capable(CAP_SYS_RESOURCE))
> > +		return -EPERM;
> > +
> >  	buf_size = min(nbytes, sizeof(buf));
> >  	if (copy_from_user(buf, user_buf, buf_size))
> >  		return -EFAULT;
> > @@ -1353,9 +1356,9 @@ static int __init psi_proc_init(void)
> >  {
> >  	if (psi_enable) {
> >  		proc_mkdir("pressure", NULL);
> > -		proc_create("pressure/io", 0, NULL, &psi_io_proc_ops);
> > -		proc_create("pressure/memory", 0, NULL, &psi_memory_proc_ops);
> > -		proc_create("pressure/cpu", 0, NULL, &psi_cpu_proc_ops);
> > +		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
> > +		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
> > +		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
> >  	}
> >  	return 0;
> >  }

-- 
Kees Cook
