Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE1843B99F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbhJZSd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbhJZSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:33:28 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA810C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:31:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e2so310827ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXguLh0WNHEKlfFuQvMTGTJ+7qrh6TUIs5KKrA5WmaA=;
        b=WoIY+3XdSLW9YQe7GBf/6F1NA6RHYjzIp8j60phOurkXAHlRC8TPVC0LXcErTJfae0
         NRbIOwv1z+NqQFeyKR8Nk7pF/rFqREGBipIUkO10+CJ+6xScbZ1KpkrW+cM8Zhz3Wrfu
         hpEoiclGT0yC4qAQrH2iTxrhuwIYk4UpPNbmnolvw4YEXdH5rZJpTkynDvIxx9YWpwN8
         nXRlBhH/6qQ/8sOfIIfbBSxylC81esVi3rtpGs0/cNdYHbPJ8DDe1jt6fzycHSZhU/ou
         LxnNyZGXctoRenoSIL+9HxmXDUhOs1zA+56xSstmnqRJ6RPoLvlGTeEcWpZB3M+3tBbI
         Ffzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXguLh0WNHEKlfFuQvMTGTJ+7qrh6TUIs5KKrA5WmaA=;
        b=c4qJ9zO8H0nKWMRLuwvavC77vV/TGF1x1PqbrlPF1d1mOwcENPzwuXpbi+eqqnq6i+
         mT7f1c67QVym76o6qlPHCOMkQZN2RLZ5yCKp3hPgTIdK29+XaG8VY5sx1sWb47MnXKOF
         1FADcrcpEAme3mXXG8C/3pCwMsI/GtLRsLUslUE8hxwCpmC5qbIjuJAKFdjWamngC7B4
         1bhLEBFucOvyGix0WW7j1scsMmOIFjAc58+9HQ5cCx1RlvzpJBtJhVpGDkJZCiBhuVUC
         apk0KSVoRJbJKt4aOnhzjUsqeDwdq9tVKaobVQAqHT5dmWxY/vH4JuddAfkfekZZx3Ju
         3vTQ==
X-Gm-Message-State: AOAM532FYyMTbr3ZCuB+tpSMt2kGgdboUIyLGgWr10ac/6/GdVhRWTBa
        dZQktIVHYmmAZMUJsPA/pVHJVdQKnfsLldfcfbAR1w==
X-Google-Smtp-Source: ABdhPJwcHcUxMTqtPzF5w+8vub3atUhPoOQHVlp/Fute42ZIqRwtsKMfstBI1lw8sOTsX8J4z656SBaTKhpsyVvO11E=
X-Received: by 2002:a2e:9b0e:: with SMTP id u14mr27526325lji.247.1635273062045;
 Tue, 26 Oct 2021 11:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com> <YXhHq52jDrU61V4E@casper.infradead.org>
In-Reply-To: <YXhHq52jDrU61V4E@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Oct 2021 14:30:25 -0400
Message-ID: <CA+CK2bBbGEJa4s7HtgQkG_tZmN66UaVcDRovgLz4q+a0VGSqZg@mail.gmail.com>
Subject: Re: [RFC 0/8] Hardening page _refcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        weixugc@google.com, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 2:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 26, 2021 at 05:38:14PM +0000, Pasha Tatashin wrote:
> > It is hard to root cause _refcount problems, because they usually
> > manifest after the damage has occurred.  Yet, they can lead to
> > catastrophic failures such memory corruptions.
> >
> > Improve debugability by adding more checks that ensure that
> > page->_refcount never turns negative (i.e. double free does not
> > happen, or free after freeze etc).
> >
> > - Check for overflow and underflow right from the functions that
> >   modify _refcount
> > - Remove set_page_count(), so we do not unconditionally overwrite
> >   _refcount with an unrestrained value
> > - Trace return values in all functions that modify _refcount
>
> I think this is overkill.  Won't we get exactly the same protection
> by simply testing that page->_refcount == 0 in set_page_count()?
> Anything which triggers that BUG_ON would already be buggy because
> it can race with speculative gets.

We can't because set_page_count(v) is used for
1. changing _refcount form a current value to unconstrained v
2.  initialize _refcount from undefined state to v.

In this work we forbid the first case, and reduce the second case to
initialize only to 1.

Pasha
