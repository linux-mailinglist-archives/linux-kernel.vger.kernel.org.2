Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64613AE6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhFUKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:15:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:13:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624270404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t62xgmFi7P0+Wa1xH3UvYQoP03WRJMMZWKMtAPjqqv0=;
        b=HTw9SZRdxX1iOFuaJxTgWnT9Wy9aoJHH1EwLR42NyrqyGioZvtadSVUYmuhWDy5ME9dJRR
        UinZfSD7mO0Cy5328iLnrSYL2B2/j6wX3rWtnq+Eyss/kq3nBy7Z0EqBUoTXegC8M8bd4g
        h+j/vC+QkDakaJYPMXX50T+j/gFQwywxOsumSBcExjuShTX3ut9BCOy80dD36inSh326zm
        PD5VHSfV7inEKFpHHf7CwFIRcnCcsCLlp24QqnLUYTqJXBXz3JygxQGTErW6KewaK59HzD
        6lMY6YVauggG5IqXaUichzQIw2sQyyvQE5cB5Tynk1nyzLp0S3c2b7oUeweB9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624270404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t62xgmFi7P0+Wa1xH3UvYQoP03WRJMMZWKMtAPjqqv0=;
        b=VaxEKMdGGX4mUvYLB99SLQCI52H0LHgfwcC93gRTPeas38aBLweEyC8jP5gfQQ0V/fZHhj
        hU+XhcrHH7kfP0CQ==
To:     "Xu\, Pengfei" <pengfei.xu@intel.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen\, Dave" <dave.hansen@intel.com>,
        "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Su\, Heng" <heng.su@intel.com>, "Du\, Julie" <julie.du@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        "Brown\, Len" <len.brown@intel.com>,
        "Li\, Philip" <philip.li@intel.com>
Subject: Re: Tested x86 FPU fixes and found "Bad FPU state" issue
In-Reply-To: <9e6f363f138e4d05b368f4428399466b@intel.com>
References: <9e6f363f138e4d05b368f4428399466b@intel.com>
Date:   Mon, 21 Jun 2021 12:13:23 +0200
Message-ID: <87pmwffruk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pengfei!

On Mon, Jun 21 2021 at 01:31, Pengfei Xu wrote:
> This "Bad FPU state" issue was found in 20210619 FPU branch kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
> branch: origin/x86/fpu
> last commit:
> "
> commit 2299e66e766a7cdca8aafc36b59ada8782d26233
> ...
> x86/fpu/signal: Let xrstor handle the features to init
> "

Thanks for testing and reporting!

I found the issue and updated the branch. New head commit is

  b4c5dbb18205 ("x86/fpu/signal: Let xrstor handle the features to init")

Thanks,

        tglx
