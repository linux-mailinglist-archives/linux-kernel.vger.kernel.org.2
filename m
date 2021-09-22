Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7A4141E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhIVGbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhIVGbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:31:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D64EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:30:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b15so7593932lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YMV0WM2KrQOxLh8C9TQC7GSD4fPut9q6yVFAqEHffJc=;
        b=i98tpsJ6L+LDayrM1mpru6+baaJ4hdgKqQsa3GPV7xDnKcxYlLj4Xejha9nhKEv+qD
         7FVGAy3eLo8iuXCOvcJmO+qoq5FFEjfDwG71FvoLTPCtxVJu/rL2Y0T9V3wHPUb72taS
         XBIDngw2MqmQc0BGT1VlMgWvB6CiEzR5GYtE++a0djJQFYdiTz/n3zoVKSCBUcsJYbrP
         mqC1RFvA07UM+LVfsf5vCyb05XJHIPgA2hlRAc6+IOKgJBl17WTEiqhSu5wgYzAiGb/p
         zVcMNmFNmgNRC2asTZ7h5cNRUL0rrs30vRQAYKoOz1t4grUQT7rGWAxCCjICpNHa02bn
         po3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMV0WM2KrQOxLh8C9TQC7GSD4fPut9q6yVFAqEHffJc=;
        b=XXZV5BfAix8WOasXV9t2Vbfbq4fceJL8QLOCyqugsyH7f+PAS3ulHCrRtJ51goz+Rc
         sH6oOyZIZ6Pc1Ni4y8nO/lMWI/Ck5c8i0VmA3DGuFc8QpPKPmvuMIseaGTkKb1RDvml8
         CGCIjKIwakk2EOeaa/n1WozwwdS0P5x46TRNPN/MtP/eI21zWcRdH00HpwxKiqEW0Oeh
         GHPf2nzlstej0bfB0tkeHNl241tAbjGcH5voPvnwRI+d71eXXooDNnZgXEcxr8Rx+qkZ
         mib/eSqVtd+PcF1xL/rkTjo6Eb8hTyGPbVxJs6G2v+IuF0MvV51yivxqvy6XwZIXAvZ3
         dIHQ==
X-Gm-Message-State: AOAM533rmdL6pRZJ30hAX5zQM6U3VYSRooQo8VqPsQNuLDqgD4CGJ7gr
        ZG42Mv8Rie41M1EJ4sfKWzQ=
X-Google-Smtp-Source: ABdhPJxU/GmtyqQeA7AzCSpw22P8Cj47KumZPWLQAIs/dbI5fkip4tPXizOBMdhpYK1VVJcHRfmagw==
X-Received: by 2002:a05:6512:2307:: with SMTP id o7mr25780370lfu.183.1632292214812;
        Tue, 21 Sep 2021 23:30:14 -0700 (PDT)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id r2sm96887lfm.78.2021.09.21.23.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 23:30:13 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id D5E305A001E; Wed, 22 Sep 2021 09:30:12 +0300 (MSK)
Date:   Wed, 22 Sep 2021 09:30:12 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Balbir Singh <sblbir@amazon.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
Message-ID: <YUrNdPLh+keAKPUy@grain>
References: <20210922061809.736124-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922061809.736124-1-pcc@google.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:18:09PM -0700, Peter Collingbourne wrote:
> This patch introduces a kernel feature known as uaccess logging.
> With uaccess logging, the userspace program passes the address and size
> of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> is a request for the kernel to log any uaccesses made during the next
> syscall to the uaccess buffer. When the next syscall returns, the address
> one past the end of the logged uaccess buffer entries is written to the
> location specified by the third argument to the prctl(). In this way,
> the userspace program may enumerate the uaccesses logged to the access
> buffer to determine which accesses occurred.
...
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e12b524426b0..3fecb0487b97 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -34,6 +34,7 @@
>  #include <linux/rseq.h>
>  #include <linux/seqlock.h>
>  #include <linux/kcsan.h>
> +#include <linux/uaccess_buffer_info.h>
>  #include <asm/kmap_size.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
> @@ -1487,6 +1488,8 @@ struct task_struct {
>  	struct callback_head		l1d_flush_kill;
>  #endif
>  
> +	struct uaccess_buffer_info	uaccess_buffer;
> +

Hi, Peter! I didn't read the patch carefully yet (will do once time permit)
but from a glance should not this member be under #ifdef CONFIG_UACCESS_BUFFER
or something? task_struct is already bloated too much :(

> +	case PR_LOG_UACCESS:
> +		if (arg5)
> +			return -EINVAL;
> +		error = uaccess_buffer_set_logging(arg2, arg3, arg4);
> +		break;

Same here (if only I didn't miss something obvious). If there is no support
for CONFIG_UACCESS_BUFFER we should return an error I guess.
