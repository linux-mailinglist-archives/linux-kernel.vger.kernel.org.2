Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5893BA1C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhGBN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhGBN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:59:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B0C061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:56:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u14so9585037pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=prR9MMxJFXYg7tQTmUSy0zU77pkSRzPHwNGdQsurfnw=;
        b=jJGc9dbBI79E5l/z1HwBg5pD9bdMDr690Yr/8fEtdU0rp8GXs4gIwfR8JOGiOCFAxY
         zBCJFA0o7fUuLPLu6aHlt2mLAURxadrVpyKySr7JB39yCT74INAJTuBJBrC9SnW+hmaC
         7NbGZGuXwIb3F8BKVzAmlw0W1E0NmHtBIwAaa4+meTVZRDJM1ZS1Idjp3/teipQ7K3wC
         AKkN1cD6EVwQv/If/iEw4CFjpeNJAKrrqTU8vaWmlGOJ9gQcDAv7mg+wjp77jenrV07N
         KVKhMiYi8e1gCceb6H3zYtN2pScQ2g7y8d92ub6JRXyi1WhVpGuWQB4mWUKfey2AobjT
         85Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=prR9MMxJFXYg7tQTmUSy0zU77pkSRzPHwNGdQsurfnw=;
        b=tslCOEReGKsF0D2KGt4OT98jQLlmc708YR0i5V1qqk84iqSTbLr9EpPzwdiXv7XPeJ
         5D32hzag00AIs3On1TEhsGxtikwQHvBL+6QTm3PP/RGPtQSyej/tdz7T10Q0hF/tHuc4
         flH5+L9BOXyIE6keEY9wJHOM3DPWdXt+3y+UIDWgiC6OlLYyGDKQGY+ediOi7CifWloE
         t0cyGu9mWJZQjp/xIaJeYqD58y0Rh29TN2vRq6kutfDQvUFlmIvwJw+XYFdmily+1SRH
         LfcUe3v3R1AjpmGV8UjrxrCTCO1brEKGBuMxwfMtb2mMDbaWiGoWt34vv6UMEEajuHyG
         00kw==
X-Gm-Message-State: AOAM530M0iugKtV+tPzlEcQg+/87veXnc/B0Ppe0NRK7r5X0MJf+SfHC
        aKH/JAoSMgi8zg2lW6m7PehyZw==
X-Google-Smtp-Source: ABdhPJxfsV4JttWkQ7T3rEm/HugUDpjN+Gb23ibpjWkUF7ReB/JxrJk4ZFHrkD5tF+MTf8AKfxjCEQ==
X-Received: by 2002:a65:6412:: with SMTP id a18mr115669pgv.445.1625234208439;
        Fri, 02 Jul 2021 06:56:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id g2sm3217396pjd.55.2021.07.02.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:56:47 -0700 (PDT)
Date:   Fri, 2 Jul 2021 21:56:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     gushengxian <gushengxian507419@gmail.com>, will@kernel.org,
        mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] perf: tests: fix some mmemory leak issues
Message-ID: <20210702135641.GA22592@leoy-ThinkPad-X240s>
References: <20210702040955.631618-1-gushengxian507419@gmail.com>
 <YN8NjJLHoB+wzLXa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN8NjJLHoB+wzLXa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Jul 02, 2021 at 09:58:52AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 01, 2021 at 09:09:55PM -0700, gushengxian escreveu:
> > From: gushengxian <gushengxian@yulong.com>
> > 
> > Some memory leak issues should be fixed by free().
> > Reported by cppcheck.

I don't think this patch does the right thing.  You could see that the
memory is allocated in arch specific function sample_ustack(), and the
"buf" pointer is assigned to sample->user_stack.data; and the memory
actually is released in the caller function test_dwarf_unwind__thread:

noinline int test_dwarf_unwind__thread(struct thread *thread)
{
        struct perf_sample sample;
        unsigned long cnt = 0;
        int err = -1;

        memset(&sample, 0, sizeof(sample));

        if (test__arch_unwind_sample(&sample, thread)) {
                pr_debug("failed to get unwind sample\n");
                goto out;
        } 

        [...]

 out:
        zfree(&sample.user_stack.data);
        zfree(&sample.user_regs.regs);
        return err;
}

So this patch will break the testing and doesn't fix any memory leak
issue.

Thanks,
Leo
