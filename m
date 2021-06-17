Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12DE3AB3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhFQMue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:50:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhFQMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:50:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BA4E21AAD;
        Thu, 17 Jun 2021 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623934102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DN/4AxAo8ebwftMrb6LxrY21RNCTWf2fWPr9rz/QTtI=;
        b=tkB1pKAYKF0hp2ccZ33ZUc6pVW+6ySKB5PgemXmFq2vmKXfhNvqjQ9RoAvHvTXvLAGjhtH
        X46Hlik8dNXRccIiC4LJuwEfFGMjftmGkRRFZ4Fjjl8KL4OclWhi2wIYx91KpT87SFWRnC
        2dnVRF1wI5lZbvuiZJzDOe0PUrZDBBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623934102;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DN/4AxAo8ebwftMrb6LxrY21RNCTWf2fWPr9rz/QTtI=;
        b=h7QRiY2uZuhlI3sLBBbtD0+kPvxgEZR/fmfLkBXqL3inqdLM0GEYnqz1Dj/6tMsg3FcuXB
        xqNMhB0Fhk8f9hBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 79531118DD;
        Thu, 17 Jun 2021 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623934102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DN/4AxAo8ebwftMrb6LxrY21RNCTWf2fWPr9rz/QTtI=;
        b=tkB1pKAYKF0hp2ccZ33ZUc6pVW+6ySKB5PgemXmFq2vmKXfhNvqjQ9RoAvHvTXvLAGjhtH
        X46Hlik8dNXRccIiC4LJuwEfFGMjftmGkRRFZ4Fjjl8KL4OclWhi2wIYx91KpT87SFWRnC
        2dnVRF1wI5lZbvuiZJzDOe0PUrZDBBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623934102;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DN/4AxAo8ebwftMrb6LxrY21RNCTWf2fWPr9rz/QTtI=;
        b=h7QRiY2uZuhlI3sLBBbtD0+kPvxgEZR/fmfLkBXqL3inqdLM0GEYnqz1Dj/6tMsg3FcuXB
        xqNMhB0Fhk8f9hBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gJeMHJZEy2BgLwAALh3uQQ
        (envelope-from <bp@suse.de>); Thu, 17 Jun 2021 12:48:22 +0000
Date:   Thu, 17 Jun 2021 14:48:17 +0200
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
Subject: Re: [patch V2 22/52] x86/fpu: Rename copy_xregs_to_kernel() and
 copy_kernel_to_xregs()
Message-ID: <YMtEkXXv1uyEI4th@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.958020458@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.958020458@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:30PM +0200, Thomas Gleixner wrote:
> The function names for xsave[s]/xrstor[s] operations are horribly named and
> a permanent source of confusion.
> 
> Rename:
> 	copy_xregs_to_kernel() to xsave_to_kernel()
> 	copy_kernel_to_xregs() to xrstor_from_kernel()

Yap, better.

I wonder if simply calling them xsave() and xrstor() won't make it
even easier. The to/from kernel thing is kinda weird. If we need
to differentiate where we're saving, we can call the user variants
"to/from_user" instead, like the copy_to_/from_user things...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
