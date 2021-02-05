Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1033116C5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhBEXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:12:52 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36471 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232633AbhBEO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:59 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id ED6AE5802A3;
        Fri,  5 Feb 2021 10:29:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 05 Feb 2021 10:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=OatKMVIe8xDJndXc2ex9/B3AvEw
        68yI8HCk4jB8IlB0=; b=ahlTSSEatCGmkY/XbvVO929BKoGbL5VsemMyau9+Npi
        BlgASFv1aPjTOIO5pBPc/jSgsdPmxPuxLg6MYm8DVRi6ERa7ht7VeWaINxFYlxfU
        R15iVWV1SU2K/PdZ1Jt/Ezx+dBpUqFQNL4EjkXCxwmDDcr7DmLr1exuAR573NK2S
        bYW+DRjBZO8AL7/ts6NPoqUp18NhSQ6OjqZp6LO98XZiheZPjbIjXHyNb0Nou2dX
        aRy4pj5k4IZms6oOexAIjkmEEXX90bZ8T6hZLKT3mGouvFMRrjifcY2M6NRdfcay
        DLVMZIKboTfD4yZWIJyTqlfdh6S/eVM+ocuHLl3Rrfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OatKMV
        Ie8xDJndXc2ex9/B3AvEw68yI8HCk4jB8IlB0=; b=crK/INhwoUiYB0pRU0gvCy
        dLChMVepi0DGGG7S/OMF95Iws0dLWAwp7p+xx7Q4lvSlKsyK8FgAZW694cpHHwtT
        Iky2FB2MgP4zUkxwZwX+HKglgDUHZVi/pco5v5vld4rqzb9IMzJH8U6yr2SVfyJ4
        J7VSAiwDP/6kEbXWrvNvOe08x9fuuOGRlFTKqHAudwjnml6gx5lmMiHokHV5a6r7
        53TaSLRokOwlvQG82fo65bz5F9uRXXDDjF5IdQR/xJYSNwiRn6d6yA4/cYBfUV0V
        jTs9rxKY2qtPN/rsJtAg87jOVFzEn4UtbYEEjEclEOBDpvQg6V/llK21hXGIt8BQ
        ==
X-ME-Sender: <xms:Z2QdYK90xZrQqIVVuGCg2Ym2AMWp07FGX4fpnWQrNfrAKBfE4oL2lw>
    <xme:Z2QdYKsEMuhHds1Vs38WgQ03K30FWsYlsQimlBKKXUJGO49al5anY3x4_hiB3JrGG
    T7Fw90_ffzSPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeeigdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Z2QdYAD3gVxzZ1hc-7vbqte3futuESjK1KTtLtJglnfD6MShnzPbYw>
    <xmx:Z2QdYCeXIyAKyyA_MBtcav7ogMFYxIopGnhHhytV-3SzbDEJ_xdipw>
    <xmx:Z2QdYPMpLA8UXo0cypJRbXYP3LguC9ngF3ZNLpKUmgy34VH6XhjIQw>
    <xmx:a2QdYG4Y9QjEAQbygiul5pOTdEzIq8pDio0gufR97HATO2sWheTDJQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 326F71080063;
        Fri,  5 Feb 2021 10:29:43 -0500 (EST)
Date:   Fri, 5 Feb 2021 16:29:41 +0100
From:   Greg KH <greg@kroah.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        gthelen@google.com, irogers@google.com, jolsa@redhat.com,
        kirill@shutemov.name, mark.rutland@arm.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        sblbir@amazon.com, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v24 07/14] mm/damon: Implement a debugfs-based user space
 interface
Message-ID: <YB1kZaD/7omxXztF@kroah.com>
References: <20210204153150.15948-1-sjpark@amazon.com>
 <20210204153150.15948-8-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204153150.15948-8-sjpark@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:31:43PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> DAMON is designed to be used by kernel space code such as the memory
> management subsystems, and therefore it provides only kernel space API.
> That said, letting the user space control DAMON could provide some
> benefits to them.  For example, it will allow user space to analyze
> their specific workloads and make their own special optimizations.
> 
> For such cases, this commit implements a simple DAMON application kernel
> module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> exports those to the user space via the debugfs.
> 
> 'damon-dbgfs' exports three files, ``attrs``, ``target_ids``, and
> ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
> 
> Attributes
> ----------
> 
> Users can read and write the ``sampling interval``, ``aggregation
> interval``, ``regions update interval``, and min/max number of
> monitoring target regions by reading from and writing to the ``attrs``
> file.  For example, below commands set those values to 5 ms, 100 ms,
> 1,000 ms, 10, 1000 and check it again::
> 
>     # cd <debugfs>/damon
>     # echo 5000 100000 1000000 10 1000 > attrs
>     # cat attrs
>     5000 100000 1000000 10 1000
> 
> Target IDs
> ----------
> 
> Some types of address spaces supports multiple monitoring target.  For
> example, the virtual memory address spaces monitoring can have multiple
> processes as the monitoring targets.  Users can set the targets by
> writing relevant id values of the targets to, and get the ids of the
> current targets by reading from the ``target_ids`` file.  In case of the
> virtual address spaces monitoring, the values should be pids of the
> monitoring target processes.  For example, below commands set processes
> having pids 42 and 4242 as the monitoring targets and check it again::
> 
>     # cd <debugfs>/damon
>     # echo 42 4242 > target_ids
>     # cat target_ids
>     42 4242
> 
> Note that setting the target ids doesn't start the monitoring.
> 
> Turning On/Off
> --------------
> 
> Setting the files as described above doesn't incur effect unless you
> explicitly start the monitoring.  You can start, stop, and check the
> current status of the monitoring by writing to and reading from the
> ``monitor_on`` file.  Writing ``on`` to the file starts the monitoring
> of the targets with the attributes.  Writing ``off`` to the file stops
> those.  DAMON also stops if every targets are invalidated (in case of
> the virtual memory monitoring, target processes are invalidated when
> terminated).  Below example commands turn on, off, and check the status
> of DAMON::
> 
>     # cd <debugfs>/damon
>     # echo on > monitor_on
>     # echo off > monitor_on
>     # cat monitor_on
>     off
> 
> Please note that you cannot write to the above-mentioned debugfs files
> while the monitoring is turned on.  If you write to the files while
> DAMON is running, an error code such as ``-EBUSY`` will be returned.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h |   3 +
>  mm/damon/Kconfig      |   9 +
>  mm/damon/Makefile     |   1 +
>  mm/damon/core.c       |  47 +++++
>  mm/damon/dbgfs.c      | 387 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 447 insertions(+)
>  create mode 100644 mm/damon/dbgfs.c
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 72cf5ebd35fe..b17e808a9cae 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -237,9 +237,12 @@ unsigned int damon_nr_regions(struct damon_target *t);
>  
>  struct damon_ctx *damon_new_ctx(void);
>  void damon_destroy_ctx(struct damon_ctx *ctx);
> +int damon_set_targets(struct damon_ctx *ctx,
> +		unsigned long *ids, ssize_t nr_ids);
>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>  		unsigned long aggr_int, unsigned long primitive_upd_int,
>  		unsigned long min_nr_reg, unsigned long max_nr_reg);
> +int damon_nr_running_ctxs(void);
>  
>  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
>  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 8ae080c52950..72f1683ba0ee 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -21,4 +21,13 @@ config DAMON_VADDR
>  	  This builds the default data access monitoring primitives for DAMON
>  	  that works for virtual address spaces.
>  
> +config DAMON_DBGFS
> +	bool "DAMON debugfs interface"
> +	depends on DAMON_VADDR && DEBUG_FS
> +	help
> +	  This builds the debugfs interface for DAMON.  The user space admins
> +	  can use the interface for arbitrary data access monitoring.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> index 6ebbd08aed67..fed4be3bace3 100644
> --- a/mm/damon/Makefile
> +++ b/mm/damon/Makefile
> @@ -2,3 +2,4 @@
>  
>  obj-$(CONFIG_DAMON)		:= core.o
>  obj-$(CONFIG_DAMON_VADDR)	+= vaddr.o
> +obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 912112662d0c..cad2b4cee39d 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -172,6 +172,39 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
>  	kfree(ctx);
>  }
>  
> +/**
> + * damon_set_targets() - Set monitoring targets.
> + * @ctx:	monitoring context
> + * @ids:	array of target ids
> + * @nr_ids:	number of entries in @ids
> + *
> + * This function should not be called while the kdamond is running.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_set_targets(struct damon_ctx *ctx,
> +		      unsigned long *ids, ssize_t nr_ids)
> +{
> +	ssize_t i;
> +	struct damon_target *t, *next;
> +
> +	damon_destroy_targets(ctx);
> +
> +	for (i = 0; i < nr_ids; i++) {
> +		t = damon_new_target(ids[i]);
> +		if (!t) {
> +			pr_err("Failed to alloc damon_target\n");
> +			/* The caller should do cleanup of the ids itself */
> +			damon_for_each_target_safe(t, next, ctx)
> +				damon_destroy_target(t);
> +			return -ENOMEM;
> +		}
> +		damon_add_target(ctx, t);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * damon_set_attrs() - Set attributes for the monitoring.
>   * @ctx:		monitoring context
> @@ -210,6 +243,20 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>  	return 0;
>  }
>  
> +/**
> + * damon_nr_running_ctxs() - Return number of currently running contexts.
> + */
> +int damon_nr_running_ctxs(void)
> +{
> +	int nr_ctxs;
> +
> +	mutex_lock(&damon_lock);
> +	nr_ctxs = nr_running_ctxs;
> +	mutex_unlock(&damon_lock);
> +
> +	return nr_ctxs;
> +}
> +
>  /* Returns the size upper limit for each monitoring region */
>  static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
>  {
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> new file mode 100644
> index 000000000000..db15380737d1
> --- /dev/null
> +++ b/mm/damon/dbgfs.c
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DAMON Debugfs Interface
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#define pr_fmt(fmt) "damon-dbgfs: " fmt
> +
> +#include <linux/damon.h>
> +#include <linux/debugfs.h>
> +#include <linux/file.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/page_idle.h>
> +#include <linux/slab.h>
> +
> +static struct damon_ctx **dbgfs_ctxs;
> +static int dbgfs_nr_ctxs;
> +static struct dentry **dbgfs_dirs;
> +
> +/*
> + * Returns non-empty string on success, negarive error code otherwise.
> + */
> +static char *user_input_str(const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	char *kbuf;
> +	ssize_t ret;
> +
> +	/* We do not accept continuous write */
> +	if (*ppos)
> +		return ERR_PTR(-EINVAL);
> +
> +	kbuf = kmalloc(count + 1, GFP_KERNEL);
> +	if (!kbuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = simple_write_to_buffer(kbuf, count + 1, ppos, buf, count);
> +	if (ret != count) {
> +		kfree(kbuf);
> +		return ERR_PTR(-EIO);
> +	}
> +	kbuf[ret] = '\0';
> +
> +	return kbuf;
> +}
> +
> +static ssize_t dbgfs_attrs_read(struct file *file,
> +		char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = file->private_data;
> +	char kbuf[128];
> +	int ret;
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	ret = scnprintf(kbuf, ARRAY_SIZE(kbuf), "%lu %lu %lu %lu %lu\n",
> +			ctx->sample_interval, ctx->aggr_interval,
> +			ctx->primitive_update_interval, ctx->min_nr_regions,
> +			ctx->max_nr_regions);
> +	mutex_unlock(&ctx->kdamond_lock);
> +
> +	return simple_read_from_buffer(buf, count, ppos, kbuf, ret);
> +}
> +
> +static ssize_t dbgfs_attrs_write(struct file *file,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = file->private_data;
> +	unsigned long s, a, r, minr, maxr;
> +	char *kbuf;
> +	ssize_t ret = count;
> +	int err;
> +
> +	kbuf = user_input_str(buf, count, ppos);
> +	if (IS_ERR(kbuf))
> +		return PTR_ERR(kbuf);
> +
> +	if (sscanf(kbuf, "%lu %lu %lu %lu %lu",
> +				&s, &a, &r, &minr, &maxr) != 5) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	if (ctx->kdamond) {
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	err = damon_set_attrs(ctx, s, a, r, minr, maxr);
> +	if (err)
> +		ret = err;
> +unlock_out:
> +	mutex_unlock(&ctx->kdamond_lock);
> +out:
> +	kfree(kbuf);
> +	return ret;
> +}
> +
> +#define targetid_is_pid(ctx)	\
> +	(ctx->primitive.target_valid == damon_va_target_valid)
> +
> +static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
> +{
> +	struct damon_target *t;
> +	unsigned long id;
> +	int written = 0;
> +	int rc;
> +
> +	damon_for_each_target(t, ctx) {
> +		id = t->id;
> +		if (targetid_is_pid(ctx))
> +			/* Show pid numbers to debugfs users */
> +			id = (unsigned long)pid_vnr((struct pid *)id);
> +
> +		rc = scnprintf(&buf[written], len - written, "%lu ", id);
> +		if (!rc)
> +			return -ENOMEM;
> +		written += rc;
> +	}
> +	if (written)
> +		written -= 1;
> +	written += scnprintf(&buf[written], len - written, "\n");
> +	return written;
> +}
> +
> +static ssize_t dbgfs_target_ids_read(struct file *file,
> +		char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = file->private_data;
> +	ssize_t len;
> +	char ids_buf[320];
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	len = sprint_target_ids(ctx, ids_buf, 320);
> +	mutex_unlock(&ctx->kdamond_lock);
> +	if (len < 0)
> +		return len;
> +
> +	return simple_read_from_buffer(buf, count, ppos, ids_buf, len);
> +}
> +
> +/*
> + * Converts a string into an array of unsigned long integers
> + *
> + * Returns an array of unsigned long integers if the conversion success, or
> + * NULL otherwise.
> + */
> +static unsigned long *str_to_target_ids(const char *str, ssize_t len,
> +					ssize_t *nr_ids)
> +{
> +	unsigned long *ids;
> +	const int max_nr_ids = 32;
> +	unsigned long id;
> +	int pos = 0, parsed, ret;
> +
> +	*nr_ids = 0;
> +	ids = kmalloc_array(max_nr_ids, sizeof(id), GFP_KERNEL);
> +	if (!ids)
> +		return NULL;
> +	while (*nr_ids < max_nr_ids && pos < len) {
> +		ret = sscanf(&str[pos], "%lu%n", &id, &parsed);
> +		pos += parsed;
> +		if (ret != 1)
> +			break;
> +		ids[*nr_ids] = id;
> +		*nr_ids += 1;
> +	}
> +
> +	return ids;
> +}
> +
> +static void dbgfs_put_pids(unsigned long *ids, int nr_ids)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_ids; i++)
> +		put_pid((struct pid *)ids[i]);
> +}
> +
> +static ssize_t dbgfs_target_ids_write(struct file *file,
> +		const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct damon_ctx *ctx = file->private_data;
> +	char *kbuf, *nrs;
> +	unsigned long *targets;
> +	ssize_t nr_targets;
> +	ssize_t ret = count;
> +	int i;
> +	int err;
> +
> +	kbuf = user_input_str(buf, count, ppos);
> +	if (IS_ERR(kbuf))
> +		return PTR_ERR(kbuf);
> +
> +	nrs = kbuf;
> +
> +	targets = str_to_target_ids(nrs, ret, &nr_targets);
> +	if (!targets) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (targetid_is_pid(ctx)) {
> +		for (i = 0; i < nr_targets; i++) {
> +			targets[i] = (unsigned long)find_get_pid(
> +					(int)targets[i]);
> +			if (!targets[i]) {
> +				dbgfs_put_pids(targets, i);
> +				ret = -EINVAL;
> +				goto free_targets_out;
> +			}
> +		}
> +	}
> +
> +	mutex_lock(&ctx->kdamond_lock);
> +	if (ctx->kdamond) {
> +		if (targetid_is_pid(ctx))
> +			dbgfs_put_pids(targets, nr_targets);
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	err = damon_set_targets(ctx, targets, nr_targets);
> +	if (err) {
> +		if (targetid_is_pid(ctx))
> +			dbgfs_put_pids(targets, nr_targets);
> +		ret = err;
> +	}
> +
> +unlock_out:
> +	mutex_unlock(&ctx->kdamond_lock);
> +free_targets_out:
> +	kfree(targets);
> +out:
> +	kfree(kbuf);
> +	return ret;
> +}
> +
> +static int damon_dbgfs_open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +
> +	return nonseekable_open(inode, file);
> +}
> +
> +static const struct file_operations attrs_fops = {
> +	.owner = THIS_MODULE,
> +	.open = damon_dbgfs_open,
> +	.read = dbgfs_attrs_read,
> +	.write = dbgfs_attrs_write,
> +};
> +
> +static const struct file_operations target_ids_fops = {
> +	.owner = THIS_MODULE,
> +	.open = damon_dbgfs_open,
> +	.read = dbgfs_target_ids_read,
> +	.write = dbgfs_target_ids_write,
> +};
> +
> +static int dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
> +{
> +	const char * const file_names[] = {"attrs", "target_ids"};
> +	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
> +		if (!debugfs_create_file(file_names[i], 0600, dir,
> +					ctx, fops[i])) {
> +			pr_err("failed to create %s file\n", file_names[i]);
> +			return -ENOMEM;

No need to check the return value of this function, just keep going and
ignore it as there's nothing to do and kernel code should not do
different things based on the output of any debugfs calls.

Also, this check is totally wrong and doesn't do what you think it is
doing...

> +static int __init __damon_dbgfs_init(void)
> +{
> +	struct dentry *dbgfs_root;
> +	const char * const file_names[] = {"monitor_on"};
> +	const struct file_operations *fops[] = {&monitor_on_fops};
> +	int i;
> +
> +	dbgfs_root = debugfs_create_dir("damon", NULL);
> +	if (IS_ERR(dbgfs_root)) {
> +		pr_err("failed to create the dbgfs dir\n");
> +		return PTR_ERR(dbgfs_root);

Again, no need to check anything, just pass the result of a debugfs call
back into another one just fine.

> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(file_names); i++) {
> +		if (!debugfs_create_file(file_names[i], 0600, dbgfs_root,
> +					NULL, fops[i])) {

Again, this isn't checking what you think it is, so please don't do it.

thanks,

greg k-h
