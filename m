Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5AB39ACD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFCV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCV25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:28:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157A46120F;
        Thu,  3 Jun 2021 21:27:10 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:27:09 -0400
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
Subject: Re: [PATCH V3 6/9] trace/hwlat: Use the generic function to
 read/write width and window
Message-ID: <20210603172709.25c322a1@gandalf.local.home>
In-Reply-To: <bf0c568ddaf9e75e3d2e77b0ffd5ad1508c47afc.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <bf0c568ddaf9e75e3d2e77b0ffd5ad1508c47afc.1621024265.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 22:51:15 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> @@ -733,16 +624,18 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
>  	return ret;
>  }
>  
> -static const struct file_operations width_fops = {
> -	.open		= tracing_open_generic,
> -	.read		= hwlat_read,
> -	.write		= hwlat_width_write,
> +static struct trace_ull_config hwlat_width = {
> +	.lock		= &hwlat_data.lock,
> +	.val		= &hwlat_data.sample_width,
> +	.max		= &hwlat_data.sample_window,
> +	.min		= NULL,
>  };
>  
> -static const struct file_operations window_fops = {
> -	.open		= tracing_open_generic,
> -	.read		= hwlat_read,
> -	.write		= hwlat_window_write,
> +static struct trace_ull_config hwlat_window = {

Yeah, the naming convention needs to be changed, because ull_config is
meaningless, and this code makes no sense. I know what it is doing, but if
I didn't, I'd have no clue what it was doing by reading it. :-p

-- Steve


> +	.lock		= &hwlat_data.lock,
> +	.val		= &hwlat_data.sample_window,
> +	.max		= NULL,
> +	.min		= &hwlat_data.sample_width,
>  };
>  
>  static const struct file_operations thread_mode_fops = {
> @@ -775,15 +668,15 @@ static int init_tracefs(void)
>  
>  	hwlat_sample_window = tracefs_create_file("window", 0640,
>  						  top_dir,
> -						  &hwlat_data.sample_window,
> -						  &window_fops);
> +						  &hwlat_window,
> +						  &trace_ull_config_fops);
>  	if (!hwlat_sample_window)
>  		goto err;
>  
>  	hwlat_sample_width = tracefs_create_file("width", 0644,
>  						 top_dir,
> -						 &hwlat_data.sample_width,
> -						 &width_fops);
> +						 &hwlat_width,
> +						 &trace_ull_config_fops);
>  	if (!hwlat_sample_width)
>  		goto err;
>  

