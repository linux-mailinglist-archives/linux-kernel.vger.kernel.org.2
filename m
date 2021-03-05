Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C359732F67D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCEXPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCEXOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:14:46 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDFAC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 15:14:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o38so2357573pgm.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cGT+MDF0P9t+59N2JBromxQsPwywDMBUNWrDg5O/QMI=;
        b=WODSua2j9rcMPMdyeboEwM00yi/ZbVJHjjcTlj+bq01hexiFgqnFaK1w/wo4a+J+Yd
         6Ag86QGjXpOTyUUOSE6UVjT34rLGzLvaZdHclLR9Nu9xO0ACF/RaB2WQy7PXPV/02ZNc
         YZi5Tc/g0H41wtxn5P4SzPf7PYHeV1qBn/wso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cGT+MDF0P9t+59N2JBromxQsPwywDMBUNWrDg5O/QMI=;
        b=inUeKIWtOGU5ju2gtXNB1Grg9aCt3A78eVzbLFaqAYaKZAkfnDcRpjJ/sZB6rAZjq8
         vFaDuG7DcAhzGS05DmhUJg6He8eB2Q4WDhZwgh33/T6r9gF3h47F9+zdRNrP3sMpgzrV
         EcmvEJOYxaWHCj59TGc5fo1xUNp344YrP39rQTynH/s+yDUaBs+Y8lz2XKobUk2BTLEE
         NX5kwI/7ETnuWLQ+fVpkGXm3sc3AHeI6fKxNr3SYcBXzwE/SuOP0GeNrIJHJQt/0xcgF
         TmpjkmU3xjlq7FVrbbP4aY/Jf2+Tz7sViNUMkeD9bvpLht/Z+crlnuGN/FODWLomuo5T
         AxTQ==
X-Gm-Message-State: AOAM531yurKIe11kENglTvD5N+g8YRov3akhSZzd3hPpISVIClhOa5Z0
        m0AYK0ThFHZYO42ehVI0Ttm4N3PVlnfrKg==
X-Google-Smtp-Source: ABdhPJw6bZ5EhjusVNNB8fbv74nKkrjso6CQiHWUJEhRtrxaGo9TR/SP+ZSL/swzX4tdZhqB4YxpDw==
X-Received: by 2002:a05:6a00:158b:b029:1d1:f9c9:84ca with SMTP id u11-20020a056a00158bb02901d1f9c984camr11566169pfk.46.1614986086200;
        Fri, 05 Mar 2021 15:14:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm3087542pfq.184.2021.03.05.15.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:14:45 -0800 (PST)
Date:   Fri, 5 Mar 2021 15:14:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] gcc-plugins fixes for v5.12-rc2
Message-ID: <202103051512.624654ABB8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull these tiny gcc-plugin fixes for v5.12-rc2. These issues
are small but have been reported a couple times now by static analyzers,
so best to get them fixed to reduce the noise. :)

Thanks!

-Kees

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.12-rc2

for you to fetch changes up to 5477edcacaacb8af8169450180a1d3bd0dfb9c99:

  gcc-plugins: latent_entropy: remove unneeded semicolon (2021-03-01 19:19:50 -0800)

----------------------------------------------------------------
gcc-plugins fixes for v5.12-rc2

- Fix coding style issues (Jason Yan)

----------------------------------------------------------------
Jason Yan (2):
      gcc-plugins: structleak: remove unneeded variable 'ret'
      gcc-plugins: latent_entropy: remove unneeded semicolon

 scripts/gcc-plugins/latent_entropy_plugin.c | 2 +-
 scripts/gcc-plugins/structleak_plugin.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
Kees Cook
