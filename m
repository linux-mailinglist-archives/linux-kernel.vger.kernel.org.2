Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D81428B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhJKK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236119AbhJKK4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:56:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CBAD6023F;
        Mon, 11 Oct 2021 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633949670;
        bh=efC4KA59LTu76+6Io6IabNwAy4+PIrTQ5Oouhu4OhOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTsOkR/PDdrvKtPGsBT9/OeJcWzf+/ckGqz27wOdLxgsHfTuAINLmM18an7Ge6no5
         3cbavbARtyhJg8L+2YPpEGzrBfLBlJp4EgBVK7tvh4zMuQ/6tmpdF5Zb0f9RpejgKw
         YbmrQEhZzCm+6ECSQlPhPdrfOoXXh6xjXgyPbkDyERZUlDBmI0Q5Y3ACG+UO2/tGaW
         9Yh0cm4BIHUDKUkb3sOef0hunodERTMs8Nmlofq+axj33nKzs02Lk/phRlx6KQv+a1
         u9YmJPI5V15f5m8k+vDxt2vqaaAEfUd5K8wE3etv8sajpXaD6ip4VUtt36QP74VcvT
         aZgdVxoYXqb0g==
Date:   Mon, 11 Oct 2021 11:54:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 16/17] arm64: Add handling of CNTVCTSS traps
Message-ID: <20211011105423.GA4009@willie-the-truck>
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211010114306.2910453-17-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010114306.2910453-17-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 12:43:05PM +0100, Marc Zyngier wrote:
> Since CNTVCTSS obey the same control bits as CNTVCT, add the necessary
> decoding to the hook table. Note that there is no known user of
> this at the moment.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/esr.h |  6 ++++++
>  arch/arm64/kernel/traps.c    | 11 +++++++++++
>  2 files changed, 17 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
