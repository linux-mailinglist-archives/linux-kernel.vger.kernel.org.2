Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537703C6A09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhGMF6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhGMF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:58:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85189C0613EF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 22:55:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d15so4493094qte.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=3P0wrRnQGSlxiiwhQ+M6v1FWAVoaNfm4NLnA+4kdAwg=;
        b=qWeVoIAnMzMwc6Lmk2qMTu9UTf4o1Xc4kIKj2aiG9X7BRL61TT1dhVderZykCZ7NWU
         wctf3j4j83t5XRc5PXeQwV1yVWejdYlrmkUcsMIXwg1fV3vcAhf3sZUV6y1dT3fAZEQL
         BB4iXkTv9Bdp661OuYFOXyP2gJJfmTKI1VtbeUWkujvpK3G8UDmEj+ayYKkFCGEZvyy+
         qytgi3DRx+IMOnTwJsNnGzGaeZRQTHJZ03dhDrwWekCsN9V9nuuG+RrS+kr0bnijUtPI
         SNM0aNMhpfnewYx2YiFWA1sHUt90nL9oBJi7iBVl2ONzJKtx0CubXy1ltsA+kt2KQ28V
         +tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=3P0wrRnQGSlxiiwhQ+M6v1FWAVoaNfm4NLnA+4kdAwg=;
        b=HnHOIgV6Fbrd0HQnlqgvPC4Q/plqB1TAKD7quBKasps0ascEXYGulDDxt+rwFPoZ2A
         bVDpGyIb9JbVgDr/cpk205Fedk5dVqfunNGjMtRvkeaA5I04MMtZ/3lzT0zbfuvUcbIV
         sSU9Rtk1nI1WtIY+qi9PcahijgZzNj/3hCZXMmARUO/kOYjLOKB2HLeESTeWjZtSzOxZ
         QGb66EaKZTMBw+LiQLxm9V/Gqs3GCwBEsjBgkVNqfkdlus/9AeCdGL0goujo7qYFkfsc
         YiPSq1TBTpm9euoksXIyJ0g8atJbKcXFM8f9c3r96qqzUF7ZaTVTW5vSGRaFYfpCqT+O
         SajA==
X-Gm-Message-State: AOAM5309hzZh1miWimiWcJvNsqzlcCjx/WLLfgf48yigRe7rMtGYgw15
        awcnFkdipxTXMOJ0NZBoSEZ8Pw==
X-Google-Smtp-Source: ABdhPJxe0y6jRbCV64kTd+SBqvUOXR1NUVZE3CgmwSkEjxbULGyu4cVsARZxNqvreArcM6jIzPWVHw==
X-Received: by 2002:a05:622a:291:: with SMTP id z17mr2413206qtw.95.1626155718426;
        Mon, 12 Jul 2021 22:55:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m6sm6434419qtx.9.2021.07.12.22.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 22:55:18 -0700 (PDT)
Date:   Mon, 12 Jul 2021 22:55:01 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: 5.13.2-rc and others have many not for stable
Message-ID: <2b1b798e-8449-11e-e2a1-daf6a341409b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 5.13.2 release.
> There are 800 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jul 2021 06:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 5.13.2-rc1

Hi Greg,

Sorry to be making waves, but please, what's up with the 5.13.2-rc,
5.12.17-rc, 5.10.50-rc, 5.4.132-rc stable release candidates?

Amongst the 2000+ patches posted today, there are a significant number
of them Signed-off-by Andrew, Signed-off-by Linus, Signed-off-by Sasha:
yet never Cc'ed to stable (nor even posted as AUTOSELs, I think).

Am I out of date?  I thought that had been agreed not to happen:
https://lore.kernel.org/linux-mm/20190808000533.7701-1-mike.kravetz@oracle.com/
is the thread I found when I looked for confirmation, but I believe the
same has been agreed before and since too.

Andrew goes to a lot of trouble to establish which Fixes from his tree
ought to go to stable.  Of course there will be exceptions which we
later decide should go in after all; but it's worrying when there's a
wholesale breach like this, and I think most of them should be dropped.

To pick on just one of many examples (sorry Miaohe!), a patch that
surprises me, but I've not had time to look into so far, and would
not want accelerated into X stable releases, 385/800

> Miaohe Lin <linmiaohe@huawei.com>
>     mm/shmem: fix shmem_swapin() race with swapoff

Hugh
