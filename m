Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC46E39ACB3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFCVYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhFCVYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:24:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B872613FF;
        Thu,  3 Jun 2021 21:22:46 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:22:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 5/9] tracing/trace: Add a generic function to
 read/write u64 values from tracefs
Message-ID: <20210603172244.6d2a6059@gandalf.local.home>
In-Reply-To: <c585e3316f49c9e33acc79452588fc26ce11dfa4.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <c585e3316f49c9e33acc79452588fc26ce11dfa4.1621024265.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 22:51:14 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Provides a generic read and write implementation to save/read u64 values
> from a file on tracefs. The trace_ull_config structure defines where to
> read/write the value, the min and the max acceptable values, and a lock
> to protect the write.

This states what the patch is doing, but does not say why it is doing it.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
> Cc: Clark Willaims <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  kernel/trace/trace.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace.h | 19 ++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 560e4c8d3825..b4cd89010813 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7516,6 +7516,93 @@ static const struct file_operations snapshot_raw_fops = {
>  
>  #endif /* CONFIG_TRACER_SNAPSHOT */
>  
> +/*
> + * trace_ull_config_write - Generic write function to save u64 value


That is a horrible name. What the hell is the "config"?

> + * @filp: The active open file structure
> + * @ubuf: The userspace provided buffer to read value into
> + * @cnt: The maximum number of bytes to read
> + * @ppos: The current "file" position
> + *
> + * This function provides a generic write implementation to save u64 values
> + * from a file on tracefs. The filp->private_data must point to a
> + * trace_ull_config structure that defines where to write the value, the
> + * min and the max acceptable values, and a lock to protect the write.

This doesn't seem to be a generic way to save 64 bit values (which I still
don't understand, because unsigned long long should work too). But it looks
like the rational is for having some kind of generic way to read 64 bit
values giving them a min and a max.

I see this is used later, but this patch needs to be rewritten. It makes no
sense.

-- Steve


> + */
> +static ssize_t
> +trace_ull_config_write(struct file *filp, const char __user *ubuf, size_t cnt,
> +		       loff_t *ppos)
> +{
> +	struct trace_ull_config *config = filp->private_data;
> +	u64 val;
> +	int err;
> +
> +	if (!config)
> +		return -EFAULT;
> +
> +	err = kstrtoull_from_user(ubuf, cnt, 10, &val);
> +	if (err)
> +		return err;
> +
> +	if (config->lock)
> +		mutex_lock(config->lock);
> +
> +	if (config->min && val < *config->min)
> +		err = -EINVAL;
> +
> +	if (config->max && val > *config->max)
> +		err = -EINVAL;
> +
> +	if (!err)
> +		*config->val = val;
> +
> +	if (config->lock)
> +		mutex_unlock(config->lock);
> +
> +	if (err)
> +		return err;
> +
> +	return cnt;
> +}
> +
> +/*
> + * trace_ull_config_read - Generic write function to read u64 value via tracefs
> + * @filp: The active open file structure
> + * @ubuf: The userspace provided buffer to read value into
> + * @cnt: The maximum number of bytes to read
> + * @ppos: The current "file" position
> + *
> + * This function provides a generic read implementation to read a u64 value
> + * from a file on tracefs. The filp->private_data must point to a
> + * trace_ull_config structure with valid data.
> + */
> +static ssize_t
> +trace_ull_config_read(struct file *filp, char __user *ubuf, size_t cnt,
> +		      loff_t *ppos)
> +{
> +	struct trace_ull_config *config = filp->private_data;
> +	char buf[ULL_STR_SIZE];
> +	u64 val;
> +        int len;
> +
> +        if (!config)
> +                return -EFAULT;
> +
> +	val = *config->val;
> +
> +        if (cnt > sizeof(buf))
> +                cnt = sizeof(buf);
> +
> +        len = snprintf(buf, sizeof(buf), "%llu\n", val);
> +
> +        return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
> +}
> +
> +const struct file_operations trace_ull_config_fops = {
> +	.open		= tracing_open_generic,
> +	.read		= trace_ull_config_read,
> +	.write		= trace_ull_config_write,
> +};
> +
>  #define TRACING_LOG_ERRS_MAX	8
>  #define TRACING_LOG_LOC_MAX	128
>  
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index cd80d046c7a5..44fa25c1264a 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1952,4 +1952,23 @@ static inline bool is_good_name(const char *name)
>  	return true;
>  }
>  
> +/*
> + * This is a generic way to read and write a u64 config value from a file
> + * in tracefs.
> + *
> + * The value is stored on the variable pointed by *val. The value needs
> + * to be at least *min and at most *max. The write is protected by an
> + * existing *lock.
> + */
> +struct trace_ull_config {
> +	struct mutex *lock;
> +	u64 *val;
> +	u64 *min;
> +	u64 *max;
> +};
> +
> +#define ULL_STR_SIZE		22	/* 20 digits max */
> +
> +extern const struct file_operations trace_ull_config_fops;
> +
>  #endif /* _LINUX_KERNEL_TRACE_H */

