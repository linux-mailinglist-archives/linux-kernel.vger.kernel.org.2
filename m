Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3488A409DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbhIMULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhIMULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:11:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D17C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:10:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v2so2691634plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FZZEMatov1ywQnlAFEuJS6XYFerKWwr4EqDpdXQaYcY=;
        b=Ygg3+TCcneorxzC43CXi9+QyVczta/m/dbbyX3FF4p4pFOnwBjsvFsPD0MCpK+rS+8
         MtRQIToFoyvhTo9TAdj9NRx8XGnX1qIKNQ4Ql6K8TG9kJRiQamhZGJn5p8PMfGtW+Dqw
         0CeQzz/5MYNPtsGK3b2RP9vz+zAuUppw6n4ob2yrSE0jOHmfr0Y/suOcCdB8kJFxJ4FH
         J+mFbropaOv/dta3lHwW1ogpb1SUc4GfQK261qmDht/Q3rs2u46pWH+EwNSntxm1nclD
         vklzSZYYi5/FIVa9m8NXWF7XLbikHgRT2kMp1UfuZv5VUbIgEMe/gnApk+nJFDFPiCJ8
         I4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FZZEMatov1ywQnlAFEuJS6XYFerKWwr4EqDpdXQaYcY=;
        b=gZvMABUaUT4O5kEqHHJj8cMlid1IiVwuK+pW1KXb59/FsLumTezvcXl9CQhtoyw+64
         FpCVee6gEkCno59N5T9h2PdXoIQg7O/z/E0DkpGQdbqyQ5B7ntSIkZSUWDFwZLP5ZsiW
         JngcgltFS4sm/762iCHMfQ+Tb86jX7xgTKLWvjpx8wbLwBohHWJH4oHWzpFDcO8j1QEA
         ZPxRMO0sMVs8kHbGikoskLNgV7Em0/3lyGpTYrf9NDJp87YM38girFB1lvCEpKG2bU7A
         7NQ27uLjZN3kGoDpvrgx1ksAB3HHP9O6msFpdNu008roYHWHxBJNsqm6OZLV3+8U8qCB
         qihA==
X-Gm-Message-State: AOAM531fPf1usCJ4MrcQpO4E5mzanP/xdOpVpu8GkbQtQJt3tvcj1rbi
        baM/GuXsX0dUItUY0dBg/Xw=
X-Google-Smtp-Source: ABdhPJx4vPt3BujS6XT0VkIhVx8lcxyx2fXBRc0yjYsLsD9r5Z+HcPsVMJ5W9tQZKVB6D5yB5hQIGQ==
X-Received: by 2002:a17:90b:3ec6:: with SMTP id rm6mr370730pjb.68.1631563817871;
        Mon, 13 Sep 2021 13:10:17 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c21sm7912657pfd.200.2021.09.13.13.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:10:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 10:10:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Feng Tang <feng.tang@intel.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
Message-ID: <YT+wKFZg0OS0YFrF@slm.duckdns.org>
References: <20210905124439.GA15026@xsang-OptiPlex-9020>
 <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com>
 <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com>
 <20210912132914.GA56674@shbuild999.sh.intel.com>
 <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
 <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com>
 <YT+ptg1Lf1kGLyUX@slm.duckdns.org>
 <CALvZod7mBLbkqZJzZz=XNGTDB4mxCd6dwM40aCv6t8fWbdUJdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7mBLbkqZJzZz=XNGTDB4mxCd6dwM40aCv6t8fWbdUJdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:09:11PM -0700, Shakeel Butt wrote:
> Thanks a lot for the explanation. Are there any concerns to call
> cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup) in system_wq?
> This will be called every 2 seconds, so, we can assume the updated
> tree would be small most of the time.

I can't think of a reason why this would be problematic.

Thanks.

-- 
tejun
