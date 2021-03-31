Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC540344AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhCVQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCVQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:15:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E988C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:15:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ce10so22218126ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xxz6uPp9nrsVmPP5FVzOOUVKIjtinfu3XiwLbV9sXRM=;
        b=B37auJWa5f+faci9S6CxgjXZvpZEjxvYT2JTO8RfJHXlouFSTNM8wQVZtVLlQKUZPJ
         67mFRHVUtAysINgZAnBMqhoteKeZWzSRhe3E6cBQ/tWMas7iDq3Je7fJolect5YIgqki
         4E73+lh8nNx3aR//zWFLoe/kLHfM78gVK36SPPjk3T/RIgy1AhJb1TmV1usByGNH+QFc
         B4hm6mq/nr0pAMn+LLQ+Z6peI23pmHaYtDecBptYzKMlARHd2/hSrlum8JYwVumLgJGO
         PD2vIOUlBUcW4rPGmnFCM7vRDHdg1N0kxkssVrHlY9pbqQm61L78HhlQErsPmSFdq6Ib
         OjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xxz6uPp9nrsVmPP5FVzOOUVKIjtinfu3XiwLbV9sXRM=;
        b=H08OoXoKjGzMUOm6tNr77c19U3LIsJWMvvRBLc2LZ8LvqsrwUG7uu6BCac5zNJvd7s
         Zug8GfeHdPwSLP99MDqGqlennLqoc3rCh+JcNl+Ep50wSOgC9zp2dPiaKqP7fKJec83T
         emNoJtLC0T98suS8/w6Tw1xneoFBt9FLyOkyqVTb5sy3ZKnnKPvWKBlCwvoj9Isr4wiE
         Gq5W5tWm6KrtAy3eY2odFoQrDqsYJ40J5FRkP6b59ghMVnZfrQ+861HoE3gnMRJY5//r
         5Oqf6soomi6N9sJlTjBGej4QLfY4YmcZmWBl/K5ETBtHiwV9EHRg3ssWz7PDcSVOYnC2
         q5sw==
X-Gm-Message-State: AOAM530j94eukfpmB0XEdE5dDWNhz18/bSzDU/HXJwE1/pjMAwZv1c2+
        b9wBhYg/UuSC20ZFMoo7QWdOpA==
X-Google-Smtp-Source: ABdhPJwIUuFnCxzO5NL76/IDSo47K440UTU8pRwnsw3jZK8/Q+G2x/w+Yrx/VtccsED7kn0PLfGA6A==
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr563337ejb.268.1616429702906;
        Mon, 22 Mar 2021 09:15:02 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id gn3sm9573414ejc.2.2021.03.22.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:15:02 -0700 (PDT)
Date:   Mon, 22 Mar 2021 16:15:00 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] kdb: Simplify kdb commands registration
Message-ID: <20210322161500.ytadytsylt24wf2r@maple.lan>
References: <20210224070827.408771-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224070827.408771-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 12:38:27PM +0530, Sumit Garg wrote:
> Simplify kdb commands registration via using linked list instead of
> static array for commands storage.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Applied, thanks!


> ---
> 
> Changes in v5:
> - Introduce new method: kdb_register_table() to register static kdb
>   main and breakpoint command tables instead of using statically
>   allocated commands.
> 
> Changes in v4:
> - Fix kdb commands memory allocation issue prior to slab being available
>   with an array of statically allocated commands. Now it works fine with
>   kgdbwait.
> - Fix a misc checkpatch warning.
> - I have dropped Doug's review tag as I think this version includes a
>   major fix that should be reviewed again.
> 
> Changes in v3:
> - Remove redundant "if" check.
> - Pick up review tag from Doug.
> 
> Changes in v2:
> - Remove redundant NULL check for "cmd_name".
> - Incorporate misc. comment.
> 
>  kernel/debug/kdb/kdb_bp.c      |  81 ++++--
>  kernel/debug/kdb/kdb_main.c    | 472 ++++++++++++++++++++-------------
>  kernel/debug/kdb/kdb_private.h |   3 +
>  3 files changed, 343 insertions(+), 213 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
> index ec4940146612..c15a1c6abfd6 100644
> --- a/kernel/debug/kdb/kdb_bp.c
> +++ b/kernel/debug/kdb/kdb_bp.c
> @@ -522,6 +522,60 @@ static int kdb_ss(int argc, const char **argv)
>  	return KDB_CMD_SS;
>  }
>  
> +static kdbtab_t bptab[] = {
> +	{	.cmd_name = "bp",
> +		.cmd_func = kdb_bp,
> +		.cmd_usage = "[<vaddr>]",
> +		.cmd_help = "Set/Display breakpoints",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.cmd_name = "bl",
> +		.cmd_func = kdb_bp,
> +		.cmd_usage = "[<vaddr>]",
> +		.cmd_help = "Display breakpoints",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.cmd_name = "bc",
> +		.cmd_func = kdb_bc,
> +		.cmd_usage = "<bpnum>",
> +		.cmd_help = "Clear Breakpoint",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_FLOW_CTRL,
> +	},
> +	{	.cmd_name = "be",
> +		.cmd_func = kdb_bc,
> +		.cmd_usage = "<bpnum>",
> +		.cmd_help = "Enable Breakpoint",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_FLOW_CTRL,
> +	},
> +	{	.cmd_name = "bd",
> +		.cmd_func = kdb_bc,
> +		.cmd_usage = "<bpnum>",
> +		.cmd_help = "Disable Breakpoint",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_FLOW_CTRL,
> +	},
> +	{	.cmd_name = "ss",
> +		.cmd_func = kdb_ss,
> +		.cmd_usage = "",
> +		.cmd_help = "Single Step",
> +		.cmd_minlen = 1,
> +		.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
> +	},
> +};
> +
> +static kdbtab_t bphcmd = {
> +	.cmd_name = "bph",
> +	.cmd_func = kdb_bp,
> +	.cmd_usage = "[<vaddr>]",
> +	.cmd_help = "[datar [length]|dataw [length]]   Set hw brk",
> +	.cmd_minlen = 0,
> +	.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
> +};
> +
>  /* Initialize the breakpoint table and register	breakpoint commands. */
>  
>  void __init kdb_initbptab(void)
> @@ -537,30 +591,7 @@ void __init kdb_initbptab(void)
>  	for (i = 0, bp = kdb_breakpoints; i < KDB_MAXBPT; i++, bp++)
>  		bp->bp_free = 1;
>  
> -	kdb_register_flags("bp", kdb_bp, "[<vaddr>]",
> -		"Set/Display breakpoints", 0,
> -		KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS);
> -	kdb_register_flags("bl", kdb_bp, "[<vaddr>]",
> -		"Display breakpoints", 0,
> -		KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS);
> +	kdb_register_table(bptab, ARRAY_SIZE(bptab));
>  	if (arch_kgdb_ops.flags & KGDB_HW_BREAKPOINT)
> -		kdb_register_flags("bph", kdb_bp, "[<vaddr>]",
> -		"[datar [length]|dataw [length]]   Set hw brk", 0,
> -		KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS);
> -	kdb_register_flags("bc", kdb_bc, "<bpnum>",
> -		"Clear Breakpoint", 0,
> -		KDB_ENABLE_FLOW_CTRL);
> -	kdb_register_flags("be", kdb_bc, "<bpnum>",
> -		"Enable Breakpoint", 0,
> -		KDB_ENABLE_FLOW_CTRL);
> -	kdb_register_flags("bd", kdb_bc, "<bpnum>",
> -		"Disable Breakpoint", 0,
> -		KDB_ENABLE_FLOW_CTRL);
> -
> -	kdb_register_flags("ss", kdb_ss, "",
> -		"Single Step", 1,
> -		KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS);
> -	/*
> -	 * Architecture dependent initialization.
> -	 */
> +		kdb_register_table(&bphcmd, 1);
>  }
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 930ac1b25ec7..1e0c2c37df94 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -33,6 +33,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/kgdb.h>
>  #include <linux/kdb.h>
> +#include <linux/list.h>
>  #include <linux/notifier.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -84,15 +85,8 @@ static unsigned int kdb_continue_catastrophic =
>  static unsigned int kdb_continue_catastrophic;
>  #endif
>  
> -/* kdb_commands describes the available commands. */
> -static kdbtab_t *kdb_commands;
> -#define KDB_BASE_CMD_MAX 50
> -static int kdb_max_commands = KDB_BASE_CMD_MAX;
> -static kdbtab_t kdb_base_commands[KDB_BASE_CMD_MAX];
> -#define for_each_kdbcmd(cmd, num)					\
> -	for ((cmd) = kdb_base_commands, (num) = 0;			\
> -	     num < kdb_max_commands;					\
> -	     num++, num == KDB_BASE_CMD_MAX ? cmd = kdb_commands : cmd++)
> +/* kdb_cmds_head describes the available commands. */
> +static LIST_HEAD(kdb_cmds_head);
>  
>  typedef struct _kdbmsg {
>  	int	km_diag;	/* kdb diagnostic */
> @@ -921,7 +915,7 @@ int kdb_parse(const char *cmdstr)
>  	char *cp;
>  	char *cpp, quoted;
>  	kdbtab_t *tp;
> -	int i, escaped, ignore_errors = 0, check_grep = 0;
> +	int escaped, ignore_errors = 0, check_grep = 0;
>  
>  	/*
>  	 * First tokenize the command string.
> @@ -1011,25 +1005,17 @@ int kdb_parse(const char *cmdstr)
>  		++argv[0];
>  	}
>  
> -	for_each_kdbcmd(tp, i) {
> -		if (tp->cmd_name) {
> -			/*
> -			 * If this command is allowed to be abbreviated,
> -			 * check to see if this is it.
> -			 */
> -
> -			if (tp->cmd_minlen
> -			 && (strlen(argv[0]) <= tp->cmd_minlen)) {
> -				if (strncmp(argv[0],
> -					    tp->cmd_name,
> -					    tp->cmd_minlen) == 0) {
> -					break;
> -				}
> -			}
> +	list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> +		/*
> +		 * If this command is allowed to be abbreviated,
> +		 * check to see if this is it.
> +		 */
> +		if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen) &&
> +		    (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0))
> +			break;
>  
> -			if (strcmp(argv[0], tp->cmd_name) == 0)
> -				break;
> -		}
> +		if (strcmp(argv[0], tp->cmd_name) == 0)
> +			break;
>  	}
>  
>  	/*
> @@ -1037,19 +1023,15 @@ int kdb_parse(const char *cmdstr)
>  	 * few characters of this match any of the known commands.
>  	 * e.g., md1c20 should match md.
>  	 */
> -	if (i == kdb_max_commands) {
> -		for_each_kdbcmd(tp, i) {
> -			if (tp->cmd_name) {
> -				if (strncmp(argv[0],
> -					    tp->cmd_name,
> -					    strlen(tp->cmd_name)) == 0) {
> -					break;
> -				}
> -			}
> +	if (list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
> +		list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> +			if (strncmp(argv[0], tp->cmd_name,
> +				    strlen(tp->cmd_name)) == 0)
> +				break;
>  		}
>  	}
>  
> -	if (i < kdb_max_commands) {
> +	if (!list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
>  		int result;
>  
>  		if (!kdb_check_flags(tp->cmd_flags, kdb_cmd_enabled, argc <= 1))
> @@ -2428,17 +2410,14 @@ static int kdb_kgdb(int argc, const char **argv)
>  static int kdb_help(int argc, const char **argv)
>  {
>  	kdbtab_t *kt;
> -	int i;
>  
>  	kdb_printf("%-15.15s %-20.20s %s\n", "Command", "Usage", "Description");
>  	kdb_printf("-----------------------------"
>  		   "-----------------------------\n");
> -	for_each_kdbcmd(kt, i) {
> +	list_for_each_entry(kt, &kdb_cmds_head, list_node) {
>  		char *space = "";
>  		if (KDB_FLAG(CMD_INTERRUPT))
>  			return 0;
> -		if (!kt->cmd_name)
> -			continue;
>  		if (!kdb_check_flags(kt->cmd_flags, kdb_cmd_enabled, true))
>  			continue;
>  		if (strlen(kt->cmd_usage) > 20)
> @@ -2659,7 +2638,6 @@ static int kdb_grep_help(int argc, const char **argv)
>   * Returns:
>   *	zero for success, one if a duplicate command.
>   */
> -#define kdb_command_extend 50	/* arbitrary */
>  int kdb_register_flags(char *cmd,
>  		       kdb_func_t func,
>  		       char *usage,
> @@ -2667,49 +2645,20 @@ int kdb_register_flags(char *cmd,
>  		       short minlen,
>  		       kdb_cmdflags_t flags)
>  {
> -	int i;
>  	kdbtab_t *kp;
>  
> -	/*
> -	 *  Brute force method to determine duplicates
> -	 */
> -	for_each_kdbcmd(kp, i) {
> -		if (kp->cmd_name && (strcmp(kp->cmd_name, cmd) == 0)) {
> +	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
> +		if (strcmp(kp->cmd_name, cmd) == 0) {
>  			kdb_printf("Duplicate kdb command registered: "
>  				"%s, func %px help %s\n", cmd, func, help);
>  			return 1;
>  		}
>  	}
>  
> -	/*
> -	 * Insert command into first available location in table
> -	 */
> -	for_each_kdbcmd(kp, i) {
> -		if (kp->cmd_name == NULL)
> -			break;
> -	}
> -
> -	if (i >= kdb_max_commands) {
> -		kdbtab_t *new = kmalloc_array(kdb_max_commands -
> -						KDB_BASE_CMD_MAX +
> -						kdb_command_extend,
> -					      sizeof(*new),
> -					      GFP_KDB);
> -		if (!new) {
> -			kdb_printf("Could not allocate new kdb_command "
> -				   "table\n");
> -			return 1;
> -		}
> -		if (kdb_commands) {
> -			memcpy(new, kdb_commands,
> -			  (kdb_max_commands - KDB_BASE_CMD_MAX) * sizeof(*new));
> -			kfree(kdb_commands);
> -		}
> -		memset(new + kdb_max_commands - KDB_BASE_CMD_MAX, 0,
> -		       kdb_command_extend * sizeof(*new));
> -		kdb_commands = new;
> -		kp = kdb_commands + kdb_max_commands - KDB_BASE_CMD_MAX;
> -		kdb_max_commands += kdb_command_extend;
> +	kp = kmalloc(sizeof(*kp), GFP_KDB);
> +	if (!kp) {
> +		kdb_printf("Could not allocate new kdb_command table\n");
> +		return 1;
>  	}
>  
>  	kp->cmd_name   = cmd;
> @@ -2718,11 +2667,27 @@ int kdb_register_flags(char *cmd,
>  	kp->cmd_help   = help;
>  	kp->cmd_minlen = minlen;
>  	kp->cmd_flags  = flags;
> +	kp->is_dynamic = true;
> +
> +	list_add_tail(&kp->list_node, &kdb_cmds_head);
>  
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(kdb_register_flags);
>  
> +/*
> + * kdb_register_table() - This function is used to register a kdb command
> + *                        table.
> + * @kp: pointer to kdb command table
> + * @len: length of kdb command table
> + */
> +void kdb_register_table(kdbtab_t *kp, size_t len)
> +{
> +	while (len--) {
> +		list_add_tail(&kp->list_node, &kdb_cmds_head);
> +		kp++;
> +	}
> +}
>  
>  /*
>   * kdb_register - Compatibility register function for commands that do
> @@ -2757,15 +2722,16 @@ EXPORT_SYMBOL_GPL(kdb_register);
>   */
>  int kdb_unregister(char *cmd)
>  {
> -	int i;
>  	kdbtab_t *kp;
>  
>  	/*
>  	 *  find the command.
>  	 */
> -	for_each_kdbcmd(kp, i) {
> -		if (kp->cmd_name && (strcmp(kp->cmd_name, cmd) == 0)) {
> -			kp->cmd_name = NULL;
> +	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
> +		if (strcmp(kp->cmd_name, cmd) == 0) {
> +			list_del(&kp->list_node);
> +			if (kp->is_dynamic)
> +				kfree(kp);
>  			return 0;
>  		}
>  	}
> @@ -2775,118 +2741,248 @@ int kdb_unregister(char *cmd)
>  }
>  EXPORT_SYMBOL_GPL(kdb_unregister);
>  
> -/* Initialize the kdb command table. */
> -static void __init kdb_inittab(void)
> -{
> -	int i;
> -	kdbtab_t *kp;
> -
> -	for_each_kdbcmd(kp, i)
> -		kp->cmd_name = NULL;
> -
> -	kdb_register_flags("md", kdb_md, "<vaddr>",
> -	  "Display Memory Contents, also mdWcN, e.g. md8c1", 1,
> -	  KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS);
> -	kdb_register_flags("mdr", kdb_md, "<vaddr> <bytes>",
> -	  "Display Raw Memory", 0,
> -	  KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS);
> -	kdb_register_flags("mdp", kdb_md, "<paddr> <bytes>",
> -	  "Display Physical Memory", 0,
> -	  KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS);
> -	kdb_register_flags("mds", kdb_md, "<vaddr>",
> -	  "Display Memory Symbolically", 0,
> -	  KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS);
> -	kdb_register_flags("mm", kdb_mm, "<vaddr> <contents>",
> -	  "Modify Memory Contents", 0,
> -	  KDB_ENABLE_MEM_WRITE | KDB_REPEAT_NO_ARGS);
> -	kdb_register_flags("go", kdb_go, "[<vaddr>]",
> -	  "Continue Execution", 1,
> -	  KDB_ENABLE_REG_WRITE | KDB_ENABLE_ALWAYS_SAFE_NO_ARGS);
> -	kdb_register_flags("rd", kdb_rd, "",
> -	  "Display Registers", 0,
> -	  KDB_ENABLE_REG_READ);
> -	kdb_register_flags("rm", kdb_rm, "<reg> <contents>",
> -	  "Modify Registers", 0,
> -	  KDB_ENABLE_REG_WRITE);
> -	kdb_register_flags("ef", kdb_ef, "<vaddr>",
> -	  "Display exception frame", 0,
> -	  KDB_ENABLE_MEM_READ);
> -	kdb_register_flags("bt", kdb_bt, "[<vaddr>]",
> -	  "Stack traceback", 1,
> -	  KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS);
> -	kdb_register_flags("btp", kdb_bt, "<pid>",
> -	  "Display stack for process <pid>", 0,
> -	  KDB_ENABLE_INSPECT);
> -	kdb_register_flags("bta", kdb_bt, "[D|R|S|T|C|Z|E|U|I|M|A]",
> -	  "Backtrace all processes matching state flag", 0,
> -	  KDB_ENABLE_INSPECT);
> -	kdb_register_flags("btc", kdb_bt, "",
> -	  "Backtrace current process on each cpu", 0,
> -	  KDB_ENABLE_INSPECT);
> -	kdb_register_flags("btt", kdb_bt, "<vaddr>",
> -	  "Backtrace process given its struct task address", 0,
> -	  KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS);
> -	kdb_register_flags("env", kdb_env, "",
> -	  "Show environment variables", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> -	kdb_register_flags("set", kdb_set, "",
> -	  "Set environment variables", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> -	kdb_register_flags("help", kdb_help, "",
> -	  "Display Help Message", 1,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> -	kdb_register_flags("?", kdb_help, "",
> -	  "Display Help Message", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> -	kdb_register_flags("cpu", kdb_cpu, "<cpunum>",
> -	  "Switch to new cpu", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE_NO_ARGS);
> -	kdb_register_flags("kgdb", kdb_kgdb, "",
> -	  "Enter kgdb mode", 0, 0);
> -	kdb_register_flags("ps", kdb_ps, "[<flags>|A]",
> -	  "Display active task list", 0,
> -	  KDB_ENABLE_INSPECT);
> -	kdb_register_flags("pid", kdb_pid, "<pidnum>",
> -	  "Switch to another task", 0,
> -	  KDB_ENABLE_INSPECT);
> -	kdb_register_flags("reboot", kdb_reboot, "",
> -	  "Reboot the machine immediately", 0,
> -	  KDB_ENABLE_REBOOT);
> +static kdbtab_t maintab[] = {
> +	{	.cmd_name = "md",
> +		.cmd_func = kdb_md,
> +		.cmd_usage = "<vaddr>",
> +		.cmd_help = "Display Memory Contents, also mdWcN, e.g. md8c1",
> +		.cmd_minlen = 1,
> +		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.cmd_name = "mdr",
> +		.cmd_func = kdb_md,
> +		.cmd_usage = "<vaddr> <bytes>",
> +		.cmd_help = "Display Raw Memory",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.cmd_name = "mdp",
> +		.cmd_func = kdb_md,
> +		.cmd_usage = "<paddr> <bytes>",
> +		.cmd_help = "Display Physical Memory",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.cmd_name = "mds",
> +		.cmd_func = kdb_md,
> +		.cmd_usage = "<vaddr>",
> +		.cmd_help = "Display Memory Symbolically",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.cmd_name = "mm",
> +		.cmd_func = kdb_mm,
> +		.cmd_usage = "<vaddr> <contents>",
> +		.cmd_help = "Modify Memory Contents",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_MEM_WRITE | KDB_REPEAT_NO_ARGS,
> +	},
> +	{	.cmd_name = "go",
> +		.cmd_func = kdb_go,
> +		.cmd_usage = "[<vaddr>]",
> +		.cmd_help = "Continue Execution",
> +		.cmd_minlen = 1,
> +		.cmd_flags = KDB_ENABLE_REG_WRITE |
> +			     KDB_ENABLE_ALWAYS_SAFE_NO_ARGS,
> +	},
> +	{	.cmd_name = "rd",
> +		.cmd_func = kdb_rd,
> +		.cmd_usage = "",
> +		.cmd_help = "Display Registers",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_REG_READ,
> +	},
> +	{	.cmd_name = "rm",
> +		.cmd_func = kdb_rm,
> +		.cmd_usage = "<reg> <contents>",
> +		.cmd_help = "Modify Registers",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_REG_WRITE,
> +	},
> +	{	.cmd_name = "ef",
> +		.cmd_func = kdb_ef,
> +		.cmd_usage = "<vaddr>",
> +		.cmd_help = "Display exception frame",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_MEM_READ,
> +	},
> +	{	.cmd_name = "bt",
> +		.cmd_func = kdb_bt,
> +		.cmd_usage = "[<vaddr>]",
> +		.cmd_help = "Stack traceback",
> +		.cmd_minlen = 1,
> +		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS,
> +	},
> +	{	.cmd_name = "btp",
> +		.cmd_func = kdb_bt,
> +		.cmd_usage = "<pid>",
> +		.cmd_help = "Display stack for process <pid>",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_INSPECT,
> +	},
> +	{	.cmd_name = "bta",
> +		.cmd_func = kdb_bt,
> +		.cmd_usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
> +		.cmd_help = "Backtrace all processes matching state flag",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_INSPECT,
> +	},
> +	{	.cmd_name = "btc",
> +		.cmd_func = kdb_bt,
> +		.cmd_usage = "",
> +		.cmd_help = "Backtrace current process on each cpu",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_INSPECT,
> +	},
> +	{	.cmd_name = "btt",
> +		.cmd_func = kdb_bt,
> +		.cmd_usage = "<vaddr>",
> +		.cmd_help = "Backtrace process given its struct task address",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS,
> +	},
> +	{	.cmd_name = "env",
> +		.cmd_func = kdb_env,
> +		.cmd_usage = "",
> +		.cmd_help = "Show environment variables",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
> +	{	.cmd_name = "set",
> +		.cmd_func = kdb_set,
> +		.cmd_usage = "",
> +		.cmd_help = "Set environment variables",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
> +	{	.cmd_name = "help",
> +		.cmd_func = kdb_help,
> +		.cmd_usage = "",
> +		.cmd_help = "Display Help Message",
> +		.cmd_minlen = 1,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
> +	{	.cmd_name = "?",
> +		.cmd_func = kdb_help,
> +		.cmd_usage = "",
> +		.cmd_help = "Display Help Message",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
> +	{	.cmd_name = "cpu",
> +		.cmd_func = kdb_cpu,
> +		.cmd_usage = "<cpunum>",
> +		.cmd_help = "Switch to new cpu",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE_NO_ARGS,
> +	},
> +	{	.cmd_name = "kgdb",
> +		.cmd_func = kdb_kgdb,
> +		.cmd_usage = "",
> +		.cmd_help = "Enter kgdb mode",
> +		.cmd_minlen = 0,
> +		.cmd_flags = 0,
> +	},
> +	{	.cmd_name = "ps",
> +		.cmd_func = kdb_ps,
> +		.cmd_usage = "[<flags>|A]",
> +		.cmd_help = "Display active task list",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_INSPECT,
> +	},
> +	{	.cmd_name = "pid",
> +		.cmd_func = kdb_pid,
> +		.cmd_usage = "<pidnum>",
> +		.cmd_help = "Switch to another task",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_INSPECT,
> +	},
> +	{	.cmd_name = "reboot",
> +		.cmd_func = kdb_reboot,
> +		.cmd_usage = "",
> +		.cmd_help = "Reboot the machine immediately",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_REBOOT,
> +	},
>  #if defined(CONFIG_MODULES)
> -	kdb_register_flags("lsmod", kdb_lsmod, "",
> -	  "List loaded kernel modules", 0,
> -	  KDB_ENABLE_INSPECT);
> +	{	.cmd_name = "lsmod",
> +		.cmd_func = kdb_lsmod,
> +		.cmd_usage = "",
> +		.cmd_help = "List loaded kernel modules",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_INSPECT,
> +	},
>  #endif
>  #if defined(CONFIG_MAGIC_SYSRQ)
> -	kdb_register_flags("sr", kdb_sr, "<key>",
> -	  "Magic SysRq key", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> +	{	.cmd_name = "sr",
> +		.cmd_func = kdb_sr,
> +		.cmd_usage = "<key>",
> +		.cmd_help = "Magic SysRq key",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
>  #endif
>  #if defined(CONFIG_PRINTK)
> -	kdb_register_flags("dmesg", kdb_dmesg, "[lines]",
> -	  "Display syslog buffer", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> +	{	.cmd_name = "dmesg",
> +		.cmd_func = kdb_dmesg,
> +		.cmd_usage = "[lines]",
> +		.cmd_help = "Display syslog buffer",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
>  #endif
> -	if (arch_kgdb_ops.enable_nmi) {
> -		kdb_register_flags("disable_nmi", kdb_disable_nmi, "",
> -		  "Disable NMI entry to KDB", 0,
> -		  KDB_ENABLE_ALWAYS_SAFE);
> -	}
> -	kdb_register_flags("defcmd", kdb_defcmd, "name \"usage\" \"help\"",
> -	  "Define a set of commands, down to endefcmd", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> -	kdb_register_flags("kill", kdb_kill, "<-signal> <pid>",
> -	  "Send a signal to a process", 0,
> -	  KDB_ENABLE_SIGNAL);
> -	kdb_register_flags("summary", kdb_summary, "",
> -	  "Summarize the system", 4,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> -	kdb_register_flags("per_cpu", kdb_per_cpu, "<sym> [<bytes>] [<cpu>]",
> -	  "Display per_cpu variables", 3,
> -	  KDB_ENABLE_MEM_READ);
> -	kdb_register_flags("grephelp", kdb_grep_help, "",
> -	  "Display help on | grep", 0,
> -	  KDB_ENABLE_ALWAYS_SAFE);
> +	{	.cmd_name = "defcmd",
> +		.cmd_func = kdb_defcmd,
> +		.cmd_usage = "name \"usage\" \"help\"",
> +		.cmd_help = "Define a set of commands, down to endefcmd",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
> +	{	.cmd_name = "kill",
> +		.cmd_func = kdb_kill,
> +		.cmd_usage = "<-signal> <pid>",
> +		.cmd_help = "Send a signal to a process",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_SIGNAL,
> +	},
> +	{	.cmd_name = "summary",
> +		.cmd_func = kdb_summary,
> +		.cmd_usage = "",
> +		.cmd_help = "Summarize the system",
> +		.cmd_minlen = 4,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
> +	{	.cmd_name = "per_cpu",
> +		.cmd_func = kdb_per_cpu,
> +		.cmd_usage = "<sym> [<bytes>] [<cpu>]",
> +		.cmd_help = "Display per_cpu variables",
> +		.cmd_minlen = 3,
> +		.cmd_flags = KDB_ENABLE_MEM_READ,
> +	},
> +	{	.cmd_name = "grephelp",
> +		.cmd_func = kdb_grep_help,
> +		.cmd_usage = "",
> +		.cmd_help = "Display help on | grep",
> +		.cmd_minlen = 0,
> +		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +	},
> +};
> +
> +static kdbtab_t nmicmd = {
> +	.cmd_name = "disable_nmi",
> +	.cmd_func = kdb_disable_nmi,
> +	.cmd_usage = "",
> +	.cmd_help = "Disable NMI entry to KDB",
> +	.cmd_minlen = 0,
> +	.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
> +};
> +
> +/* Initialize the kdb command table. */
> +static void __init kdb_inittab(void)
> +{
> +	kdb_register_table(maintab, ARRAY_SIZE(maintab));
> +	if (arch_kgdb_ops.enable_nmi)
> +		kdb_register_table(&nmicmd, 1);
>  }
>  
>  /* Execute any commands defined in kdb_cmds.  */
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index a4281fb99299..2d4030fa56cf 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -174,8 +174,11 @@ typedef struct _kdbtab {
>  	short    cmd_minlen;		/* Minimum legal # command
>  					 * chars required */
>  	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
> +	struct list_head list_node;	/* Command list */
> +	bool    is_dynamic;		/* Command table allocation type */
>  } kdbtab_t;
>  
> +extern void kdb_register_table(kdbtab_t *kp, size_t len);
>  extern int kdb_bt(int, const char **);	/* KDB display back trace */
>  
>  /* KDB breakpoint management functions */
> -- 
> 2.25.1
