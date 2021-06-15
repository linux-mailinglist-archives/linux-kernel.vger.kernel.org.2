Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A433A7B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhFOKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:11:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhFOKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:11:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E87251FD2A;
        Tue, 15 Jun 2021 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623751750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDL1wVF9bJANau7hVbUKw7g0vTRPh8Xhz8VAUx4fNrI=;
        b=mQqL16G7p/jd5oXo4A2EyZOd2suj+AfB/Mm3Qh9YDlqAqKrVpUNAuSgVD6D4adH6fixCP+
        4+97gNItYZtziDtGeo3pTRhhpBxuoLaXIzDDfGJ7NlmUP15k9vpISQd9v9q06Hc04pEcYg
        k2WzfKQ1bRlQ/jEATJH2PCWo3uyjR1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623751750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDL1wVF9bJANau7hVbUKw7g0vTRPh8Xhz8VAUx4fNrI=;
        b=wI9fDY34eP4LHswxyBnlhCJ81dzK2c/ZaEhopBQsEnNe1AkduGuPMeiQAxwC+KOqOGeGnC
        WY8YCQXptLVnhTAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D1424118DD;
        Tue, 15 Jun 2021 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623751750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDL1wVF9bJANau7hVbUKw7g0vTRPh8Xhz8VAUx4fNrI=;
        b=mQqL16G7p/jd5oXo4A2EyZOd2suj+AfB/Mm3Qh9YDlqAqKrVpUNAuSgVD6D4adH6fixCP+
        4+97gNItYZtziDtGeo3pTRhhpBxuoLaXIzDDfGJ7NlmUP15k9vpISQd9v9q06Hc04pEcYg
        k2WzfKQ1bRlQ/jEATJH2PCWo3uyjR1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623751750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDL1wVF9bJANau7hVbUKw7g0vTRPh8Xhz8VAUx4fNrI=;
        b=wI9fDY34eP4LHswxyBnlhCJ81dzK2c/ZaEhopBQsEnNe1AkduGuPMeiQAxwC+KOqOGeGnC
        WY8YCQXptLVnhTAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Gw9xMkZ8yGAFFQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 15 Jun 2021 10:09:10 +0000
Date:   Tue, 15 Jun 2021 12:09:00 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 09/41] x86/kvm: Avoid looking up PKRU in XSAVE buffer
Message-ID: <YMh8PAomWPzHx3Nt@zn.tnic>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.931697147@linutronix.de>
 <YMcuzOOCGl+nKysP@zn.tnic>
 <918268bd-8092-7511-f0b8-d981143b7610@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <918268bd-8092-7511-f0b8-d981143b7610@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:34:31PM -0700, Dave Hansen wrote:
> I gave that a shot.  Two wrinkles: The PKRU memcpy() needs 'offset' from
> cpuid_count() and the PKRU case also needs the 'valid -=' manipulation.
>  The result is attached, and while it makes the diff look better, I
> don't think the resulting code is an improvement.

Bah, that was too much wishful and faulty thinking on my part, forget
what I said.

> I *think* these are already stored in xfeature_uncompacted_offset[].  It
> would be a pretty simple matter to export it.  I just assumed that this
> is a slow enough path that the KVM folks don't care.

I guess. Yeah, let's cleanup the FPU mess first and then see what makes
sense or not.

> I'm happy to change it, but I usually like to separate declarations from
> pure code.  Although, I guess that's a bit inconsistent in that file.

No, this is what I mean:

+			src = get_xsave_addr(xsave, xfeature_nr);
+			if (src)
+				memcpy(dest + offset, src, size);

vs

+			void *dest = get_xsave_addr(xsave, xfeature_nr);
+
+			if (dest)
 				memcpy(dest, src + offset, size);

both in your patch.

It is a lot easier when reading the code to have the error handling
glued together with the previous function call.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
