Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAB3A7446
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFOCse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFOCs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:48:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2892C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:46:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gt18so1377291ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVu/q50mLKZC8+FmqE6RzI+X9/hmuWYOAB854u4sNe0=;
        b=lH8grbcFhCAO4tnhWvsAdMiBjS0dTx3HutQQBO9coicIiuYTgrOeRLwpRjHXqMce1/
         jlap8x9hVMfojCAQL0TmYXz+FyLqz+bqKIlRSJS3e+s2DHZplVtmv0r7hBkVZzC2o+er
         nxlHTtAb3r4mchIxkgI5MOGYLAzko3i2pecmOL0Z42EF0b3ox+/Pmr1dSd7003L0FrDr
         aoAuPuvRiIIuj+kiBzu5zJQcJDus9CmYTMuIB9AyBdYK4OnA7adx7M6L4FlbGfyhjdmq
         I8QALrFxn/N9hR0DJ6Xv8/n4+4+0/0zRI6bM7liU6yRbMP0oPJL0Pt48DtbAVjrqTH/u
         BxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVu/q50mLKZC8+FmqE6RzI+X9/hmuWYOAB854u4sNe0=;
        b=MWlssjUwyrX1417TslAeDnVWZXx2AkPHF0fgcjBx9x4FEHwY6EjfMJzDGU9cWme/+R
         k7RoXE8Zahj9YkwuMjZ9ono+1M0iafmG6R7+Sjc4nJez7q+Tif7KulkcT13oSV87bTDF
         vZRbtq1JaEyIFuyOV+sKuiN5zT7EfG6v68Ou7IoRagKiB7yXhUwpV80vVBNVGujMlZu8
         aCrB255pqCw/wCbOqbucoiM7o+fEdx05ZCiiHK9qQSdLqQBsOJLkQAKBTFV7jSaJ62AA
         8MxVroZJTWrxWwWgvLps7Rv+eQFHjBolHA3BC30MkOHXCr005nA1qMtRsgbceuw0R71k
         5REA==
X-Gm-Message-State: AOAM533MZRRdIEE6mRMwY0PEftv/AlekNfPQMGjQRwpMJYIFHdFEWJyE
        mAgiEmqTxfVGw5+7lkOI/vRQE0d/CF4EpuVV9YZ3NYojMlx0gQ==
X-Google-Smtp-Source: ABdhPJxZ/dgSfmoQFiza4iMe8qVVuP8sYLGcxHmV82OdFool6B9csSY6OkHOGeXlUVIIywTaOOGzKuIwejrZQ+CsBo0=
X-Received: by 2002:a05:6512:1144:: with SMTP id m4mr14563109lfg.390.1623724714373;
 Mon, 14 Jun 2021 19:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210615012014.1100672-1-jannh@google.com> <20210614190032.09d8b7ac530c8b14ace44b82@linux-foundation.org>
 <CAG48ez1nZcrJPO-hOLyE08g8HKSGEambCp6mNv6FNR2c9+6sJg@mail.gmail.com>
In-Reply-To: <CAG48ez1nZcrJPO-hOLyE08g8HKSGEambCp6mNv6FNR2c9+6sJg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 15 Jun 2021 04:38:08 +0200
Message-ID: <CAG48ez1uODg-_6LrLsLzCoBr=VEBisfeNhSkTmYgwG0Ldq+Dxg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/gup: fix try_grab_compound_head() race with split_huge_page()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        stable <stable@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 4:36 AM Jann Horn <jannh@google.com> wrote:
> If you don't like the ifdeffery in this patch, can you please merge
> the v1 patch? It's not like I was adding a new BUG_ON(), I was just
> refactoring an existing BUG_ON() into a helper function, so I wasn't
> making things worse; and I don't want to think about how to best
> design WARN/BUG macros for the VM subsystem in order to land this
> bugfix.

Ah, nevermind, I hadn't seen that you already merged this one.
