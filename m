Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93673AE95E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFUMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFUMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:47:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:45:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso17548188otj.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O21GciyTpaxqmDgMZPyp7BhBIp+OaBFdrCDg/nqizCw=;
        b=CjH/y8SaoMXF3byYcObLTv0osehq88mbaxDpOhZs0Wde7MnJHOtQUe+kCASuohN8oG
         aOWjfAalOynXbrGRj/MB2LUyVcX9vr8SKfNkA6vR5F8unfVTmTYZtR49cCle1lEV11Xh
         Ej0cE2eP1kq4/I+8RSOKISdSP+5LyhiOFPyq9/3gcbEJQF0JV7o3XkzEI0ZvlwqsSBjm
         1mTGYUNavnyfjgaO7A1ymewQLHi03NM0RPUjmuFWlioFGMBlH2hAjljmtBsJmO9pc7h4
         RtUtfdeApE98KZ6pE/LExb0eKC8qA2+ShDr0eTtERUy9CEZRTeXGdg2uczBqW8+RnCuu
         J33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O21GciyTpaxqmDgMZPyp7BhBIp+OaBFdrCDg/nqizCw=;
        b=LU3NGJUkFj+j4dFeF7rGcz299gygi/lNXDVZXDtptQnWK9EOB+Tnux3b5RYBHG2uUp
         HYCRKzaXdtViudgYhE/aXrcAJpK5jNJ7xB1u1J0EICQdogZ2l/0ykWyChGd9IXXwsVrB
         7Zq9CPM6JRqSJQNlo8G5eisKOyUMz+buDjra36qrPPB33sB87+j8JvsOiR1pfapzbXI/
         O09vAIj2d0uAX/85z794yU/mWJE3kXe5gKB9KQFBZHJGPDCj2zdnnNMwi7l0CeSnjPbt
         g8QJflb/bDHpXEFD4uun6eTldPLgGqAwE4negcA/pxhXmNEBESSnE8XxgYN8r4V1M0sR
         ctOw==
X-Gm-Message-State: AOAM533m8zsH6umLjajpyyzk7x+OWr3v58eXGzxU4EdUXUi4pZ5PnNb0
        DJ1FGj9vfNjUyfIFLO3w9jTF/R04PrzHmWl0A37OCg==
X-Google-Smtp-Source: ABdhPJzU6m6lFzkIY/6suaM+3/SBqnWkGz1uc7je6Xn6rX8rQ595uL4fIZD/BMSlOIOl3gn/FRim1zid6MPDXSS0vfQ=
X-Received: by 2002:a9d:4e7:: with SMTP id 94mr21273799otm.233.1624279532556;
 Mon, 21 Jun 2021 05:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Jun 2021 14:45:20 +0200
Message-ID: <CANpmjNP9n8-m4MhY6Cdnfx_SYLVtG8NJ7raMUR+3rBoNyyfs+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] kasan: add memory corruption identification
 support for hw tag-based kasan
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2021 at 13:48, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> Add memory corruption identification for hardware tag-based KASAN mode.
>
> Changes since v3:
>  - Preserve Copyright from hw_tags.c/sw_tags.c and
>    report_sw_tags.c/report_hw_tags.c
>  - Make non-trivial change in kasan sw tag-based mode
>
> Changes since v2:
>  - Thanks for Marco's Suggestion
>  - Rename the CONFIG_KASAN_SW_TAGS_IDENTIFY
>  - Integrate tag-based kasan common part
>  - Rebase to latest linux-next
>
> Kuan-Ying Lee (3):
>   kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to
>     CONFIG_KASAN_TAGS_IDENTIFY
>   kasan: integrate the common part of two KASAN tag-based modes
>   kasan: add memory corruption identification support for hardware
>     tag-based mode

I think this looks fine, thank you for your efforts. How did you test
this? Did you run the lib/test_kasan module with both SW_TAGS and
HW_TAGS mode? I was about to run that before adding my Reviewed-by.

Andrey, Alex, if you have time, please have a quick look at the series.

Thanks,
-- Marco
