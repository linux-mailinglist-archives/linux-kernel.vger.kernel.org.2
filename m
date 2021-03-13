Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F8339E12
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhCMMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:41:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231392AbhCMMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615639258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eagCFlIDHMIudK4vof/BRyU/fRgM/eIedg5D6cKZPVI=;
        b=OKfiQcAh/OOWl9VkGvIbd24DETtUdxYKZ8kJschuW0aq+FS+JNOFo+3Qpv3sg0A14MXfye
        tb98gPEjvKbL3fcuGdInZexo9fx4NAvioh1A/7VHBoeHbatM/7Hav4oi8IWjAZwiLqu0nu
        xg5uMmNwjCnm60o0FKCFOc28iYlz0U0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-2wWEllC6ME6UGIIdEsNuyg-1; Sat, 13 Mar 2021 07:40:56 -0500
X-MC-Unique: 2wWEllC6ME6UGIIdEsNuyg-1
Received: by mail-pj1-f69.google.com with SMTP id i9so4188988pjz.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 04:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eagCFlIDHMIudK4vof/BRyU/fRgM/eIedg5D6cKZPVI=;
        b=NbchiqDopcWkeZlk+w2voetk5tuJwWSxnB83/SMnmM5G4KnmsbBS2MOYt9DkC40yJ6
         XtvCiqutGXomOLE8bawIfRg2VaL0UKtAw7BB/B3f0uS8KVRiVpO4I+y3KN5qXTwQDl2l
         vGU66UtIZX4c+uT+5mTcMU83Ant5sxk7DTfrp/rARn0fRzqMysfrS3qeQYCw60CfRSfj
         uNoxyW9Da6LnnCz+iv437V/C0ef95seUF1fkD5qRK1grM9FsYT7Qn7nfOHMjCwKsCQEs
         dzBzCHNE3si/n37Dy3wyTO9rR2wzeXn0XeYPccf7ehTD+JEqUZcViZNAWPffyNZoeReO
         5G4w==
X-Gm-Message-State: AOAM532US5VPQFmM34aNhp1cbuFvUmaEhr66bTjKH3vl1hMJGao7v60N
        AL9RP+11hAY06h0XaoS4b4RCLfBoRuaw0n2D8l5xRYks+evtuhD61Q4XfHaJKwClDIvWHoNWAU+
        3YTY28OkX9ZhrtpeRZR4Beesm
X-Received: by 2002:a63:fb18:: with SMTP id o24mr15495313pgh.55.1615639255519;
        Sat, 13 Mar 2021 04:40:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytP436HyeGcc23xgylTsiHMzCO6hv5nMP+KgzqnRJZfCRlztmbsqPrh1SjFQGmJRPSNmOR1A==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr15495303pgh.55.1615639255279;
        Sat, 13 Mar 2021 04:40:55 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w18sm5016788pjh.19.2021.03.13.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 04:40:54 -0800 (PST)
Date:   Sat, 13 Mar 2021 20:40:44 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>, Martin DEVERA <devik@eaxlabs.cz>
Subject: [GIT PULL] erofs fix for 5.12-rc3
Message-ID: <20210313124044.GA488856@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.11-rc3?
All details about this new regression are as below.

All commits have been tested and have been in -next for days.
This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.12-rc3

for you to fetch changes up to 9f377622a484de0818c49ee01e0ab4eedf6acd81:

  erofs: fix bio->bi_max_vecs behavior change (2021-03-08 10:43:32 +0800)

----------------------------------------------------------------
Change since last update:

Fix an urgent regression introduced by commit baa2c7c97153 ("block:
set .bi_max_vecs as actual allocated vector number"), which could
cause unexpected hung since linux 5.12-rc1.

Resolve it by avoiding using bio->bi_max_vecs completely.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix bio->bi_max_vecs behavior change

 fs/erofs/data.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

