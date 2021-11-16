Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC11453843
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhKPRJE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Nov 2021 12:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232680AbhKPRJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:09:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C64C961AA3;
        Tue, 16 Nov 2021 17:06:05 +0000 (UTC)
Date:   Tue, 16 Nov 2021 12:06:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <20211116120603.4e0c04c2@gandalf.local.home>
In-Reply-To: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 10:21:34 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> With this knob you can enable pstore recording early enough to debug
> hangs happening during the boot process before userspace is up enough to
> enable it via sysfs.
> 

Is this still needed? It's still in my internal patchwork, and I haven't
seen any responses.

-- Steve


> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  fs/pstore/ftrace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index 5939595f0115..92d35ee83c95 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -117,13 +117,26 @@ static const struct file_operations pstore_knob_fops = {
>  
>  static struct dentry *pstore_ftrace_dir;
>  
> +static unsigned int record_ftrace_init;
> +module_param(record_ftrace_init, uint, 0400);
> +
>  void pstore_register_ftrace(void)
>  {
> +	int ret;
> +
>  	if (!psinfo->write)
>  		return;
>  
>  	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
>  
> +	if (record_ftrace_init) {
> +		ret = register_ftrace_function(&pstore_ftrace_ops);
> +		if (ret)
> +			return;
> +
> +		pstore_ftrace_enabled = 1;
> +	}
> +
>  	debugfs_create_file("record_ftrace", 0600, pstore_ftrace_dir, NULL,
>  			    &pstore_knob_fops);
>  }

