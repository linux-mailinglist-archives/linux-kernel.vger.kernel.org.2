Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D23452C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKPIKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhKPIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:10:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738AC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u/XuvxSsL02/ksp9AlMhOom/3HnZ4/vMd+hnB5J+MWo=; b=mogVjwudK8w/ux7vAbMeuULvN7
        2daqpLc5ynYkqm6NKJrsMP14IiLq7qTqVUUySuKSXr5HHtKwVwe2SceJGMJBno6AIX+MfG0HfS7Sy
        X0s/SFQodQIr/kkT6BY3pZ4xP7rvnCufdFrN/vE93AdYBN40QywxVsz2jnTQx4pzU+653+LjfDWQL
        ZzufJkDk9XelCEhXiMfBA9GCd4/VeLbdai4XfGKpV4fv3nUmuYOTeCp4YkePHzBlkyo819ZqXzrRR
        8Jbtyp87McNScH7E7n+torVZuj3URjfVGWycl/MSNU5/rab/sW9jJHNmo4tJMHZQN+SXMaNhAW0oJ
        SmeOzz+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmtV4-006ZTU-HZ; Tue, 16 Nov 2021 08:07:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F6A598651D; Tue, 16 Nov 2021 09:07:30 +0100 (CET)
Date:   Tue, 16 Nov 2021 09:07:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init to compile time
Message-ID: <20211116080730.GV174703@worktop.programming.kicks-ass.net>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211116024942.60644-1-yinan@linux.alibaba.com>
 <20211116024942.60644-2-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116024942.60644-2-yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:49:41AM +0800, Yinan Liu wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 30bc880c3849..c776a2956237 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6406,8 +6406,9 @@ static int ftrace_process_locs(struct module *mod,
>  	if (!count)
>  		return 0;
>  
> -	sort(start, count, sizeof(*start),
> -	     ftrace_cmp_ips, NULL);
> +	if (mod)
> +		sort(start, count, sizeof(*start),
> +		     ftrace_cmp_ips, NULL);
>  

/me hands a bucket of {} your way. Also, can't sorttable be ran on
modules ?

> @@ -376,5 +466,20 @@ static int do_sort(Elf_Ehdr *ehdr,
>  		}
>  	}
>  #endif
> +	if (mcount_sort_thread) {
> +		void *retval = NULL;
> +		/* wait for mcount sort done */
> +		rc = pthread_join(mcount_sort_thread, &retval);
> +		if (rc)
> +			fprintf(stderr,
> +				"pthread_join failed '%s': %s\n",
> +				strerror(errno), fname);

Use some here too :-)

> +		else if (retval) {
> +			rc = -1;
> +			fprintf(stderr,
> +				"failed to sort mcount '%s': %s\n",
> +				(char *)retval, fname);
> +		}
> +	}
>  	return rc;
>  }
