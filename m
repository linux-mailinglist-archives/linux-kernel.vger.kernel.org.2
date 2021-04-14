Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDACA35F6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbhDNOwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350095AbhDNOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:51:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78596C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:51:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d8so10232565plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0f1yRWivcg5wQEbGqXPrGa6vWe7+yI6CnScm8BKrOXM=;
        b=GMp7JY7KV9+C/G92RdzQXM1EdpBV/CchvizI/V9Rl6NATzXRvScvm5DqvzOlxZefSw
         K38lN8vuLA8/44nzXSkhr/bv0EzkOvz0qsxv0ihzQkrjTaZs7HI2LXE7KWSyVV0el0/E
         9lm4pKpbmp3G6eszp8Rr2lzbGUZywcoPllowYPXFgXEggVD2Tt0V6pa4kDbzdVvYOtXu
         NTynYwE15sz2/3cwd6W9KmD2keoIn7uHQo6edSza/PmuboGtkLgbHZo8EaTIYGJs5XsX
         sXQgqJQPEfxMaNUc8zxwXv82U2nFsXN8l4pfjQ6vT6NoiDmAM/+knTxaj4QACHOHrSI8
         eVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0f1yRWivcg5wQEbGqXPrGa6vWe7+yI6CnScm8BKrOXM=;
        b=FYGASpfU8kZ9ClgAKmSN8OGPAG5vZeZ8FVMomBlfObWJrg2bieoFiOY1konlWu73X0
         RVp1ZkBgBzX9okTNU5XzU4LUXNzCFRBjIwREDIXq1P/Y2gMBhzuS6N1nsK1mXDAOY1Mh
         pqo29suI3XwJi425W7wah2EO7pRvNhkIhNzsn9HWeIeJk8l4VS4zjZEgLVCB+6Tdlm0y
         q1lQ9QZwDpk586G40vPyKPG3BXrZq8gUsG+6c1YFBRn7IcXRdCgv7YPdsjGVZSY20nFc
         wKcqzgvjvlDZ0E6YF918PTlPj7v4AsclhWF6m17C79Jjeg7/GHZLC7qmXaevXBBA5Mo5
         VbvQ==
X-Gm-Message-State: AOAM533OGkMfGB4bDvHXcnVMjr+9c6P13lDgn9awsgMhtdUozvmxzF/i
        6awvLHTQGTJFlGCDmVeGzGy06h+eyaexeA==
X-Google-Smtp-Source: ABdhPJy6nS3DZqN9rRxKPIxlJr7UaPzNPqUID4YYB0NrdZ4Da19lEFMdSIImOmNOYY6GRIAvEjxzJA==
X-Received: by 2002:a17:903:1d2:b029:ea:e375:6a57 with SMTP id e18-20020a17090301d2b02900eae3756a57mr19026603plh.31.1618411882083;
        Wed, 14 Apr 2021 07:51:22 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:35:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id h18sm17268953pgj.51.2021.04.14.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 07:51:21 -0700 (PDT)
Date:   Wed, 14 Apr 2021 07:51:19 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rui.xiang@huawei.com, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2] time: Fix overwrite err unexpected in clock_adjtime32
Message-ID: <20210414145119.GB9318@hoboy.vegasvil.org>
References: <20210414030449.90692-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414030449.90692-1-chenjun102@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:04:49AM +0000, Chen Jun wrote:
> the correct error is covered by put_old_timex32.
> 
> Fixes: 3a4d44b61625 ("ntp: Move adjtimex related compat syscalls to native counterparts")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>

Reviewed-by: Richard Cochran <richardcochran@gmail.com>
