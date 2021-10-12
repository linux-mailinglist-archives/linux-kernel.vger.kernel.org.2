Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3042A128
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhJLJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhJLJe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:34:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B93C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:32:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t11so13127159plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjzfOb2gtN1u8obAgrzFiLQ684Vop1WYpdfozFIYNbM=;
        b=aUN79haGLdilQZbwQ2763BN39KvkoPsE3h3yb2F3g02IhvUbd7+UHpmgDRsPwdvqhg
         qq86Y7m3+RnD8SsrhKuJzfveNRvA/JMub5MMabigbZcHAd3lQTt+YqD2WCkiac3sGIg8
         ivybUQxgrQ1NSYey8R0pYNdpFe/O11GXl2iR87zlJs5Bjw3HPD+5rcn/1u4q5p39WYEq
         6pa8YxzzKCfPlUmjHEiqbLaF+mY+hpZHgNCXf+2QAIC1xaDoKQohWb9eNSlKpJUrNwkN
         0YpOPypoEJJpeVteY/FStkieAKSrKGeKix9ijK5oRzo3pfBNjsy0aOLP8ZKvzMiIqFDE
         eZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjzfOb2gtN1u8obAgrzFiLQ684Vop1WYpdfozFIYNbM=;
        b=1r8g6Z9V6EaMhDWRC2PqopI25+0w5T5D198zFZWUbmdZrVj/3B12ygJKFyR2fRxn16
         BVc3Hm6HnjJM50MFDMLdeJx8XA7SBdboDUHlQQ6mHf8iZmLbDEkU++t0/jNABHOMPIV9
         epwpNNdHjh95ZN5E414r0aBCv1MJTUwOK4zQw7algxyg/hkxCddj30Yhn8T4B3RldQ4K
         1Np2xSa0iv74+V/IqKUEdz+IZkDDN5tp31Ll0WqbrXb+06Z2tvIWacgVsTtgi6nGYf6r
         iJz6SUDHzdZkWsrh2nZNTW4BfWQuVtwdEfoNDW5pkQM9iJPZ6fHptZmGWJ6Uw7hDZOOG
         bk/A==
X-Gm-Message-State: AOAM533cDIk2QvOO5aQzh5jbLGyCpTAZ/L6gvm3kA68JJbNhPJsBKWCT
        xgqvcykF0KczPsx6QfUEWsoi1Q==
X-Google-Smtp-Source: ABdhPJxEZXuRSwmLWd10BJsQLAh/3HgVQI8IjFeMRwsWoABKdg5QGkMx8QfnuDas3MxWQHqNt9oYMA==
X-Received: by 2002:a17:90b:4d87:: with SMTP id oj7mr4748844pjb.107.1634031174331;
        Tue, 12 Oct 2021 02:32:54 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id x13sm10611652pge.37.2021.10.12.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:32:53 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:02:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Hector Martin \"marcan\"" <marcan@marcan.st>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device
 does not exist
Message-ID: <20211012093252.hb6rlcpxv5bmk7n3@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
 <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
 <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049FC437-EC38-4FE5-891E-5E25960892CF@marcan.st>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-21, 18:31, Hector Martin "marcan" wrote:
> That doesn't work, though, because the CPUs aren't normal devices
> with runtime-pm. That was the first thing I tried :).

What's the exact problem with runtime PM here ?

> If you think this *should* be made to work instead then I can try that.

-- 
viresh
