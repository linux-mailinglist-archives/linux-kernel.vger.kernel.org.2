Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D681B40AB43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhINJ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhINJ73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECBD26109E;
        Tue, 14 Sep 2021 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631613492;
        bh=EFJnenSRfRKo4xYQ8fa+u3XqKr53G5eRL3ApQ4cQFjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrjN+bAsK3KmtJW4F53ScwCj1/rEKL9KopTswiGWmA+ZlIW77GfxTJp7cuHMvqodf
         v8a9jkbEEyKP9rXnIQ4V0KeNQk6GyE/k0PPKzEM9D/6v66h6YBCTDYDncclu+tBR1t
         1E/A/wKkncHhgpo6/Rtx9oNb36Rlq7kQg+UwuixD4GIFka1dK8Y1CwCwRWx5tg28BL
         P7M2Hb8SaPJBiBot71uH/pfRDZ6gh/HqMqtFQ2+jOaKR3D8mmSBpuctOAkfEp7fXjS
         P0TOUqc+q4SG88f9RjxYfrtROQ41dRv0t/HDk/R9SE5vAIWHAvYRoJZ9cGof0Y+HWS
         xhQTYG3rYtQxQ==
Date:   Tue, 14 Sep 2021 11:58:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] sched: Provide Kconfig support for default dynamic
 preempt mode
Message-ID: <20210914095810.GA9846@lothringen>
References: <20210913111623.230436-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913111623.230436-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:16:23PM +0200, Frederic Weisbecker wrote:
>  config PREEMPT_DYNAMIC
> -	bool
> +	bool "Preemption behaviour defined on boot"
> +	default y if HAVE_PREEMPT_DYNAMIC
> +	select PREEMPT

As reported by kernel test robot, the above default should be turned
into:

	depends of HAVE_PREEMPT_DYNAMIC
	default y

I'm issuing a v3.
