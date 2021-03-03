Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9B32BF67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835398AbhCCSDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359865AbhCCPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:15:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B112C061763
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:14:53 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s15so17762313qtq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02fu5WYb4zB8afDuZziisDwQ8OoOWP0B0v4Rl6iTFJY=;
        b=IqUr1tr6XVDEkkhNF54HYhb5qpKF79GGDSvxIkcDDqzw0sUuYq2YdnlvAFxbjvcM/Z
         KaaMML7XI29GvXAQSwj65qAJobsyf45FOKs6BSaQMS8Dbw833jKNUcEJCwJhSfclfIqD
         V7rofKELfQDdgO9NFSI9fgPby9fqOXX4UHoRhYdY2dq251QoZ2Spnv+HC55iNfpohj8Y
         EhZyntXP2pSM8hXeMfEm5b5+eEc9WNIKsH+P++cFgoSaktsaYkHcfrliBmIvAZK2+BrJ
         /7OnO7WC/Y9HPDZBnMLnmhY+SEBiPieyT9mkW68sHJq4o6lBHERLUxqeydWh7TpMo7xA
         l0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=02fu5WYb4zB8afDuZziisDwQ8OoOWP0B0v4Rl6iTFJY=;
        b=axR46SgRoVrSdugGNyLO1MqL8lt/4JH59ybNaH+eUf6u8b/z4reV+Bo5fPSG2kjslb
         4cwcy2aJzBlfAWNp6syLuVHp1/MVttJtijjanlZSzqxics0hbKbl0MgY8xsKlx0reXgx
         xK8RWgJIz2WQMWACBu/0it51UvivQPAYHu1OltJCcynCR6rPcrKG2ZHap5ZJfwG0HacB
         0rYKDWTMKYGe8CkBvjMfVnxff9BJnc1H35icETZA9+d4GEq76XzGsTiLFVhZJ1PoYNyc
         GfoXUkXAgzAPpxqTtfQEXjCU5gY4rWAD+5DAhsnTUI0npivYAa+OYITNqrNa7U/dAj6F
         MFpw==
X-Gm-Message-State: AOAM530ZfUExLarr3o1H8PaeL8fYkRZPempLRVJQ4qaCRquvF9HJlf22
        gs2gu/PTnquk4py7sG7Sd2w=
X-Google-Smtp-Source: ABdhPJwIlokG4Od7T8Jhzbs/L9SxalWI1ehAKNoAjl7dTjNu2acG5XnSKas0Y2SetupAk/LAxZ8TLA==
X-Received: by 2002:a05:622a:210:: with SMTP id b16mr7052088qtx.69.1614784492703;
        Wed, 03 Mar 2021 07:14:52 -0800 (PST)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id n5sm11629167qkp.133.2021.03.03.07.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:14:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 Mar 2021 10:14:50 -0500
From:   Tejun Heo <tj@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Move the position of debug_work_activate()
 in __queue_work()
Message-ID: <YD+n6i7twcyfazJk@slm.duckdns.org>
References: <20210218031649.151638-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218031649.151638-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:16:49AM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> The debug_work_activate() is called on the premise that
> the work can be inserted, because if wq be in WQ_DRAINING
> status, insert work may be failed.
> 
> Fixes: e41e704bc4f4 ("workqueue: improve destroy_workqueue() debuggability")
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Applied to wq/for-5.12-fixes.

Thanks.

-- 
tejun
