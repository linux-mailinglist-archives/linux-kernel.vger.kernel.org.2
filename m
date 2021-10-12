Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3342A6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhJLOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237060AbhJLON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634047916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsimebWiWHiIoUpKbRqBPY9Rl7kaR7A4B63k1RE+UMA=;
        b=E5b79mUIOOZ76oJRXYAWnHAYsJU7OjQGev5olArwO21XZ/YCmfJ5QHiUCfZF0XS4rgb0lh
        Cpyneqvy/lxT5TFeCFaj3wIhZ94RGnLtDxRjvAlPyin+6A/tiryVstKFTgMPl1+SgGiSbk
        cFprZicKqB+rs8l8Hg51d7fUCe2WOiU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-305ZjSnnMxqwC4MYIEKOBA-1; Tue, 12 Oct 2021 10:11:55 -0400
X-MC-Unique: 305ZjSnnMxqwC4MYIEKOBA-1
Received: by mail-wr1-f69.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so10051773wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OsimebWiWHiIoUpKbRqBPY9Rl7kaR7A4B63k1RE+UMA=;
        b=q46cS72KXq61LJas71F8oZXq9uQHL2tcjiVKwq474QtURFYB2FSsg/0emD6zTW/H9j
         i+IAZoWxSTCmLCzcJCNf/XMY+vAl1aUIMmtvNTk8OyKAaktU0K2XxYN+ofggzV8RpgPX
         24xkWV7W1XrwvuuHUWELmDo/KrSgzMS6TWT/p3SiL4qaXKwaGqiIMjIQzbJULOLLtSUR
         lKBUP3uHQWUdoWRQ4oImLM6pQSX6gqMsAY5adWIAfk6irOWPNV0QNfkblg1slbowvUbo
         4FDto3pu8YtqDQCdFucl/topyMuPOn2UOwzuLaKki15503ozN8zFBkdklc++8o8GqSLt
         qp6g==
X-Gm-Message-State: AOAM530RoVCeMIKRee5N2cvtYljQzQZhXdZnoV9ys466RxMffproGpPG
        rYUw0EfNnwph3g39gQy322wYgBZdXvSCxuJFewndnfGtusj+uSeZ8vaAP/egxghzBFefSWAP6op
        anR7Y6VdS1nxeSomrby4ZbV4X
X-Received: by 2002:a1c:2358:: with SMTP id j85mr5783116wmj.1.1634047914661;
        Tue, 12 Oct 2021 07:11:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvqRQrklWThEKlc50AA6u4uzIfi/vB/pwWCl+oe/S2LBpw2e7bnvnn8I9rpJJ7ta4bF5p5Ng==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr5783090wmj.1.1634047914456;
        Tue, 12 Oct 2021 07:11:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a12.dip0.t-ipconnect.de. [91.12.106.18])
        by smtp.gmail.com with ESMTPSA id a2sm11046607wru.82.2021.10.12.07.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:11:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] pid: add pidfd_get_task() helper
To:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Minchan Kim <minchan@kernel.org>
References: <20211011133245.1703103-1-brauner@kernel.org>
 <20211011133245.1703103-2-brauner@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9eaad83c-d7cb-b3ab-df28-0c6436f156f3@redhat.com>
Date:   Tue, 12 Oct 2021 16:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011133245.1703103-2-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.21 15:32, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> The number of system calls making use of pidfds is constantly
> increasing. Some of those new system calls duplicate the code to turn a
> pidfd into task_struct it refers to. Give them a simple helper for this.
> 
> Link: https://lore.kernel.org/r/20211004125050.1153693-2-christian.brauner@ubuntu.com
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Matthew Bobrowski <repnop@google.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Matthew Bobrowski <repnop@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> - David Hildenbrand <david@redhat.com>:
>    - Also document that the caller is expected to decrease the reference
>      count on the returned task.
> ---
>   include/linux/pid.h |  1 +
>   kernel/pid.c        | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
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
> index efe87db44683..2fc0a16ec77b 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -539,6 +539,42 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
>   	return pid;
>   }
>   
> +/**
> + * pidfd_get_task() - Get the task associated with a pidfd
> + *
> + * @pidfd: pidfd for which to get the task
> + * @flags: flags associated with this pidfd
> + *
> + * Return the task associated with @pidfd. The function takes a reference on
> + * the returned task. The caller is responsible for releasing that reference.
> + *
> + * Currently, the process identified by @pidfd is always a thread-group leader.
> + * This restriction currently exists for all aspects of pidfds including pidfd
> + * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd polling
> + * (only supports thread group leaders).
> + *
> + * Return: On success, the task_struct associated with the pidfd.
> + *	   On error, a negative errno number will be returned.
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

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

