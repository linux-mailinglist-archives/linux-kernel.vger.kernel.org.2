Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C034231FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhJEU3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhJEU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:29:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB621C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:27:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so1024952lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrxAr1DMFcUoXrP9dumzBLC/Lw/hT6O755uVEMlFswE=;
        b=HsmKf/WlvT1iuWP5p7cQG5PLruNmSr+8jig8nlHWYbCoy/MiQdGQsQQ1v6ewUtLFws
         2B2nEU9cSKXNuhlaIelqIoTMqmnidx7P72VTXtZYPA00JtAtgVIEfnz3RtOP3Vw6eYHD
         xr1Vf4mTexXdG+nblxYlt6w61qPxG9cd+ZXGAHUL+8ct0j+36KhcLBnk5mR83JSvDxCk
         qEOLsZnuOWj3Hgj4VyoYvWGJnsuhKsrpENG4cQK5xKHg0a2M2ueS8+/SKTqqd5E6GINr
         cYxzdmZIVudSLsBmV1b1vIeHuR/6JiYnJbBbeIapJ6HRGgCxNrDTqApDwRWXasWwko6U
         wHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrxAr1DMFcUoXrP9dumzBLC/Lw/hT6O755uVEMlFswE=;
        b=e7ggg2LWmjY4eac5CqXONdZJk3WRwp0zCbb8KOIQm0MW3xinsi2ludCflYiUC2/L9C
         13bUI+30UMCpDjQAHQB3ypHd1A1TUp1YXqie2oaE1s2OuW2cO/Lf96IuA/ECTOTZNzcU
         COYAvlmgZ4B21+4kOTZiEFruBUBC1MI7pwNucav1aJebkXsiJ2THzLQt/S7R9K5k5dze
         Mv0CftQgtBMChRdwXiFZy7JYZjtQF6hY8L4aLSZhaig12eUPWWFHpLSIfdsieQ2AaHav
         ByBZBEgo0AthJScMWc/m84tPQDYmFYI8SK+/Fzt0+w13GAcc3CkiGi7SCI0KY9swk7q7
         14mw==
X-Gm-Message-State: AOAM533djlebx/JKRqlwHUVGGnQLMS/9EC2BuT5MXf6tTE86MuwI9Rm8
        IRKcfurxIKsDepFsu+XqEnZ/bINZlukaxVf2hCCjlw==
X-Google-Smtp-Source: ABdhPJzxMI6+KUc0ee2sAFuvzdOO/8xqZ7M6GeqBvrEc6KSuuWO2njt8Fmb6HGCp05cnRLh/l6vEkT+SBNG3kA1Zi/A=
X-Received: by 2002:a05:651c:2115:: with SMTP id a21mr25453839ljq.34.1633465659035;
 Tue, 05 Oct 2021 13:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211005045439.1430114-1-zephaniah@gmail.com>
In-Reply-To: <20211005045439.1430114-1-zephaniah@gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 5 Oct 2021 13:27:29 -0700
Message-ID: <CAAYoRsVOhBJPC6rK2GdMRL=8Hn+eJUBHT-F1WWFJds7dfQom3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/power turbostat: Allow -e for all names.
To:     "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 9:54 PM Zephaniah E. Loss-Cutler-Hull
<zephaniah@gmail.com> wrote:
>
> Currently, there are a number of variables which are displayed by
> default, enabled with -e all, and listed by --list, but which you can
> not give to --enable/-e.
>
> So you can enable CPU0c1 (in the bic array), but you can't enable C1 or
> C1% (not in the bic array, but exists in sysfs).
>
> This runs counter to both the documentation and user expectations, and
> it's just not very user friendly.
>
> As such, the mechanism used by --hide has been duplicated, and is now
> also used by --enable, so we can handle unknown names gracefully.
>
> Note: One impact of this is that truly unknown fields given to --enable
> will no longer generate errors, they will be silently ignored, as --hide
> does.
>
> Signed-off-by: Zephaniah E. Loss-Cutler-Hull <zephaniah@gmail.com>

This is an incredibly useful patch. Thank you.
Tested-by and Reviewed-by: Doug Smythies <dsmythies@telus.net>

> ---
>  tools/power/x86/turbostat/turbostat.c | 49 +++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 47d3ba895d6d..f5d634ee5fee 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -686,7 +686,9 @@ unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC
>  #define BIC_IS_ENABLED(COUNTER_BIT) (bic_enabled & COUNTER_BIT)
>
>  #define MAX_DEFERRED 16
> +char *deferred_add_names[MAX_DEFERRED];
>  char *deferred_skip_names[MAX_DEFERRED];
> +int deferred_add_index;
>  int deferred_skip_index;
>
>  /*
> @@ -775,17 +777,23 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
>                 }
>                 if (i == MAX_BIC) {
>                         if (mode == SHOW_LIST) {
> -                               fprintf(stderr, "Invalid counter name: %s\n", name_list);
> -                               exit(-1);
> -                       }
> -                       deferred_skip_names[deferred_skip_index++] = name_list;
> -                       if (debug)
> -                               fprintf(stderr, "deferred \"%s\"\n", name_list);
> -                       if (deferred_skip_index >= MAX_DEFERRED) {
> -                               fprintf(stderr, "More than max %d un-recognized --skip options '%s'\n",
> -                                       MAX_DEFERRED, name_list);
> -                               help();
> -                               exit(1);
> +                               deferred_add_names[deferred_add_index++] = name_list;
> +                               if (deferred_add_index >= MAX_DEFERRED) {
> +                                       fprintf(stderr, "More than max %d un-recognized --add options '%s'\n",
> +                                                       MAX_DEFERRED, name_list);
> +                                       help();
> +                                       exit(1);
> +                               }
> +                       } else {
> +                               deferred_skip_names[deferred_skip_index++] = name_list;
> +                               if (debug)
> +                                       fprintf(stderr, "deferred \"%s\"\n", name_list);
> +                               if (deferred_skip_index >= MAX_DEFERRED) {
> +                                       fprintf(stderr, "More than max %d un-recognized --skip options '%s'\n",
> +                                                       MAX_DEFERRED, name_list);
> +                                       help();
> +                                       exit(1);
> +                               }
>                         }
>                 }
>
> @@ -6138,6 +6146,16 @@ void parse_add_command(char *add_command)
>         }
>  }
>
> +int is_deferred_add(char *name)
> +{
> +       int i;
> +
> +       for (i = 0; i < deferred_add_index; ++i)
> +               if (!strcmp(name, deferred_add_names[i]))
> +                       return 1;
> +       return 0;
> +}
> +
>  int is_deferred_skip(char *name)
>  {
>         int i;
> @@ -6156,9 +6174,6 @@ void probe_sysfs(void)
>         int state;
>         char *sp;
>
> -       if (!DO_BIC(BIC_sysfs))
> -               return;
> -
>         for (state = 10; state >= 0; --state) {
>
>                 sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name", base_cpu, state);
> @@ -6181,6 +6196,9 @@ void probe_sysfs(void)
>
>                 sprintf(path, "cpuidle/state%d/time", state);
>
> +               if (!DO_BIC(BIC_sysfs) && !is_deferred_add(name_buf))
> +                       continue;
> +
>                 if (is_deferred_skip(name_buf))
>                         continue;
>
> @@ -6206,6 +6224,9 @@ void probe_sysfs(void)
>
>                 sprintf(path, "cpuidle/state%d/usage", state);
>
> +               if (!DO_BIC(BIC_sysfs) && !is_deferred_add(name_buf))
> +                       continue;
> +
>                 if (is_deferred_skip(name_buf))
>                         continue;
>
> --
> 2.33.0
>
