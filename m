Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B93402D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbhIGRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbhIGRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:02:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077BDC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:01:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y17so8628233pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eTWAB5IRZ6u+fFBbo38jlDZw3s3Kz/HwTHFwTqUgCyM=;
        b=HxffgRT4HJI82SYZun9lQga2rWb3tMZra8BfyVs7+MlqsPqxBLj0q9eYIbh5TRPbJX
         C7K6VLiyrAtOdxB9J8pRTnDq2iXlVoupXwWD7i8gjfh9wIWl2sTx0ZczCjAGXHVwS8us
         0HxJni+G9UWSGX8VNoeqKtCgovvc9iUG14ao+q9JNS9e4Q9BjjiiJRa/CJXd6m8hm8TG
         zQRg4AIYZPvZo+1kMU0r+vAQhElWeroPtmWUs5si8KNfnqCkQJ27ysZhSUW+3df1CzQk
         vWh2CVS4ni69+H24KdpGsg0HEaa92FLkJ9807lTOFcxDNmgpGtIMLgOU9UucSRS0WPP5
         7lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eTWAB5IRZ6u+fFBbo38jlDZw3s3Kz/HwTHFwTqUgCyM=;
        b=IsJA/LHo/KTLsfokwXiHlDFSpY9S2Ihjy8s6Zn/4WWPvHt5J1bvqxmnpmvWU45m2tN
         MigBAAvrol44iSItFKiJ7OxSQ33tWsernfEUfXXQ6lvRCvu2CSeYWWoNDsGn3uJVllKl
         /xoga6Ta6fbkj05YlL0qqtegDXDE9Z1qkDh3a5eCNyi26PFCaxo0/qOaiGNZY2Z0R7ZH
         M5BJ23jon27vrTNoSYBfBt9BTlLsLpHiC0kFjX9uGYN3yAvrHSh1pd/eNNUiTLKXvi3/
         qg7hszdTnCcu28hKk8KXzQcvD+J05cQ/hqebH6v6KL5KTMag+9mSH1t4Q6PSOjiB0vNm
         pqVA==
X-Gm-Message-State: AOAM533ePHmQqjO2eUlFcqrlQTgg1O3DZxwqIUgBU/IvU6cB5yvE65My
        Vt2YwR0b6fvGBLiw/O757JY=
X-Google-Smtp-Source: ABdhPJzmjtRpbR3Yzd5ozFN07mquPcMva0l+ci5rcbXSo8eBpnwkMjX0CZUF5DyXlTh4nS4MPAp4Ew==
X-Received: by 2002:a05:6a00:10ca:b0:3fe:3a9b:2100 with SMTP id d10-20020a056a0010ca00b003fe3a9b2100mr21607959pfu.59.1631034068275;
        Tue, 07 Sep 2021 10:01:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id t10sm13401083pge.10.2021.09.07.10.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 10:01:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Sep 2021 07:01:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YTea0kK9yL5+GoKt@slm.duckdns.org>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
 <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
 <YS0WF0sxr0ysb6Za@mtj.duckdns.org>
 <1f0cd867-9c6d-4e22-cadd-06af9f852f7a@huawei.com>
 <YS60T2bfLpxb6SUY@slm.duckdns.org>
 <128d52ab-b4ee-65f8-e0a3-2796ef43a98b@huawei.com>
 <YS+uEmQRmQqAbkmG@slm.duckdns.org>
 <3df62791-d123-db9b-ec9c-092c47a941cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df62791-d123-db9b-ec9c-092c47a941cc@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 02, 2021 at 03:42:15PM +0800, Zhang Qiao wrote:
> I checked the code again.
> I don't quite understand what you said, if the child be moved between
> cgroup_post_fork() and sched_post_sched(), what problems might it cause?

cgroup_post_fork() is where the child's creation is committed from cgroup's
POV, so it'd be migrating cgroups before the initial creation is finished.
From glancing, looks like it'll break css_set task counts to begin with.
This violates the basic assumptions and can cause critical failures in
subtle ways. The would replace one subtle race with a possibly worse one.

Thanks.

-- 
tejun
