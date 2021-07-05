Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD123BB9F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhGEJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:17:19 -0400
Received: from foss.arm.com ([217.140.110.172]:41616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhGEJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:17:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19AA313D5;
        Mon,  5 Jul 2021 02:14:42 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.8.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313C43F5A1;
        Mon,  5 Jul 2021 02:14:38 -0700 (PDT)
Date:   Mon, 5 Jul 2021 10:14:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        daniel.lezcano@linaro.org, maz@kernel.org,
        konrad.dybcio@somainline.org, saiprakash.ranjan@codeaurora.org,
        robh@kernel.org, marcan@marcan.st, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linu Cherian <lcherian@marvell.com>
Subject: Re: [PATCH] clocksource: Add Marvell Errata-38627 workaround
Message-ID: <20210705091436.GE38629@C02TD0UTHF1T.local>
References: <20210705060843.3150-1-bbhushan2@marvell.com>
 <20210705090753.GD38629@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705090753.GD38629@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 10:07:53AM +0100, Mark Rutland wrote:
> Hi Bharat,
> 
> On Mon, Jul 05, 2021 at 11:38:43AM +0530, Bharat Bhushan wrote:
> > CPU pipeline have unpredicted behavior when timer
> > interrupt appears and then disappears prior to the
> > exception happening. Time interrupt appears on timer
> > expiry and disappears when timer programming or timer
> > disable. This typically can happen when a load
> > instruction misses in the cache,  which can take
> > few hundreds of cycles, and an interrupt appears
> > after the load instruction starts executing but
> > disappears before the load instruction completes.
> 
> Could you elaborate on the scenario? What sort of unpredictable
> behaviour can occur? e.g:
> 
> * Does the CPU lockup?
> * Does the CPU take the exception at all?
> * Does the load behave erroneously?
> * Does any CPU state (e.g. GPRs, PC, PSTATE) become corrupted?
> 
> Does the problem manifest when IRQs are masked by DAIF.I, or by
> CNT8_CTL_EL0.{IMASK,ENABLE} ?

Whoops, that was supposed to say:

| CNT*_CTL_EL0.{IMASK,ENABLE}

... i.e. those fields in either CNTP_CTL_EL0 or CNTV_CTL_EL0.

Thanks,
Mark.
