Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357F330DAC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhBCNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231487AbhBCNLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:11:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E03864F95;
        Wed,  3 Feb 2021 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612357868;
        bh=Z28w/dtmNYwRNJRS3ps3omqMGfLxEEw9/SS58NecS1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsolqZuN74+Vm6jaLfvzXLDq6PLL81G1BcwRpk3pv+Iy9VCUnbNHbu39aGjWx5Sh7
         EZOflFGHtElWM44KHecvsbf+tRZqJu6O4W3OP+Z7G20/ZG5U35hTGViISD4WUiM/9e
         UOx7xAc6QHRaMjEXi1epQH98feIopiJ6qbs5Y0jdSMfpopWl15P7orC8oiPt1wZeS4
         ikds0dTd1yoyUS0Z31C80Z2S/fHkqxEUuYpVesOCgUnasWXhj5uWp5W1HEFp9UsOwL
         xa12HPM5v1ibRyEwkGcM4x4IogU8VGyrwpSiD4iNERb4cd4IdMwRe5srHVwPfoviBj
         RGv1UJZWNA1vg==
Date:   Wed, 3 Feb 2021 14:11:05 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     chenshiyan <chenshiyan@linux.alibaba.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] nohz: Restart tick before do softirq
Message-ID: <20210203131105.GA3666@lothringen>
References: <1612151143-72242-1-git-send-email-chenshiyan@linux.alibaba.com>
 <20210201123811.GA41955@lothringen>
 <B2A33260-1D22-4C29-9811-64F0A68F0D64@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B2A33260-1D22-4C29-9811-64F0A68F0D64@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 09:04:05PM +0800, chenshiyan wrote:
> Are you working on an architecture that doesn't implement it?
> -No, we test it on x86.
> 
> The problem is , when it's doing softirq, but there’s no tick, so we don’t know how long 
> It takes. The TOP or some other procs can not show the right value of sirq.

But IRQTIME counting is based on sched_clock() which shouldn't use jiffies
in the case in x86. In fact jiffies based sched_clock() isn't suitable for
IRQTIME at all. So I don't understand the problem.
