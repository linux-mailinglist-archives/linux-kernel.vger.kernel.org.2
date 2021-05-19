Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651FB38852B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 05:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbhESDTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbhESDTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 23:19:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06942C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:17:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r5so16819845lfr.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxNVQPiC8fzbxLiyAUu9bsx0HZLll8xQ7nokNM1IEpE=;
        b=efD+mqUpjR1dd0ERhmnuJ8hRRDA/3RqzPWiqZBAtCryCyZaUtomUS3IfTkjeOIA9UX
         vBYuvUtTNGWnCphyRb0vD9f00gYJMkWS0ezJAJrKjSGqpbyYVJDj/iFthwRLa6uFHtLg
         KLBoPW3UfdmH/fKmEoIQyq87033h4rdkRyBYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxNVQPiC8fzbxLiyAUu9bsx0HZLll8xQ7nokNM1IEpE=;
        b=j7Mib+jwBXBe6qpRAzgcyCiVF+g43VMZGdO3YP1OoTdY1Jf0WMS1WbRkbkRWDPikP3
         3xd2NypsaLdpfnIcfxTXwbqXZiNmGMlXltV7/5DjoIJUJmi+hvxG8WGrqBEJn+nOAsD2
         a3r5enEA0lPjIfenCxYGNx4s5NAf096KdAzVhSL7JZztHaNhbR5y/4I+hZ0mHtkgy2DE
         bCWsKIO3pyMRNC8Xq+3Jxy+GnJQsUJHaVkZBnR6Vekkd3gA+QY8oYN1YxNM80AilLRLS
         eQNuuVN6UQas33QyD73sGkITZNQ467hchVvRzkhFndhm3YBKeFCDU5kMuyhVaKzk6fEq
         yEBQ==
X-Gm-Message-State: AOAM530xv54f0q1hZKTo8Fga/UOXYn6Y6mIj5JAqhCM+NL/sfxJqERCM
        9DQZnnqR8inLso2CwNajTWMesK6HJNgp5tU/ELI=
X-Google-Smtp-Source: ABdhPJzYi9mxlr10osN85s+cglZ7g9i82LrJT0wIN3yGcB5S2A51J9QWo8Ut4UVGdFU5X9VVksZmbg==
X-Received: by 2002:ac2:4f92:: with SMTP id z18mr6446690lfs.343.1621394259145;
        Tue, 18 May 2021 20:17:39 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j8sm283017lfh.192.2021.05.18.20.17.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 20:17:38 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v8so11843672lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 20:17:37 -0700 (PDT)
X-Received: by 2002:a05:6512:1047:: with SMTP id c7mr6691613lfb.253.1621394257275;
 Tue, 18 May 2021 20:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210519013313.1274454-1-ying.huang@intel.com>
In-Reply-To: <20210519013313.1274454-1-ying.huang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 17:17:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=wig4SQjBLtmFODs6oXukwrO0o5CPUVzxT2UvJM9jvwSiA@mail.gmail.com>
Message-ID: <CAHk-=wig4SQjBLtmFODs6oXukwrO0o5CPUVzxT2UvJM9jvwSiA@mail.gmail.com>
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

On Tue, May 18, 2021 at 3:33 PM Huang Ying <ying.huang@intel.com> wrote:
>
> With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
> COW, the idle swap cache (neither the page nor the corresponding swap
> entry is mapped by any process) will be left at the original position
> in the LRU list.  While it may be in the active list or the head of
> the inactive list, so that vmscan may take more overhead or time to
> reclaim these actually unused pages.

This looks sensible to me (and numbers talk!), but as Rik says, it
would probably be a good idea to move the trylock_page()/unlock_page()
into try_to_free_idle_swapcache(), and that would make the calling
side a whole lot cleaner and easier to read.

                    Linus
