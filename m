Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02935DA38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbhDMIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242957AbhDMIlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:41:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 01:40:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b84004837eb674589142e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8400:4837:eb67:4589:142e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17DB71EC01A9;
        Tue, 13 Apr 2021 10:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618303239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EMBA8K2tTBDqgIIPapi7csnRaNzXmVEsaJb2MIff5gM=;
        b=NPZ5jgxmWkR7T84WoESxT6zzRuQX33QwR+7bkVW+WOUF22Zdj1GG+XuPwLAIt6BqxVz+a+
        YV8hKqaHvvhj96L4rY1CjbN4lalZ74KrhDsFBRxFjuhtqlvN9GJ0MmzLPmf4iIGHfX7lw7
        21bNenwAfDaPJOBZh/3dyfief+8vF1k=
Date:   Tue, 13 Apr 2021 10:40:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: x86: report: write to unrecognized MSR
Message-ID: <20210413084036.GA16519@zn.tnic>
References: <12997c36-8e18-87fc-2e49-bf40c14db2d7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12997c36-8e18-87fc-2e49-bf40c14db2d7@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 03:09:41PM -0700, Randy Dunlap wrote:
> 
> [   27.075563] msr: Write to unrecognized MSR 0x1b0 by x86_energy_perf (pid: 1223).
> [   27.078979] msr: See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for details.
> 
> (aka x86_energy_perf_policy)
> 
> 
> on linux-next-20210409 / x86_64.

You're using an old x86_energy_perf tool on a new kernel. That's fixed
upstream.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
