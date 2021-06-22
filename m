Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD83AFFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFVJLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFVJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:11:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A05C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:08:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624352924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpVayGWDD5jCjOsDFgbodGAhFkKfuv5XGWD7w7SebTM=;
        b=2R1/CleI7KOMUBqtuusPHNeBMyB6LQW23QPGGjCQZvQ0Gu1F5g27502eLEXYsIptF0rt2a
        wFXNgg3XyBG6ewdHMW1VmxCc3MGP0g7PgSqc24FhbZE4sEL0qHwmNZxbkV3e19pF+jZNQQ
        ZVL9VeYqf9YFoxGChCOYTmoaynoFcIkfaQYp2RRSuG2XU8bSo5vhhzMGYPjwLkoWk60cuW
        505IOY8i6xYQWJurLi5DhjnRL33vp7xdu9IhaISgVmewqkYkLjA2uFszN/E3EGEE4y/h9d
        2fs4u9TpFNBtvW0bxQV+WKLDxjJ6ohry5GsNzc4I/Ernfr0GnALVnaGSuf9SlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624352924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpVayGWDD5jCjOsDFgbodGAhFkKfuv5XGWD7w7SebTM=;
        b=kqPPEE7X6YDcM7f4Bc1ElGjkw5V0cvl+ZcwqnvLAfjy3YlwWAhRzZff+Y52vnYnYgjfvjL
        s2+Xj7eFKHetLXAg==
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Li\, Aubrey" <aubrey.li@intel.com>,
        "Xing\, Zhengjun" <zhengjun.xing@linux.intel.com>,
        "Tang\, Feng" <feng.tang@intel.com>,
        "Liu\, Yujie" <yujie.liu@intel.com>,
        "Si\, Beibei" <beibei.si@intel.com>,
        "Li\, Philip" <philip.li@intel.com>,
        "Du\, Julie" <julie.du@intel.com>
Subject: Re: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
In-Reply-To: <20210622015937.GB687@xsang-OptiPlex-9020>
References: <20210618141823.161158090@linutronix.de> <20210622015937.GB687@xsang-OptiPlex-9020>
Date:   Tue, 22 Jun 2021 11:08:43 +0200
Message-ID: <87wnqme06c.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,

On Tue, Jun 22 2021 at 09:59, Oliver Sang wrote:
> On Fri, Jun 18, 2021 at 10:18:23PM +0800, Thomas Gleixner wrote:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
>
> 0-Day kernel CI tested this branch from performance view,
> choosing some sub-tests from will-it-scale (detail as below), since we
> thought if the branch has the impact of fpu ops, will-it-scale should be
> able to catch it.
> we also plan to add stress-ng for new round test.
> could you suggest if any other suitable test suites? and what's the most
> proper sub-tests in will-it-scale and stress-ng?

Hard to tell. Anything scheduling heavy will exercise these code paths.

Thanks,

        tglx

        
