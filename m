Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8053E3BE5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 19:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhHHRWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 13:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhHHRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 13:22:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B798C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 10:22:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c9so18160977wri.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xr4kzAIVCjF5FWTWh8J9rcezZE9QmpHisTh5XpSTVq4=;
        b=mDxynq6Jq//Ri1glX3u9qsjJ6/u+r4M7lt2FY7TsRKMyANRxSlDVUuJ/LIYWwITwG/
         VLOKicPlQtys7CtvUq+IPzuOKYqpYuhDFfWD8hXMvNuCuXW2qXfhgQqv+sYPddsu3Gn3
         Zlp4ewD8HXuQipWBBhIcXhYfyzGBwD/iZLi2uH16SBGvfmmmpokOMIV9VUp+/xzj3YPZ
         30qs1UPhU6JYsD72FfCVMgyELf+UfY9oEja3Y8fbCwm/HW3ZjqFYaOCTdMxF1jYlqkNi
         bMkAgXbiJdzXqMWd/N3b7dRtHUkTSK49XyKPqhTx8p5lWbL1DtLxId0We8gZ/DJLWGgp
         0UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xr4kzAIVCjF5FWTWh8J9rcezZE9QmpHisTh5XpSTVq4=;
        b=WHtSZVxHhpzCUrVTPYep5FMTEFSRf1UywTfQjC1VpbvacxcFdRsU8W9S1kgBXKd7k/
         7N/++INRe5Ydnh+rCBkkW9yG1ffAVCHXmQEEOpbSBotWc8KHIkeEdUcViqSm1WjpvqfI
         LwG5MS6ywtHrk87Jy7wkmPy69ptDFTPt66ZDeILyblCNG9RVIOQcYo8K9+4DE5o0wteg
         04DLSsIFXRBhPf0ulYuEuGyLxPTnwr7bofwU83OOlg44iaoK1A7tpboB5IiXq75UBavK
         bFFHhir19Z07pspc654OHnbkOtfYoCcmTsbF3DQXZIM2i9Ou6SQ0b3DipyZQUAE0hSYN
         CFgQ==
X-Gm-Message-State: AOAM533TWbaWdFRm3Ekwx+QSPth0CrGsPwYrcTOPl0IqSQURfuYpBx8G
        dNjStZj+sCrmVhY2g5HVgOIpN9ROwQXP1IVB5snf/g==
X-Google-Smtp-Source: ABdhPJyFFefuLsnyCCaoulIxQ4VUhijEdFZCwn+kZxl577A90oqK14aJQG1mV/gJhdfOQAr7zs2QlK2gH0l5krIEYnk=
X-Received: by 2002:adf:f68d:: with SMTP id v13mr2877761wrp.358.1628443319773;
 Sun, 08 Aug 2021 10:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-4-yuzhao@google.com>
 <YQkqMhGsra8YCVoU@casper.infradead.org>
In-Reply-To: <YQkqMhGsra8YCVoU@casper.infradead.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 8 Aug 2021 11:21:48 -0600
Message-ID: <CAOUHufZYt+QbOmhrjXiwOAWXAXMYAzHy8gUas8MtzxJGNWqxAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: don't remap clean subpages when splitting
 isolated thp
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 5:38 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Jul 31, 2021 at 12:39:38AM -0600, Yu Zhao wrote:
> > +++ b/include/linux/rmap.h
> > @@ -243,7 +243,7 @@ int page_mkclean(struct page *);
> >   */
> >  void page_mlock(struct page *page);
> >
> > -void remove_migration_ptes(struct page *old, struct page *new, bool locked);
> > +void remove_migration_ptes(struct page *old, struct page *new, bool locked, bool unmap_clean);
>
> I'm not a big fan of 'bool, bool'.  Could we use a flag word instead?
>
> #define MIGRATE_REMOVE_LOCKED   1
> #define MIGRATE_UNMAP_CLEAN     2

Will do. Thanks.
