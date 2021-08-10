Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB83E505D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 02:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhHJAeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 20:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhHJAeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 20:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D3A56101D;
        Tue, 10 Aug 2021 00:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628555633;
        bh=jMEmG3INE/AjMkr/7WaIZLvElv0uCMZQFkHwYgy0C3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/z8RP5UQC3gb6EadO7hMtNJfspeAATyEkQlrbJ89utpwLojzq1gqXPwdimBrBKlN
         cjFkXsypCYhk/hYavr3NmptdbU0W9H+UqTYnBpB7+KA3kAL4TWIMuourzOiG7wE1Ch
         aZMFU3if5SdSBfWFbtYZd+k68hLQcTkBiCeBUM+i5rPna3ljLu7qRjPqsP9cesPEVT
         vqMVLmff3zgmSdIhkKlhRPo4DTYkSZ0eM0ssVBu2P3289PircmF8qahbrtN2OFkczM
         IK+6bnHA6B14sGvfatM/gccuBaYA1Yq78CHoryQlhDZjf/AbkrgYWW+OmAoU4xbGsl
         OdGQ+G/yc9JDw==
Date:   Tue, 10 Aug 2021 09:33:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 02/10] tracing/boot: Add per-event histogram action
 options
Message-Id: <20210810093350.21d0d65c283c4b3fc9570d93@kernel.org>
In-Reply-To: <162852408422.143877.5430352080751791322.stgit@devnote2>
References: <162852406891.143877.12110677006587392853.stgit@devnote2>
        <162852408422.143877.5430352080751791322.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 00:48:04 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a hist-trigger action syntax support to boot-time tracing.
> Currently, boot-time tracing supports per-event actions as option
> strings. However, for the histogram action, it has a special syntax
> and usually needs a long action definition.
> To make it readable and fit to the bootconfig syntax, this introduces
> a new options for histogram.
> 
> Here are the histogram action options for boot-time tracing.
> 
> ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
>      keys = <KEY>[,...]
>      values = <VAL>[,...]
>      sort = <SORT-KEY>[,...]
>      size = <ENTRIES>
>      name = <HISTNAME>
>      var { <VAR> = <EXPR> ... }
>      pause|continue|clear
>      onmax|onchange { var = <VAR>; <ACTION> [= <PARAM>] }
>      onmatch { event = <EVENT>; <ACTION> [= <PARAM>] }
>      filter = <FILTER>
> }
> 
> Where <ACTION> is one of below;
> 
>      trace = <EVENT>, <ARG1>[, ...]
>      save = <ARG1>[, ...]
>      snapshot
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v3:
>    - Allow var expression includes spaces, since it is natural that
>      user write an expression with space in bootconfig.
>      (e.g. "var.lat = common_timestamp.usecs - $ts0")
>  Changes in v2:
>    - Cleanup code to add ':' as a prefix for each element
>      instead of fixup the last ':'.
>    - Fix syntax typo for handler actions.
>    - Make pause|continue|clear mutual exclusive.
>    - Add __printf() attribute to the append_printf().
> ---
>  kernel/trace/trace_boot.c |  231 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index d713714cba67..763f8a7b7e1b 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -171,6 +171,231 @@ trace_boot_add_synth_event(struct xbc_node *node, const char *event)
>  }
>  #endif
>  
> +#ifdef CONFIG_HIST_TRIGGERS
> +static int __init __printf(3, 4)
> +append_printf(char **bufp, char *end, const char *fmt, ...)
> +{
> +	va_list args;
> +	int ret;
> +
> +	if (*bufp == end)
> +		return -ENOSPC;
> +
> +	va_start(args, fmt);
> +	ret = vsnprintf(*bufp, end - *bufp, fmt, args);
> +	if (ret < end - *bufp) {
> +		*bufp += ret;
> +	} else {
> +		*bufp = end;
> +		ret = -ERANGE;
> +	}
> +	va_end(args);
> +
> +	return ret;
> +}
> +
> +static int __init
> +append_str_nospace(char **bufp, char *end, char *str)

Kbuild bot reported that I missed 'const' for the @str. Indeed, it's correct.

Let me update the series.

Thank you,

> +{
> +	char *p = *bufp;
> +	int len;
> +
> +	while (p < end - 1 && *str != '\0') {
> +		if (!isspace(*str))
> +			*(p++) = *str;
> +		str++;
> +	}
> +	*p = '\0';
> +	if (p == end - 1) {
> +		*bufp = end;
> +		return -ENOSPC;
> +	}
> +	len = p - *bufp;
> +	*bufp = p;
> +	return (int)len;
> +}
> +
> +static int __init
> +trace_boot_hist_add_array(struct xbc_node *hnode, char **bufp,
> +			  char *end, const char *key)
> +{
> +	struct xbc_node *knode, *anode;
> +	const char *p;
> +	char sep;
> +
> +	knode = xbc_node_find_child(hnode, key);
> +	if (knode) {
> +		anode = xbc_node_get_child(knode);
> +		if (!anode) {
> +			pr_err("hist.%s requires value(s).\n", key);
> +			return -EINVAL;
> +		}
> +
> +		append_printf(bufp, end, ":%s", key);
> +		sep = '=';
> +		xbc_array_for_each_value(anode, p) {
> +			append_printf(bufp, end, "%c%s", sep, p);
> +			if (sep == '=')
> +				sep = ',';
> +		}
> +	} else
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
> +static int __init
> +trace_boot_hist_add_handler(struct xbc_node *hnode, char **bufp,
> +			    char *end, const char *param)
> +{
> +	struct xbc_node *knode, *anode;
> +	const char *p;
> +	char sep;
> +
> +	/* Compose 'handler' parameter */
> +	p = xbc_node_find_value(hnode, param, NULL);
> +	if (!p) {
> +		pr_err("hist.%s requires '%s' option.\n",
> +		       xbc_node_get_data(hnode), param);
> +		return -EINVAL;
> +	}
> +	append_printf(bufp, end, ":%s(%s)", xbc_node_get_data(hnode), p);
> +
> +	/* Compose 'action' parameter */
> +	knode = xbc_node_find_child(hnode, "trace");
> +	if (!knode)
> +		knode = xbc_node_find_child(hnode, "save");
> +
> +	if (knode) {
> +		anode = xbc_node_get_child(knode);
> +		if (!anode || !xbc_node_is_value(anode)) {
> +			pr_err("hist.%s.%s requires value(s).\n",
> +			       xbc_node_get_data(hnode),
> +			       xbc_node_get_data(knode));
> +			return -EINVAL;
> +		}
> +
> +		append_printf(bufp, end, ".%s", xbc_node_get_data(knode));
> +		sep = '(';
> +		xbc_array_for_each_value(anode, p) {
> +			append_printf(bufp, end, "%c%s", sep, p);
> +			if (sep == '(')
> +				sep = ',';
> +		}
> +		append_printf(bufp, end, ")");
> +	} else if (xbc_node_find_child(hnode, "snapshot")) {
> +		append_printf(bufp, end, ".snapshot()");
> +	} else {
> +		pr_err("hist.%s requires an action.\n",
> +		       xbc_node_get_data(hnode));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Histogram boottime tracing syntax.
> + *
> + * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
> + *	keys = <KEY>[,...]
> + *	values = <VAL>[,...]
> + *	sort = <SORT-KEY>[,...]
> + *	size = <ENTRIES>
> + *	name = <HISTNAME>
> + *	var { <VAR> = <EXPR> ... }
> + *	pause|continue|clear
> + *	onmax|onchange { var = <VAR>; <ACTION> [= <PARAM>] }
> + *	onmatch { event = <EVENT>; <ACTION> [= <PARAM>] }
> + *	filter = <FILTER>
> + * }
> + *
> + * Where <ACTION> are;
> + *
> + *	trace = <EVENT>, <ARG1>[, ...]
> + *	save = <ARG1>[, ...]
> + *	snapshot
> + */
> +static int __init
> +trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
> +{
> +	struct xbc_node *node, *knode;
> +	char *end = buf + size;
> +	const char *p;
> +	int ret = 0;
> +
> +	append_printf(&buf, end, "hist");
> +
> +	ret = trace_boot_hist_add_array(hnode, &buf, end, "keys");
> +	if (ret < 0) {
> +		if (ret == -ENOENT)
> +			pr_err("hist requires keys.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = trace_boot_hist_add_array(hnode, &buf, end, "values");
> +	if (ret == -EINVAL)
> +		return ret;
> +	ret = trace_boot_hist_add_array(hnode, &buf, end, "sort");
> +	if (ret == -EINVAL)
> +		return ret;
> +
> +	p = xbc_node_find_value(hnode, "size", NULL);
> +	if (p)
> +		append_printf(&buf, end, ":size=%s", p);
> +
> +	p = xbc_node_find_value(hnode, "name", NULL);
> +	if (p)
> +		append_printf(&buf, end, ":name=%s", p);
> +
> +	node = xbc_node_find_child(hnode, "var");
> +	if (node) {
> +		xbc_node_for_each_key_value(node, knode, p) {
> +			/* Expression must not include spaces. */
> +			append_printf(&buf, end, ":%s=",
> +				      xbc_node_get_data(knode));
> +			append_str_nospace(&buf, end, p);
> +		}
> +	}
> +
> +	/* Histogram control attributes (mutual exclusive) */
> +	if (xbc_node_find_child(hnode, "pause"))
> +		append_printf(&buf, end, ":pause");
> +	else if (xbc_node_find_child(hnode, "continue"))
> +		append_printf(&buf, end, ":continue");
> +	else if (xbc_node_find_child(hnode, "clear"))
> +		append_printf(&buf, end, ":clear");
> +
> +	/* Histogram handler and actions */
> +	node = xbc_node_find_child(hnode, "onmax");
> +	if (node && trace_boot_hist_add_handler(node, &buf, end, "var") < 0)
> +		return -EINVAL;
> +	node = xbc_node_find_child(hnode, "onchange");
> +	if (node && trace_boot_hist_add_handler(node, &buf, end, "var") < 0)
> +		return -EINVAL;
> +	node = xbc_node_find_child(hnode, "onmatch");
> +	if (node && trace_boot_hist_add_handler(node, &buf, end, "event") < 0)
> +		return -EINVAL;
> +
> +	p = xbc_node_find_value(hnode, "filter", NULL);
> +	if (p)
> +		append_printf(&buf, end, " if %s", p);
> +
> +	if (buf == end) {
> +		pr_err("hist exceeds the max command length.\n");
> +		return -E2BIG;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int __init
> +trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  static void __init
>  trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  			  struct xbc_node *enode)
> @@ -212,6 +437,12 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  			else if (trigger_process_regex(file, buf) < 0)
>  				pr_err("Failed to apply an action: %s\n", buf);
>  		}
> +		anode = xbc_node_find_child(enode, "hist");
> +		if (anode &&
> +		    trace_boot_compose_hist_cmd(anode, buf, ARRAY_SIZE(buf)) == 0) {
> +			if (trigger_process_regex(file, buf) < 0)
> +				pr_err("Failed to apply hist trigger: %s\n", buf);
> +		}
>  	} else if (xbc_node_find_value(enode, "actions", NULL))
>  		pr_err("Failed to apply event actions because CONFIG_HIST_TRIGGERS is not set.\n");
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
