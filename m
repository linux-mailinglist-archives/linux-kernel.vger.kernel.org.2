Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735CE3DBCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhG3PzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhG3PzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:55:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3BC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:54:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e5so11572971pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xuQ5Hj99GyYFnsFA2x3KGejJmiGy5PTCVic7W2UmUVM=;
        b=i8iEwRekyx9YY80vpNYzYzcv5OeckV3RGzwqyH18FjgbOjESwgFhvxtt/RHxz2lEAz
         q/O43nTE1HzTgaQmzppw1noxz8tqRN9C5dh07SH/h6AkFBKm4G8dQCkjOUoxABEjDdB/
         beNBRfUupNeK7qImXC+EmFVZE91QT0TGOxfqchc3mvyoxFbpo5QhRfWbDxsAwzGsMmqu
         1dcc1dvvQ88sBhOKOU9QqLqTwdGNTkg3AWbGWJJW0vqOM9hn911jK3DgMMrY3wVSi1SN
         x+Rc+agHYASHqhMOVOiCN4VODfxmnohFgKa+uIGkg+hk5MGJOJL7vOFGqvJ41I36/u7k
         1S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xuQ5Hj99GyYFnsFA2x3KGejJmiGy5PTCVic7W2UmUVM=;
        b=phrxh6/H4mLzzPGbuw9NyF9svu+bM3G2LWp2digf0SgIdIB0DGpKJg1xiqtbQ0iCg2
         H+Q6GBmh4d7mrFncV9ZFYspRaPiRd/WeY8v6M0aaqi7no7RLtE6iHO87ZIEPv5PJVVP+
         h1zFaMVnqvbrNscTkBDWclCaUZ6je2Ob2wwMqWhw7Y4fdQ6UxGaRABsHN+kxbP2b9RkF
         3uaxfbTWg5S9b6ufheXLVU7no4FSrCXyUdux+6If9ONm/TLlmd4BEbsd+mBMQhiL4Bk2
         J4P8lLdLORGr0Pe+PmJ4GnH4GFCpVE2A/xnKVAcxTVjfUk+JAphKq7P+MH8u/s1TdZhp
         NClw==
X-Gm-Message-State: AOAM530k4BFFAG0cefLaXGSGYxpsPuD8sICLXWloDrQwvegEdW2BX7r7
        ba9NNeU74ZGHBaPT+rTjx/8=
X-Google-Smtp-Source: ABdhPJz8Z0MztyBrhb9z3w9WjA3M/TRQyK8d+cnXd7EsIYHIqBt2B0Al6ZiaUbRb9cgaEdsN//2MmQ==
X-Received: by 2002:a05:6a00:1307:b029:308:1e2b:a24b with SMTP id j7-20020a056a001307b02903081e2ba24bmr3582208pfu.57.1627660498526;
        Fri, 30 Jul 2021 08:54:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5ec3])
        by smtp.gmail.com with ESMTPSA id k25sm2816656pfa.213.2021.07.30.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:54:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 30 Jul 2021 05:54:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix typo in comments
Message-ID: <YQQgzciYUKg0gio1@mtj.duckdns.org>
References: <20210730063951.2745-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730063951.2745-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 02:39:51PM +0800, Cai Huoqing wrote:
> Fix typo:
> *assing  ==> assign
> *iff  ==> if

iff is if and only if and isn't a typo.

Thanks.

-- 
tejun
