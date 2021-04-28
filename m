Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972C536DDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbhD1Q5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:57:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbhD1Q5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:57:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619628989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcjfKGsDUtZIm8NkZRo5Z9ImIbSWx7ZUl7/bQCsDzSA=;
        b=veY7OyHT63EGaVlw/w9Z99/o5BgyI0d4czHBFdspTtcYHheb689AV/UAVgIZzSjbXmG8js
        Ji/3ccq3EIz33tMLHblpFkiU6jI2B1DvOvbyrjWZrxeSG2bnW9f+Xj7kl5XSJkE4VNGDT8
        ERh/ezmaRUyONyBLwlBwNBVvsHwmYR1DvF0b4Ra2AmVlCTDkUnZf58OTlqGkP3XEItkkng
        MSH/gIYa6SbqwHiEV1mf9lOGhn3Gi+2Pq6wzhnAlDLf4NNkqyM7dUEgkSOxMMPqKsmiydE
        IrvmoJdvV26X1IQvYlHQiGN4sN5j0uhUZxOZnIGuc5ZaXxEtqhfm8R1/8kUvww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619628989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcjfKGsDUtZIm8NkZRo5Z9ImIbSWx7ZUl7/bQCsDzSA=;
        b=qEpMcwOYuFwl4uZ259mGVlC75/RmDvgQV/rjWXCIAlOZgzxCQzCc4xMYs6MaiR3DJAX7MW
        PZQC6hS9vPwessBw==
To:     Philip Li <philip.li@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp\@lists.01.org" <lkp@lists.01.org>,
        "lkp\@intel.com" <lkp@intel.com>,
        "zhengjun.xing\@intel.com" <zhengjun.xing@intel.com>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [LKP] Re: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2% regression
In-Reply-To: <20210428152339.GA2282261@pl-dbox>
References: <20210427090013.GG32408@xsang-OptiPlex-9020> <87fszcnecr.ffs@nanos.tec.linutronix.de> <20210428050758.GB52098@shbuild999.sh.intel.com> <d392cc91241641df865217d82368eba8@hisilicon.com> <20210428080819.GB53821@shbuild999.sh.intel.com> <87o8dyn5xr.ffs@nanos.tec.linutronix.de> <20210428152339.GA2282261@pl-dbox>
Date:   Wed, 28 Apr 2021 18:56:29 +0200
Message-ID: <874kfqmjpe.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philip,

On Wed, Apr 28 2021 at 23:23, Philip Li wrote:
> On Wed, Apr 28, 2021 at 10:56:16AM +0200, Thomas Gleixner wrote:
>> On Wed, Apr 28 2021 at 16:08, Feng Tang wrote:
>> > On Wed, Apr 28, 2021 at 07:01:35AM +0000, Song Bao Hua (Barry Song) wrote:
>> >
>> >> But it is still an irrelevant problem.
>> > Yes, the commit itself has no problem. And my personal thought
>> > is no further action is needed. 
>> 
>> The commit does not need any further action, but this testing stuff
> Sorry Thomas for confusion and trouble caused by this. We will take it
> seriously to refine the report process for this category (alignment or
> cache behavior) of performance change, to avoid meaningless ones.

Things go wrong every now and then. As long as we figure it out and
stuff gets fixed, no problem.

Thanks,

        tglx
