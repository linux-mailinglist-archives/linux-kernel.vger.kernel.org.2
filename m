Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E28E3B2EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFXMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhFXMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:33:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C0C061767
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:30:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h15so9897651lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eANjIt1ea3/GD9zwECka/bvl5FsJJ9i8D0Xy6D39U6g=;
        b=KZ1w5PY2YJwsBuan/wZbvqYKKrtktvzWcKZeQEDdQixcOpGRiFutq0rBSTvU47FuR1
         gk3BrW+5zdRkx7QThxiwG+tVNy1hStnVkAbEZHqslS4JZueTizBJlZ9CFHSLdn5GRSYP
         9mP//Wio8sz+vZmseS7i//0AJzhc73SZ4kCVqcChQW8rPdk2baPWSZlwCJ8+T8B2KYur
         iG0Xh8bIHPPJ3i0xHqsnsrVE9QXzzD54wBCWMhz/wDH0hKqV7R9f8EOi8BLpQJJo0Yue
         JhvxkoBumVXga6VuXVx2BM4z5ksOvMr8MDFyTT51FTSxQsvG6cocYuZvAIivhz2eNoje
         wEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eANjIt1ea3/GD9zwECka/bvl5FsJJ9i8D0Xy6D39U6g=;
        b=jgPUysBrJWVFfUOsn5kQhrAZz6GFpL676DwK0eyUQKdeiD0kyWKbAWmRsSErH9SGEY
         pvgtW1grC+kSkMtuiF1vWwKSdX2ECRqT934lVUZys3ZdPze4BeviplmrkLDLkz1xectS
         nHdYvhDsdxxB6B88lKpe9VHCibP2Iyh8xFV3GNJwGXInfgXTnjNhJf4C0bNwtXyW1Pd8
         GQDsBnE7/1grIOwN6h3q7rOJEXOSSCpjkb9rpnU7TwbXC4kvOD3smSclCrLn3Vpakdwb
         xvyXpRmjgJSaAb0ulMqH7ZsGJ1vHqmLqyWBNGLHQsdBopO6nLwtfLDpqfGxD/KL61d0R
         1Tiw==
X-Gm-Message-State: AOAM5323S8tmrw9jHgQ5oArWiKVaf5ds4kUSLvnal7aul+1kr/l5nvG5
        k8kdTXUGSNRRHtme3ENude6TTA==
X-Google-Smtp-Source: ABdhPJx2yAMansJcTLde40yafZ5PBw8/fLg4YMd03kIZ2hv0mEcwfdXnPw0DRdSdR94Pvac5XRXKBw==
X-Received: by 2002:a05:6512:239f:: with SMTP id c31mr3625727lfv.47.1624537846566;
        Thu, 24 Jun 2021 05:30:46 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id t26sm59871lfq.269.2021.06.24.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:30:46 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     bgoncalv@redhat.com
Cc:     bsegall@google.com, cki-project@redhat.com, ehamera@redhat.com,
        ffan@redhat.com, jiyin@redhat.com, jlelli@redhat.com,
        jstancek@redhat.com, linux-kernel@vger.kernel.org,
        mm-qe@redhat.com, nathan@kernel.org, skt-results-master@redhat.com,
        xzhou@redhat.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: FAIL: Test report for kernel 5.13.0-rc6 (mainline.kernel.org, cba5e972)
Date:   Thu, 24 Jun 2021 14:27:28 +0200
Message-Id: <20210624122728.82625-1-odin@uged.al>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CA+QYu4pXLd9rGTh5o6BS+E0iA3H2ADArFM=N_yN1WWm_PngWnA@mail.gmail.com>
References: <CA+QYu4pXLd9rGTh5o6BS+E0iA3H2ADArFM=N_yN1WWm_PngWnA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Since this commit (Commit: cba5e97280f5 - Merge tag
> 'sched_urgent_for_v5.13_rc6') we started to see some problem when
> running the LTP "cfs_bandwidth01" test case.

We got a similar report here, together with some discussion:
https://lore.kernel.org/lkml/9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com/

It should be fixed by this patch, so feel free to test and report back:
https://lore.kernel.org/lkml/20210621174330.11258-1-vincent.guittot@linaro.org/

It has already made its way into tip;
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=sched/urgent

Thanks
Odin
