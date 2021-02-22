Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731643215BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBVMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBVMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:05:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:05:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t15so18734264wrx.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NclULmLY/ftRm92H3Aa3FWcE/hZqu5iWbLssTn3FkoA=;
        b=Mxi8GAeVLdMgsC9DVIgFouM9dRlDPr2Lc87gRAwtz0mdDxEBQDk28Hqc79+yNgzcLI
         qN0kHXS3eoiPXMdvC7qS3QA3OWRdQh/n5T8Aiuw9FU1EwlPHFCpjyz5F4zHqJqdpnwBI
         w/bj4UwDMeq5tDK/0F8BPtu2ZQSjjMalIWXqj5v0zdcFBD74Jnac9Pn7PO7Bu0nsfbG9
         WAq0LyNKZKEuk0psPG6cHNhjINSazC3rQw1IlEOok5G2ydhqdqaGirLbR0r3wZGik5y7
         sBHYCAD0u4T7SnOEDDBAwE5o0CkCRYogd3UiaRfVvl0H/AxbQExVyOLrSp7xT0E/Kxfe
         t5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NclULmLY/ftRm92H3Aa3FWcE/hZqu5iWbLssTn3FkoA=;
        b=D7aDwUJZvJ8YyqeKupLjsgqOxFE9dF84F0HDAD1ixhap2viC5O6+vsl+okuudP5TNv
         JnYoRU/ftrA2YwcO6tefFof1Iuapf6bQTBKZ/efCYFsi0ndeqWqedXnS+OhNuGdj6J39
         DWEIr9k8g1nfasRyAS0/5iRMKl3X8rQzh6sDKNccCxFUFsNjjo9DgfLM8tQBcSZgcLKr
         FxIfPjhMLbuXzvgMsDo8+VsgQifKeMeW00/sJnsFGQ3+EL4wGKmQqmqidXhTLfvX2lN4
         sx3L+D/3Db+ymiwO/BB4cSS2CO0FfmMgnnIl3FManuMUMqMDBEfqwJEykOSf5GW9afFm
         DUlw==
X-Gm-Message-State: AOAM5318PTcM44uzTL2i3WAUVpltma3uHF8p2fsdUsPkX76RSMQEbMSB
        iOOxcvh0ZAsNRVak4v0igby+bcYFFIA8eQSa
X-Google-Smtp-Source: ABdhPJyinf6idJuHpHQ3XoGjWwZ+DUtGuzopkydHKmDOMKc60UZ8KcKO5bfEKRv7UtE2foEWuRH5Ow==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr10044874wrn.18.1613995504528;
        Mon, 22 Feb 2021 04:05:04 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t11sm17539519wmb.32.2021.02.22.04.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:05:03 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:05:02 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kdb: Simplify kdb commands registration
Message-ID: <20210222120502.phazkmskgqvpe4yy@maple.lan>
References: <1613650198-27437-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613650198-27437-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:39:58PM +0530, Sumit Garg wrote:
> Simplify kdb commands registration via using linked list instead of
> static array for commands storage.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> Changes in v4:
> - Fix kdb commands memory allocation issue prior to slab being available
>   with an array of statically allocated commands. Now it works fine with
>   kgdbwait.

I'm not sure this is the right approach. It's still faking dynamic usage
when none of the callers at this stage of the boot actually are dynamic.

Consider instead what would happen if there was a kdb_register_table() that
took a kdbtab_t pointer and an length and enqueued them to the new list.

The effect of this is that most of the existing kdb_register() and
kdb_register_flags() calls would become (self documenting) static
tables instead:

kdb_register_flags("md", kdb_md, "<vaddr>",
	  "Display Memory Contents, also mdWcN, e.g. md8c1", 1,
		  KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS);
...

Effectively becomes:

kdbtab_t maintab[] = {
	{ .cmd_name = "md", 
	  .cmd_func = mdb_md,
	  .cmd_usage = "<vaddr">,
	  .cmd_help = "Display Memory Contents, also mdWcN, e.g. md8c1",
	  .cmd_minlen = 1,
	  .cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
	},
	...
};

kdb_register_table(maintab, ARRAY_SIZE(maintab));

At that point the only users of kdb_register_flags() would be the macro
logic and that already relies on the slabs so it is OK to have dynamic
memory allocation for that.


Daniel.


PS It is also possible to switch the macro logic to simplify the
   allocation by embedded a kdbtab_t into struct defcmd_set. That
   would also even more tidy up of registration code... but that
   could (and should) be in another patch so it doesn't all
   have to land together.


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
>  kernel/debug/kdb/kdb_main.c    | 129 ++++++++++++++---------------------------
>  kernel/debug/kdb/kdb_private.h |   2 +
>  2 files changed, 47 insertions(+), 84 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 930ac1b..5215e04 100644
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
> @@ -84,15 +85,12 @@ static unsigned int kdb_continue_catastrophic =
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
> +
> +#define KDB_CMD_INIT_MAX	50
> +static int kdb_cmd_init_idx;
> +static kdbtab_t kdb_commands_init[KDB_CMD_INIT_MAX];
>  
>  typedef struct _kdbmsg {
>  	int	km_diag;	/* kdb diagnostic */
> @@ -921,7 +919,7 @@ int kdb_parse(const char *cmdstr)
>  	char *cp;
>  	char *cpp, quoted;
>  	kdbtab_t *tp;
> -	int i, escaped, ignore_errors = 0, check_grep = 0;
> +	int escaped, ignore_errors = 0, check_grep = 0;
>  
>  	/*
>  	 * First tokenize the command string.
> @@ -1011,25 +1009,17 @@ int kdb_parse(const char *cmdstr)
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
> @@ -1037,19 +1027,15 @@ int kdb_parse(const char *cmdstr)
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
> @@ -2428,17 +2414,14 @@ static int kdb_kgdb(int argc, const char **argv)
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
> @@ -2667,49 +2650,30 @@ int kdb_register_flags(char *cmd,
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
> +	if (slab_is_available()) {
> +		kp = kmalloc(sizeof(*kp), GFP_KDB);
> +		if (!kp) {
> +			kdb_printf("Could not allocate new kdb_command table\n");
>  			return 1;
>  		}
> -		if (kdb_commands) {
> -			memcpy(new, kdb_commands,
> -			  (kdb_max_commands - KDB_BASE_CMD_MAX) * sizeof(*new));
> -			kfree(kdb_commands);
> +		kp->is_dynamic = true;
> +	} else {
> +		if (kdb_cmd_init_idx >= KDB_CMD_INIT_MAX) {
> +			kdb_printf("Could not allocate init kdb_command table\n");
> +			return 1;
>  		}
> -		memset(new + kdb_max_commands - KDB_BASE_CMD_MAX, 0,
> -		       kdb_command_extend * sizeof(*new));
> -		kdb_commands = new;
> -		kp = kdb_commands + kdb_max_commands - KDB_BASE_CMD_MAX;
> -		kdb_max_commands += kdb_command_extend;
> +		kp = &kdb_commands_init[kdb_cmd_init_idx];
> +		kdb_cmd_init_idx++;
>  	}
>  
>  	kp->cmd_name   = cmd;
> @@ -2719,6 +2683,8 @@ int kdb_register_flags(char *cmd,
>  	kp->cmd_minlen = minlen;
>  	kp->cmd_flags  = flags;
>  
> +	list_add_tail(&kp->list_node, &kdb_cmds_head);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(kdb_register_flags);
> @@ -2757,15 +2723,16 @@ EXPORT_SYMBOL_GPL(kdb_register);
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
> @@ -2778,12 +2745,6 @@ EXPORT_SYMBOL_GPL(kdb_unregister);
>  /* Initialize the kdb command table. */
>  static void __init kdb_inittab(void)
>  {
> -	int i;
> -	kdbtab_t *kp;
> -
> -	for_each_kdbcmd(kp, i)
> -		kp->cmd_name = NULL;
> -
>  	kdb_register_flags("md", kdb_md, "<vaddr>",
>  	  "Display Memory Contents, also mdWcN, e.g. md8c1", 1,
>  	  KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS);
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index a4281fb..f969a6a 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -174,6 +174,8 @@ typedef struct _kdbtab {
>  	short    cmd_minlen;		/* Minimum legal # command
>  					 * chars required */
>  	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
> +	struct list_head list_node;	/* Command list */
> +	bool    is_dynamic;		/* Command table allocation type */
>  } kdbtab_t;
>  
>  extern int kdb_bt(int, const char **);	/* KDB display back trace */
> -- 
> 2.7.4
> 
