Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDC3B1526
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:53:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43206 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFWHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:53:52 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 065C71FD66;
        Wed, 23 Jun 2021 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624434695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPn3n76cv2PWv05vGA1V1VJx6HeHo/9mvLTv1jvZ4H0=;
        b=x+WPXwWbT7JUEhSDmZPOYrtcQOLp019w3wjtj7JajI8QNoPktBWlkZ46h7N/XTCgonpSHG
        sbY/LZON0ciYPuLVajQSjPF6qFy7+xUUH/k3h9LvTBkZ3Y3FHKPBOWMG4tKSi3BDCS68zV
        aTuFmpv7i28fZdV3TYX1e0FWXhyXRPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624434695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPn3n76cv2PWv05vGA1V1VJx6HeHo/9mvLTv1jvZ4H0=;
        b=62b3/gdgNf6OyWpnISGygwNka9S3vkxMXL0Xg299dU4qBMHZLcG9Q3F4KLCFpKRBXbselP
        Iroqpq12bYxlkgCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E608311A97;
        Wed, 23 Jun 2021 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624434694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPn3n76cv2PWv05vGA1V1VJx6HeHo/9mvLTv1jvZ4H0=;
        b=EQEB3DrKvm9eXY9WWLi1U2nTdKJnhKABzqEvsURugFKCA4qeW59Ahj99of+b0FzU1XtJwp
        vF+g2zFkWJO8zsI9zrLcj9kmpU9ammoMFWH0f2XQ8duk2y+nT2OC20cI9EF0JxbuXpDps/
        lRViN9LRPzjxvQ+gZ2lQi6LpP40IuSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624434694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPn3n76cv2PWv05vGA1V1VJx6HeHo/9mvLTv1jvZ4H0=;
        b=rOVQ6YVQo8ZCIvjLHc2wQFgm8XPggmRa1fzV23Tk03gso/7aevCCi7BCnjr1bTghkbUdSe
        jwilp9B1IiP1NcDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1akGNwbo0mDlCQAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 23 Jun 2021 07:51:34 +0000
Date:   Wed, 23 Jun 2021 09:51:28 +0200
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
Subject: Re: [patch V3 62/66] x86/fpu/signal: Sanitize
 copy_user_to_fpregs_zeroing()
Message-ID: <YNLoAD0/+so9z1TA@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.442467526@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.442467526@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:25PM +0200, Thomas Gleixner wrote:
> Now that user_xfeatures is correctly set when xsave is enabled, remove the
> duplicated initialization of components.
> 
> Rename the function while at it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |   36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
