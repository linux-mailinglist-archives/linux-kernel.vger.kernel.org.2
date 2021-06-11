Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D803A476A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFKRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:07:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59326 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFKRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:07:00 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA54B2199C;
        Fri, 11 Jun 2021 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623431101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh+fMe3EIwHtmryyyMYh8wCuyuhafkTUBc+31h66sd8=;
        b=aW4loFNkIFDJGatrykOtb/wogl7S/7lc5mNlx6OIcS+5lT5YzcvdphpUCrfjftjCde9O6H
        SLPFITyEg4ndjpNra1soGlnJbpn2A+6hrAquAtRnp9WiiuTUSUilt9RTAcZPZlpQOTkbPM
        ExNVh2f3KLux8T1IOrC1GHOTszRwLv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623431101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh+fMe3EIwHtmryyyMYh8wCuyuhafkTUBc+31h66sd8=;
        b=B3Ew2jwFoJnHCTY40wSmOvr2qzhcPW6HnLoRtGIOPIN4dCinMWk/ckNqwOvw5BYB+c6Esc
        LWBsPiWsz4PpqFAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 92DC4118DD;
        Fri, 11 Jun 2021 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623431101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh+fMe3EIwHtmryyyMYh8wCuyuhafkTUBc+31h66sd8=;
        b=aW4loFNkIFDJGatrykOtb/wogl7S/7lc5mNlx6OIcS+5lT5YzcvdphpUCrfjftjCde9O6H
        SLPFITyEg4ndjpNra1soGlnJbpn2A+6hrAquAtRnp9WiiuTUSUilt9RTAcZPZlpQOTkbPM
        ExNVh2f3KLux8T1IOrC1GHOTszRwLv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623431101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh+fMe3EIwHtmryyyMYh8wCuyuhafkTUBc+31h66sd8=;
        b=B3Ew2jwFoJnHCTY40wSmOvr2qzhcPW6HnLoRtGIOPIN4dCinMWk/ckNqwOvw5BYB+c6Esc
        LWBsPiWsz4PpqFAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id orU1I72Xw2CpQgAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 11 Jun 2021 17:05:01 +0000
Date:   Fri, 11 Jun 2021 19:04:59 +0200
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
Subject: Re: [patch 01/41] Revert a5eff7259790 ("x86/pkeys: Add PKRU value to
 init_fpstate")
Message-ID: <YMOXu0w7Q9RZR3zt@zn.tnic>
References: <20210611161523.508908024@linutronix.de>
 <20210611163110.987044144@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611163110.987044144@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 06:15:24PM +0200, Thomas Gleixner wrote:
> This cannot work and it's unclear how that ever made a difference.


Subject: Re: [patch 01/41] Revert a5eff7259790 ("x86/pkeys: Add PKRU value to init_fpstate")

Add subject prefix pls:

x86/pkeys: Revert...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
