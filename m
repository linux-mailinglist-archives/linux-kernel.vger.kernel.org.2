Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E43B0D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhFVTNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 15:13:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:13:19 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57B0821969;
        Tue, 22 Jun 2021 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624389062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a28prh9NK0Ofit31iABeSu3DbKXKoi9RSUcS74dw9w0=;
        b=z+nkmR90uwN65DmKGe+VsQfkpcP8NOS4ZW+3W5RY5ONh2u5sc04fs0m7RhQ+NQrQru3BPs
        rZQbx0HSF/3OufS9XjT+9weesW5V7bU8exA8mdEpocId/Kikuk6mTm27MAPUTcRVTOYVjs
        YJMpoSc6mIOfd0/qrk/sbyKxdJiDduU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624389062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a28prh9NK0Ofit31iABeSu3DbKXKoi9RSUcS74dw9w0=;
        b=EjNvqEtqMGFuQwmhkUKPL/5Ik6oxy4eyF87dq9zWpZYPDm7AXBjNrKR/JTz0jtas+qmfSC
        HQ6TqtAMbssx6VBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 450EC11A97;
        Tue, 22 Jun 2021 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624389062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a28prh9NK0Ofit31iABeSu3DbKXKoi9RSUcS74dw9w0=;
        b=z+nkmR90uwN65DmKGe+VsQfkpcP8NOS4ZW+3W5RY5ONh2u5sc04fs0m7RhQ+NQrQru3BPs
        rZQbx0HSF/3OufS9XjT+9weesW5V7bU8exA8mdEpocId/Kikuk6mTm27MAPUTcRVTOYVjs
        YJMpoSc6mIOfd0/qrk/sbyKxdJiDduU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624389062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a28prh9NK0Ofit31iABeSu3DbKXKoi9RSUcS74dw9w0=;
        b=EjNvqEtqMGFuQwmhkUKPL/5Ik6oxy4eyF87dq9zWpZYPDm7AXBjNrKR/JTz0jtas+qmfSC
        HQ6TqtAMbssx6VBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id R7DHD8Y10mB0egAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 19:11:02 +0000
Date:   Tue, 22 Jun 2021 21:10:52 +0200
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
Subject: Re: [patch V3 61/66] x86/fpu/signal: Sanitize the xstate check on
 sigframe
Message-ID: <YNI1vNLPL7VrN33Y@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143451.325530702@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143451.325530702@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:24PM +0200, Thomas Gleixner wrote:
> Utilize the check for the extended state magic in the FX software reserved
> bytes and set the parameters for restoring fx_only in the relevant members
> of fw_sw_user.
> 
> This allows further cleanups on top because the data is consistent.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c |   69 +++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 37 deletions(-)

Modulo Andy's catch, I can't find anything out of the ordinary here and
all this does makes sense to me. Still a tentative

Reviewed-by: Borislav Petkov <bp@suse.de>

because this is all nasty magic to me. (yah, magic1 and magic2 :-))

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
