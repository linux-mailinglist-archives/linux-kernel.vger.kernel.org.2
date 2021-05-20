Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C593038B51A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhETRWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhETRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:22:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61966C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:21:14 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f18so16953662qko.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/HTClkKdhjlqKmOxijrTQo2SPYYOskb+LliCI/kUOU=;
        b=U7BodbQ1ZJ1F+VCcVaZf4RgjFu9RbOHIYXnQnmN15bX3gdlhK71Vp0gcxwlWBLlnVi
         /tLO75nHX3CXv7UtfajO4yAK/CHmrlPz+U4SMlfP2Hb8uzmuljiz9HJfxthztBifZNe9
         mp6UABYPiJbnskRM0vuRwIC170KCHNNKCb60k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/HTClkKdhjlqKmOxijrTQo2SPYYOskb+LliCI/kUOU=;
        b=e/F9pNdyhvZfw5TKGlnvRFdPFQbbzs2CpqwHeT38p/BJ+zys47HDNhQYwTQjRjlhER
         ZYGLbwMu+VNPXF98NF5RTyX3jJbLKnGYe9WdTg83M5Mp69qC9zLOkE6kBKWbomqfNx3f
         D0T7NIh+Oy51KQ+OhwchO37XPG9DoL7zpbIceivUTqK9NKIqgRtxGdzBREzgprfLhM7E
         1KHeVyPAC1y34Y86r26ci7boiDBZuSKrJ0mVQiXYlLrQCHyVXMFjp4jhIGzn9wlKYNYo
         r/lqIuWclkHOk5ackV5linp6qjkbYDQI2JNSsp7IxjLqZhPimm2yqa2PUyBpYQWeTI1G
         6bhg==
X-Gm-Message-State: AOAM531kFFP1eNMymF/g0vRXANL4SUQL0NA/RKAUF8/jFvUfzRHD0csn
        MOlccNHIzN+/zFBEd3LlZU34VrcXGz385Q==
X-Google-Smtp-Source: ABdhPJybNc9RlFFN9yL4kHoJXWW/A4WTFNddxz9GWmuO96CXrrgu7UAVK5FQoqJlj4BPLd7CCgvYUA==
X-Received: by 2002:a05:620a:a4c:: with SMTP id j12mr4137468qka.33.1621531272708;
        Thu, 20 May 2021 10:21:12 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id n19sm2243464qtp.65.2021.05.20.10.21.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 10:21:11 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id g38so23794427ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:21:11 -0700 (PDT)
X-Received: by 2002:a25:4252:: with SMTP id p79mr8740024yba.276.1621531270600;
 Thu, 20 May 2021 10:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210513112842.707103-1-sumit.garg@linaro.org> <20210513112842.707103-2-sumit.garg@linaro.org>
In-Reply-To: <20210513112842.707103-2-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 May 2021 10:20:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkQoUFzYa3OKPSwQo51V09-EXTdp=GNo=H+ZMcjX-ovw@mail.gmail.com>
Message-ID: <CAD=FV=UkQoUFzYa3OKPSwQo51V09-EXTdp=GNo=H+ZMcjX-ovw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kdb: Get rid of redundant kdb_register_flags()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 13, 2021 at 4:29 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Commit e4f291b3f7bb ("kdb: Simplify kdb commands registration")
> allowed registration of pre-allocated kdb commands with pointer to
> struct kdbtab_t. Lets switch other users as well to register pre-
> allocated kdb commands via:
> - Changing prototype for kdb_register() to pass a pointer to struct
>   kdbtab_t instead.
> - Embed kdbtab_t structure in defcmd_set rather than individual params.
>   So while at it rename struct defcmd_set to struct kdb_macro_t as that
>   sounds more appropriate given its purpose.
>
> With these changes kdb_register_flags() becomes redundant and hence
> removed. Also, since we have switched all users to register
> pre-allocated commands, "is_dynamic" flag in struct kdbtab_t becomes
> redundant and hence removed as well.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/linux/kdb.h            |  27 +++--
>  kernel/debug/kdb/kdb_main.c    | 206 +++++++++++----------------------
>  kernel/debug/kdb/kdb_private.h |  13 ---
>  kernel/trace/trace_kdb.c       |  12 +-
>  samples/kdb/kdb_hello.c        |  20 ++--
>  5 files changed, 104 insertions(+), 174 deletions(-)
>
> diff --git a/include/linux/kdb.h b/include/linux/kdb.h
> index 0125a677b67f..9e893279b2ea 100644
> --- a/include/linux/kdb.h
> +++ b/include/linux/kdb.h
> @@ -13,6 +13,8 @@
>   * Copyright (C) 2009 Jason Wessel <jason.wessel@windriver.com>
>   */
>
> +#include <linux/list.h>
> +
>  /* Shifted versions of the command enable bits are be used if the command
>   * has no arguments (see kdb_check_flags). This allows commands, such as
>   * go, to have different permissions depending upon whether it is called
> @@ -64,6 +66,17 @@ typedef enum {
>
>  typedef int (*kdb_func_t)(int, const char **);
>
> +/* The KDB shell command table */
> +typedef struct _kdbtab {
> +       char    *cmd_name;              /* Command name */
> +       kdb_func_t cmd_func;            /* Function to execute command */
> +       char    *cmd_usage;             /* Usage String for this command */
> +       char    *cmd_help;              /* Help message for this command */
> +       short    cmd_minlen;            /* Minimum legal # cmd chars required */
> +       kdb_cmdflags_t cmd_flags;       /* Command behaviour flags */
> +       struct list_head list_node;     /* Command list */
> +} kdbtab_t;

IMO prefixing all of the members of the structure with "cmd_" just
makes the code that references them more awkward. For instance, when I
read:

s->cmd.cmd_name

I wonder why it can't just be:

s->cmd.name


> +
>  #ifdef CONFIG_KGDB_KDB
>  #include <linux/init.h>
>  #include <linux/sched.h>
> @@ -193,19 +206,13 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
>  #endif /* ! CONFIG_KALLSYMS */
>
>  /* Dynamic kdb shell command registration */
> -extern int kdb_register(char *, kdb_func_t, char *, char *, short);
> -extern int kdb_register_flags(char *, kdb_func_t, char *, char *,
> -                             short, kdb_cmdflags_t);
> -extern int kdb_unregister(char *);
> +extern int kdb_register(kdbtab_t *cmd);
> +extern int kdb_unregister(kdbtab_t *cmd);

I suggest changing kdb_unregister() to return "void". It can no longer
fail and generally we can't really do anything if unregister calls
fail anyway.


>  #else /* ! CONFIG_KGDB_KDB */
>  static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
>  static inline void kdb_init(int level) {}
> -static inline int kdb_register(char *cmd, kdb_func_t func, char *usage,
> -                              char *help, short minlen) { return 0; }
> -static inline int kdb_register_flags(char *cmd, kdb_func_t func, char *usage,
> -                                    char *help, short minlen,
> -                                    kdb_cmdflags_t flags) { return 0; }
> -static inline int kdb_unregister(char *cmd) { return 0; }
> +static inline int kdb_register(kdbtab_t *cmd) { return 0; }
> +static inline int kdb_unregister(kdbtab_t *cmd) { return 0; }
>  #endif /* CONFIG_KGDB_KDB */
>  enum {
>         KDB_NOT_INITIALIZED,
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 1baa96a2ecb8..de685b2a8ce7 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -33,7 +33,6 @@
>  #include <linux/kallsyms.h>
>  #include <linux/kgdb.h>
>  #include <linux/kdb.h>
> -#include <linux/list.h>
>  #include <linux/notifier.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -654,16 +653,14 @@ static void kdb_cmderror(int diag)
>   * Returns:
>   *     zero for success, a kdb diagnostic if error
>   */
> -struct defcmd_set {
> +struct kdb_macro_t {
>         int count;
>         bool usable;
> -       char *name;
> -       char *usage;
> -       char *help;
> +       kdbtab_t cmd;
>         char **command;
>  };
> -static struct defcmd_set *defcmd_set;
> -static int defcmd_set_count;
> +static struct kdb_macro_t *kdb_macro;
> +static int kdb_macro_count;

It would have made my review job easier if the rename from
"defcmd_set" to "kdb_macro" was in a separate no-op change...


>  static bool defcmd_in_progress;
>
>  /* Forward references */
> @@ -671,20 +668,14 @@ static int kdb_exec_defcmd(int argc, const char **argv);
>
>  static int kdb_defcmd2(const char *cmdstr, const char *argv0)
>  {
> -       struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
> +       struct kdb_macro_t *s = kdb_macro + kdb_macro_count - 1;
>         char **save_command = s->command;
>         if (strcmp(argv0, "endefcmd") == 0) {
>                 defcmd_in_progress = false;
>                 if (!s->count)
>                         s->usable = false;
>                 if (s->usable)
> -                       /* macros are always safe because when executed each
> -                        * internal command re-enters kdb_parse() and is
> -                        * safety checked individually.
> -                        */

You dropped this comment. Should it instead move into kdb_defcmd()
where you set the KDB_ENABLE_ALWAYS_SAFE flag?


> -                       kdb_register_flags(s->name, kdb_exec_defcmd, s->usage,
> -                                          s->help, 0,
> -                                          KDB_ENABLE_ALWAYS_SAFE);
> +                       kdb_register(&s->cmd);
>                 return 0;
>         }
>         if (!s->usable)
> @@ -704,7 +695,9 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
>
>  static int kdb_defcmd(int argc, const char **argv)
>  {
> -       struct defcmd_set *save_defcmd_set = defcmd_set, *s;
> +       struct kdb_macro_t *save_kdb_macro = kdb_macro, *s;
> +       kdbtab_t *mp;
> +
>         if (defcmd_in_progress) {
>                 kdb_printf("kdb: nested defcmd detected, assuming missing "
>                            "endefcmd\n");
> @@ -712,9 +705,9 @@ static int kdb_defcmd(int argc, const char **argv)
>         }
>         if (argc == 0) {
>                 int i;
> -               for (s = defcmd_set; s < defcmd_set + defcmd_set_count; ++s) {
> -                       kdb_printf("defcmd %s \"%s\" \"%s\"\n", s->name,
> -                                  s->usage, s->help);
> +               for (s = kdb_macro; s < kdb_macro + kdb_macro_count; ++s) {
> +                       kdb_printf("defcmd %s \"%s\" \"%s\"\n", s->cmd.cmd_name,
> +                                  s->cmd.cmd_usage, s->cmd.cmd_help);
>                         for (i = 0; i < s->count; ++i)
>                                 kdb_printf("%s", s->command[i]);
>                         kdb_printf("endefcmd\n");
> @@ -727,45 +720,50 @@ static int kdb_defcmd(int argc, const char **argv)
>                 kdb_printf("Command only available during kdb_init()\n");
>                 return KDB_NOTIMP;
>         }
> -       defcmd_set = kmalloc_array(defcmd_set_count + 1, sizeof(*defcmd_set),
> +       kdb_macro = kmalloc_array(kdb_macro_count + 1, sizeof(*kdb_macro),
>                                    GFP_KDB);

Looking at the code that follows makes me think we should have been
using krealloc_array(), but I guess we don't need to bother since the
next patch changes all of it. ;-)


> -       if (!defcmd_set)
> +       if (!kdb_macro)
>                 goto fail_defcmd;
> -       memcpy(defcmd_set, save_defcmd_set,
> -              defcmd_set_count * sizeof(*defcmd_set));
> -       s = defcmd_set + defcmd_set_count;
> +       memcpy(kdb_macro, save_kdb_macro,
> +              kdb_macro_count * sizeof(*kdb_macro));
> +       s = kdb_macro + kdb_macro_count;
>         memset(s, 0, sizeof(*s));
>         s->usable = true;
> -       s->name = kdb_strdup(argv[1], GFP_KDB);
> -       if (!s->name)
> +
> +       mp = &s->cmd;
> +       mp->cmd_func = kdb_exec_defcmd;
> +       mp->cmd_minlen = 0;
> +       mp->cmd_flags = KDB_ENABLE_ALWAYS_SAFE;
> +       mp->cmd_name = kdb_strdup(argv[1], GFP_KDB);
> +       if (!mp->cmd_name)
>                 goto fail_name;
> -       s->usage = kdb_strdup(argv[2], GFP_KDB);
> -       if (!s->usage)
> +       mp->cmd_usage = kdb_strdup(argv[2], GFP_KDB);
> +       if (!mp->cmd_usage)
>                 goto fail_usage;
> -       s->help = kdb_strdup(argv[3], GFP_KDB);
> -       if (!s->help)
> +       mp->cmd_help = kdb_strdup(argv[3], GFP_KDB);
> +       if (!mp->cmd_help)
>                 goto fail_help;
> -       if (s->usage[0] == '"') {
> -               strcpy(s->usage, argv[2]+1);
> -               s->usage[strlen(s->usage)-1] = '\0';
> +       if (mp->cmd_usage[0] == '"') {
> +               strcpy(mp->cmd_usage, argv[2]+1);
> +               mp->cmd_usage[strlen(mp->cmd_usage)-1] = '\0';
>         }
> -       if (s->help[0] == '"') {
> -               strcpy(s->help, argv[3]+1);
> -               s->help[strlen(s->help)-1] = '\0';
> +       if (mp->cmd_help[0] == '"') {
> +               strcpy(mp->cmd_help, argv[3]+1);
> +               mp->cmd_help[strlen(mp->cmd_help)-1] = '\0';
>         }
> -       ++defcmd_set_count;
> +       ++kdb_macro_count;
>         defcmd_in_progress = true;
> -       kfree(save_defcmd_set);
> +       kfree(save_kdb_macro);
>         return 0;
>  fail_help:
> -       kfree(s->usage);
> +       kfree(mp->cmd_usage);
>  fail_usage:
> -       kfree(s->name);
> +       kfree(mp->cmd_name);
>  fail_name:
> -       kfree(defcmd_set);
> +       kfree(kdb_macro);
>  fail_defcmd:
> -       kdb_printf("Could not allocate new defcmd_set entry for %s\n", argv[1]);
> -       defcmd_set = save_defcmd_set;
> +       kdb_printf("Could not allocate new kdb_macro entry for %s\n", argv[1]);
> +       kdb_macro = save_kdb_macro;
>         return KDB_NOTIMP;
>  }
>
> @@ -781,14 +779,14 @@ static int kdb_defcmd(int argc, const char **argv)
>  static int kdb_exec_defcmd(int argc, const char **argv)
>  {
>         int i, ret;
> -       struct defcmd_set *s;
> +       struct kdb_macro_t *s;
>         if (argc != 0)
>                 return KDB_ARGCOUNT;
> -       for (s = defcmd_set, i = 0; i < defcmd_set_count; ++i, ++s) {
> -               if (strcmp(s->name, argv[0]) == 0)
> +       for (s = kdb_macro, i = 0; i < kdb_macro_count; ++i, ++s) {
> +               if (strcmp(s->cmd.cmd_name, argv[0]) == 0)
>                         break;
>         }
> -       if (i == defcmd_set_count) {
> +       if (i == kdb_macro_count) {
>                 kdb_printf("kdb_exec_defcmd: could not find commands for %s\n",
>                            argv[0]);
>                 return KDB_NOTIMP;
> @@ -797,7 +795,7 @@ static int kdb_exec_defcmd(int argc, const char **argv)
>                 /* Recursive use of kdb_parse, do not use argv after
>                  * this point */
>                 argv = NULL;
> -               kdb_printf("[%s]kdb> %s\n", s->name, s->command[i]);
> +               kdb_printf("[%s]kdb> %s\n", s->cmd.cmd_name, s->command[i]);
>                 ret = kdb_parse(s->command[i]);
>                 if (ret)
>                         return ret;
> @@ -2620,55 +2618,6 @@ static int kdb_grep_help(int argc, const char **argv)
>         return 0;
>  }
>
> -/*
> - * kdb_register_flags - This function is used to register a kernel
> - *     debugger command.
> - * Inputs:
> - *     cmd     Command name
> - *     func    Function to execute the command
> - *     usage   A simple usage string showing arguments
> - *     help    A simple help string describing command
> - *     repeat  Does the command auto repeat on enter?
> - * Returns:
> - *     zero for success, one if a duplicate command.
> - */
> -int kdb_register_flags(char *cmd,
> -                      kdb_func_t func,
> -                      char *usage,
> -                      char *help,
> -                      short minlen,
> -                      kdb_cmdflags_t flags)
> -{
> -       kdbtab_t *kp;
> -
> -       list_for_each_entry(kp, &kdb_cmds_head, list_node) {
> -               if (strcmp(kp->cmd_name, cmd) == 0) {
> -                       kdb_printf("Duplicate kdb command registered: "
> -                               "%s, func %px help %s\n", cmd, func, help);
> -                       return 1;
> -               }
> -       }
> -
> -       kp = kmalloc(sizeof(*kp), GFP_KDB);
> -       if (!kp) {
> -               kdb_printf("Could not allocate new kdb_command table\n");
> -               return 1;
> -       }
> -
> -       kp->cmd_name   = cmd;
> -       kp->cmd_func   = func;
> -       kp->cmd_usage  = usage;
> -       kp->cmd_help   = help;
> -       kp->cmd_minlen = minlen;
> -       kp->cmd_flags  = flags;
> -       kp->is_dynamic = true;
> -
> -       list_add_tail(&kp->list_node, &kdb_cmds_head);
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(kdb_register_flags);
> -
>  /*
>   * kdb_register_table() - This function is used to register a kdb command
>   *                        table.
> @@ -2684,54 +2633,37 @@ void kdb_register_table(kdbtab_t *kp, size_t len)
>  }
>
>  /*

You intended to make this kernel doc style, right? So "/**" here?


> - * kdb_register - Compatibility register function for commands that do
> - *     not need to specify a repeat state.  Equivalent to
> - *     kdb_register_flags with flags set to 0.
> - * Inputs:
> - *     cmd     Command name
> - *     func    Function to execute the command
> - *     usage   A simple usage string showing arguments
> - *     help    A simple help string describing command
> - * Returns:
> - *     zero for success, one if a duplicate command.
> + * kdb_register() - This function is used to register a kernel debugger
> + *                  command.
> + * @cmd: pointer to kdb command

You should document that it's the job of the caller to keep the memory
for the cmd allocated until unregister is called.

I'll also note that your diffs would be slightly easier to understand
if you moved your new kdb_register() to before kdb_register_table().
That's because the new kdb_register() is more similar to the old
kdb_register_flags().


>   */
> -int kdb_register(char *cmd,
> -            kdb_func_t func,
> -            char *usage,
> -            char *help,
> -            short minlen)
> -{
> -       return kdb_register_flags(cmd, func, usage, help, minlen, 0);
> -}
> -EXPORT_SYMBOL_GPL(kdb_register);
> -
> -/*
> - * kdb_unregister - This function is used to unregister a kernel
> - *     debugger command.  It is generally called when a module which
> - *     implements kdb commands is unloaded.
> - * Inputs:
> - *     cmd     Command name
> - * Returns:
> - *     zero for success, one command not registered.
> - */
> -int kdb_unregister(char *cmd)
> +int kdb_register(kdbtab_t *cmd)
>  {
>         kdbtab_t *kp;
>
> -       /*
> -        *  find the command.
> -        */
>         list_for_each_entry(kp, &kdb_cmds_head, list_node) {
> -               if (strcmp(kp->cmd_name, cmd) == 0) {
> -                       list_del(&kp->list_node);
> -                       if (kp->is_dynamic)
> -                               kfree(kp);
> -                       return 0;
> +               if (strcmp(kp->cmd_name, cmd->cmd_name) == 0) {
> +                       kdb_printf("Duplicate kdb cmd: %s, func %p help %s\n",
> +                                  cmd->cmd_name, cmd->cmd_func, cmd->cmd_help);
> +                       return 1;
>                 }
>         }
>
> -       /* Couldn't find it.  */
> -       return 1;
> +       list_add_tail(&cmd->list_node, &kdb_cmds_head);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kdb_register);
> +
> +/*

You intended to make this kernel doc style, right? So "/**" here?


-Doug
