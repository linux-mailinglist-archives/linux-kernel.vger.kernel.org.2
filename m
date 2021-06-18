Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC093AD27E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhFRTG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhFRTGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:06:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BBD560FF0;
        Fri, 18 Jun 2021 19:04:44 +0000 (UTC)
Date:   Fri, 18 Jun 2021 15:04:43 -0400
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
Subject: Re: [PATCH V4 12/12] trace/osnoise: Support hotplug operations
Message-ID: <20210618150443.44a49826@oasis.local.home>
In-Reply-To: <ee28d6e8b028a66a1d624895cf0aa04ddd17cb37.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
        <ee28d6e8b028a66a1d624895cf0aa04ddd17cb37.1623746916.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 11:28:51 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> @@ -1566,7 +1627,14 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>  		osnoise_tracer_stop(tr);
>  
>  	mutex_lock(&interface_lock);
> +	/*
> +	 * osnoise_cpumask is ready by CPU hotplug operations.

I don't understand the usage of "ready" above. Lost in translation?

	 * osnoise_cpumask is updated by CPU hotplug operations.

?

-- Steve


> +	 */
> +	get_online_cpus();
> +
>  	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
> +
> +	put_online_cpus();
>  	mutex_unlock(&interface_lock);
>  
