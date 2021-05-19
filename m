Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A35388534
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 05:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352962AbhESD1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 23:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbhESD1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 23:27:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6AC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:26:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w33so8897086lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpasTbcUwDlCfIGR1M3M+UXkX63OJ/48GBiL5suA0mk=;
        b=FigIIEelPosPPDJU4RFwr5/imb2qFh3HmXTIas60wCUN3GDfaauWgLaN8SeMRHVOU3
         GCYOAyQHPYFgmWa8m0X02GaNUizY/Reme/IXp+rF9BraM/pVwBpIWbNGjX1FhiLCVKyi
         W4cQZXG3SL9rc60vtfR3N5wg9vagVKhV3wXX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpasTbcUwDlCfIGR1M3M+UXkX63OJ/48GBiL5suA0mk=;
        b=CqiKpf8NtPypWf0IJXQPh3SN91hGlEx14cVsFeRlK0uTRjwTUoTIBXLHNt5PeTxp0k
         FSF9S+po0w5jiDPrtDXzNfv4MHRrEG9lTFZi4IbYMyQR8NIZhp25Td6wLKfT93uclCfA
         W7htp6ftKO8Rvbutnnj+yo+Mbj5kGiqASeQI4/1v8dV/h+IE+X1XtI8cp2lvYUI7JIA3
         X0AYBFj8nbO5Hd2pErPXhLIZywdD2u8DblIVzK5qoNVFil4jxe06lA/aqDmfExN0huvp
         1R8TmGsaExtKYOTGwar+zw6hfoi+QJGfJqv12cNMtQvPqaNYy6TGzZm8dvmVLjKzaTsR
         5MyA==
X-Gm-Message-State: AOAM532GRmbz6Lg2xtFHzphHpZbh/jDGpAE2Xe6WyjugZJnB8AEf9yN6
        OavtEiGs/Q5x+qbAopP/fB59FndYuVPiptcTSNY=
X-Google-Smtp-Source: ABdhPJz17QtlXJY1VJRqZ4cimwTZaUJSwsEzRcKbEmmyHSHhCSW6WIXM+mHsGhcfEi9QDKKC90CwLQ==
X-Received: by 2002:a05:6512:3301:: with SMTP id k1mr6445956lfe.170.1621394768475;
        Tue, 18 May 2021 20:26:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t7sm2497837lfe.170.2021.05.18.20.26.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 20:26:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v5so13835999ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:26:07 -0700 (PDT)
X-Received: by 2002:a05:651c:3de:: with SMTP id f30mr6615066ljp.251.1621394766828;
 Tue, 18 May 2021 20:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210519013313.1274454-1-ying.huang@intel.com> <CAHk-=wig4SQjBLtmFODs6oXukwrO0o5CPUVzxT2UvJM9jvwSiA@mail.gmail.com>
In-Reply-To: <CAHk-=wig4SQjBLtmFODs6oXukwrO0o5CPUVzxT2UvJM9jvwSiA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 17:25:50 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgUMC03e1Ost6q4gb7+2jWO=vBHW63OYaOHOHvi39esng@mail.gmail.com>
Message-ID: <CAHk-=wgUMC03e1Ost6q4gb7+2jWO=vBHW63OYaOHOHvi39esng@mail.gmail.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after COW
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This looks sensible to me (and numbers talk!), but as Rik says, it
> would probably be a good idea to move the trylock_page()/unlock_page()
> into try_to_free_idle_swapcache(), and that would make the calling
> side a whole lot cleaner and easier to read.

To keep the error handling simple, and keep that "if that didn't work,
just return" logic in you had, doing it as two functions like:

  static inline void locked_try_to_free_idle_swapcache(struct page *page)
  { .. your current try_to_free_idle_swapcache() .. }

  void try_to_free_idle_swapcache(struct page *page)
  {
        if (trylock_page(page)) {
                locked_try_to_free_idle_swapcache(page);
                unlock_page(page);
        }
  }

would keep that readability and simplicity.

And then the wp_page_copy() code ends up being

        if (page_copied && PageSwapCache(old_page) && !page_mapped(old_page))
                      try_to_free_idle_swapcache(old_page);

which looks pretty sensible to me: if we copied the page, and the old
page is a no longer mapped swap cache page, let's try to free it.

That's still a hell of a long conditional, partly because of those
long names. But at least it's conceptually fairly straightforward and
easy to understand what's going on.

No?

               Linus
