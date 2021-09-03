Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38F6400433
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350257AbhICRid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350131AbhICRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:38:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C78C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 10:37:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y6so42115lje.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVoeDRCjbIrkbAE/9p73s/VaveAMWQIPwuXda/nZblk=;
        b=Cq4nr560UV2fO3Qvu2QeNzaXnPfJkTEjZQ3fjQxM3QcTx9hUmVMzgwHCVahBBo11d0
         DjHNHv0LVFfRU2T3WpuHQLMDX1i1z4tRxuV9RrybEsOD5MhCy/eVmQwuz8yozphGS1V2
         6KQ/uV2NNNJ/+2NafSj1lnaMQPZFVYGYrfg+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVoeDRCjbIrkbAE/9p73s/VaveAMWQIPwuXda/nZblk=;
        b=hLju9Ah6Gx2bMbl4ptlrcBhq0C4aLNbRpxqRF5rh+UibZdjnJ3/qzRDaulGT86BNie
         PwenWdnjYTYplI8UQ3ImKgfHaeoiZvvEBbjNm8Ixi3upE8g4IpAwNILZg7xlcfFFXq/0
         4Xw8o63TAzFMcz0oxJfGPLDxpEq2aQchX6L8mMdHjoS/99eLhdiJHxWtlYA+XYX5j0df
         w2Y3Ms16mYdTwP0/Ldd9Z2Hg202vlTKVXcpR7KVnNXSTTsWd0i0ke0HZmos3irlxWQ67
         u3SKoY9VRT6F5TBHZCJusalrUKpVPKBQ+TxqvtRt9S1bTaeN5ME408QDzc+ISLIufkCn
         FjrA==
X-Gm-Message-State: AOAM533P13Rpkxcg2qFIA1ys7vBwNjGTFVmf4dce9PdJqX5je83Z31vw
        bgiSdDziTCg/8WCsu21cUcKpE8chJ+H2qnHOFX4=
X-Google-Smtp-Source: ABdhPJxdWGkRqAb92csDI4nfsM9mzx7Ss1L05YzcL7E5sBocxRi08oEzhEPDj4wqU4iBNvPFFkP6Xg==
X-Received: by 2002:a05:651c:54e:: with SMTP id q14mr144276ljp.152.1630690648607;
        Fri, 03 Sep 2021 10:37:28 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u3sm614145lju.107.2021.09.03.10.37.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 10:37:27 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bq28so13158337lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:37:27 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr59624lfr.173.1630690646762;
 Fri, 03 Sep 2021 10:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <YS/r5eaf/ps5ekie@localhost.localdomain> <CAHk-=wiYNEj8JRO3f4L9GG06Akwwr18mM4Co8nWeAH44a9y-aw@mail.gmail.com>
 <bceb9212-8fb0-be6e-997f-82962f855081@arm.com> <CAHk-=wg35pAyCFC6_hhBTAGGUPprf=hwx5+Ey1tnqXzuaOLsRQ@mail.gmail.com>
 <ab606dd7-87a7-25cd-8f0e-841638cc40e3@arm.com>
In-Reply-To: <ab606dd7-87a7-25cd-8f0e-841638cc40e3@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 10:37:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGs=YDah3mBfi5A0Vh7OMeLfk3yOw219nvRAeghLmHGg@mail.gmail.com>
Message-ID: <CAHk-=wiGs=YDah3mBfi5A0Vh7OMeLfk3yOw219nvRAeghLmHGg@mail.gmail.com>
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.15
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Claire Chang <tientzu@chromium.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Will Deacon <will@kernel.org>, pasic@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 6:51 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> > "essentially"? "shouldn't be expected"? I'm not getting a lot of warm
> > and fuzzies from that. I'd like to have something a bit more concrete.
>
> As above, upstream Kconfigs do prevent any possible overlap at the
> moment (with "swiotlb: use depends on for DMA_RESTRICTED_POOL" fixing
> the bug which inadvertently made SWIOTLB user-selectable).

Ok. I've done the merge, I do hope that this code can be clarified at
some point in the future.

             Linus
