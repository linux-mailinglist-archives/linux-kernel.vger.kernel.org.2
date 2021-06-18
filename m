Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1713ACF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhFRQDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhFRQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:03:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E11C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 09:00:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWe8aUzcnMAbXG5rd+miMyOIe41LlzQ7svV6dR727iM=;
        b=L3qpTcO8eVQidHVoVRGeu9ezZdtAm5eBugEIGKRZOCnl3to/3c3Q0WhB985uMUV8fqhPY9
        uyS6U/AgK3rcthop1mc249Z/JVpBDG1znD+wCnV89aM4iPnsoYczT/kbpLqdT0apaYjVp/
        0E6XZ1sSbV5lEuBDB4h9kFbtUyQz41thlmS+h8LcnmE+jhvtBClhXFp+Q11wxBiEWCnIvt
        RPwnzTRoRCEke7z7CbQYoK4z1nscNOMi2JA0lXZA6h/h+L28XrLg89QV0hwa06U9FTyAvu
        fB57pJcHdX8wOoNUxazGOQpsuW+eNnmeVE+hNzzsNAGtRPnoKL/Kc+TV3rmMRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWe8aUzcnMAbXG5rd+miMyOIe41LlzQ7svV6dR727iM=;
        b=pyE2++pi/rDZohCTa16nr6r/04eg/NedLUbin8dc8fwwaSLdJTj3zSD1J0L1+AszA2AvN+
        sa+hzU1pZ3l9qrAw==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        luming.yu@intel.com
Subject: Re: [GIT PULL clocksource] Clocksource watchdog commits for v5.14
In-Reply-To: <20210609233723.GA1717240@paulmck-ThinkPad-P17-Gen-1>
References: <20210609233723.GA1717240@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 18 Jun 2021 18:00:57 +0200
Message-ID: <87bl83f9hi.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09 2021 at 16:37, Paul E. McKenney wrote:
> This pull request contains changes to cause the clocksource watchdog to
> reject measurement noise caused by delays between clocksource reads.
> These have been posted a few times to LKML, most recently v15:
>
> https://lore.kernel.org/lkml/20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1/
>
> These have been acked by Feng Tang and reviewed by Luming Yu.  These have
> also been subjected to subjected to the kbuild test robot and -next
> testing, and are available in the git repository based on v5.13-rc1 at:

I'll go through them soon. Sorry for the delay.
