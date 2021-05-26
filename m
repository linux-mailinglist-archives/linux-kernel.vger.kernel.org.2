Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE483910E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhEZGxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhEZGx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:53:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:51:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso14819510wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DDAe2oVfUQ0z9d/bYleqH8/aHTZsO4TUDnuof1x1n/c=;
        b=hmStGAN8pll5I8OAGfCRQJhwQMbQorx5Iy5jo2CfHIYctbtxTxLN40bCohkTCUVuOg
         iO0LVhjTgIvVqYgi44YdmUKKzzan/AuzkZ6Y6cjb9SF6Fz6rlIayUUtdWKvHy+PxZrds
         jMXbvNA4sOsRGIjPEBTLNruKsCZYNGh1FnBDcwxHrj1CKQlXU4P8MDJjVmRMxp0vGMA5
         LeDfrs9nkln4JPZP9V4A28Z/9j14mBNRwoG1Y2ng/l4DYYlDXRLVrXjsQIOIsOwbIMPD
         ZABDCIo6FgfOheJVjm6d6Ce4lQ8cGfrAdtbatqw9iU4FZvuF9txJcC1oI2JjUaFZUt11
         Mvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DDAe2oVfUQ0z9d/bYleqH8/aHTZsO4TUDnuof1x1n/c=;
        b=ezKvSrojcd6JL4hRKTgFu85oUym/bXjJ10c7A4fzSR8MPvhmPlpQYG6srjbiMJ+X6K
         QdFybcU4awV72rTlECtTIl88ljXp0d9nRuEsk8SwUzsGSVczrv3iN2wNB8YBmi9u6jmT
         ZEDMiVQdNN2ZU68bNNz0Hn2Ur1pr1wnvsTlhb50mUJxC3XO+SAEWrkV7dM8u1XTWsBky
         9GK6WLyX7TlQvtyuln3Hiv5v4FU5cVVLfeZ4yfx7N32djD2mDwox6MZSTUE9I1ZUgtE8
         1rzovpbQP/68W9N3gbguVEXuRmXFC26T1kwzmZrDsqA/GAaXUb9Ituwwllscc/lFg8ru
         O5NA==
X-Gm-Message-State: AOAM532d+Xu4oFdh4lWOGRQYaC9QLnxQ8SW7ngEp2fui2F/ObA+fQkI/
        BvHMeTs5lh9yKilODJaG1ixSiMeG2/k=
X-Google-Smtp-Source: ABdhPJy9E44VTuQoCb8+TDMBhKE/219r6Xyq/N4IQWKPjWv4mnSnI6kFLvpLPEBV0PguUcwfv69gtA==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr1873722wmb.51.1622011915556;
        Tue, 25 May 2021 23:51:55 -0700 (PDT)
Received: from gmail.com (0526ECF1.unconfigured.pool.telekom.hu. [5.38.236.241])
        by smtp.gmail.com with ESMTPSA id o129sm5235994wmo.22.2021.05.25.23.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 23:51:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 26 May 2021 08:51:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched/topology: Fix a spelling mistake in error
 message
Message-ID: <YK3wCeXWcjgalNbo@gmail.com>
References: <20210526021856.9060-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526021856.9060-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhen Lei <thunder.leizhen@huawei.com> wrote:

> The misspelled word 'borken' should be 'broken'.
> 
> Fixes: 6ae72dff3759 ("sched: Robustify topology setup")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

NAK. You are trying to 'fix' a joke.

Thanks,

	Ingo
