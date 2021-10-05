Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C95422B41
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhJEOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbhJEOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:40:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBCEC061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:39:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d20008b62c5101b4e88fa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2000:8b62:c510:1b4e:88fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DD0D1EC0489;
        Tue,  5 Oct 2021 16:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633444742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dBI3lASetDpNcd+YaZnzQv/73q7wDSsq3FUu+gvanQ=;
        b=lUDmpPcKn3PQ688uR08pB/MGzBROHkFehFVkZgF+sbELIf8nSsW3ghxQ65HYf1Y4hm+B4h
        bkwKarKtZ/4V2UKSHEf1sYyHmMoj2rcL7MHKo0NFKsmYhAiSoxhc+Uf/QK6bx933QFAyH0
        iNe7vnQ6D+V9FeIKkGewdkPnJQrrlgE=
Date:   Tue, 5 Oct 2021 16:38:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
Message-ID: <YVxjgFScCZNwliMi@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:29:41PM +0200, Paul Menzel wrote:
> Selecting the symbol `AMD_MEM_ENCRYPT` – as
> done in Debian 5.13.9-1~exp1 [1] – also selects
> `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it defaults to yes,

I'm assuming that "selecting" is done automatically: alldefconfig,
olddefconfig?

Because CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT only depends on
CONFIG_AMD_MEM_ENCRYPT and former can be disabled in oldconfig or
menuconfig etc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
