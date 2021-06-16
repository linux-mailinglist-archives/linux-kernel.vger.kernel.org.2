Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA843AA102
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhFPQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:15:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47598 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhFPQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:15:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6D9C21A24;
        Wed, 16 Jun 2021 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623860028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXj92z4a9ZpU4KyvBJ0jS1fmopQOK6FNM9D/r4NVIU0=;
        b=W9YlBk6yozlbUtGrwWDAsuUReTvG8Ig6elsnjSi1NI56/0JhX+9pMCOErovMVplGKjRhgb
        Gph6uxGIZDr+VmlN2tvWmFMtklYp3L5Uw2rnhd7TDmCaglnw4bID2goi4UiRHDlabVUI6x
        YDMxwqgTIWn5qK6oT4noo3AfQxiuWMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623860028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXj92z4a9ZpU4KyvBJ0jS1fmopQOK6FNM9D/r4NVIU0=;
        b=Qt1YKIfozozXzrymnI2uIUL+N97ZUeR5tgGAR4fQ+KmYMo3i1yUK5i1Tj4Hl/RM/gotE1L
        eI9cjBzuZD0pddDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A42E5118DD;
        Wed, 16 Jun 2021 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623860028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXj92z4a9ZpU4KyvBJ0jS1fmopQOK6FNM9D/r4NVIU0=;
        b=W9YlBk6yozlbUtGrwWDAsuUReTvG8Ig6elsnjSi1NI56/0JhX+9pMCOErovMVplGKjRhgb
        Gph6uxGIZDr+VmlN2tvWmFMtklYp3L5Uw2rnhd7TDmCaglnw4bID2goi4UiRHDlabVUI6x
        YDMxwqgTIWn5qK6oT4noo3AfQxiuWMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623860028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXj92z4a9ZpU4KyvBJ0jS1fmopQOK6FNM9D/r4NVIU0=;
        b=Qt1YKIfozozXzrymnI2uIUL+N97ZUeR5tgGAR4fQ+KmYMo3i1yUK5i1Tj4Hl/RM/gotE1L
        eI9cjBzuZD0pddDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id EHb8JjwjymBCFwAALh3uQQ
        (envelope-from <bp@suse.de>); Wed, 16 Jun 2021 16:13:48 +0000
Date:   Wed, 16 Jun 2021 18:13:38 +0200
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
Subject: Re: [patch V2 14/52] x86/fpu: Make copy_xstate_to_kernel() usable
 for [x]fpregs_get()
Message-ID: <YMojMrxr+UwI0cVR@zn.tnic>
References: <20210614154408.673478623@linutronix.de>
 <20210614155355.143470533@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614155355.143470533@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:44:22PM +0200, Thomas Gleixner wrote:
> When xsave with init state optimiziation is used then a component's state

				optimization

> @@ -1062,14 +1062,20 @@ static void copy_feature(bool from_xstat
>  	membuf_write(to, from_xstate ? xstate : init_xstate, size);
>  }
>  
> -/*
> - * Convert from kernel XSAVE or XSAVES compacted format to UABI
> - * non-compacted format and copy to a kernel-space ptrace buffer.
> +/**
> + * copy_uabi_xstate_to_membuf - Copy kernel saved xstate to a UABI buffer

If this is what it does, then the function should be called:

copy_xstate_to_uabi_buf()

or so.

"membuf" is only an implementation detail anyway. IMHO.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
