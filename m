Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5950737A80E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhEKNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:49:46 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:37641 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhEKNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:49:45 -0400
Received: by mail-il1-f181.google.com with SMTP id j12so17213110ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dBIuGgxpOHh5H6g1Y8ow6Rq8BnvVrWVHf5D1vJH2MIE=;
        b=DZ84NQcscmmIDwcvjTRnBSnvSPr13ag2Gz5D/9sOfI64bZEL4dJcjhHjkKwG4YifTX
         nbcXGXfq90A7853gqrT6NIxBDyf8gRssLhTN4CuVqTaa6nLWAqosJfPY+b41KtnFxOfF
         p52tGQSfFEP73evqZ10zQtDFtvBn4OkCbiapU1YKkGKZLxp0Z7Gu2PV+1Ye/1GStjxES
         dvcOz5hnkE3df85OKiI2W2J9WaCgKf/Z1XiKdEPdy3itWZlHyz0kSnFVxaCxwCAvxhbK
         /U/jZREQgn/wAWmftlzFV7tUryCnvixCgUB1ijtLoN/1q73pN0+OuytL3SBDKYbZkREF
         VvlA==
X-Gm-Message-State: AOAM532zrN+5Dc88p4WeP+IHwxH39D01WO0he7PWOtGKxg+hWUF623j1
        AdS5CLBebc2NL2w+xaJRQD+g4CCUvtM=
X-Google-Smtp-Source: ABdhPJxsJRRVHYUbtLD5mBz1DHZ1HaC2t1XKxLgFibnn573/egetLDuHR7SILNkJiC07l1NCsPhdlA==
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr13051867ilk.105.1620740918040;
        Tue, 11 May 2021 06:48:38 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id x13sm9629935ilq.85.2021.05.11.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 06:48:37 -0700 (PDT)
Date:   Tue, 11 May 2021 13:48:36 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add lib/percpu* as part of percpu entry
Message-ID: <YJqLNBLRP1+wMSWZ@google.com>
References: <20210511131737.185726-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511131737.185726-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 11, 2021 at 04:17:37PM +0300, Nikolay Borisov wrote:
> Without this patch get_maintainers.pl on a patch which modified
> lib/percpu_refcount.c produces:
> 
> Jens Axboe <axboe@kernel.dk> (commit_signer:2/5=40%)
> Ming Lei <ming.lei@redhat.com> (commit_signer:2/5=40%,authored:2/5=40%,added_lines:99/114=87%,removed_lines:34/43=79%)
> "Paul E. McKenney" <paulmck@kernel.org> (commit_signer:1/5=20%,authored:1/5=20%,added_lines:9/114=8%,removed_lines:3/43=7%)
> Tejun Heo <tj@kernel.org> (commit_signer:1/5=20%)
> Andrew Morton <akpm@linux-foundation.org> (commit_signer:1/5=20%)
> Nikolay Borisov <nborisov@suse.com> (authored:1/5=20%,removed_lines:3/43=7%)
> Joe Perches <joe@perches.com> (authored:1/5=20%,removed_lines:3/43=7%)
> linux-kernel@vger.kernel.org (open list)
> 
> Whereas with the patch applied it now (properly) prints:
> 
> Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
> Christoph Lameter <cl@linux.com> (maintainer:PER-CPU MEMORY ALLOCATOR)
> linux-kernel@vger.kernel.org (open list)
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d92f85ca831d..b18fed606ddd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14004,6 +14004,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
>  F:	arch/*/include/asm/percpu.h
>  F:	include/linux/percpu*.h
> +F:	lib/percpu*.c
>  F:	mm/percpu*.c
>  
>  PER-TASK DELAY ACCOUNTING
> -- 
> 2.25.1
> 

Yeah, in the past I've taken percpu_ref stuff, so I think this makes
sense. If no one has any objections I'll pick this up and your other
patch.

Thanks,
Dennis
