Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230103B0FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFVWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFVWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:05:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCFFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 15:03:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l2so615486qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wkAr8aOuO1gqCpd3kuOd4aOsjsXn3orrM4lykm5kRRg=;
        b=k9sbw7UQKZqwqLvfcyT9h2n90eADsv5f+9xzfFVaan7PRpVp15NSetJiykfVkB4JNg
         hvBZppmrT/oYJzeCrcGNo8L02swCm1zQXq4eR7ZmZ4ul+mWpNrmy08v0+2Ub8hnqN1SY
         4vtXbW+8DVS+DpjxxO7tp9VEIrXcKQj1IgRB96zbuK84qj4r4JcWM34vt2+Hn1h6a2Si
         6exmdWvEUmRqbO0RHDCyG10IEHIXx+KaHu4sXisl2WmF5x8m0uoNxkKtDV7OQpIGBrwU
         mpsDQaFp+LKpFkeS7GmgZWQToLTInOKHPvwiet9AwMWyay0OGZ2Rve8APqCHgxyCHLW2
         EvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=wkAr8aOuO1gqCpd3kuOd4aOsjsXn3orrM4lykm5kRRg=;
        b=gxMF8HIIJQ3PmOPb1CkRa0B7aVpiX18S7sIrofDw7qpw/s+W5Dj18c32pMVfnzTFZr
         Jq8Q+h9fkGNV8THYN+HXdr0EjY/GTp3XV2prxnVVu0gDDS0UmY6vjngz4nJHxXWI7j8A
         x3Yg8Nqki4dcUNDEGscs/SkB5qLOuhT4jR1kVQllkpq08ihemcgdnIOB9QygqhsPm42t
         0+mE5IxcjVZKrre70NKuG8I93posJsdtbo/cg332hD21hx0kyYK3gw8xAr7DeydRgbRh
         +Y735NG+DHlT/OT8CriIJTnBrU1QK+70ypX0Y/Fp9OPjLcym62uKKATmCuHe3r4B8AOl
         D4YA==
X-Gm-Message-State: AOAM530t/aAwDlsMlKF+RAxjbc/v3T3rs64+hJx2NnOaSosJafZ2vsx4
        5O/qxa5SMzIuiPtz8ab5IhU=
X-Google-Smtp-Source: ABdhPJw5wlgNzHs51lnfgoAS8VpgiYGVphCz1eWTvbl4nkSpSbrgoC/PAM2gW85QBDR/QE++QYnu9w==
X-Received: by 2002:ac8:4984:: with SMTP id f4mr909028qtq.106.1624399417307;
        Tue, 22 Jun 2021 15:03:37 -0700 (PDT)
Received: from fedora ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id q14sm565362qtw.24.2021.06.22.15.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 15:03:36 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Tue, 22 Jun 2021 18:03:34 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     dominique.martinet@atmark-techno.com, jxgao@google.com, hch@lst.de,
        lukas@mntmn.com, aymen.sghaier@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        iommu@lists.linux-foundation.org, erdemaktas@google.com,
        marcorr@google.com, pgonda@google.com, chanho61.park@samsung.com
Subject: [GIT PULL] (stable) stable/for-linus-5.14
Message-ID: <YNJeNrBOwTkCoLmd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Please git pull the following branch:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.14

which has the regression for the DMA operations where the offset was
ignored and corruptions would appear.

Going forward there will be a cleanups to make the offset and alignment
logic more clearer and better test-cases to help with this.

Bumyong Lee (1):
      swiotlb: manipulate orig_addr when tlb_addr has offset

 kernel/dma/swiotlb.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
