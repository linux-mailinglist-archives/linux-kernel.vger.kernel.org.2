Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12883A48C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhFKSj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFKSj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:39:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1E34613AE;
        Fri, 11 Jun 2021 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623436648;
        bh=qf2B9XJZdLQRovCkHJh/OKFzbW1BwVV2cBTxEkGaWD0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NiWg9s/3KmoDKqAksYX4qi3VqIRcRzkCnWqh0whq9caP6akytQR39xD6L40qsztNt
         mCdD4WLN0uJzGOW2liNVT3+iN30XO19aI+O9fIIQRUDcXfxWZBtmPzCzLEHkakcbJH
         lASc7NhyFYjeaWX81SlYVfEx6TphzslExU166KnZWbAzWErxWZMxirbjGyuzv1VJBe
         gpyQ+YcEtRdpV4IvHaepmpq8gpuo+UomsXvlX6sbU2m/IcnahUdpvikHYbTd7gj8p2
         s7zbJqV7+BerhBaCwRZzFy4P1ketrN7XluKoZ5nAQ75JuoiTgCm2J0CkTSvalz+Si4
         uZoJVcKx6DdGA==
Subject: Re: [patch 05/41] x86/fpu: Limit xstate copy size in xstateregs_set()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.515164108@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <ff835ae2-bdd8-3a82-abd1-8ac7500acdcc@kernel.org>
Date:   Fri, 11 Jun 2021 11:37:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611163111.515164108@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 9:15 AM, Thomas Gleixner wrote:
> If the count argument is larger than the xstate size, this will happily
> copy beyond the end of xstate.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

This interface is horrible.  Oh well.
