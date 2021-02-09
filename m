Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11C0314F81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhBIMu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:50:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:60730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhBIMtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83327ADCD;
        Tue,  9 Feb 2021 12:49:10 +0000 (UTC)
Date:   Tue, 9 Feb 2021 13:49:06 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/21] x86/fpu/xstate: Define the scope of the initial
 xstate data
Message-ID: <20210209124906.GC15909@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-9-chang.seok.bae@intel.com>
 <20210208123330.GE17908@zn.tnic>
 <AF6E884F-F6DC-4519-B57E-F6CFBDBEF85B@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AF6E884F-F6DC-4519-B57E-F6CFBDBEF85B@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:53:23PM +0000, Bae, Chang Seok wrote:
> Maybe, drop ‘for convenience’ from this sentence, since the buffer’s usage is
> not much relevant in this changelog.

Yes, "init_fpstate" is kinda clear what it is, from the name.

> It does functional change, but it is conditional to AMX enabling.
>
> It includes all the initial states when AMX states not enabled. But it will
> exclude the AMX state (with 8KB zeros) with the change.

Those sentences "no functional change" are supposed to mean that
the patch doesn't change anything and is only an equivalent code
transformation.

Yours does. So drop it from this one and from all the other patches as
it is causing more confusion than it is trying to dispel.

> I think they are in a different context.
> 
> The helper indicates the mask for the ‘init_fpstate’ buffer. The rest is the
> initial mask value for the per-task xstate buffer.

Wait, what?

Are you trying to tell me that that helper will return different masks
depending on xfeatures_mask_user_dynamic, which changes in its lifetime?

Then drop that helper altogether - that is more confusion and the xstate
code is already confusing enough.

> Since you suggested to introduce get_xstate_buffer_attr(), how about replacing
> what you found with something like:
> 
> get_xstate_buffer_attr(XSTATE_INIT_MASK)

I'd prefer no helper at all but only comments above the usage site.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
