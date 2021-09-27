Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01A8419150
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhI0JKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhI0JKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:10:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7909C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:08:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b15so73356846lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kxoB9mdMEcTYaE8IB5Sp9G6grOx34N+1L2jpLnbwDQo=;
        b=RVlfdSdDqh2nb52hnBus/aGjFtE0qJvNCsbiMFR+TaBERfh4COBpLLJo6GxzwYDw+j
         T2JH3JqVVkxxe5vwyGrTUtlslTIGVyB7pCcpCg+d7A1oXY8RxGQqtGA46I++/XgMkKDv
         71ijReBePA0whAW4INt7iGk+D/JKsm6vPEd3oSxHN7FGvS6i6shdaO7uA1vT6NWbJJAZ
         vmNiCbSEVvgCEBEmfT58m0NyHqCABm7rzN/uLRKSFeX7GBCdyQxL0w+QUxcOf6lTatGB
         nNXyVWwSfJWGUwF3QFODGA4Z/Hb32myldrm8VFrz+E+1xZJyIkOfQbtmp/tW4trlAglI
         lWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kxoB9mdMEcTYaE8IB5Sp9G6grOx34N+1L2jpLnbwDQo=;
        b=VER4Mag+d/pxmpBLvqCf/UHYbVm9652pu+O3Ceai9IytAnlvCx0ITQVoATZdRD7id1
         UE2hAKMd6hpu2mxrfvgQqsz5GudRTvvBAPMq0qgA8U2sFN+rFh53jgFtIbdX4Q5spvx/
         CN+8cVjAaeUFsv4Q6cysvB1tqmG1dYkG8MxsIicPfngVoViK7AmBtPURFmLInVNdyj7O
         4RJWkd87w+RlIiaYUh7lt6ASqhMWc/2/SsT5ZbWByOWCkRJpH5z4QKjQMdvH02Tppa2k
         cY0gnuvQLGW2+/wp/kUOgnfQP5zkcK7rbddLQyMZdAwZcdlUEFInhrqQEF6mxV4QLaii
         N2rA==
X-Gm-Message-State: AOAM531WP+mzB4iehU9chzJgkiQHKbIOVw6vWvRRbwA9j+yYwUXLty/M
        eV0nLJp3+RY9ewbNil5r8aG9dXQRrLmzAg==
X-Google-Smtp-Source: ABdhPJwNwfYaOpwDx/Ps+4B8HoVpwhq5tkIdzspPlEGmStAbODdsSs1jy8L1kc6hatMOzrJTdHJwlw==
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr28375759ljf.191.1632733734119;
        Mon, 27 Sep 2021 02:08:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e2sm960866ljj.118.2021.09.27.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:08:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B66F510306C; Mon, 27 Sep 2021 12:08:52 +0300 (+03)
Date:   Mon, 27 Sep 2021 12:08:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/8] mm/madvise: propagate vma->vm_end changes
Message-ID: <20210927090852.sc5u65ufwvfx57rl@box.shutemov.name>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926161259.238054-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 09:12:52AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> The comment in madvise_dontneed_free() says that vma splits that occur
> while the mmap-lock is dropped, during userfaultfd_remove(), should be
> handled correctly, but nothing in the code indicates that it is so: prev
> is invalidated, and do_madvise() will therefore continue to update VMAs
> from the "obsolete" end (i.e., the one before the split).
> 
> Propagate the changes to end from madvise_dontneed_free() back to
> do_madvise() and continue the updates from the new end accordingly.

Could you describe in details a race that would lead to wrong behaviour?

If mmap lock was dropped any change to VMA layout can appear. We can have
totally unrelated VMA there.

Either way, if userspace change VMA layout for a region that is under
madvise(MADV_DONTNEED) it is totally broken. I don't see a valid reason to
do this.

The current behaviour looks reasonable to me. Yes, we can miss VMAs, but
these VMAs can also be created just after madvise() is finished.

-- 
 Kirill A. Shutemov
