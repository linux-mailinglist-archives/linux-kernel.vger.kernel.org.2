Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F73A0490
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhFHTkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:40:05 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:40919 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhFHTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:39:11 -0400
Received: by mail-ej1-f54.google.com with SMTP id my49so17802466ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKTPUiA9elPvGMQvcCJuNHjTNIa7sShKwEDWPPy8EEM=;
        b=YJhPa5F64W5qsXB46vVhKbDqi5siZegf325mLIcJZloLiygLe2QcoCk01IJMSn1A5Y
         l0XKyEEy81MvYt8ozVZv1tof/OjybSmlr6M3a3l/SYcT3xdsP6d0mlhlWeXukMsqLPlx
         7RiIOhXwx8BUpt7XyA7Mm+eS2zARv05N5C7Vw9oUeMkTLZnl8QXHJfgA+TdGgIQAis8d
         sOfu3HQ7pWUAhjYgbWI2xeWtboHtq1zSPo5E2wHJDlz7b4krRVlhyGSH+huv2jNBELRz
         yqjJP07h54OxYiyUGieD5U3L2GV6gPzAS4KzHrDR82CU3cC3y+W3CY8rfphTBQOGT+PI
         Hn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKTPUiA9elPvGMQvcCJuNHjTNIa7sShKwEDWPPy8EEM=;
        b=QjRnmhJy6MmKIjzJY5SHTAc0uY/wFjAOLooprD20PZOLNa+Jk71vmtpB0nVYk6pF02
         27CV0G9CjEpsbN5gwbJ9QyBE80wfOII7CQWxWsaHNpfnZFSzwK+oImOQfK4O50ubRn5r
         /f2bh84A+eCnd4ILoiV2c57SNw38IGX7PrRFRJicMoa0J4IwXpj+t/F+CacR9WobyXHs
         Hb5wI7rwIPOXJJgVefXpw9bHyM9wnUW/Ci78tkoUULOQx00Wm6wFGTnbDaxA69bvdwO/
         cUMajfxA/zW2+Gfodq9nGkHHRsyqBw6Zc6g7ocA7eUKydUFpZjGRvpcIlHODubMTpN0h
         UquA==
X-Gm-Message-State: AOAM533lrIclazFSh+k2n5uuD1O6rogp/um/jUAI8g0w8s4Kk2tq4pTM
        QaXV4+4hAYn8rGM+bv0c0gU2H9zQrlJEQqJcF9g=
X-Google-Smtp-Source: ABdhPJzy5smI5eapf2uWMTdSduOVdqYwN94fU3XJCWeuFH21fThypuQKQ4eBn2/DZmf65LeRsf+9XZ74nOyvkjySw2c=
X-Received: by 2002:a17:907:7b97:: with SMTP id ne23mr24957151ejc.499.1623180977706;
 Tue, 08 Jun 2021 12:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210604203513.240709-1-shy828301@gmail.com> <YL265A86DQe5Rgon@dhcp22.suse.cz>
 <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
 <YL5rvdzh9dou+uAz@dhcp22.suse.cz> <CAHbLzkooYAi=Hb0=oJ+2b6G=h5Sx4jnyo5L0nPYjDcBqBHnfug@mail.gmail.com>
 <YL8RFneAmSSi2Z0I@dhcp22.suse.cz> <CAHbLzkquqKOL7pH8yBdfpafeHJCUZvccNKjQBucsP7C4k83f7g@mail.gmail.com>
 <YL+ttjqJ9lEMndiA@dhcp22.suse.cz>
In-Reply-To: <YL+ttjqJ9lEMndiA@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 8 Jun 2021 12:36:05 -0700
Message-ID: <CAHbLzkrQdt+gvq-SdQoH8sVVNiSxdMqreTGsrZC4AsVpYzysWQ@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 10:49 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 08-06-21 10:15:36, Yang Shi wrote:
> [...]
> > I did some archeology, the findings are:
> >
> > The zero page has PageReserved flag set, it was skipped by the
> > explicit PageReserved check in mempolicy.c since commit f4598c8b3678
> > ("[PATCH] migration: make sure there is no attempt to migrate reserved
> > pages."). The zero page was not used anymore by do_anonymous_page()
> > since 2.6.24 by commit 557ed1fa2620 ("remove ZERO_PAGE"), then
> > reinstated by commit a13ea5b759645 ("mm: reinstate ZERO_PAGE") and
> > this commit added zero page check in vm_normal_page(), so mempolicy
> > doesn't depend on PageReserved check to skip zero page anymore since
> > then.
> >
> > So the zero page is skipped by mempolicy.c since 2.6.16.
>
> Thanks a lot! This is really useful. Can you just add it to the
> changelog so others do not have to go through the painful archeology.
>
> With that, feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks. Will add that into v2.

>
> Thanls!
> --
> Michal Hocko
> SUSE Labs
