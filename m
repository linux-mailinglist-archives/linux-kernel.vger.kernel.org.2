Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B031CA14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhBPLqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhBPLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:40:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559BAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:39:39 -0800 (PST)
Received: from zn.tnic (p200300ec2f07cd0057261f4475df3a88.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:cd00:5726:1f44:75df:3a88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D48C81EC0258;
        Tue, 16 Feb 2021 12:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613475577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jgS+GomQ4NiGavnCUdrwH6fJiuF6SeCslhur8kkvAaE=;
        b=SH+3SJHOah+1Pnms0y+ql+//doOoRM04jih/iRCcJHn7O1NuSB+LGJoPE7OyEmmtfYPaNj
        0u9aC0iKxw3UqW5JSpvzWR8+3ZEWV8D0r9RYJCC3sfMCXSZomUCOgJtlUoD9UY970jI+SA
        FRF2cXfK8OEtza3WCyK0FqDHApgxiYA=
Date:   Tue, 16 Feb 2021 12:39:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: smpboot: CPU numbers printed as warning
Message-ID: <20210216113936.GC10592@zn.tnic>
References: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
 <YCuVEDXyIu+yE4c1@alley>
 <20210216101449.GA10592@zn.tnic>
 <871rdg8dyb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rdg8dyb.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:17:24PM +0106, John Ogness wrote:
> It is supported to provide loglevels for CONT messages. The loglevel is
> then only used if the append fails:
> 
>     pr_cont(KERN_INFO "message part");
> 
> I don't know if we want to go down that path. But it is supported.

Sounds ok to me. I leave it up to you guys to decide whether we wanna
change that there.

But I don't care that much about the CPU numbers ending up getting
issued at warning level so we can just as well do nothing and leave it
as is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
