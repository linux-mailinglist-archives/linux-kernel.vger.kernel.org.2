Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C913DCCEA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhHARV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhHARV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 13:21:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89D7C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 10:21:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so9584955wmq.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzvM9SoxmrTowv5D6pgvfMchPMVaYjFvxTuqL1a3S4A=;
        b=rRsHRVfKRVogQODHxYh5wnoqtYUcIZrdsmsgaoxEEWbEx8IvoB3QELsX3h91IGcSem
         TjY61fF2QpJ9TABut1mUCdcSD7CLERqjG45P6WNrdMMbDLhvQyZEaV1pxagRPzOdpmN+
         Xoozzu/ueFruLXySMahC3dKkg6Zm0TufFvN3KGVoL9GMHOYiMWk9iKpEver9WnjUn1XL
         Dzsjmrk9ypGLusGvQsx9eUsjp3Wt1Imz60OHOGBHWdM78Kk6iG/d/EI+m4cWI5ZhWHVb
         i2TEm/mRzy9Bmo08rfsEyRxyaV8jOAfld502dC7Q0qbqWyz+fPf9SSKrheC/hIZp2/cZ
         hD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzvM9SoxmrTowv5D6pgvfMchPMVaYjFvxTuqL1a3S4A=;
        b=mcumGH2IBY3V56Ty9JLDkg97J+bRvIZkaOWmJVqpxPAQ250eBZN5H1QTM5rA1sD9Ma
         cG+fwM2hNV7bdpt/GKuGSr66IJhcgSpii7zZayLHe0lRULXuAkeNHzqWEV9p3nIWeY7o
         nSn2MoQO7I4t+qGO5tjcgxzdUeTH/BSwetv7C5ZDHawFkhIzJ+sdT5PytjClE6vDL0Ih
         J5FSn1lWJFHT48W0mYV23KY6DMZ8eN17/rAoPqxwSbeJXRMJMqnDWALQqsLyx0A5y6ZB
         c4fS730b7MEiA+026Au/+79CdG1yAM20bzA/jF0n6pbpMJ9u8btcWalSN8WOL8RbTygk
         CUVA==
X-Gm-Message-State: AOAM532bA0u+WKActJH3LhetbbzI55VQHmdI8nDBOMWA79NZLCllIVdJ
        oRi1FPLj+XIemjxJS2viIwxeMdZ+PirEMhXyK+yJB7V1Y6I8Mg==
X-Google-Smtp-Source: ABdhPJx/Yzm0cUEFV0uwEAO4xDP9kVP2V1/1nHhymS4nP5099JH/bzJ9Gz1AxbYTDestqWClCiCgXw+WTsrHk0exI3w=
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr12849323wmq.101.1627838508308;
 Sun, 01 Aug 2021 10:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210520065355.2736558-1-yuzhao@google.com> <20210728015926.1553-1-hdanton@sina.com>
In-Reply-To: <20210728015926.1553-1-hdanton@sina.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 1 Aug 2021 11:21:37 -0600
Message-ID: <CAOUHufagNvQvBd45m2ZOi310_zbUc5Jg2Kn3zqmjShnY9jOrcA@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Multigenerational LRU Framework
To:     Hillf Danton <hdanton@sina.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 7:59 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 20 May 2021 00:53:41 -0600 Yu Zhao wrote:
> >
> > What's new in v3
> > ================
> > 1) Fixed a bug reported by the Arch Linux kernel team:
> >    https://github.com/zen-kernel/zen-kernel/issues/207
> > 2) Rebased to v5.13-rc2.
>
> Given no reply within two months, feel free to spin, would-be Mr Kswapd.

Thanks for the reminder. Will gladly get on it sometime this week.
