Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFF36D451
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbhD1I5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbhD1I5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:57:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE79C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:56:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619600176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yw4zbZWnM1LPmPQXkz7A/is9cLSvX597px5tqOEQQo4=;
        b=AiEgCe9joO/m2F6pUIhcwtKgxeL/sY62GHtALfVn31G/PWeqRrxS+3kbIgeh7mAy1qwhE0
        LW4qfv1WPj62xCG0mSctGzVAOE+elPvHxrm8NxIfsyP7evRb/g/K89Hd7vvPT8IASMUPRj
        82d/EjeKuoEJ6t7NBLb0ylSmyphZiTFmYHXrhKrLw+UyF70+r0z18bEkZnQkxhEedBo76z
        mKkuKQQ04Jg++gUYb+ejlSVifsXePzOM7T04jsxuQwg4nLzRCP085AooHuUBDa0gcAIHRD
        T1A+nbQcShdIpKZHS+bQjJbjLarI2Yf+x1ww/zAbvA4GC24hSIt9uI3IV+RagQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619600176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yw4zbZWnM1LPmPQXkz7A/is9cLSvX597px5tqOEQQo4=;
        b=c3tXF+ERXAz6Zf+7+lv7on7FahKKJsDK7aaF8GJ+kqy6l8Xa6zaOnjWV/984sHRXG2hP+L
        OpZbepHN73Yu9tDw==
To:     Feng Tang <feng.tang@intel.com>,
        "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp\@lists.01.org" <lkp@lists.01.org>,
        "lkp\@intel.com" <lkp@intel.com>,
        "ying.huang\@intel.com" <ying.huang@intel.com>,
        "zhengjun.xing\@intel.com" <zhengjun.xing@intel.com>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2% regression
In-Reply-To: <20210428080819.GB53821@shbuild999.sh.intel.com>
References: <20210427090013.GG32408@xsang-OptiPlex-9020> <87fszcnecr.ffs@nanos.tec.linutronix.de> <20210428050758.GB52098@shbuild999.sh.intel.com> <d392cc91241641df865217d82368eba8@hisilicon.com> <20210428080819.GB53821@shbuild999.sh.intel.com>
Date:   Wed, 28 Apr 2021 10:56:16 +0200
Message-ID: <87o8dyn5xr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28 2021 at 16:08, Feng Tang wrote:
> On Wed, Apr 28, 2021 at 07:01:35AM +0000, Song Bao Hua (Barry Song) wrote:
>
>> But it is still an irrelevant problem.
> Yes, the commit itself has no problem. And my personal thought
> is no further action is needed. 

The commit does not need any further action, but this testing stuff
really needs further action because we can't differentiate between real
regressions and these bogus reports anymore.

Thanks,

        tglx
