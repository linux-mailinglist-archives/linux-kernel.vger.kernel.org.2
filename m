Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6EB37F269
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEMEt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:49:59 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:39669 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhEMEtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:49:51 -0400
Received: by mail-il1-f178.google.com with SMTP id o9so16938647ilh.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 21:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1bFSgP0Vbpje3f5C9DQaOkMAM+6teiK5qo8mAH870dE=;
        b=o5mzUjq9FIlMakN9tshJzAzifJ0POCE3mHrP5cbfTHTEgV6P4LXn0fEElBE77KLcWx
         TLaLeD8gbdUQOJlhYcWZHC9fLa72MSYO2gvT0d7Ecy/3t83oLVchp3oUcrUpa02bpVK9
         xA/NDZa+qmEYdXzjrBGwAVSiuRiTD24s8Ktu37HfSaSlDR2M6PoRf4UU7Z5+3xVZvLCt
         BLnZPl0vJB+CRUhIhNwKV6enmj3m9mZWTEaype2LrUILV3B7Dha5pAYXAnfYVvZP7714
         nEPV4r3umx6zb2+/Sx6x1MIgfFupgUd+2OQFbMDX1IncsNhv+76+IlFwq7+1ylggI/cU
         zoeg==
X-Gm-Message-State: AOAM53249chf3a+AtV70gAeImh4ZZF/mn9mMs7PUaqn0z/jXPkxxC9aX
        0ld3LpSjEYhz7lx1vEMz3N8/gfBOdKo=
X-Google-Smtp-Source: ABdhPJwOJCoVKNUPS/dWECjmQ1m5ZLe8CfXSzpiPqQdB1xAbjy5S2beojtnUISL61Rims7EqsSsDbw==
X-Received: by 2002:a05:6e02:1c83:: with SMTP id w3mr34743860ill.125.1620881321072;
        Wed, 12 May 2021 21:48:41 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id b10sm729827ioz.35.2021.05.12.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 21:48:40 -0700 (PDT)
Date:   Thu, 13 May 2021 04:48:39 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add lib/percpu* as part of percpu entry
Message-ID: <YJyvp//Yrva+uUqE@google.com>
References: <20210511131737.185726-1-nborisov@suse.com>
 <YJqLNBLRP1+wMSWZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJqLNBLRP1+wMSWZ@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 01:48:36PM +0000, Dennis Zhou wrote:
> Hello,
> 
> On Tue, May 11, 2021 at 04:17:37PM +0300, Nikolay Borisov wrote:
> > Without this patch get_maintainers.pl on a patch which modified
> > lib/percpu_refcount.c produces:
> > 
> > Jens Axboe <axboe@kernel.dk> (commit_signer:2/5=40%)
> > Ming Lei <ming.lei@redhat.com> (commit_signer:2/5=40%,authored:2/5=40%,added_lines:99/114=87%,removed_lines:34/43=79%)
> > "Paul E. McKenney" <paulmck@kernel.org> (commit_signer:1/5=20%,authored:1/5=20%,added_lines:9/114=8%,removed_lines:3/43=7%)
> > Tejun Heo <tj@kernel.org> (commit_signer:1/5=20%)
> > Andrew Morton <akpm@linux-foundation.org> (commit_signer:1/5=20%)
> > Nikolay Borisov <nborisov@suse.com> (authored:1/5=20%,removed_lines:3/43=7%)
> > Joe Perches <joe@perches.com> (authored:1/5=20%,removed_lines:3/43=7%)
> > linux-kernel@vger.kernel.org (open list)
> > 
> > Whereas with the patch applied it now (properly) prints:
> > 
> > Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> > Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> > Christoph Lameter <cl@linux.com> (maintainer:PER-CPU MEMORY ALLOCATOR)
> > linux-kernel@vger.kernel.org (open list)
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d92f85ca831d..b18fed606ddd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14004,6 +14004,7 @@ S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
> >  F:	arch/*/include/asm/percpu.h
> >  F:	include/linux/percpu*.h
> > +F:	lib/percpu*.c
> >  F:	mm/percpu*.c
> >  
> >  PER-TASK DELAY ACCOUNTING
> > -- 
> > 2.25.1
> > 
> 
> Yeah, in the past I've taken percpu_ref stuff, so I think this makes
> sense. If no one has any objections I'll pick this up and your other
> patch.
> 
> Thanks,
> Dennis

I've applied this to for-5.13-fixes. I've also updated the mailing list
to linux-mm.

Thanks,
Dennis
