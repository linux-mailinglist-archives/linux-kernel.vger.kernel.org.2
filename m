Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBC30B694
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhBBEgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhBBEfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:35:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 20:35:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y10so7491323plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 20:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s/jBe4x5qao1XlNzDjw6BrspTSD8rLixWJszF6QG+Xw=;
        b=XRLXM7ESwFkWTxcTlgYW9PqRsEg97aBMXDivdj/Ii8fohSCmtmCwSfSPJC5yR8G04X
         EJWoe3Mowly6AoLRjXJpntYxYJgpKX78OAaGShjSLUSm5ewWRovvERbemumNO57pPQFn
         pQOXi+iZyyPD9MvwT1krH3RQNi9IDaIUmwc/zE22jviwi8hWkEVgvXYUgFq6QjFoov4F
         AKqFFXvvC1+zq726OKOMtwY4SBCi8ZAtNYueSbV9CCC7so6BGT005DtkdzPp8ZBhQ/WG
         OgYTu8GuXVzh4ONyZxP+eg/kRNlJPWBH6R4GhhZDhvGLRV/5/oklNiQcj2s3DLGBWInx
         xs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s/jBe4x5qao1XlNzDjw6BrspTSD8rLixWJszF6QG+Xw=;
        b=jejYLRJqMf1Leedmh2RSshNffZR6fCsLsgC1WU5yg1shCYH8tYeTAQww6q4WPJhbfx
         EflS+Qlxp3ySE0ZO1Vg4w9P8qTu89nubexmrb0ukD1G1uUGpELLI8j8nO2EMUQO1e/QO
         25irEH6S/dqF8NOYcN7Daod3ZRnywYE6c0t4WBN60xCMWLT7feJSy6W0eJmn1B1WDC86
         45qfG0a8TmARvyTybQ6Cyg9G41Grfv0YGmk8WuF907YzaA41yAytnnQn+FQ8K7PR+d3N
         GBuknYHlzGjWlFAOamJU8h6f1oJ5SMj/nCT7NzH+jtMPNXPAxaPvwmnVrkDzc4xrbfvb
         CIPA==
X-Gm-Message-State: AOAM533mFWwCiuuLYPvhwJ4YD07GFdUeF8rPcHb0s4V4ijHFaO2XRXm/
        vCcjFESdBUz+jN0gxAPCcw0Hmg==
X-Google-Smtp-Source: ABdhPJyXHy8o5efYWxLhy1dLJ8hnfuZwXzP62f1Sg8h/0T7IBCFLSl9kbktKWjtRdG8iqvXFRTfMig==
X-Received: by 2002:a17:902:b94b:b029:e0:1e:da58 with SMTP id h11-20020a170902b94bb02900e0001eda58mr20773271pls.55.1612240509723;
        Mon, 01 Feb 2021 20:35:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id x5sm1200519pjl.1.2021.02.01.20.35.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 20:35:08 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:05:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] opp: Don't ignore clk_get() errors other than -ENOENT
Message-ID: <20210202043506.kkw6ha4r7dp6wknc@vireshk-i7>
References: <61854037cd4d3ac367cfda3f02fd1557b1b3bb8b.1612153322.git.viresh.kumar@linaro.org>
 <e6523427-0484-18c3-5b66-a35146556bab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6523427-0484-18c3-5b66-a35146556bab@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 22:54, Dmitry Osipenko wrote:
> Thanks, looks okay.
> 
> Although, I think the previous variant of coding style was a bit more appropriate, i.e. like this:
> 
> dev_err_probe(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
> 
> return ERR_PTR(ret);

Okay will move to that.

-- 
viresh
