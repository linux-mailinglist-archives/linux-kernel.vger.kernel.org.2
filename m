Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94B38B51B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhETRWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhETRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:22:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34116C061760
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:21:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g8so5827396qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIsGSms3zUeXZTUYxcIlfsJLSeoxkaCz0E4COH66hi8=;
        b=OkcRWQZ7jQ2GDNnyAoUAPqJjsNQsqfyYhIHHCiGXeNTiWJwpKpLCFXG9t7om3a0n14
         iW9plRvFzPqjpf11YaIEjARLzGlvn3kGc6brJ6VWez7WfP4AmuE3Jl9j3dqdsnBvHlk1
         W3xFbCxU0TTRku8NeG4xVtdiQw42Pa5XZqCs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIsGSms3zUeXZTUYxcIlfsJLSeoxkaCz0E4COH66hi8=;
        b=iBiyySJtVoQ6voHay4H2sq1RwgHetHeuBQGQZjMDOCpanRM2pwW5dBzSRNO7l05+Td
         bej1NQqXRqDHwZXJN8F0G9Q/z1um7Cxu93BTGgVf3Z9J+K30aOVbIOxsA6QCgUhkeIlx
         xKYdB4uwX8FiroX9qThT09gIK1ppUUfeeiKpXo6EjHCFj8EmaJai9/upU3Xs8RZghSAu
         UPN4mkdvPFxOgpXDnOt5mwCI3PVm9/+EVVVAFnzP9vgxzM4pr1//hqbhAvU34X3X4qQY
         jXgLgc0yHAuULa338plULVRdDzKLhN/s+ez+tG6QGMae+D9Q2NVIM0MJHMsdW6zyX7qU
         +NlA==
X-Gm-Message-State: AOAM530cEjP1nsP7MpuPoL/QNngLM4o3uqWF5ujALd8dw2wJFmyd1zkq
        VHu91572MijB9QlrrwXKMmlPXZIOiuBtZw==
X-Google-Smtp-Source: ABdhPJzxx+JHeEZ9s2ngY9QnKe61ty5j0EPDMHam0UkzHB2hkG+a1RCWu+xwUs2pPTJICcNvEzIsDw==
X-Received: by 2002:ac8:7288:: with SMTP id v8mr6328131qto.61.1621531283827;
        Thu, 20 May 2021 10:21:23 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r125sm2576839qkf.24.2021.05.20.10.21.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 10:21:23 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id b13so22455673ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:21:23 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr8778240ybp.476.1621531282709;
 Thu, 20 May 2021 10:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210513112842.707103-1-sumit.garg@linaro.org> <20210513112842.707103-3-sumit.garg@linaro.org>
In-Reply-To: <20210513112842.707103-3-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 May 2021 10:21:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W6gnqDoOCMsDTvP4_yS_szEa2g3_rhDG82ZpDTv6e5MA@mail.gmail.com>
Message-ID: <CAD=FV=W6gnqDoOCMsDTvP4_yS_szEa2g3_rhDG82ZpDTv6e5MA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kdb: Simplify kdb_defcmd macro logic
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
> index de685b2a8ce7..ce7f4c71992d 100644
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
> +       kdbtab_t cmd;                   /* Macro command name */

It's more than just the name, right?


> +       struct list_head commands;      /* Associated command list */

I get confused between the two different usages of "command". Can we
call the individual entries of a macro "statements". So this would be:

struct list_head statements; /* Associated statement list */

...and the structure below would get renamed as well.

>  };
> +
> +struct kdb_macro_cmd_t {
> +       char *cmd;                      /* Command name */

This isn't the "name" of the command, is it? It's the actual statement
that the user entered?


Other than that, this looks like a nice patch to me.


-Doug
