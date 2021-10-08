Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638C2426635
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhJHIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhJHItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633682860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WYUCm3uu3x5VEZX6tiSMSzUMl8aPSDJKTcW8O5kKkk=;
        b=LcroS770xHIxfMbs5ldtIDHHdUX+oZwlAXA+0bUOKODj/jW1kQkm0wFcUixjikmb4HTD+m
        5aV5UFhc7G8Pb7YnlZkVjSJ4AOV7k/W6ZUlfQvCRtINsgt/BxfzKXGGQMmxyzfw89j4Ylm
        vDuIjEX7zJe86LYfdLe9nTE7EzCEn48=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-P7qBgBEpOGqIFH8N5tL7xQ-1; Fri, 08 Oct 2021 04:47:39 -0400
X-MC-Unique: P7qBgBEpOGqIFH8N5tL7xQ-1
Received: by mail-wr1-f71.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so3072695wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9WYUCm3uu3x5VEZX6tiSMSzUMl8aPSDJKTcW8O5kKkk=;
        b=x5cZEZMfpZrXaszFsWEbkHxru2faufOyuvopUW9+sOaPoxqLJmiBWLftP2p4c8RA61
         6FmSTOqzfklhMiK5oaF6T3YVsECd5YiiTJZP3DbwQGRO5d9VNEJgmVDG4ghvKEbSItqk
         dff6h7/CliDn/Tc/MsJpZlXTTlTwPokAuOE+0azIKU1XSMO1vHi6NKd8K8zjwuc/Av1g
         vBriIbZoQvPXSwl4k6e0eBikzym0MXxVocjVkXMBNKeH1OR/ZeHocDoyw/dlTG8kEG9w
         iGznAUdBkH1yJd+GGsbWIXtCR16dNvVq3+k+UZoqoCSWiBDdASTFN1VHRyu7r64iXN3d
         XkEA==
X-Gm-Message-State: AOAM530VE0CNsn84Nl6JoYOgq7IrY13J2mLU4nqXHhMTclY2yqjzvXt9
        80fJhTh450dDSEwL5EXUv2xa0Lyjyj9amdll7HdYhgOq6W47C/gyjzUMJom+UGVTB5QFm/aazpQ
        IXkbPHhRwQ/sXc8krvV/4t6zE
X-Received: by 2002:adf:9f05:: with SMTP id l5mr2392656wrf.181.1633682858162;
        Fri, 08 Oct 2021 01:47:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgaKyK69rtKZVDZp9AMMm8t6YHzrkIn4jdU6PRUqG5dwT3K0RrdkSd6xu+7TKAN98/K8kEaQ==
X-Received: by 2002:adf:9f05:: with SMTP id l5mr2392638wrf.181.1633682858006;
        Fri, 08 Oct 2021 01:47:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id p3sm11313861wmp.43.2021.10.08.01.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 01:47:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] pid: add pidfd_get_task() helper
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>
References: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
 <20211004125050.1153693-2-christian.brauner@ubuntu.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <be830537-18e4-d49b-720a-ca40785c4610@redhat.com>
Date:   Fri, 8 Oct 2021 10:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211004125050.1153693-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.21 14:50, Christian Brauner wrote:
> The number of system calls making use of pidfds is constantly
> increasing. Some of those new system calls duplicate the code to turn a
> pidfd into task_struct it refers to. Give them a simple helper for this.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Matthew Bobrowski <repnop@google.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>   include/linux/pid.h |  1 +
>   kernel/pid.c        | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index af308e15f174..343abf22092e 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -78,6 +78,7 @@ struct file;
>   
>   extern struct pid *pidfd_pid(const struct file *file);
>   struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
> +struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
>   int pidfd_create(struct pid *pid, unsigned int flags);
>   
>   static inline struct pid *get_pid(struct pid *pid)
> diff --git a/kernel/pid.c b/kernel/pid.c
> index efe87db44683..2ffbb87b2ce8 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -539,6 +539,40 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
>   	return pid;
>   }
>   
> +/**
> + * pidfd_get_task() - Get the task associated with a pidfd
> + *
> + * @pidfd: pidfd for which to get the task
> + * @flags: flags associated with this pidfd
> + *
> + * Return the task associated with the given pidfd.
> + * Currently, the process identified by @pidfd is always a thread-group leader.
> + * This restriction currently exists for all aspects of pidfds including pidfd
> + * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd polling
> + * (only supports thread group leaders).
> + *
> + * Return: On success, the task_struct associated with the pidfd.
> + *	   On error, a negative errno number will be returned.

Nice doc.

You might want to document what callers of this function are expected to 
do to clean up.


> + */
> +struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
> +{
> +	unsigned int f_flags;
> +	struct pid *pid;
> +	struct task_struct *task;
> +
> +	pid = pidfd_get_pid(pidfd, &f_flags);
> +	if (IS_ERR(pid))
> +		return ERR_CAST(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_TGID);
> +	put_pid(pid);

The code to be replaced always does the put_pid() after the 
put_task_struct(). Is this new ordering safe? (didn't check)

> +	if (!task)
> +		return ERR_PTR(-ESRCH);
> +
> +	*flags = f_flags;
> +	return task;
> +}
> +
>   /**
>    * pidfd_create() - Create a new pid file descriptor.
>    *
> 

I'd have squashed this into the second patch, makes it a lot easier to 
review and it's only a MM cleanup at this point.

-- 
Thanks,

David / dhildenb

