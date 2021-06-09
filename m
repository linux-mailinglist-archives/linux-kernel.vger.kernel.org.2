Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80C33A1113
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhFIKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:30:48 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36420 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhFIKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:30:45 -0400
Received: by mail-lf1-f49.google.com with SMTP id v22so35874490lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7nPZCXLPijOT5fF+FbZxX7XklvUO6QeqH4yp5xzaFwE=;
        b=Gf01+i+rhrmHv9uNBDWDc4o/KNuydo5p1MgGdFh07Uoo+QVHZHlt6MLTMN/DbW7mCN
         a6vTFWPnMtsCf4wTlZA2u3Gb8Xz+5GHAmSFv+9eLD2WDtbE71s7If/Uqqdzr8VNKy1SX
         A0wsmHGiKewJw7KfcC20flRS3LszPAHip5ia4RJ7Za6GCxzOqTJO4BzKoThXHiCjfEUR
         kRmpXjGugz/IpC3P1hv06est6m8bAPWn0hRaPEe0VCXpRVR6HzsH8Cv/vW8EhCRxt4Gi
         sUdzYSad+GLPzNIZeBblLs0VftgEtBokyA+gFODBNZBOmmprVk9BeQvgD/eXURL1FZ0p
         b0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7nPZCXLPijOT5fF+FbZxX7XklvUO6QeqH4yp5xzaFwE=;
        b=VllpI1C4YAgrl8UrQF2SL3bvljIj9U0IssAGosLQtcf/2FQ0QommxEh4sKjjBjkT+/
         a7Weus99RVU2g6f07b7EyDfIcQJ+AUWTvBTG5uld9mU4IF+7PICj9TKpfkG+esp6SY6a
         Ootd7cNvl1jomMtzQEnYOSI5e/Jz7zaRoyNrxVSTrwj3Up4mlneTBk00+MVrzAlKTr1N
         MnAibLe+9BU0OPB1T9LEeIbfqN/0tAJWt+wpo8ZvcpbvzXv49xhoVJT9dhcF+wJogi2y
         14+4yVpF0vwoqHLjPWWMb0yEWzaKqsk0ztTfNXHpRCU7gygXslBVpjH1On98mj2C+r/2
         SWxA==
X-Gm-Message-State: AOAM531Kkph257G42OJSTjs+Dopc5/SVSWuVpFvZAgtyE+yxwGpSJh1O
        sXQ9cw91Qv/miT+R1FltT0WFww==
X-Google-Smtp-Source: ABdhPJwjfxmKWEB3+rmH59gf3PO/sBFiAJZlK0/2MqOWJs+l0Ao8B7SWqlQ+PgaSFfHF90dKNoc7hg==
X-Received: by 2002:a05:6512:38ce:: with SMTP id p14mr19133331lft.197.1623234456361;
        Wed, 09 Jun 2021 03:27:36 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y22sm308374lfh.154.2021.06.09.03.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:27:35 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3AE1A10265B; Wed,  9 Jun 2021 13:27:51 +0300 (+03)
Date:   Wed, 9 Jun 2021 13:27:51 +0300
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
Subject: Re: [PATCH v2 10/10] mm: hwpoison_user_mappings() try_to_unmap()
 with TTU_SYNC
Message-ID: <20210609102751.kl4ywrx3bybyg46w@box.shutemov.name>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
 <329c28ed-95df-9a2c-8893-b444d8a6d340@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329c28ed-95df-9a2c-8893-b444d8a6d340@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:30:00PM -0700, Hugh Dickins wrote:
> TTU_SYNC prevents an unlikely race, when try_to_unmap() returns shortly
> before the page is accounted as unmapped.  It is unlikely to coincide
> with hwpoisoning, but now that we have the flag, hwpoison_user_mappings()
> would do well to use it.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
