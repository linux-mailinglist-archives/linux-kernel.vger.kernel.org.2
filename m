Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62F23C546D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348761AbhGLH6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbhGLHUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:20:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42160C061786
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:17:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i5so11563849lfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo5VZqy0CSVsN0ojiM8kCxZj5ttq9uBKj4mVUnzOgPA=;
        b=lUDfFU6JfeZbcHW/3gTYpRjCy0+1PkpjeFblxe1x78E2RjyaWhx1SIWHYe7JajuG0u
         c2j3g54ap4OA0p1/cri9sjfleD6UTF2G6M+bv4TWLh8nMfjjL+Ays6zQYfQy8reeMXqt
         Ej0BpcKkyhWsmmEkHu+ePoSq5HGpnRZMIPIqiLfYrpPCobPCKUy6+E/uhlErhHPKY5ba
         WeTNfQk7whdtvOrb9k1BEEiPf589NRHNl15M2KAA8x7D2Hfz9AO7wyj6m3b7zF2U62Aq
         5ehaSF0iCpMKISaaZYaJSrGJTvdjyhud8r/nbBAgWAg8mo18ENxF54Ju0hKvUDnEXCJV
         5Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo5VZqy0CSVsN0ojiM8kCxZj5ttq9uBKj4mVUnzOgPA=;
        b=lK7aGcA1/55RmERX0t62AW89HKmVke3oPwGYQcypmmLYNcZ8DK3crAeHoJRFulyGWg
         aQbw+upo2uU7qgmBjf10wzShLdshdcHThD76vlATK0Xt/xlslRRzEhbfCKs7KsKVkbrS
         Lh+/tail+5F5i3kkL8Kqe7D+7xkBaGYuoUmCF0i7MRA6La+q7JMMNEYKQVBzxtSAmlmF
         GsdT9OzRBRZdZfBIHf4smo4LAmCF36XE1uL5bh1+LbyfInUew8CKgghb5601tZ6/uKD5
         H8mKEHly0cTqVsT5kxxcglfr7i0bAw+SdQmZqh+4escl4R7gEXNZZx4y6HBUFbRmNEva
         4okg==
X-Gm-Message-State: AOAM531c/rVBe56ZdJfKhfewP6eSWG6CWnqTlu7PNvAeoxmLCmtekYCF
        PXMiNhGzi2DbAwX+lBZXmWir/iI7uwNjoubkjvHHkQ==
X-Google-Smtp-Source: ABdhPJyr04XMJJlCelSpPAQoTSbn/SKwim1bVmAfudxDtIhw6zrWy+z2hfB1j26kbCCDKChKdm8BSTEbVM/O6C3MwDo=
X-Received: by 2002:a19:e002:: with SMTP id x2mr39218295lfg.84.1626074237649;
 Mon, 12 Jul 2021 00:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org>
 <20210709104320.101568-5-sumit.garg@linaro.org> <CAD=FV=UqBPV_HQfu++j4yJ2nEN7tzFScnoYQFUhNuXE82OBDhg@mail.gmail.com>
In-Reply-To: <CAD=FV=UqBPV_HQfu++j4yJ2nEN7tzFScnoYQFUhNuXE82OBDhg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 12 Jul 2021 12:47:06 +0530
Message-ID: <CAFA6WYNeKSi4792tUROxqyz4guinnkLzsO8K61T5UUwjTcxZ2g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kdb: Rename members of struct kdbtab_t
To:     Doug Anderson <dianders@chromium.org>
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

On Sat, 10 Jul 2021 at 03:07, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jul 9, 2021 at 3:44 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > @@ -711,10 +711,10 @@ static int kdb_defcmd(int argc, const char **argv)
> >                 struct kdb_macro_statement_t *kmc;
> >
> >                 list_for_each_entry(kp, &kdb_cmds_head, list_node) {
> > -                       if (kp->cmd_func == kdb_exec_defcmd) {
> > +                       if (kp->func == kdb_exec_defcmd) {
> >                                 kdb_printf("defcmd %s \"%s\" \"%s\"\n",
> > -                                          kp->cmd_name, kp->cmd_usage,
> > -                                          kp->cmd_help);
> > +                                          kp->name, kp->usage,
> > +                                          kp->help);
>
> The call could probably be squashed down to 2 lines instead of 3 now.
>

Ack.

>
> > @@ -1031,8 +1031,8 @@ int kdb_parse(const char *cmdstr)
> >          */
> >         if (list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
> >                 list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> > -                       if (strncmp(argv[0], tp->cmd_name,
> > -                                   strlen(tp->cmd_name)) == 0)
> > +                       if (strncmp(argv[0], tp->name,
> > +                                   strlen(tp->name)) == 0)
>
> Squash down to one line now that it's shorter.
>

Ack.

>
> The word wrapping isn't really a huge deal to me, though, so:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
-Sumit
