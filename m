Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B635392C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhDDR15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 13:27:51 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68132C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 10:27:46 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i19so7049364qtv.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Et1pca22Rg6d/lGnAY2sJzq7rHmXVlBp3eJBVJWY0FY=;
        b=BEKMcjmZ/ELTAhqoIDaBgoDkF/HxeJih8TW0aGen3UPq8Ri7bqaPeyd6+oaHbmICJr
         +AKTraEqumwXYyJ0qyePUC62K6KYe/Y8gs3C99SqldmWpjCRjD7pgYGVhqAkEqgBK5ex
         olbRxsiRs+j6ivP3oQe+1uCSPOmG1OaJjBrcjuIh13V5RqnYjbYsMGo1fEHxoki2lAz6
         3Wc6nxwxrFNUNYKvZ+n6FQ7eUBEOrclLSSq2c0MOspOLPIWKNyiuRlr6nonpdTBrjaH+
         8HOGQxzgSEoeKAEz0za1iL25hNpoWSrhLpPwXY1fBoKqml8eGKnqGCM2Mvw7S1rkSB8b
         4QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Et1pca22Rg6d/lGnAY2sJzq7rHmXVlBp3eJBVJWY0FY=;
        b=l6XH+rVe/P5hoMbMjmVCOktXqd2zw8I8kzIYXd3ddoHsuoGN71aCVo1K0OwzAVmTC2
         r7ntEEHtY+5C/PMdM1o2xaspofpJwRygjv+EZrjYMWyp7vfq/tXgNvVF0n/npZNqBWXf
         9omW1V4bSeTgP0NRl1yqmg9ppr03kclcNkwa1RgRddG/EhXfp1iFSQIzsXYm5nziXNc1
         dg3z3Ld0WvN7zYkSK968mgnGtXQmDzeogHLnu1ku4JBjdwFapW8dwx/2bxuF5YgiGejg
         p8bjFTD/BdP5VGGrWRqAA8oP821AW1p8V2dutn1fKiZDqgly2LpUtasvzfodIqSuC4RQ
         TJiA==
X-Gm-Message-State: AOAM5334cOcYySHIN/QsUQ9JvmrBFnZ5T+oIHLzJxPi4+FRuksOhrh+0
        K5qmvDny4rYLSNMnwDMwL34=
X-Google-Smtp-Source: ABdhPJzwiWG/hjgQ19Kce3jXWbtxfzWYnV0jUsEo907kRJmeo0pHxZ7c71+qNpNtRiNhrHwkSE4Rzw==
X-Received: by 2002:ac8:5847:: with SMTP id h7mr19346858qth.108.1617557265566;
        Sun, 04 Apr 2021 10:27:45 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id j6sm10092921qtx.14.2021.04.04.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 10:27:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Apr 2021 13:27:44 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3,RESEND] workqueue/watchdog: Make unbound workqueues
 aware of touch_softlockup_watchdog()
Message-ID: <YGn3ECSJ6zPLMbnX@mtj.duckdns.org>
References: <1616586031-31809-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616586031-31809-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-5.12-fixes w/ minor description update.

Thanks.

-- 
tejun
