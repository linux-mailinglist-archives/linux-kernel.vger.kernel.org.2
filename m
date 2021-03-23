Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFD93457E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCWGia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCWGiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:38:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E007EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:38:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b83so24991865lfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSlBc3ZngBpiSOBHU+TuOOm2Zx3vcQzp5yg+cLCt4ag=;
        b=sHrT681rY+0rIwjIqOBRu7J9IpoeGE2rE0Y3NSnZTcNAXypXgMrWVutpPgxtwOHyuX
         922KwstH6XNi1q/iWJyU46kRCF81jmAPK0yI8VqrpTwYJFE/c5tsrugr3S+JQFYm1+3L
         LSMIf6kAHbpWYnO5jLR6Q1Nkip5n/+4vuvu1sCm2rFdwHFL5xFjimtM23S/0iP8CqmWJ
         uKNMjv6jnTH+je4f6tcdfJ6/LHX3IbNOEKsA15IeemXsqClwC4qjsS9rM/8iCqmoYctC
         epAlQkU+LimfxQoRWfLE7ed7Vxay63aF0K4XI8ZLWmhDgHfa/0iOK6XVzCvbv/USN5EV
         2/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSlBc3ZngBpiSOBHU+TuOOm2Zx3vcQzp5yg+cLCt4ag=;
        b=cWzNz3DY9CY2apld8P45wXX80lmN/a5eI1e/M670+xIzIpPCNonNXvYCBNnPAFc8D+
         zY6D3P336vxzSc8kZ+Kui7fhrvgs1B4alCiRIjXiRooxTqUJmtjOaxpDT+Ev7MmnFKeO
         TdZfZJ0h7nRUhgLcWhRZ5kzPeoMTUYCQXnMUOsWmkOwjCd7OqBQUdoCEa6ekb54wJoFN
         +qgEXuxwTDVqJeFJCxKSg+cqywNF+hcNXqy3+RFT0Ejz03utri60cTmJ9wiirwTSxpcM
         qiPH43NncCeWh3EhDEDBTH9yHtIdUFkyeDSV9rMPBvI7AxPxqhBBSFOV4cfgNLuMPjvO
         CtxA==
X-Gm-Message-State: AOAM533indpvRO4gtxIn2oaobhQi2hMuPL6FbQ7KQTrCE5T/JD361sgF
        LbRuiUx20lnnKAVcNxUjLXuunJI7728+G8wiaUEp6g==
X-Google-Smtp-Source: ABdhPJzU/VYeEgd9/jJllXeRBEjovJjqw5mvv74HaXJ0ebymNLYQruEx7PoOrA7PNN8fYODvuLCV5mq2N26T0Kx017Q=
X-Received: by 2002:ac2:46db:: with SMTP id p27mr1747028lfo.396.1616481500301;
 Mon, 22 Mar 2021 23:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <1612771342-16883-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1612771342-16883-1-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Mar 2021 12:08:09 +0530
Message-ID: <CAFA6WYPPTivcLW8D+_nRdc4M1FLr21cbNt81BXYgbb7T3odaWw@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Refactor env variables get/set code
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, 8 Feb 2021 at 13:32, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add two new kdb environment access methods as kdb_setenv() and
> kdb_printenv() in order to abstract out environment access code
> from kdb command functions.
>
> Also, replace (char *)0 with NULL as an initializer for environment
> variables array.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v3:
> - Remove redundant '\0' char assignment.
> - Pick up Doug's review tag.
>
> Changes in v2:
> - Get rid of code motion to separate kdb_env.c file.
> - Replace (char *)0 with NULL.
> - Use kernel-doc style function comments.
> - s/kdb_prienv/kdb_printenv/
>
>  kernel/debug/kdb/kdb_main.c | 164 ++++++++++++++++++++++++--------------------
>  1 file changed, 91 insertions(+), 73 deletions(-)
>

Do you have any further comments on this? If no, can you pick this up as well?

-Sumit

> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 588062a..69b8f55 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -142,40 +142,40 @@ static const int __nkdb_err = ARRAY_SIZE(kdbmsgs);
>
>  static char *__env[] = {
>  #if defined(CONFIG_SMP)
> - "PROMPT=[%d]kdb> ",
> +       "PROMPT=[%d]kdb> ",
>  #else
> - "PROMPT=kdb> ",
> +       "PROMPT=kdb> ",
>  #endif
> - "MOREPROMPT=more> ",
> - "RADIX=16",
> - "MDCOUNT=8",                  /* lines of md output */
> - KDB_PLATFORM_ENV,
> - "DTABCOUNT=30",
> - "NOSECT=1",
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> - (char *)0,
> +       "MOREPROMPT=more> ",
> +       "RADIX=16",
> +       "MDCOUNT=8",            /* lines of md output */
> +       KDB_PLATFORM_ENV,
> +       "DTABCOUNT=30",
> +       "NOSECT=1",
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
> +       NULL,
>  };
>
>  static const int __nenv = ARRAY_SIZE(__env);
> @@ -318,6 +318,63 @@ int kdbgetintenv(const char *match, int *value)
>  }
>
>  /*
> + * kdb_setenv() - Alter an existing environment variable or create a new one.
> + * @var: Name of the variable
> + * @val: Value of the variable
> + *
> + * Return: Zero on success, a kdb diagnostic on failure.
> + */
> +static int kdb_setenv(const char *var, const char *val)
> +{
> +       int i;
> +       char *ep;
> +       size_t varlen, vallen;
> +
> +       varlen = strlen(var);
> +       vallen = strlen(val);
> +       ep = kdballocenv(varlen + vallen + 2);
> +       if (ep == (char *)0)
> +               return KDB_ENVBUFFULL;
> +
> +       sprintf(ep, "%s=%s", var, val);
> +
> +       for (i = 0; i < __nenv; i++) {
> +               if (__env[i]
> +                && ((strncmp(__env[i], var, varlen) == 0)
> +                  && ((__env[i][varlen] == '\0')
> +                   || (__env[i][varlen] == '=')))) {
> +                       __env[i] = ep;
> +                       return 0;
> +               }
> +       }
> +
> +       /*
> +        * Wasn't existing variable.  Fit into slot.
> +        */
> +       for (i = 0; i < __nenv-1; i++) {
> +               if (__env[i] == (char *)0) {
> +                       __env[i] = ep;
> +                       return 0;
> +               }
> +       }
> +
> +       return KDB_ENVFULL;
> +}
> +
> +/*
> + * kdb_printenv() - Display the current environment variables.
> + */
> +static void kdb_printenv(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < __nenv; i++) {
> +               if (__env[i])
> +                       kdb_printf("%s\n", __env[i]);
> +       }
> +}
> +
> +/*
>   * kdbgetularg - This function will convert a numeric string into an
>   *     unsigned long value.
>   * Parameters:
> @@ -374,10 +431,6 @@ int kdbgetu64arg(const char *arg, u64 *value)
>   */
>  int kdb_set(int argc, const char **argv)
>  {
> -       int i;
> -       char *ep;
> -       size_t varlen, vallen;
> -
>         /*
>          * we can be invoked two ways:
>          *   set var=value    argv[1]="var", argv[2]="value"
> @@ -422,37 +475,7 @@ int kdb_set(int argc, const char **argv)
>          * Tokenizer squashed the '=' sign.  argv[1] is variable
>          * name, argv[2] = value.
>          */
> -       varlen = strlen(argv[1]);
> -       vallen = strlen(argv[2]);
> -       ep = kdballocenv(varlen + vallen + 2);
> -       if (ep == (char *)0)
> -               return KDB_ENVBUFFULL;
> -
> -       sprintf(ep, "%s=%s", argv[1], argv[2]);
> -
> -       ep[varlen+vallen+1] = '\0';
> -
> -       for (i = 0; i < __nenv; i++) {
> -               if (__env[i]
> -                && ((strncmp(__env[i], argv[1], varlen) == 0)
> -                  && ((__env[i][varlen] == '\0')
> -                   || (__env[i][varlen] == '=')))) {
> -                       __env[i] = ep;
> -                       return 0;
> -               }
> -       }
> -
> -       /*
> -        * Wasn't existing variable.  Fit into slot.
> -        */
> -       for (i = 0; i < __nenv-1; i++) {
> -               if (__env[i] == (char *)0) {
> -                       __env[i] = ep;
> -                       return 0;
> -               }
> -       }
> -
> -       return KDB_ENVFULL;
> +       return kdb_setenv(argv[1], argv[2]);
>  }
>
>  static int kdb_check_regs(void)
> @@ -2055,12 +2078,7 @@ static int kdb_lsmod(int argc, const char **argv)
>
>  static int kdb_env(int argc, const char **argv)
>  {
> -       int i;
> -
> -       for (i = 0; i < __nenv; i++) {
> -               if (__env[i])
> -                       kdb_printf("%s\n", __env[i]);
> -       }
> +       kdb_printenv();
>
>         if (KDB_DEBUG(MASK))
>                 kdb_printf("KDBDEBUG=0x%x\n",
> --
> 2.7.4
>
