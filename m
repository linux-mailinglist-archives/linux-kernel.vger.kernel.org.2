Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB33A7EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFONRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:17:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52290 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhFONRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:17:38 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9871219CC;
        Tue, 15 Jun 2021 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623762932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y98G+xkTVHvfFDvbuoCaFeuLgRNF6e9aZ5lRPBsj2Dk=;
        b=aR9QypVO5CAePnszn4q5Uy/IQYJiGZd+ODGojzKoSHS2oEuRrYOGWAle1XLx1LjXXlMxwu
        13yvqddOnMTTdVyAE9MQwIqqTSNn2ivFC9kDmzEmlwr2e5WgZVitRCto0jbHLf7Y08tfB9
        5LUKOcR/XOT+3LzEkUoO6/6V+M82ELE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623762932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y98G+xkTVHvfFDvbuoCaFeuLgRNF6e9aZ5lRPBsj2Dk=;
        b=f3lKq3qxohBo8r+30Ij1xYLWK21iqvYRoyg+7op5AgJMIDdL9fefdmjR5fojjkF2C1wlUv
        YoR+ApIZ558A6fBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D2871118DD;
        Tue, 15 Jun 2021 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623762932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y98G+xkTVHvfFDvbuoCaFeuLgRNF6e9aZ5lRPBsj2Dk=;
        b=aR9QypVO5CAePnszn4q5Uy/IQYJiGZd+ODGojzKoSHS2oEuRrYOGWAle1XLx1LjXXlMxwu
        13yvqddOnMTTdVyAE9MQwIqqTSNn2ivFC9kDmzEmlwr2e5WgZVitRCto0jbHLf7Y08tfB9
        5LUKOcR/XOT+3LzEkUoO6/6V+M82ELE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623762932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y98G+xkTVHvfFDvbuoCaFeuLgRNF6e9aZ5lRPBsj2Dk=;
        b=f3lKq3qxohBo8r+30Ij1xYLWK21iqvYRoyg+7op5AgJMIDdL9fefdmjR5fojjkF2C1wlUv
        YoR+ApIZ558A6fBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id k/aMM/SnyGAtCwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 15 Jun 2021 13:15:32 +0000
Date:   Tue, 15 Jun 2021 15:15:16 +0200
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
Subject: Re: [patch V2 03/52] x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add
 PKRU value to init_fpstate")
Message-ID: <YMin5Pe8jVL+qxt3@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155353.984120664@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155353.984120664@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:11PM +0200, Thomas Gleixner wrote:
> This cannot work and it's unclear how that ever made a difference.
> 
> init_fpstate.xsave.header.xfeatures is always 0 so get_xsave_addr() will
> always return a NULL pointer, which will prevent storing the default PKRU
> value in initfp_state.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Fix subject
> ---
>  arch/x86/kernel/cpu/common.c |    5 -----
>  arch/x86/mm/pkeys.c          |    6 ------
>  2 files changed, 11 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
