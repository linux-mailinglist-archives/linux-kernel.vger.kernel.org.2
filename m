Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D574081A6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhILUrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236513AbhILUrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rrAMza/pUnynZmhIDTEN4QNHQg4Z+gAt6lAgc6gAyDI=;
        b=CbH/g4xTBnArbYyCwFGGR5HybztGk9fZ/Zpa4kKF27V8vGNM/KHmuiNk1rrwCndFnlG53s
        ijD7UhpOEaLe07eicWr1hrfjI/x6pc728ecT4iaFVHlczZx65drDRrj18VoH5ZI8RzveC1
        oLI810Tw1egB7muaRcUyA+Rad2y+ksE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-92ORu5tHPlKzxHxfY254-w-1; Sun, 12 Sep 2021 16:46:06 -0400
X-MC-Unique: 92ORu5tHPlKzxHxfY254-w-1
Received: by mail-ed1-f69.google.com with SMTP id ec14-20020a0564020d4e00b003cf5630c190so3892946edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rrAMza/pUnynZmhIDTEN4QNHQg4Z+gAt6lAgc6gAyDI=;
        b=5OQoxoCE6ONE8ZDbFdUc3Eaqt6hAhW2knRt9SS04CE2BM+bbdGGmPjMnKXYpyHx8M5
         ISTLhD0VOG2PO1O6f2IpTQBdbEXNK2+UT7X4shTzxRdRUkDQc+Y3DYoSUV5c/2f2qQSm
         yT7kKZB0jckZ1QGRkGgYQqPIDUm9kWoeHd096Y1fr6KHfAvPNv4tPopbWq3vsq5bQ8I8
         cEMiNjlrkorbpul1xm7FnZDBjWKQIO2KiSD5F6itluVkeO7q6geCR8CYvTofQYjpI/DU
         67hA14OSYAMX1vfznStGO8dTevRcu7BbsnyEE52X0QSjn5L9RE2WNiDjXY9wQ2+1+BoF
         /Wlw==
X-Gm-Message-State: AOAM530/hp3r4d07D7x749Rcb2akv9RUSsx7F4ejcQknOtDOl9Z7zo7C
        ILk4c2zpMuIFjLJBSk/noocnSDeZbRIJxc35TXfIe3GTocox771S3yryzogsf2gIoeCvT4F5rk7
        S64HB3gNjxyGxo9NXDHe4GcBN
X-Received: by 2002:a17:907:7704:: with SMTP id kw4mr9261587ejc.23.1631479565654;
        Sun, 12 Sep 2021 13:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXSB3DdYTE6sKKZ0UqhPTtJ4d12lBwqzOQjSzbYs34K7+jD7eDXHjYzAm3xM6qkVDQxaZKDw==
X-Received: by 2002:a17:907:7704:: with SMTP id kw4mr9261567ejc.23.1631479565436;
        Sun, 12 Sep 2021 13:46:05 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id e22sm2896144edu.35.2021.09.12.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:46:05 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:46:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v11 07/24] perf record: Start threads in the beginning of
 trace streaming
Message-ID: <YT5nC8mD2RVBpj0+@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <0b55237124aee9e348449540691320b66879be6c.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b55237124aee9e348449540691320b66879be6c.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:10AM +0300, Alexey Bayduraev wrote:

SNIP

> +			pollfd->entries[ctlfd_pos].events = 0;
> +		}
> +
> +		pollfd->entries[ctlfd_pos].revents = 0;
> +	}
> +	record__mmap_read_all(thread->rec, true);
> +
> +	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
> +	if (err == -1)
> +		pr_err("threads[%d]: failed to notify on termination: %s",
> +		       thread->tid, strerror(errno));
> +
> +	return NULL;
> +}
> +
>  static void record__init_features(struct record *rec)
>  {
>  	struct perf_session *session = rec->session;
> @@ -1918,13 +1979,59 @@ static int record__terminate_thread(struct record_thread *thread_data)
>  
>  static int record__start_threads(struct record *rec)
>  {
> +	int t, tt, ret = 0, nr_threads = rec->nr_threads;
>  	struct record_thread *thread_data = rec->thread_data;
> +	sigset_t full, mask;
> +	pthread_t handle;
> +	pthread_attr_t attrs;

should we return here in case nr_threads == 1?

jirka

> +
> +	sigfillset(&full);
> +	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
> +		pr_err("Failed to block signals on threads start: %s\n", strerror(errno));
> +		return -1;
> +	}
> +
> +	pthread_attr_init(&attrs);
> +	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> +
> +	for (t = 1; t < nr_threads; t++) {
> +		enum thread_msg msg = THREAD_MSG__UNDEFINED;
> +
> +		pthread_attr_setaffinity_np(&attrs,
> +					    MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
> +					    (cpu_set_t *)(thread_data[t].mask->affinity.bits));
> +
> +		if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
> +			for (tt = 1; tt < t; tt++)
> +				record__terminate_thread(&thread_data[t]);
> +			pr_err("Failed to start threads: %s\n", strerror(errno));
> +			ret = -1;
> +			goto out_err;
> +		}
> +
> +		if (read(thread_data[t].pipes.ack[0], &msg, sizeof(msg)) > 0)
> +			pr_debug2("threads[%d]: sent %s\n", rec->thread_data[t].tid,
> +				 thread_msg_tags[msg]);
> +	}
> +
> +	if (nr_threads > 1) {
> +		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread_data[0].mask->affinity),
> +				  (cpu_set_t *)thread_data[0].mask->affinity.bits);
> +	}
>  
>  	thread = &thread_data[0];
>  
>  	pr_debug("threads[%d]: started on cpu=%d\n", thread->tid, sched_getcpu());
>  
> -	return 0;
> +out_err:
> +	pthread_attr_destroy(&attrs);
> +
> +	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
> +		pr_err("Failed to unblock signals on threads start: %s\n", strerror(errno));
> +		ret = -1;
> +	}
> +
> +	return ret;
>  }
>  
>  static int record__stop_threads(struct record *rec, unsigned long *waking)
> -- 
> 2.19.0
> 

