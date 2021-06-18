Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF53A3AD1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhFRSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhFRSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:04:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0ACC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:02:13 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso10507506otj.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gm6MYYB9NnNxdkRuQyLBTfy2a1l9+kymVbo6dLCaxp8=;
        b=IX/TeFICHe0M9eY2FgHiWrn+tdb/q5XFgD8uXsgjTWA8ccYLhwkhmj5LVksZqDuyP/
         WO98d4+EqUEGVeNVRkwGXvDR2KFUUsjHgWYsSZNspeMbY0pyo5tCDjX5g3a0S5zJVn5J
         VVQVThsNKNWwgywn+UIOieUM+TDA8ZHnfFAZ0UJx9g4jXc4QSs4THTGKFETKMbtCQOhC
         oohAmV/ouLnwljoWkk30lA1Ew7AeSHyL7YWAUXHRppPW6exwVxxl6v4oWTx8GoKtepVU
         0FuNut9qWjAnX/+VsjdAfRTl/lf12Qwyt/IudALVfQNQswOIeBJ2fnVR25hgKkqCacht
         +gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gm6MYYB9NnNxdkRuQyLBTfy2a1l9+kymVbo6dLCaxp8=;
        b=Zk8jzMepR7NH6uSY6y+qZqdwEd398z47Ii/lRNRm8hjPyhaMmXaJR2CrgiIzIsYq/4
         h6+wct+ktmDQFawhC8bM8bsPPjMSFGjma+YSdbr+Ryv8VL+2Vi10BGhjVgjYNiWIqhF7
         hHe1/xx8hCIUx6IiB5P9zGDKzMkqtYb6enCS4roJB6tysZYRC9mmjYr92eF2T+njx+HZ
         1G8snjpNLr6QCbApowiFqEfehubDp28QcbGl7mRvXToxT6RWXsO72GzUL0+2KMWkoRdd
         f4Ao6CbtwnhY8yTZH3/mEZbycanFcxxHeZAKMgB76YGZFc+qQm9LkIc+0dclKClKnG64
         GR8w==
X-Gm-Message-State: AOAM5306BZYEas6BHnTeKr51itY1E5LRgpaZyqNITNOUOuBouft/OXMv
        Uh5OPpA9ccy97yrtF1OWDx1FsO1jaA+HObX2skGFIQ==
X-Google-Smtp-Source: ABdhPJzDjg2IGcepCwb5aVYpL0iyoVlRw7VwKmnVSWke5phSkT/PVMVrc8WMy+XMkfj6Q5UajD7a40VUOZZuPPBY+Tc=
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr10406630otl.8.1624039332635;
 Fri, 18 Jun 2021 11:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local> <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com> <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan> <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora> <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de> <YMrfWBLsJxCRhX5U@atmark-techno.com>
In-Reply-To: <YMrfWBLsJxCRhX5U@atmark-techno.com>
From:   Jianxiong Gao <jxgao@google.com>
Date:   Fri, 18 Jun 2021 11:01:59 -0700
Message-ID: <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb) stable/for-linus-5.12)
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Jianxiong Gao, before spending more time on this, could you also try
> Chanho Park's patch?
> https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f
>
I have tested Chanho Parks's patch and it works for us.
The NVMe driver performs correctly with the patch.

I have teste the patch on 06af8679449d

-- 
Jianxiong Gao
