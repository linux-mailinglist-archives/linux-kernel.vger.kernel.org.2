Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6F3A466A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFKQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFKQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:24:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBEAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:22:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e2so10449764ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7VLGpzo0pic/uCZ5FLPezepVfzXChJpgysJmVZaFsc=;
        b=J/Dt9jQa1QKH8awC7zPDGpIDCC1B4T52bk/xbJkYWmrsyiPBf1xyBpuuJ6YktX8o19
         OGXWD4ofRJ+1Y/e3NXpAm87lNARcyx+eUZLb2kGvTbni8Z4d4UmVsZbpfpQ1wYz+9Ynn
         Tu2YFuveWjy2F/JCy1EWycl4zSkeUBSU/byuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7VLGpzo0pic/uCZ5FLPezepVfzXChJpgysJmVZaFsc=;
        b=HIylj2jyrLGdNiYcsb1AyZjB4UHIWLbIUp5ZEkKGhKsbyu6c7tMEAbj2fku27xlrIJ
         xgoiJB1VVNiagigylsBO2J8dfB1tD/9j2IGf0WtyHqA2FYM0c7oVbYXiEfjAub5fZTb6
         VUn/CnQqv7CeoSk3GhW4f5dtw+Svd5Aggl0Wtc3MoOhxcMkBFkmSDeleG+0fnVYWcEs+
         ZaRijr1jDaRp1mvwUNQgaGsgat6HT6aQPDVUCn9NTfv5NlAgfpby1URAVXVmWXC7Nk+A
         SacHFt2XFmJMcqu9Aewkll8qcJFoiyAFHADIes6AXvb5rOhafAOfkKpsz7DrfqvtB5Lg
         6qEw==
X-Gm-Message-State: AOAM530ioL03HZ0FFXnZQ5Q7H+IGn6Ht6nPmjFADC6iPFw3ImPP4o6Hx
        bfFrOeAiqf38U3YSBFJEf2VPH7J6gkI7hfgRj1E=
X-Google-Smtp-Source: ABdhPJwpgOVRAYcfM4VFy9KvJ/+vnE44vCSfluIJsLO+MVsN9j4yckc8B4cVU0EhRvX03PMkQrBS5w==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr3758131ljp.55.1623428549370;
        Fri, 11 Jun 2021 09:22:29 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s28sm479221ljc.34.2021.06.11.09.22.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 09:22:04 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s22so10442761ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:22:00 -0700 (PDT)
X-Received: by 2002:a2e:c52:: with SMTP id o18mr3611750ljd.411.1623428518600;
 Fri, 11 Jun 2021 09:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local> <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com> <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
In-Reply-To: <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jun 2021 09:21:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxgTB=G7P6KRneAd0s310WYK2NDisXM5P-wsNibgLrQA@mail.gmail.com>
Message-ID: <CAHk-=wgxgTB=G7P6KRneAd0s310WYK2NDisXM5P-wsNibgLrQA@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb) stable/for-linus-5.12)
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        jianxiong Gao <jxgao@google.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 3:35 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> Linus,
>
> Would you be terribly offended if I took your code (s/unsigned
> long/unsigned int), and used Chanho's description of the problem (see below)?

No offense to that at all - that looks like the right solution. See my
answer to Christoph: I do think my patch does the right one, but I
can't test it and my knowledge of the swiotlb code is not complete
enough to really do anything else than "this looks right".

And adding my sign-off to the patch is fine, but I don't necessarily
need the authorship credit - mine was a throw-away patch just looking
at what the bisection report said. All the real effort was by the
reporters (and for the commit message, Bumyong Lee & co).

Finally - looking at the two places that do have that
swiotlb_align_offset(), my reaction is "I don't understand what that
code is doing".

The index does that

        index = find_slots(dev, orig_addr, alloc_size + offset);

so that offset does seem to depend on how the find_slots code works.
Which in turn does use the same dma_get_min_align_mask() thing that
swiotlb_align_offset() uses.  So the offsets do seem to match, but
find_slots(dev() does a lot of stuff that I don't know. so...

IOW, it does reinforce my "I don't know this code AT ALL". Which just
makes me more convinced that I shouldn't get authorship of the patch
because if something goes wrong with it, I can't help.

So at most maybe a "Suggested-by:".

My patch really was based on very little context and "this is the
calculation that makes sense given the other calculations in the
function".

              Linus
