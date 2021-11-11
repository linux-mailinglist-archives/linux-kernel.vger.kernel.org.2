Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8B44D431
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhKKJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKKJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:42:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3029EC0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:39:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 200so4730111pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=66upB9UJ5ORHzEAep2tUlnqy1cpQgTaUpFgQyeQM7dY=;
        b=Wxr7X2sp8eKvGoz48TQ3IPxhQ4Nu4qygPiKKqgo/aBbYYKpRnesfp4LYCwK/FVA7Yg
         TNZpOd5bktb1ZqkACJg7/ZFcYdX1nUmV3jytP7u3PO1NVb6clMa5glMjZQZMv+zxsOO/
         wzoVAqSgGL6mYeRDOsmoTvAyBF805kCYy/3M+vODNYbYejue/H3siQtugQeerSxyF3f3
         aFY1RWd4cmkpm753WxZYuZnDzCt6O+V0ee7xtjkxWjTyroWGBg7/At6f6+RWOh+OlldX
         IyLzsvXZTQ+fGNLJiqZ1p3U3IOHuUfWeMzklXPXDCgtDv38Gg2TGDBka519DDBuedEt3
         Mztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=66upB9UJ5ORHzEAep2tUlnqy1cpQgTaUpFgQyeQM7dY=;
        b=oA7gS6RXkPSaDcru7KyVlrvqRfEzuQ0PZe4irFCCIDngvxvqYE7C1fW6rN1gy75lLc
         WBG2Vq6yO/V+Q0nExpI6jvAafhWYiXDykirLJur40wJyqdCL0OzP55zLTfFEZpHcpXys
         AVqaqt42B0ocVR1skljsbXZmAFG1Eye+m4P28Ib7t9aaB7gr/JWcoERFjqOo2M5UGLkx
         0SlUseoZXa3Vngf960K+n+jTssMup4ccJ2IIaX+T1Qlhu5sMHNRtwovPYfPOz1ikBV3a
         lrc7jiodc1FLVkMAa9LuGGEmZe2OD+DFgxalLIFHDxN2yfd/nNG1wGkmJOv8fDfwj1B/
         p3HQ==
X-Gm-Message-State: AOAM531c0Od6IOGkdtUH9/BJDm74YcYkmd+hfZ/sbpXH45paz+CX55cs
        vIg7NYyzAP5zOmbJ3fTEd4ZDoQ==
X-Google-Smtp-Source: ABdhPJzAwF3ghBkf4IoJKTXb1HRcavwwixJemxah5ku3wC3cgiH64Pc9/2YwwSLt4r0ZQ06AB8sp+A==
X-Received: by 2002:a05:6a00:1a94:b0:49f:f5b4:5d17 with SMTP id e20-20020a056a001a9400b0049ff5b45d17mr5328492pfv.55.1636623572688;
        Thu, 11 Nov 2021 01:39:32 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id t4sm2435282pfj.166.2021.11.11.01.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Nov 2021 01:39:32 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:39:27 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: qcom: smd-rpm: Report enable state to framework
Message-ID: <20211111093926.GL7231@dragon>
References: <20211109022558.14529-1-shawn.guo@linaro.org>
 <YYpMzau3CWRQYlkJ@gerhold.net>
 <20211110131507.GJ7231@dragon>
 <YYvNmrSeJNCE4BEC@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYvNmrSeJNCE4BEC@ripper>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 05:48:10AM -0800, Bjorn Andersson wrote:
> > IMHO, properly reporting enable state to framework is definitely the
> > right thing to do, and should have been done from day one.
> > 
> 
> I always thought is_enabled() should reflect the hardware state - in
> particular for clk_summary. The particular concern being that by
> initializing the is_enabled() state to either true or false, we're
> making an assumption about the hardware state. And if something where to
> do if (enabled) disable (or if (disabled) enable), we might skip a
> critical operation just because we tricked the logic.

That's probably why clk_smd_rpm_handoff() is called.  As there is no way
to query RPM for resource state, we send enable request for all RPM
clocks to get hardware and software state in sync.

> So, do you need it for anything other than clk_disable_unused()?

Not critical, but I need it for debugfs clk_summary as well.

Shawn
