Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAC64193EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhI0MQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhI0MQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:16:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57FAC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:14:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b20so76793459lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uway50zvdV9IkkDWCwSqCVmkv4J6V3Me6I6p/5FbnZY=;
        b=QPQBQZ3uytQAdVOMKOE3xXA2c+FqNJOiWHzTrpKJulUSyg+Rk3BPBosCNl+ynfngxh
         JHXhEsJsTAUHyrK/xECllLRbFUXh4Rdq5VSH2Bg4mWi0ziHTyA/BFUmOs4ZHLd41oOuu
         9WHuNw7knv2w4yE36v3O6IisomdC3Y43JRUmpeUlDy0gDSKHPKIBH+woR6i+1rSq3cA1
         kdDp6OE3rdCA44wrVWkf8G5+kdVs70ayNdk2ihjGvCkFAZOT2WhprY6NKtvfTLXqy2Mg
         DHaV2ReCuDwRuiUNfZs3SEgR3W59SmB5vXm9zJlPLO42HGdlSwpr7kbp45qDj1AkoOhk
         HoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uway50zvdV9IkkDWCwSqCVmkv4J6V3Me6I6p/5FbnZY=;
        b=CHb7OTeKCuSrxxxmmpeuw5BNq3II6r2LNELjDsEF+W0g38CAiKkx/Vb7mgn+Vzz9KD
         hkmX8fu0MoiY1qZWUF8XLm3J2YiOcJtRRnqeqrOZgubm7AebflSCixXnow9WTk7A2xbf
         DBWcv0ZH5RcGOg/wx4Mp/ZwTcoJG1kf/j2d5mG+JDU2O9LT9CSt/OcUHeRJBh7G8HJZD
         ABi18X0TD8Wds8lG6OkhVU6CkOHom1m3D4jEb8IVOUX0zzobL2CZaO51nBeNM4GnSWmU
         j2ODoMlpsBZPq0qK3pH+LzTe1USx2f344oD5GGsCA6D0CDIx7Drk0ibyoGIdO7mPgCgT
         vLAw==
X-Gm-Message-State: AOAM533Q9zGKjq7RijrTAH1GRV/UIi5YF+yvd6N9AOmy/GaNymfRjPsW
        9AEuGaibRiDJCQ4n1nMie6vp6g==
X-Google-Smtp-Source: ABdhPJyCvwqIpXfij1yuQcR7ZfznCVQpcripRFjCjrhYgkCPw/+DnxS5Jb3lg3RDG4+xF3ht/mBh8A==
X-Received: by 2002:a2e:a4cb:: with SMTP id p11mr27887999ljm.138.1632744890181;
        Mon, 27 Sep 2021 05:14:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u27sm1582411lfm.38.2021.09.27.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:14:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 26A07102FD9; Mon, 27 Sep 2021 15:14:49 +0300 (+03)
Date:   Mon, 27 Sep 2021 15:14:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/8] mm/madvise: define madvise behavior in a struct
Message-ID: <20210927121449.kac5g25aejbwvylf@box>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-5-namit@vmware.com>
 <20210927093103.g3cszw75gfctwtzk@box.shutemov.name>
 <48D4E700-0005-46D4-8EAA-B839D8449C66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48D4E700-0005-46D4-8EAA-B839D8449C66@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:31:21AM -0700, Nadav Amit wrote:
> 
> 
> > On Sep 27, 2021, at 2:31 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Sun, Sep 26, 2021 at 09:12:55AM -0700, Nadav Amit wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >> 
> >> The different behaviors of madvise are different in several ways, which
> >> are distributed across several functions. Use the design pattern from
> >> iouring in order to define the actions that are required for each
> >> behavior.
> >> 
> >> The next patches will get rid of old helper functions that are modified
> >> in this patch and the redundant use of array_index_nospec(). The next
> >> patches will add more actions for each leaf into the new struct.
> >> 
> >> No functional change is intended.
> >> 
> >> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Colin Cross <ccross@google.com>
> >> Cc: Suren Baghdasarya <surenb@google.com>
> >> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> ---
> >> mm/madvise.c | 168 +++++++++++++++++++++++++++++++++------------------
> >> 1 file changed, 109 insertions(+), 59 deletions(-)
> >> 
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 17e39c70704b..127507c71ba9 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -29,6 +29,7 @@
> >> #include <linux/swapops.h>
> >> #include <linux/shmem_fs.h>
> >> #include <linux/mmu_notifier.h>
> >> +#include <linux/nospec.h>
> >> 
> >> #include <asm/tlb.h>
> >> 
> >> @@ -39,6 +40,101 @@ struct madvise_walk_private {
> >> 	bool pageout;
> >> };
> >> 
> >> +struct madvise_info {
> >> +	u8 behavior_valid: 1;
> >> +	u8 process_behavior_valid: 1;
> >> +	u8 need_mmap_read_only: 1;
> >> +};
> >> +
> >> +static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {
> > 
> > MADV_SOFT_OFFLINE+1 smells bad.
> 
> I can set another constant instead and let the compiler shout if anything
> outside the array is initialized.

I would rather introduce a function that would return struct madvise_info
for a given behavior. The function would have a switch inside. The default:
may have BUILD_BUG() or something.

-- 
 Kirill A. Shutemov
