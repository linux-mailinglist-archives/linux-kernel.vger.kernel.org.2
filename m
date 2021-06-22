Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66603B079D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhFVOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:43:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39388 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:43:06 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9D46F1FD45;
        Tue, 22 Jun 2021 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624372849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZcjy74akHRVejPRS+w1IjYF8NwPACuRfZ3q+/8AXu8=;
        b=uGlJlqjfTv5uA3UGYWxWJjxKtawxjFNz7OyBJlwBOggPp7j8AB/IKPAAu+6jCd5MkOpzke
        MiJj+agRV1YmcEtQ7m86etai9E2c4MYld4S4IKh+9BIYHJtWbz2ivu4MW8LzhKd0c/ayez
        OzDKA9tjmStM4iuf9FAT+7anNf/76tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624372849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZcjy74akHRVejPRS+w1IjYF8NwPACuRfZ3q+/8AXu8=;
        b=lqWjVZ4Sc4kIHzq6ZUaTsqHPFXNWAWCw1gFPqUnG/OW9J+vXZ5pvi/1HyxJ8/ocjyD2BEQ
        0dmN4zJ8B9/LD4CA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 89074118DD;
        Tue, 22 Jun 2021 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624372849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZcjy74akHRVejPRS+w1IjYF8NwPACuRfZ3q+/8AXu8=;
        b=uGlJlqjfTv5uA3UGYWxWJjxKtawxjFNz7OyBJlwBOggPp7j8AB/IKPAAu+6jCd5MkOpzke
        MiJj+agRV1YmcEtQ7m86etai9E2c4MYld4S4IKh+9BIYHJtWbz2ivu4MW8LzhKd0c/ayez
        OzDKA9tjmStM4iuf9FAT+7anNf/76tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624372849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZcjy74akHRVejPRS+w1IjYF8NwPACuRfZ3q+/8AXu8=;
        b=lqWjVZ4Sc4kIHzq6ZUaTsqHPFXNWAWCw1gFPqUnG/OW9J+vXZ5pvi/1HyxJ8/ocjyD2BEQ
        0dmN4zJ8B9/LD4CA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id OlBfIHH20WCLYwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 14:40:49 +0000
Date:   Tue, 22 Jun 2021 16:40:48 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V3 46/66] x86/fpu: Rename fpu__clear_all() to
 fpu_flush_thread()
Message-ID: <YNH2cD8wvrl0zgXF@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143449.628751239@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143449.628751239@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:09PM +0200, Thomas Gleixner wrote:
> Make it clear what the function is about.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h |    3 ++-
>  arch/x86/kernel/fpu/core.c          |    4 ++--
>  arch/x86/kernel/process.c           |    2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
