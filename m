Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6C3826D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhEQIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:25:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233648AbhEQIZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:25:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91153AEBD;
        Mon, 17 May 2021 08:23:54 +0000 (UTC)
Date:   Mon, 17 May 2021 10:23:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] init: Print out unknown kernel parameters
Message-ID: <YKIoFcsrILdZSxfp@zn.tnic>
References: <20210511211009.42259-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210511211009.42259-1-ahalaney@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:10:09PM -0500, Andrew Halaney wrote:
> It is easy to foobar setting a kernel parameter on the command line
> without realizing it, there's not much output that you can use to
> assess what the kernel did with that parameter by default.
> 
> Make it a little more explicit which parameters on the command line
> _looked_ like a valid parameter for the kernel, but did not match
> anything and ultimately got tossed to init. This is very similar to the
> unknown parameter message received when loading a module.
> 
> This assumes the parameters are processed in a normal fashion, some
> parameters (dyndbg= for example) don't register their
> parameter with the rest of the kernel's parameters, and therefore
> always show up in this list (and are also given to init - like the
> rest of this list).
> 
> Another example is BOOT_IMAGE= is highlighted as an offender, which it
> technically is, but is passed by LILO and GRUB so most systems will see
> that complaint.
> 
> An example output where "foobared" and "unrecognized" are intentionally
> invalid parameters:
> 
>   Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.12-dirty debug log_buf_len=4M foobared unrecognized=foo
>   Unknown command line parameters: foobared BOOT_IMAGE=/boot/vmlinuz-5.12-dirty unrecognized=foo
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> It's my first time sending a v2 via email, please let me know if I've
> messed that up in anyway. I decided it wasn't worth the effort to do
> "autocorrect" functionality Borislav was pondering about, feel free to
> disagree on that if you have a strong opinion.

Oh well, I guess let's first see how this works in practice.

Looks ok to me:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
