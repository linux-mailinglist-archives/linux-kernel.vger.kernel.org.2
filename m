Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1153A2E40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFJOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231356AbhFJOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623335471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0VZTN3R2rXjD61PUqH94pStzeb8jjlq9I3l1ZVwBtoA=;
        b=WSsu7y9l3aUCQlBMxUnpnwDvYVTj7XXKsVMUQAV+HaPJUzfOb4pf+tHAEDNqIDdg4PPjlB
        2/sLfX/JAhBWbTpB4WhDm6rX16roY7qWmIdSY/5+/DTdqZBjT1JH3aUXOUWm+J0TdCdV5b
        KSHM8bbp5bRymO7IBoT28uzaPAh6xCo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-NY-thgLANIa4jVCSzQVA2A-1; Thu, 10 Jun 2021 10:31:09 -0400
X-MC-Unique: NY-thgLANIa4jVCSzQVA2A-1
Received: by mail-qk1-f198.google.com with SMTP id c15-20020ae9e20f0000b02903aafa8c83e7so5086362qkc.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0VZTN3R2rXjD61PUqH94pStzeb8jjlq9I3l1ZVwBtoA=;
        b=G4nCOxTgdub90vVPPgqjeQzz+RsZb5/4bnRpQ9ftyhJHel9kt2i0kf2gspuoShJ5sa
         fWik1Ec/J5X/t8+dNkyKSMgVj3Ie+lzuVHb2XLBSWVrBTvWDs4AsA9F/eCK3i0n1KkLM
         kyXU6Ef3bIrx7NrydlpVaHlagXUC+P0fymQBDAFwZbDHsXoJiO2t4FI9t84ymuMeilMO
         xG2AIQjrFXdelzMNYZfzkxCQFisEnf/1OJEWsz494zArT/bQbQ4i4sVdl3SksbgQ+tSm
         iofuLSfVjpqa+ZSXTUsaTcoCoDR+ld4LPuqPEX8G7/8NC9zqDQhlW+KusSCu8fwva2jj
         2kSQ==
X-Gm-Message-State: AOAM5322TJSHC2MvqZKEPQ2elKJWaqWXzjD6KfNGNHjTQMxJfMkokEdf
        6/hrhLQFkGRrfKroQi8/XIegSkUlA8D/na9exsSADVkaoZ4BqhxI2hpq0t72OBS/ZVC0lf8pnNJ
        D+YeQuAirXMT558WXYM0AT3a0
X-Received: by 2002:a05:620a:142f:: with SMTP id k15mr4861067qkj.45.1623335469151;
        Thu, 10 Jun 2021 07:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaXtWdI4izo1rF2l9lVelqqAY3pjMU8ji/IWRwI5GEqoBIXP4m9XphwynSSZDXWCgmPaIwrQ==
X-Received: by 2002:a05:620a:142f:: with SMTP id k15mr4861031qkj.45.1623335468800;
        Thu, 10 Jun 2021 07:31:08 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id c23sm2330972qkc.3.2021.06.10.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:31:08 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:31:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd
Message-ID: <YMIiKopOMrWZiFCY@t490s>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <53fbc9d-891e-46b2-cb4b-468c3b19238e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53fbc9d-891e-46b2-cb4b-468c3b19238e@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:40:08PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: re-evaluate pmde after taking lock, then
> use it in subsequent tests, instead of repeatedly dereferencing pointer.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

