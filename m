Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A341B4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbhI1RBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241907AbhI1RBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:01:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0DC361352
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632848402;
        bh=LG73icpSNBU/h5t34vTPoYSK6Cz2xz8oCZHbpUZyobE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mrm3kuuRt9rTs8NzBZWKzW9esRU3J2gFAarVZlpdoVicveeRdIEpnxnHjVjpc3MLd
         qE2lRrMsL6807RAQbe8tCWwp/k+47coKlK874eHIHxpofe3f11ZbPR4VkEkRHd6/ME
         RRu0NJFkri4xR39TJd2LtSpOoNJrDZzSAIeOp2LrhoUMQzcepDayORyoU04TDBScv/
         9X1kk02S95m0EotJLtdfer0+O7aN3k9CUmZ4zlKu4q/f2JMsRlQC0jzZNdcxxO7s2l
         0kZkmoah/UHYPpBPI/23fqgxsy27QnWQVoToOiYvlXmepnwDAn4NvsE3yXFk+SZdQh
         X+muqectLw59Q==
Received: by mail-lf1-f42.google.com with SMTP id y28so94583271lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:00:02 -0700 (PDT)
X-Gm-Message-State: AOAM530uO5iCxeRbmMU5h7GPf44tPnRhJD4kXyY/BXgtBNXeYTC6GBwB
        IB/HzyBopZZkzUXLKbkoV9lTYFPfMGDUGdCowRE=
X-Google-Smtp-Source: ABdhPJxY+7EIdyIqAHPL7HS8zvTNn2gElYimnSM6iaXJpYTEkKGO3fCLONhSZe9SIqGhVwfZnGJja/w17Fp28QsN9eU=
X-Received: by 2002:a2e:7503:: with SMTP id q3mr1068082ljc.48.1632848400893;
 Tue, 28 Sep 2021 10:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com> <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com> <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com> <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <YVMFT+hrePumXlDU@casper.infradead.org>
In-Reply-To: <YVMFT+hrePumXlDU@casper.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Sep 2021 09:59:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4833=8MnSeF7N8WUwubp4YQ+WXM8AdZkaiDgymXnkAkg@mail.gmail.com>
Message-ID: <CAPhsuW4833=8MnSeF7N8WUwubp4YQ+WXM8AdZkaiDgymXnkAkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:07 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Sep 27, 2021 at 03:24:47PM -0700, Song Liu wrote:
> > OTOH, does it make sense to block writes within khugepaged, like:
> > @@ -1652,6 +1653,11 @@ static void collapse_file(struct mm_struct *mm,
> >         /* Only allocate from the target node */
> >         gfp = alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
> >
> > +       if (deny_write_access(file)) {
> > +               result = SCAN_BUSY_WRITE;
> > +               return;
> > +       }
>
> The problem is that it denies, rather than blocking.  That means that the
> writer gets ETXTBSY instead of waiting until khugepaged is done.
>

Yes, I was thinking about the same problem last night and this morning.
Unfortunately, I haven't got a good solution yet. Do you have some
suggestions on this?

Thanks,
Song
