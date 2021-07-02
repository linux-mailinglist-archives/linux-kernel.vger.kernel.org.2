Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37383B9BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhGBE5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhGBE5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:57:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A01C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 21:55:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id in17-20020a17090b4391b0290170ba0ec7fcso8087473pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 21:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wdpYac922+2MTlxWPHYisZu+1HjHabMF9049YmCpVc=;
        b=q8GcCDdQAmEIRNwTEc0ZT49UMheJANOM3BeGBqt9HosmhwUlxPmIw4hRgwbWvVxFqZ
         SwlkUrDAWtNPIN8GjI5y7UtinPZLnE1UHs7BX0U0rH0bh0rG+7or/oR1+K+VABxk53xQ
         0rCiZxsSOMfj97YIrPhbLL0D+ynBVYw1e0yyEmG0xVhfd3QvZXToGH/K8+g4LSTMTnsw
         BCbNisHE30++nWDIxXBye6EtG8echBFZQbeWYPsxU+FPnvG5OUlW3ZWuSBvwHhNhsdoW
         j9xrJOTTBnjzuUwaVcgnJKH+GDMfu7TDAtK3sF/R5NdJruCSIXiaQ6CRpxFRQgYp3YId
         wAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wdpYac922+2MTlxWPHYisZu+1HjHabMF9049YmCpVc=;
        b=gVB0AWjGhhsnsfeySCxUyPVIP+jOG+xav0+uLzoVhcCMqq78rqW8jUDXLeKGKfVyoI
         OzFMQBYm/QZkyVwcWU477XoQV2RDg6WmaLyI5OjeiCDdhNxP5its97voLHGP1UTNjUmo
         o8rnlWy2Ng6QK5j2Uzm2cCX8U/F3fn5FXTkXBzOtbg2DL9flCtFR9U8udUURxsB73ps7
         SZkqYfZwOCh8aZeCWqp3ebb/qrUG9ASPYOJ85gOqK65Qul+BdqYWh5x8/jK+n5PbtRqD
         xnSBsDHx0cYteZVZfs1o/A10EQqAPlGzTi2m+DpLoFUoqUxbUKh1cVRa4GFth/YchyqO
         uq2w==
X-Gm-Message-State: AOAM530eEKgV9zzwXvcLxYQRCr6zNoiPPwF9WoaTKw8Av6DiK2ic7+Lk
        N2I+IVGQGpZxgoP6M2NvVCuuVA==
X-Google-Smtp-Source: ABdhPJznt1hF1UhbLKd6O/yeO2rtrvTkZBeGb4a5GgpM31uoykKdAXgmMBRg83/pWoJpJgqh1pi2vg==
X-Received: by 2002:a17:903:1ce:b029:128:e252:4480 with SMTP id e14-20020a17090301ceb0290128e2524480mr2821877plh.74.1625201715380;
        Thu, 01 Jul 2021 21:55:15 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id cx5sm3347132pjb.1.2021.07.01.21.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 21:55:14 -0700 (PDT)
Date:   Fri, 2 Jul 2021 10:25:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, arnd@arndb.de,
        jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
        yu1.wang@intel.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
        stefanha@redhat.com
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210702045512.u4dvbapoc5a2a4jb@vireshk-i7>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
 <YN4WeJCepCrpylOD@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN4WeJCepCrpylOD@kunai>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-21, 21:24, Wolfram Sang wrote:
> 
> > I just noticed this now, but this function even tries to send data
> > partially, which isn't right. If the caller (i2c device's driver)
> > calls this for 5 struct i2c_msg instances, then all 5 need to get
> > through or none.. where as we try to send as many as possible here.
> > 
> > This looks broken to me. Rather return an error value here on success,
> > or make it complete failure.
> > 
> > Though to be fair I see i2c-core also returns number of messages
> > processed from i2c_transfer().
> > 
> > Wolfram, what's expected here ? Shouldn't all message transfer or
> > none?
> 
> Well, on a physical bus, it can simply happen that after message 3 of 5,
> the bus is stalled, so we need to bail out.

Right, and in that case the transfer will have any meaning left? I believe it
needs to be fully retried as the requests may have been dependent on each other.

> Again, I am missing details of a virtqueue, but I'd think it is
> different. If adding to the queue fails, then it probably make sense to
> drop the whole transfer.

Exactly my point.

> Of course, it can later happen on the physical bus of the host, though,
> that the bus is stalled after message 3 of 5, and I2C_RDWR will bail
> out.

Basically we fail as soon as we know something is not right, correct?

-- 
viresh
