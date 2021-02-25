Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE03251BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhBYOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBYOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:50:43 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:50:03 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so6076175ior.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UVDK1LAZZ/TisHSaSggR1wEVPd/8AFG+H067+sVbKTE=;
        b=hSTfV1n9eokxRc7P6tJxm0Jx+tKyraQacFUO+6n+z1RT+cc2Bt67/nE+Ue8ONp1JcI
         pKQmWpP8/rljnlbGmOcggm7Z7NEc60xbnbfhOYFrD6ImIIBtRIpSa4cxltCGZ1oA+lb4
         Vg5RbAkwcu21mTK18ev6h0sZqSNHU+u8qoP4hbFxmfB496OQ+p3DI7EPZHtW41zby1gn
         zEUZk7+3xkgpdbyCm1POugQsrh3aTLJwpGsybXiB+HjIvpAl9XQ5Zj85oWeqdd71J+l0
         AiOrbl2deUyjKlN1s0Pf8zkd78dFpvaknUzVT+cpYuKBHx0VcLBSsIDd0gkXQ6qSzcro
         x29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UVDK1LAZZ/TisHSaSggR1wEVPd/8AFG+H067+sVbKTE=;
        b=kH1l6RD6IpyyUF94prLVU+4MRDIiH5A7VajonRkMFLAZEhWjEdmyAPqOZ2gvVH93Kw
         Vs3VUCy3KdpIiT/mjg1cDK+sM0sxG38XjNtx9xYQvUxzT22RniWVrK1xrkJQvMmh6Xeb
         pW5VoDFyIG4MFQ/bxZNQYZ02sPseZnSYm6Hmv3oJIqEEYy3zJIsZtDoQ/2/7UAAqaF8p
         fcJ8d+980R6UYX3oDqM6eOB39Iqznx5uQB2bIelGHk5UUdoofasM66eWm2rf4MUQeYGi
         ceR1rJZwXUdtiCLECwe38hPsMLK9mTznMON5YSg+NHiZyMX8IFg6/k8j8sZBzdf2Iu3K
         Thug==
X-Gm-Message-State: AOAM532NraUy4g2dTuHndMDjfA9Gj27Oyquskh5eWtb2DEZxdtFhuqaS
        oVoZ2FJYF750SZ3eCg2tPkk7v8pzXSKDUdob
X-Google-Smtp-Source: ABdhPJzHb7nDLiSnUF8364AJ2bwChyxDaWGStHS2r+QTjn37aq7c5hDbkWKGvz2TADbAUdbiUFPc0Q==
X-Received: by 2002:a02:6014:: with SMTP id i20mr3418900jac.101.1614264601670;
        Thu, 25 Feb 2021 06:50:01 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y20sm3371612ilc.18.2021.02.25.06.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 06:50:01 -0800 (PST)
Subject: Re: [io_uring] 6f70bae3cf: BUG:KASAN:use-after-free_in__lock_acquire
To:     kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20210225053817.GA21663@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <685010d2-1760-1adb-fa99-2a051827babf@kernel.dk>
Date:   Thu, 25 Feb 2021 07:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225053817.GA21663@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 10:38 PM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 6f70bae3cffed4f3b1a4e9f94b8505e114a40223 ("io_uring: ensure io-wq context is always destroyed for tasks")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This one has been fixed.

-- 
Jens Axboe

