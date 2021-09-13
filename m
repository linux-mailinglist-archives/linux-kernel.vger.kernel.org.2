Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EC640880E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhIMJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbhIMJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:23:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB96BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:21:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g1so8208777lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O8RhwD434zCMehEmpGCUUM/Q3Qv+zqePWNa7zAHg+/Y=;
        b=l4NKr4PVhAEJ/wIbdb4Vm9pEOqPqc5B2ZA6XLZfLfnLeRKPr7jIY/2IIiym3p/6YzR
         r1UGxuo3J3mvrvy1q8IoPWWgzU6QtVQ4WjLfEPW8KS73KbmXDtFii7gMMhksyQ53zRg6
         MVMIi5CZy/Tn0fxSjSlcVs119nNDZ3t56UUwJTgz7yhQEjkr18i+mn2vjjOJA8KJUyhc
         6656jYrp2x1jH5BAgJzX+K+tadWkg8nKlCYn13mlPBU1XDTkGFpZL1TXrci4+awieh8Z
         N++HTqEsqqdISWOBMJi0xYgf6X22mmB5TcivjZaTh1FCFQR9UhxB2vJkRj8n5YidLMCz
         KfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O8RhwD434zCMehEmpGCUUM/Q3Qv+zqePWNa7zAHg+/Y=;
        b=wSD3wWQq6gTgdETjBxNeTKhJfJJn9LR/14chdtZ9RA1dCdyn0g5UzCkTaZOEyvDUXz
         tVcWgLO94KjbqwmGPLnEmTc29rwF769dXknSL33ow759Cr+UGO9CUmIwfDvuNZvZY9Q1
         JLso7b5PBwzyAe3RxGf9xvoBbbdzu7Q/xLvEgQfW92wgJjUu3Pmy5orlRx9PIyGN05Pf
         Mh6+FJdq+y25Sq5A2P8n0kBT0KTM663MsrEHbjW9xBFjfKjM/fcofHcuABbj9TqDwhpH
         NgMakxAD8lVSx4N3nKlwcpRzFtDwycbg6aBULzQ/Y8SqiqGsZdvxxR2HrIxkc3B5gksG
         2x2Q==
X-Gm-Message-State: AOAM530syYP2CtIyifSqxvDMV6HPhM7UtTs43MnpnJsfbqJ+9m/bYnxf
        rK9TSV1HKtJ94qEDnH+e4jJ56g==
X-Google-Smtp-Source: ABdhPJyfE1u6aIl575Xvrqj5iRCTv/Wfdrdd6R2mQyPAHS+d9E3Fz80GEIbaSFfsDAe1bCp7/epywA==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr8271697lfi.587.1631524905196;
        Mon, 13 Sep 2021 02:21:45 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id u17sm910326ljk.124.2021.09.13.02.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 02:21:44 -0700 (PDT)
Date:   Mon, 13 Sep 2021 11:21:43 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     CGEL <cgel.zte@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] tee/optee/shm_pool: fix application of sizeof
 to pointer
Message-ID: <20210913092143.GA165502@jade>
References: <c66fd6f831571b53b741350513e36405bba6c666.1629211976.git.jing.yangyang@zte.com.cn>
 <20210902103428.bdbkybvi6he6mgy2@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210902103428.bdbkybvi6he6mgy2@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:34:28AM +0100, Daniel Thompson wrote:
> On Thu, Aug 19, 2021 at 08:21:27PM -0700, CGEL wrote:
> > From: jing yangyang <jing.yangyang@zte.com.cn>
> > 
> > sizeof when applied to a pointer typed expression gives the size of
> > the pointer.
> > 
> > ./drivers/tee/optee/shm_pool.c:38:28-34: ERROR application of sizeof to pointer
> > 
> > This issue was detected with the help of Coccinelle.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> 
> This should not affect code generation since both pages and *pages are
> pointers but the change looks good to me.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks for reviewing, I agree with your analysis. 
I'm picking this up as a bugfix for V5.15.

Cheers,
Jens
