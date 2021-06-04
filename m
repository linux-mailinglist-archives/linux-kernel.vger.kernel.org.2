Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB839BD6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFDQmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:42:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AD1C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 09:40:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e11so12334135ljn.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhFNdOFEb7tY8E3v9lMAy3fzJKa2EYZF1NmtM8kq03Y=;
        b=miPPXNCovT0YwVjgGfAqeZGUX8KyHm0bPfhSO4EFDMf1mmQLqeJOmpY5tMvpghjiIu
         4DwPBK7hc9MdrSZMgVuFgSApNQyzdRu/qSDWptesD0BbMdZFAfPXF6rAhOerWnxC+Wrg
         lEtkOuhPN2OzxJGbwyYgWmK0lKc3RKqtDwv5kEJTH41eIC7vBxbHto7OdNztvCUDmjcp
         W/zTpaVqoud7n6bx+0BMDKuig+EC3qD3ELjgeRvx1ezMotXBDlfwdmgxVzz/5/mtGlVM
         cIiYs4DFSLe6cabD1lzMemB98fSMPIZAJmA/1lNyWHAgNiNzAVtb7BYzWSvcTYn3VhWA
         vKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhFNdOFEb7tY8E3v9lMAy3fzJKa2EYZF1NmtM8kq03Y=;
        b=bOLeoxRqwlLWwftEeeIE+GhidR+dKP9gUo92Ro5xirQWOsYUNOKXravEeuKnHbk8TW
         GBugiZI2HTSf3PqUxC653G2o9mzhd/rSmAYngq6DPAwGHrntEDpY8/thgZbTi00P/VSK
         tnJDb/M2pL5++9dZY0ov+ubp2mdpxi93bSa72+IwGda0OHwMMn5GKgaNuOmpAc6W9ks1
         5J6K5x5R8JhoHdf0Xerux8b+prmnXflPFaLfp9/cx3jA0lhMtcN1ROD9+PlldSMYv3u9
         tOgFtQblOMqRnGHasPNcVga2ipGCVZPiIDwJ5gWiszXFFZUlFAyz1YRQymlNWBchnbBg
         Y6MQ==
X-Gm-Message-State: AOAM532yRu/ksfp3LAkkXYYBUdQtJnpRp9+tWSqgjc/pTm/91e/z+uF0
        tZYODiRNXVAen1j7tssIr0DJqg==
X-Google-Smtp-Source: ABdhPJzILO3kFES+M4ohJdIk/vUuefxXO0mz4bOoX24CboUrQZ1Fu36xaXBa/ZFslEz2wl3HJQAPRw==
X-Received: by 2002:a2e:9945:: with SMTP id r5mr4111309ljj.324.1622824852172;
        Fri, 04 Jun 2021 09:40:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f9sm190602lfu.71.2021.06.04.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:40:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E6EDD1027A9; Fri,  4 Jun 2021 19:41:03 +0300 (+03)
Date:   Fri, 4 Jun 2021 19:41:03 +0300
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm/thp: remap_page() is only needed on anonymous THP
Message-ID: <20210604164103.bvwe6a2avgjbjmyn@box.shutemov.name>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011415430.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011415430.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:17:19PM -0700, Hugh Dickins wrote:
> THP splitting's unmap_page() only sets TTU_SPLIT_FREEZE when PageAnon,
> and migration entries are only inserted when TTU_MIGRATION (unused here)
> or TTU_SPLIT_FREEZE is set: so it's just a waste of time for remap_page()
> to search for migration entries to remove when !PageAnon.
> 
> Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
