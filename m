Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469463C2AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhGIVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:39:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3359FC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:37:14 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i4so4771920qvq.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeilyD9ahaj/44sq03A2+xgWY8Z3b90Fi9ryhOZxPFU=;
        b=JQPh9cmQKdNIfHt+KKTETwk436zmgqj4jJMcmqZ8De0QsgicOU2RuauXHCdeF7jCmT
         hNThVxkXssH6KEkMYzJ7NaFTEYwcs83m0yKmtacXwkHurs71olQNsFt8rkXoHyRCXkwK
         dl/f2eqnEog1an+QDFoYu8JATSLT5wLymywuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeilyD9ahaj/44sq03A2+xgWY8Z3b90Fi9ryhOZxPFU=;
        b=sDK3jRzLHKQr3Q9+O/Bfh12ALlX6sf1R88PdtW9bevWIICVl1MxApyOwYoK6O3GDiS
         q/C6mjHRBgeDcQnoK7+z9Pgt3r7hnzLXsQkpdv5wJFg0n7IA10OIJ6jaZYhdB04wue7S
         LYPxtmT9JBmxgz61rGNjmD/TMkO2UpRb0CCJ8+Bm0Owh7860cjFON+5wngFWjGcn4ojV
         vYEebsWkLyUtJuoJd/Ol3gdDPowp1Pt00pJ5HIoMgBK2+c5VbE0qoZQWCPxZbFnQWEv9
         Ou7Lu5kmZTvWngNv+bID8yBAerrwmkbVjDFlMOGum1+j613mL9uutceU7HIODG2MFYQD
         QUOg==
X-Gm-Message-State: AOAM533+VVq1VwzemMWpwGGI3MGZIZT6zxh4mD8f2CTiH37cDQ367ZML
        pVKw339cojhMbELsDM08AAEoOTAE9awf+w==
X-Google-Smtp-Source: ABdhPJxbqL+uhL8vbi/VZyG4UrJHuLcLb3yvJdHqi+rTXG14fw3pS075HvliNtFgJZDpcdjG4qh23Q==
X-Received: by 2002:a05:6214:509b:: with SMTP id kk27mr38513978qvb.56.1625866633011;
        Fri, 09 Jul 2021 14:37:13 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id p187sm3124876qkd.101.2021.07.09.14.37.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:37:11 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id p22so16664728yba.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:11 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr48821389ybk.79.1625866631195;
 Fri, 09 Jul 2021 14:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org> <20210709104320.101568-2-sumit.garg@linaro.org>
In-Reply-To: <20210709104320.101568-2-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jul 2021 14:36:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W4zMtf-Cmu1KcboJTx=G52rr6Z7hy3LvT3fS76XEbtSw@mail.gmail.com>
Message-ID: <CAD=FV=W4zMtf-Cmu1KcboJTx=G52rr6Z7hy3LvT3fS76XEbtSw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kdb: Rename struct defcmd_set to struct kdb_macro_t
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

On Fri, Jul 9, 2021 at 3:43 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> as that sounds more appropriate given its purpose.

nit: Personally I prefer this to be a whole sentence that isn't just a
continuation of the patch subject.


> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 38 ++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index d8ee5647b732..d4897fbc9d2e 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -654,7 +654,7 @@ static void kdb_cmderror(int diag)
>   * Returns:
>   *     zero for success, a kdb diagnostic if error
>   */
> -struct defcmd_set {
> +struct kdb_macro_t {

Why the "_t" at the end? To me that implies that this is a typedef, so
you'd declare a variable of this as:

kdb_macro_t my_macro;

...instead of:

struct kdb_macro_t my_macro;

Not that I'm suggesting adding a typedef for this structure. It seems
kernel convention is not to do typedefs for structures unless there's
a strong reason to. Rather, I'm just suggesting removing the "_t" from
the end.


> @@ -671,7 +671,7 @@ static int kdb_exec_defcmd(int argc, const char **argv);
>
>  static int kdb_defcmd2(const char *cmdstr, const char *argv0)
>  {
> -       struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
> +       struct kdb_macro_t *s = kdb_macro + kdb_macro_count - 1;

I guess the variable "s" was short for "set". Should it change to "m"
? Here and in other places below.


> @@ -727,13 +727,13 @@ static int kdb_defcmd(int argc, const char **argv)
>                 kdb_printf("Command only available during kdb_init()\n");
>                 return KDB_NOTIMP;
>         }
> -       defcmd_set = kmalloc_array(defcmd_set_count + 1, sizeof(*defcmd_set),
> +       kdb_macro = kmalloc_array(kdb_macro_count + 1, sizeof(*kdb_macro),
>                                    GFP_KDB);

nit: the indentation is now off for the GFP_KDB since you changed the
length of the previous line.

Sorry for not noticing those things in the previous version. I guess
having this part of the change split out really did make it easier to
review! ;-) Those are all pretty much just nits, so if they're fixed
feel free to add my Reviewed-by tag.
