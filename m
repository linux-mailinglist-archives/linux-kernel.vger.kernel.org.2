Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD16351E73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbhDASln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:51264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237184AbhDASSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:18:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F1CFAEB3;
        Thu,  1 Apr 2021 18:18:54 +0000 (UTC)
Date:   Thu, 1 Apr 2021 20:18:54 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tony.luck@intel.com, linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: Backporting to v5.6: fd258dc4442c ("x86/mce: Add Skylake quirk
 for patrol scrub reported errors")
Message-ID: <20210401181854.GB11782@zn.tnic>
References: <20210401161740.GA22501@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401161740.GA22501@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Paul,

On Thu, Apr 01, 2021 at 09:17:40AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> We are looking at backporting fd258dc4442c ("x86/mce: Add Skylake quirk
> for patrol scrub reported errors") to v5.6.  When accompanied by these
> guys, it passes our usual kernel smoke-testing:
> 
> 1df73b2131e3 ("x86/mce: Fixup exception only for the correct MCEs")
> 1de08dccd383 ("x86/mce: Add a struct mce.kflags field")

why do you even need those two?

fd258dc4442c gives you only an Action Optional severity for that
particular error type and the other two patches are for recovery of
errors in the kernel memory range, i.e., for pmem etc., so should be
unrelated.

I mean, it depends on what you want to backport, ofc.

HTH.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
