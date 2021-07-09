Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553F3C2AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhGIVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:40:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CCDC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:37:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j184so11011626qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SS6R9gYCanZZ2a5AF9Vn6YGG3Ugen51EagpNmwizlw=;
        b=htXTjgiymu14ekBEb8CWzMGrlJ9B2S1blxXfmo9C+AihKwhFyOTkmUrMDXhrCaQTuK
         RPNDVtqc7OvOaIw4+XeCXfhbbuFfF7TuNdRpCS7J8koCgiiEfrSLSisSmfPpSsvSjd1I
         bKDgNgGM2McaV8qVmzAkjkuPuFNPUcKf7Tg94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SS6R9gYCanZZ2a5AF9Vn6YGG3Ugen51EagpNmwizlw=;
        b=cmoI7etFhuw14u8EWBNzwjsJRzVLl3H4gCMt5TQEnrBx+XFbcT/JIFwq1N9ttsX8ns
         Cgj+Hpi0kd+JI92TKQa6g9LfuPjJL6KBlcT2RWHmcWp2pn9nXT3fGZgDwrpUOCj9rEL9
         i3X2HSxorbtmK65ikrX6mdmOcKDQCLjPfx3/fdSlj+SPBsQlEMj5wsJjQkxWt723CzX2
         l1An/2NpvelhMhLuY1t/XmpB0INpe8C+kWUHQeLAAgSy268pJR6wEi1WNw1uYXhi3cG2
         4ejaePpSobgXBjikm6tH6z2P0XXji9FRbj7ImHSwkRdK3dlgYIssL2ZTeWASopOrLdXq
         tOlA==
X-Gm-Message-State: AOAM532jiR+OPQ9iSZfPOl0vBRgZYtDjhuRfS0QOBfogPvWd40WIyGbn
        38VAYbYyxU5LQQw+jGWKJS2mFzsfA+kknw==
X-Google-Smtp-Source: ABdhPJy0gMXNzLVGOL8XhmJUKnMMW6sQAsNAlJrrx33gNKXdVhQoyqH7S4TmnJ/peW3I6Am9I6z6gA==
X-Received: by 2002:a37:a97:: with SMTP id 145mr27462327qkk.441.1625866666294;
        Fri, 09 Jul 2021 14:37:46 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y26sm2985351qkm.32.2021.07.09.14.37.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:37:45 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id o139so16637284ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:37:45 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr48976818ybm.345.1625866664715;
 Fri, 09 Jul 2021 14:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org> <20210709104320.101568-5-sumit.garg@linaro.org>
In-Reply-To: <20210709104320.101568-5-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jul 2021 14:37:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UqBPV_HQfu++j4yJ2nEN7tzFScnoYQFUhNuXE82OBDhg@mail.gmail.com>
Message-ID: <CAD=FV=UqBPV_HQfu++j4yJ2nEN7tzFScnoYQFUhNuXE82OBDhg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kdb: Rename members of struct kdbtab_t
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

On Fri, Jul 9, 2021 at 3:44 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> @@ -711,10 +711,10 @@ static int kdb_defcmd(int argc, const char **argv)
>                 struct kdb_macro_statement_t *kmc;
>
>                 list_for_each_entry(kp, &kdb_cmds_head, list_node) {
> -                       if (kp->cmd_func == kdb_exec_defcmd) {
> +                       if (kp->func == kdb_exec_defcmd) {
>                                 kdb_printf("defcmd %s \"%s\" \"%s\"\n",
> -                                          kp->cmd_name, kp->cmd_usage,
> -                                          kp->cmd_help);
> +                                          kp->name, kp->usage,
> +                                          kp->help);

The call could probably be squashed down to 2 lines instead of 3 now.


> @@ -1031,8 +1031,8 @@ int kdb_parse(const char *cmdstr)
>          */
>         if (list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
>                 list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> -                       if (strncmp(argv[0], tp->cmd_name,
> -                                   strlen(tp->cmd_name)) == 0)
> +                       if (strncmp(argv[0], tp->name,
> +                                   strlen(tp->name)) == 0)

Squash down to one line now that it's shorter.


The word wrapping isn't really a huge deal to me, though, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
