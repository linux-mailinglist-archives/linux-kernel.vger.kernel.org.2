Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD862419E60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhI0Sgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbhI0Sgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:36:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E397C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:35:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so80068606lfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jIsaeZxB9iIHx2Xlr4ffwG7DDOBE7KZeGUWD2K48eI=;
        b=DGnGiVsWgNqibsS1Ab5nKqt7YSbGTS5Tcr0kHz7SyALq+hN2DJXB66SHS6HvDYU2RC
         wX6Jz58IJLYRva+k9kqC0ZdmYbOQu/f6gkWyrVI5GZXHj+f/rVDt+ctTpvanz5gi9wji
         /kiqtD3eiPtfH8Ab50k3VlieyRneSVxG+cw9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jIsaeZxB9iIHx2Xlr4ffwG7DDOBE7KZeGUWD2K48eI=;
        b=A/8L7q5Y4BHsIRFUKYPo9tyJaMzahESHUEk7S9ZFu/JKUMGPCzZz+EPEbcKd7B7v3K
         rZVYQ+XDUkwa2i5wbyRZJlTModuazn4wZH+CXeE5CWH8ZfL0wMMFSQT/DSbTvAC2YQWK
         H+Ys39jx1AlYMjmjilAiTAgimddPhpnHEFG4fJ7y8oCnonLZQwteNTE3vSBySe9WP0Uz
         //7BxV56lrNI/kADGCUcGQccrPmRFQV7aB6YTowMEvv9ABtw096uLc1PT55O1ciQ3mXm
         N5DyopiChprhYOeBQSP4FvS2biVTfU13hlDYq0Xds2icf6+WYBi0hBZeuQJLeiS0wOmN
         PTzw==
X-Gm-Message-State: AOAM531e6Ik5ESqf8fSx6JWnjRWcKZ1H/hnIV7l0xQJza0skFROfKCnA
        VALS5tyGrsVlPTi/qT36whmczOddEm8qX/c1gbw=
X-Google-Smtp-Source: ABdhPJxufNLwPMdAapbQcwW/G1OQ/NSd/Nd/MVRaKkEM9iWgur9lXfNBY5+PNPkNqgtxeQyXbsdRVA==
X-Received: by 2002:a05:6512:3087:: with SMTP id z7mr1261631lfd.556.1632767713713;
        Mon, 27 Sep 2021 11:35:13 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m10sm1675252lfc.83.2021.09.27.11.35.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:35:12 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id i4so81250604lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:35:11 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr1347010ljf.191.1632767710543;
 Mon, 27 Sep 2021 11:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIFNf/xZwlrWstK@moria.home.lan>
In-Reply-To: <YVIFNf/xZwlrWstK@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Sep 2021 11:34:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaL3xcv6LL=1+WdaicaDngvNOTCYU5c9UF_MTsibWBSw@mail.gmail.com>
Message-ID: <CAHk-=wjaL3xcv6LL=1+WdaicaDngvNOTCYU5c9UF_MTsibWBSw@mail.gmail.com>
Subject: Re: Struct page proposal
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:54 AM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> That list_head is the problematic one. Why do we need to be able to take a page
> from the middle of a freelist?

At least for the merging with the buddy page case.

          Linus
