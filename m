Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCAB3C2AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGIVkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:40:21 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFECC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:37:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cn9so5248554qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQt5Yxt+QI2V2kEVlQQ4D1EcN/8bc+gnQfWtPBvR4WM=;
        b=Jea4bW6QN83UPadyfw2cVUNHb+dm7/nDCxYbXJPEmsjwxn4BLVMQhbw2Zad75RoxRk
         bfZoNh3BRqjudcYJy61eGRTD9CC7VXIqpOHxtXfQtMfpujBHrw8+K8qaorvoHA3vC4Ps
         ft45m+A0dWWRTPPIgYKUdfq3+MYeL3wipalL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQt5Yxt+QI2V2kEVlQQ4D1EcN/8bc+gnQfWtPBvR4WM=;
        b=btlqecBnFZNjeFAHgiypVOmkm0hr+Jd88lUPRWfgPB/z9L5Y+K2/1BKJ22s9780B9G
         4N4jf4PL49LaBMlqrkuywZGZrPcRrrXBVIN/b8b9OWuxUb2LdvdVneijjQxikDcAcgCO
         eKttspJQ+T0CgoQhfUyeX8XoCeB7RrXm3++2kBQaCC1as2sQNioqtfqBe9m0PaWrYcVX
         7Ab0P4KDj0AMIZZ4VttseSYtbYCs7RLoT9P22xAKrEk12xXnim9xmaZw5EGRVDrPwOtu
         4kuA7XDyXa+Gb+qt2s5s9rb44D1HXUkuvV2tDXnu0a5c/Aaolwn25C2adwYVphhruIfS
         V3xA==
X-Gm-Message-State: AOAM530w5s6yHLNLxARQkj02mZCSjIUmBrGkkGca5PZIIk6hMhKdXMA0
        CgHdPsAZB0P5XgcgH7YNrEc45Md0rNdqlA==
X-Google-Smtp-Source: ABdhPJzNmE94TyeSSzNgEL4Z9AVobGc9Agc/ew/+9E8FshqC7Y5LJfsQijuRM6FrAYSt9j7DiubGVg==
X-Received: by 2002:a05:6214:1141:: with SMTP id b1mr37043435qvt.2.1625866657099;
        Fri, 09 Jul 2021 14:37:37 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 7sm2640535qtx.33.2021.07.09.14.37.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:37:36 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id y38so16686128ybi.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:36 -0700 (PDT)
X-Received: by 2002:a25:cc52:: with SMTP id l79mr47923674ybf.476.1625866655796;
 Fri, 09 Jul 2021 14:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org> <20210709104320.101568-4-sumit.garg@linaro.org>
In-Reply-To: <20210709104320.101568-4-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jul 2021 14:37:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHPCXSAmgf62K7+5LLbrz--BenQk5AyDozscr62qjbJg@mail.gmail.com>
Message-ID: <CAD=FV=XHPCXSAmgf62K7+5LLbrz--BenQk5AyDozscr62qjbJg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] kdb: Simplify kdb_defcmd macro logic
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
> Switch to use a linked list instead of dynamic array which makes
> allocation of kdb macro and traversing the kdb macro commands list
> simpler.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 107 +++++++++++++++++++-----------------
>  1 file changed, 58 insertions(+), 49 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 6d9ff4048e7d..371983c03223 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -654,13 +654,16 @@ static void kdb_cmderror(int diag)
>   *     zero for success, a kdb diagnostic if error
>   */
>  struct kdb_macro_t {
> -       int count;
> -       bool usable;
> -       kdbtab_t cmd;
> -       char **command;
> +       kdbtab_t cmd;                   /* Macro command */
> +       struct list_head statements;    /* Associated statement list */
>  };
> +
> +struct kdb_macro_statement_t {
> +       char *statement;                /* Statement name */

This is still not really the name. This is the actual statement,
right? Like it might contain "ftdump -1", right? It seems really weird
to call that the "name". You could drop the word "name", or change
this to "Statement text", or just totally drop the comment.

Other than that this looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
