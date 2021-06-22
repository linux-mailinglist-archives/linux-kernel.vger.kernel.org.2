Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4403B075B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhFVO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFVO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:27:27 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318CBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:25:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g4so38696218qkl.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bhZNS7lV5Nt4MqmRXeAUAX8kJsakiDO8lzXugXWHbE4=;
        b=daz3+H6EJBGXGoBTg39kHoL2KNKovROdtZln0nWY9XMdAMrMCQrl+TxzlT4+AIWdB8
         dRWICDcoPNm/qmWKVXcrxcq615cVASIjKaBCjpUtAl1tjT1qw10xnYG0p8WRedXGWh6Z
         uhLx7ef8W4h8Y3JRYglTFtN+sD6OHajX7bama7UV78ZsBu+d+Yyi/ergotR4dJSsWr6c
         7rKe5PUZwF3PMWl+Eb1nwuLLu9EiwoTnEf/PusmOMogUGUd+zK56yUW1vgPkrP+q9L57
         O+zGShtXT89jlJprgRcfx0clntUr0SiOAAs5/8cH4MmjVD7Ko6y/TgvIxpyVDdx44kPl
         QrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bhZNS7lV5Nt4MqmRXeAUAX8kJsakiDO8lzXugXWHbE4=;
        b=dd0nqYLARREGcf1ZcI3ajf7rhfYexQoffnAq3hY8Zho3aYJNP66b5YlUIhVGqIT1wX
         YF/FfaI4qmmRvy1o6QolDjqZNVtH3AdpGdkRABhlh5VS2xnDtOhVvduRue6qp45S4oKX
         7Sb1R6Avt7gVdlAMHPBtHyEg32k2QM46yEmYVlJh2rJM9DLT8fVVLhBGFFcQsImv2pcD
         bDgajC5QDH6LIgQSMPepuvwf/44VfN0xPiTsHgt8FPbWxNzFooX7Eem4C+yF3RHnrD4W
         B7HR58BuyArnvO1mFhkPYuXItu2fIbnOpj0fsIk5o0uTBNu1yMCof+TB0BS17XQWUSmZ
         XNuQ==
X-Gm-Message-State: AOAM5302t9Y2+MS36qQWeBeSLC8/rybQac05HswBfBgRF7xAPrA3UOkq
        qFRdi70fbS7MNs/a2Qlt1og=
X-Google-Smtp-Source: ABdhPJwh4W374a+eRb6OAzi2CZC5IqCiVckqz6Cy+tkNATBzVN9hfunqY0rvXPgtrNGYT+VTclLSvw==
X-Received: by 2002:ae9:e407:: with SMTP id q7mr4633566qkc.410.1624371910173;
        Tue, 22 Jun 2021 07:25:10 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id f2sm665611qth.11.2021.06.22.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:25:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Jun 2021 10:25:08 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v6 0/3] sched/fair: Burstable CFS bandwidth controller
Message-ID: <YNHyxFQLsPPVoinf@slm.duckdns.org>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 05:27:57PM +0800, Huaixin Chang wrote:
> Changelog:
> v6:
> - Separate burst config to cpu.max.burst.
> - Rewrite commit log and document for burst feature.
> - Remove global sysfsctl to disable burst feature.
> - Some code mofication.
> - Rebase upon v5.13-rc6.

This looks fine from cgroup interface POV.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
