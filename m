Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02F3A176A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhFIOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhFIOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:39:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 07:37:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o127so4160675wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=loJFWwQdko7Drp/ynHnKOheU5fM56NACsA5Pe1BnpWo=;
        b=IG2HMWTkVMLfN7vCdwm0Kp17gqWtmV7hdMNPCrCW+nW/O0TWHDq8JSUCcuLFvrX/TU
         SUNRHFOUYS7+10hJx+2GffbNWtSjBE6QbJzdVlFj5hr1DTq3EQBhZfhVcW4jVVT7OJAK
         47LvW0JKvwaIwjhRSxdPNzSebjad3bkrK36dIAWbxjPzqgsQWm3RRgMFwA6fqv0ORdFo
         PCYBGbumKNZOS78hSrP5yKAZnpmwuRhv7XQ0uXEbW+rR7yiylqdZTVa0JhRoRzPtBkF4
         Cknnmk+Bd7Kpuh0YivlYdbjhGSMRQ0kh58Oh0pLxfPc36zo+8D8ELl/K7K4H6uKlZob7
         BEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=loJFWwQdko7Drp/ynHnKOheU5fM56NACsA5Pe1BnpWo=;
        b=t0tX4JN/taoE5e48JfpqFeaiG3UQx7olZ+mjp2x1zm7zg4AEj9xG25ZsO4sD7UqahR
         ibVlaAEwJfB23pepetNhJvVm6B/M9uB/ULEx8yvZ1IAOPDM2o67rZScelL7WyM6O951s
         FPys70lnCVgUdOb5m5Zcllj/AR/beT4xjODUcrI2xJp1Wvc3qn0+llIs0GVa0yAcsCFE
         beE3bgpNiZDl//ZVd3ZU1SE0XgwNkWN2ZrP87tMKHuntbJ7JAGLbLlNQPW/t0vVCCN3o
         WMTen9/rFYmbLdaRL96lrdmXCxL5PS9NLVXeamboj7U9HP0c/HAjJCJteDBuwPXkjU9H
         5VdA==
X-Gm-Message-State: AOAM533+d4eLPjtjz4G3/iYn+kjq2Yc8ncOP1D040jd7o4PpLORZ3wnj
        ZUkoK8rdY8dfAeYp4eGVf1QLEQ==
X-Google-Smtp-Source: ABdhPJwU91mPU8nKRvkIRK9eqo/o+X4Btj76FX6WzRu6CbDl33WtoVyIZolSeC4GXegYkIl/uCt+pw==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr115955wmq.169.1623249427236;
        Wed, 09 Jun 2021 07:37:07 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id q19sm6212826wmc.44.2021.06.09.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:37:06 -0700 (PDT)
Date:   Wed, 9 Jun 2021 14:37:04 +0000
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YMDSEHB5+zlajb4x@google.com>
References: <20210609143339.1194238-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609143339.1194238-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 Jun 2021 at 14:33:39 (+0000), Quentin Perret wrote:
> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> active task to maintain the last uclamp.max and prevent blocked util
> from suddenly becoming visible.
> 
> However, there is an asymmetry in how the flag is set and cleared which
> can lead to having the flag set whilst there are active task on the rq.
> Specifically, the flag is set in the uclamp_rq_inc() path, which is
> called at enqueue time, but cleared in the uclamp_rq_dec_id() which is
> called both when dequeueing and task _and_ during cgroup migrations.
> 
> Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
> things remain symmetrical.
> 
> Reported-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>

Argh, and I think this wants

Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
