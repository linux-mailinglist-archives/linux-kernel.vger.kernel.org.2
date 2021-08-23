Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B453F497F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhHWLRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:17:03 -0400
Received: from mail-vk1-f177.google.com ([209.85.221.177]:34367 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhHWLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:17:02 -0400
Received: by mail-vk1-f177.google.com with SMTP id 1so4421962vkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faHE5uLzzMMIXxbLQnSAHKHQ7h63WsGlPBA2VsHG9i4=;
        b=J3JGsVHA+U9CMtYNYeNIW49KM2erVQXQXITrOO2Q8CoMYBI4xkmm799xOXzoSl7cXc
         8pctAEKGMHiG2wE83oQBKM+PDO9J9mqKfa4FjmG01DasyVXb2WH7FYEVd2qufmDZo5nI
         gSuW+Kxo+81x2zD8bAbDWDgMZvATiG0L8QxQhhav9aX+u9qNsU0kQtAX6U1EGDiL0XLr
         XkbAtWqMpmOG3Prlp3xPfq5vol1inPZxX6lprBYKngjWZs++luAZ83Mtcg86WM53nY9u
         SE35bMhKx0oG1NT6nTPlz1iMsJ9eHgNi1vdPIiD55u8alrhFlC9tcT6jPlIsxalnHoo1
         aF+Q==
X-Gm-Message-State: AOAM530RSplnSsOS0hp6YmrGMpjhgjqCH089AML2DdB9iDpgrlFjQeVg
        +PZ8/HJfPlBRhqNIxG7HZBMby8Vf4hsbH4SigY0ZHTZbKN4=
X-Google-Smtp-Source: ABdhPJyBujEAKkJwc3CxZYA/34T0Of7QAcEQZSGrCYq/UzE7wCdt75wXS1JesiZ0tErPlgSvAtwypeXQHWbK9MgIjXU=
X-Received: by 2002:a1f:21cf:: with SMTP id h198mr8200797vkh.2.1629717379832;
 Mon, 23 Aug 2021 04:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210823104942.1371825-1-geert@linux-m68k.org>
In-Reply-To: <20210823104942.1371825-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Aug 2021 13:16:08 +0200
Message-ID: <CAMuHMdVnF6yAf6ffUd7Jy2p03fbTNz6ymVGU5dUSkr18b=fo7Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 12:52 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.14-rc6[1] to v5.14-rc5[3], the summaries are:
>   - build errors: +2/-0

  + /kisskb/src/drivers/dma/idxd/init.c: error: implicit declaration
of function 'cpu_feature_enabled'
[-Werror=implicit-function-declaration]:  => 815:7
  + /kisskb/src/drivers/dma/idxd/perfmon.h: error: 'struct perf_event'
has no member named 'pmu':  => 35:13, 24:13

um-x86_64/um-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7c60610d476766e128cc4284bb6349732cbd6606/ (182 out of 189 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/36a21d51725af2ce0700c6ebcb6b9594aac658a6/ (182 out of 189 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
