Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E617409909
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhIMQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhIMQ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:28:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF6DC061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:27:08 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r4so21711127ybp.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCljwccdQFwVFy93OqtVIKp3PZCDT/ADvJ86wXMBB1c=;
        b=qVzntkI8ty7TzZwssmW70rJfJG5dO830VxZRRdhP0PMesxf0cxhOS6BKeHeoSQZcXY
         ucXtZh2XKH52rRh+oML3toVHEWo3pPfNgy54xdw3DNgQsRtzyrXJFaGCIK/0GG2ONGBH
         AgTAem/Pe8z1CioKikN7gLqb91CSDjE7gEhhVAB/AryYavXNAUftiFIR6Wz4vYMj86zW
         3X8mb7xdnL3CBpMdDM/kEu5XAIJRGewznJ3d9A91R/DBQATtDhb6AjtphuR2BaZUOPF4
         a9ZxuldSe62SqjCsa2uqdTLNyViN3odKWmq31eDHbYvNt2P+JPMqi2i5G0d48LqtRed3
         BBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCljwccdQFwVFy93OqtVIKp3PZCDT/ADvJ86wXMBB1c=;
        b=JPKUfSC2zQ5+9ML3LgdiUnkbJWtYE/7Ffh+SOZdUdy8tCgutUBmDcfC9jbdnlJM+64
         WQtKGiJ2iwsrhE5in05O6Ijxpi9h0poUUiYDZ7cMhZUBLDvW75M1ITvY+4VEk3frABSA
         a8/+nAXWIIc36m81ltpWdRtP1BmMPy+ufU1Um91K1RbQ7jFZzkXxHWto+zAJIVWRJJrj
         IvJKeMRtDwK8J8S+H1aZwOWuJa+4u/cL0RmVCLDGdTZ+C8g3nFOmU1X+q1VNdjo4BJ0t
         PLtulz/Tzlb9uNSXV+Qbfpb118E3B7q7GQC3sw1pSGcBp8SEjOqUy2PgR84+Fh8iDBSH
         e/cA==
X-Gm-Message-State: AOAM530y3hGKxRMU+mX1/fPBGjcHD+QA//oeQS8vIG66RhHnKpU3cVyM
        Y7ozAllGHZ8qYiwQBO0sRaCLLu7XA+Dj+uk5TJVtjw==
X-Google-Smtp-Source: ABdhPJz27MKbWIWOFZuyc0cuHlwNoQfGdaFHQcK7JtxZ3RlsQ5t4Byfn2DRfdHGxQOyKT9AagntMY5b47icO48wTVz0=
X-Received: by 2002:a25:c011:: with SMTP id c17mr15408711ybf.291.1631550427500;
 Mon, 13 Sep 2021 09:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210913130034.103362-1-yan2228598786@gmail.com>
In-Reply-To: <20210913130034.103362-1-yan2228598786@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Sep 2021 09:26:56 -0700
Message-ID: <CANn89i+EvheAER7uHvacU0=DRsQoXkCi3P9_v0VXoTkZU7K2TA@mail.gmail.com>
Subject: Re: [PATCH] net: tcp_drop adds `reason` v5
To:     Zhongya Yan <yan2228598786@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>,
        2228598786@qq.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 6:01 AM Zhongya Yan <yan2228598786@gmail.com> wrote:
>
> Description information in the reason field of tcp_drop, "Tcp" is changed to "TCP"
> Feel free to suggest changes
>

This is a cryptic changelog.
Have you forgotten to copy/paste important information ?

We would like something that explains what the patch is about, and
eventually how to use the new functionality.

Do not assume future readers of linux TCP stack will have instant
access to all your prior versions

Also patch is about tcp,  net: prefix in patch title should be tcp:

Thanks.
