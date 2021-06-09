Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E844D3A10F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhFIKY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhFIKY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:24:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869ABC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:22:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c11so30988537ljd.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6uruXXgycz3PzmsGxFp0d1BH6LTSufRmzFrWdqQ4mc=;
        b=WB4dEGpOdPinEm37yCSXeOb6D6NGmvodkCMIURE5OEsPRgAChjTgjUOf1BPGpxDlSt
         XZ37m8l/AMowyMdfL8Tk5AmkhDlZN5ZO4DRPLEggRE/Fw4t0dCRTTQO5okB7njurPmm8
         HHC0xGkm9eD8c1tAt+RaST4qnWogEoyparX5k+PHvDIbOKnIugRkigaogQE+eDphZ0R8
         MkjmwjqyN5bDSVB8gpNUAM6KScvwAWU02bchsevARH3lUNk/m70Qt6TKpbJVnZ2z+heZ
         V156Rd6p2c/GNE0qgY7PKicdhzhWr9EpgkomRMyujgbsb5758ggedPeKi0m4ktFO2Kof
         3rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6uruXXgycz3PzmsGxFp0d1BH6LTSufRmzFrWdqQ4mc=;
        b=YGsBSqGTd0LMG1xVCLfSFPfQ4YIjNhXp6K7kpLF6nBXrNmaoQEy7l3D344a1+CToY4
         j7cggP4rMfN4ksvdVmJpK6maoiTL95ZF0d1eawTCXwlAU15yimFz9f5Njig8Qq4Tzv/S
         3bpnjGybRjvkdQRqt+NScDeF+T8plSVyK3S5GpzDtlufF/rUp5ouByvImwZnzI0TAy5s
         EUIOeDdrMEC/A0v8o3ReRO1oat8/AXmOQ0asFwty9lH+WI3DhsP140qZ/AMiiQtx7t6X
         dd1ZwzXb5AVeWr8vsp7CBjGezhmY0UhOeQqWyvCwcNyQVW8Zgy/SQuPpGyIHg4CJtLQi
         6laQ==
X-Gm-Message-State: AOAM5310DATu+4K7Uzn6Oysa4Tptyt39cqf6BSNmUQAx+MqVVxh7487w
        0qAjoRWqAFvBiWeHoNCZvIsVhQ==
X-Google-Smtp-Source: ABdhPJzQoY/oPwGbmN/H6HFABut1q+iI/R7BfG6S7+o2muaOpqU8h056D2LLtf6t/RTpZlzRYWWqhA==
X-Received: by 2002:a2e:a378:: with SMTP id i24mr1750832ljn.303.1623234151918;
        Wed, 09 Jun 2021 03:22:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v12sm309344lfi.6.2021.06.09.03.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:22:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7DC7810265B; Wed,  9 Jun 2021 13:22:46 +0300 (+03)
Date:   Wed, 9 Jun 2021 13:22:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] mm/thp: make is_huge_zero_pmd() safe and quicker
Message-ID: <20210609102246.hgw23tsqyw7jxts3@box.shutemov.name>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
 <21ea9ca-a1f5-8b90-5e88-95fb1c49bbfa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ea9ca-a1f5-8b90-5e88-95fb1c49bbfa@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:08:09PM -0700, Hugh Dickins wrote:
> Most callers of is_huge_zero_pmd() supply a pmd already verified present;
> but a few (notably zap_huge_pmd()) do not - it might be a pmd migration
> entry, in which the pfn is encoded differently from a present pmd: which
> might pass the is_huge_zero_pmd() test (though not on x86, since L1TF
> forced us to protect against that); or perhaps even crash in pmd_page()
> applied to a swap-like entry.
> 
> Make it safe by adding pmd_present() check into is_huge_zero_pmd() itself;
> and make it quicker by saving huge_zero_pfn, so that is_huge_zero_pmd()
> will not need to do that pmd_page() lookup each time.
> 
> __split_huge_pmd_locked() checked pmd_trans_huge() before: that worked,
> but is unnecessary now that is_huge_zero_pmd() checks present.
> 
> Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
