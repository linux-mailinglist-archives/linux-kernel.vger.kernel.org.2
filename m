Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE03AD0CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbhFRQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhFRQ7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:59:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9AE613D1;
        Fri, 18 Jun 2021 16:56:52 +0000 (UTC)
Date:   Fri, 18 Jun 2021 12:56:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 06/12] trace: Add a generic function to read/write
 u64 values from tracefs
Message-ID: <20210618125651.7de04840@oasis.local.home>
In-Reply-To: <681a2fb508b3dad2979ac705c3df633f14abb9b2.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
        <681a2fb508b3dad2979ac705c3df633f14abb9b2.1623746916.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 11:28:45 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> +static ssize_t
> +trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt,
> +		      loff_t *ppos)
> +{
> +	struct trace_min_max_param *param = filp->private_data;
> +	char buf[ULL_STR_SIZE];
> +	u64 val;
> +        int len;

White space issue above?

> +
> +        if (!param)
> +                return -EFAULT;

And above here too?


> +
> +	val = *param->val;
> +
> +        if (cnt > sizeof(buf))
> +                cnt = sizeof(buf);
> +
> +        len = snprintf(buf, sizeof(buf), "%llu\n", val);
> +
> +        return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);

Egad, this entire patch is filled with whitespace issues!

Please check your other patches too.

> +}
> +


> +
> +#define ULL_STR_SIZE		22	/* 20 digits max */

Nit. I'd make this 24, just to be integer aligned. I mean, it's used as:


trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt,
		      loff_t *ppos)
{
	struct trace_min_max_param *param = filp->private_data;
	char buf[ULL_STR_SIZE];
	u64 val;
	int len;

Probably should reverse the above as well, that way if you do have
ULL_STR_SIZE as 24, then the int len, will fit right in before the u64
val. Although, I think compilers are free to optimize that too :-/

-- Steve
