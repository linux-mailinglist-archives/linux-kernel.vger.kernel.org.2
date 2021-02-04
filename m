Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E040D30F3B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhBDNK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:10:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:36790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236223AbhBDNKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:10:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF6C8AC97;
        Thu,  4 Feb 2021 13:10:13 +0000 (UTC)
Date:   Thu, 4 Feb 2021 14:10:02 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/21] x86/fpu/xstate: Introduce helpers to manage
 dynamic xstate buffers
Message-ID: <20210204131002.GA17068@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-8-chang.seok.bae@intel.com>
 <20210126201746.GB9662@zn.tnic>
 <80003059-987E-4FFA-8F9D-6A480192BE5D@intel.com>
 <20210127104110.GB8115@zn.tnic>
 <9A4E3B85-BE0C-40C6-B261-E634CFCD9819@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A4E3B85-BE0C-40C6-B261-E634CFCD9819@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:10:24AM +0000, Bae, Chang Seok wrote:
> Okay, how about:
> “
> This alignment bit is set if the state is saved on a 64B-aligned address in
> the compacted format buffer.
> "

I'd prefer:

/*
 * True if the buffer of the corresponding XFEATURE is located on the next 64
 * byte boundary. Otherwise, it follows the preceding component immediately.
 */
static bool xstate_aligns[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = false };

> The threshold here could be more than that. But the intention is a heads-up to
> (re-)consider (a) a new allocation mechanism and (b) to shrink the memory
> allocation.
> 
> Also, the AMX state size is limited to (a bit less than) 64KB and it was
> discussed that vmalloc() will be okay with AMX [2].

So if nothing is going to grow over 64K, why are we even talking about this?

> Maybe it is possible to backtrack this allocation failure out of #NM handling.
> But the tracepoint can provide a clear context, although limited to those
> using it.

Yes, add it when it is really needed. Not slapping it proactively and
hoping for any potential usage.

> Indeed, this is the most preferred way on one hand. But there was a change to
> the current allocation approach by Ingo about 6 years ago [3].

Yah, there's that. :-\

I guess it needs to stay embedded. Oh well.

I guess you can diminish the confusion by doing this:

struct fpu {

	...

	union fpregs_state		*state;

	union fpregs_state		__default_state;
};

and tasks will have

	state = &__default_state;

set up by default in fpu__copy() etc.

AMX tasks will simply change the pointer to the vmalloc'ed xstate
buffer. This way at least the pointer will be a single one and the task
alloc code will simply reroute it instead of having two things to pay
attention to.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
