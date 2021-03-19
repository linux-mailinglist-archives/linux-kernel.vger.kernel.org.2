Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F28E34241D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:08:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCSSIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:08:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616177321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfxtfjT60D0/i11pvfLUSVY8fTbGUW4gIYpe8cXpgbQ=;
        b=DFMC5kdnTJv0ah+zOVlS3NTREv7DXSR0DR+ChsZ26pEcsrGI6ZzZYv2cSV0G7RqM+rphxh
        96/gPdVGKq/jEngtFfhPRXdXptsEaHSZkF/Nh5P1ahyf7yu1x1Ky2HUbTEpCHOAxMkaRY4
        QkHo26DtXisDPKfXPXSJaP3gvZLSy1zjVyaMRWsgqC/zzEPbHXxJfjmiqWvDtlFY7QkOjQ
        gDFijuUAjtUPQ38wbnAoairSOtqETE+uLSMh3+XFIPZt5rpgH0MOKys4jOPXpdraf9ejnB
        W9ukYy6zXTrP08QTSjOvn/AdcXVmAslGoTj14qkRKhLRprEmHB30SMBMdCeWOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616177321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfxtfjT60D0/i11pvfLUSVY8fTbGUW4gIYpe8cXpgbQ=;
        b=kRq7qiOLteStyH8xDOFTE47Aykp8lZM7bZHxFsanbAcwsueUs1ttykLOvj+9EL1iiM4aQD
        sQeTyK4pjbRIQBCQ==
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 5/9] kentry: Remove enter_from/exit_to_user_mode()
In-Reply-To: <8c0d187da7f8a44302c16e0a7325b3179d229331.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org> <8c0d187da7f8a44302c16e0a7325b3179d229331.1616004689.git.luto@kernel.org>
Date:   Fri, 19 Mar 2021 19:08:41 +0100
Message-ID: <87k0q35846.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 11:12, Andy Lutomirski wrote:
> -/**
> - * exit_to_user_mode - Fixup state when exiting to user mode
> - *
> - * Syscall/interrupt exit enables interrupts, but the kernel state is
> - * interrupts disabled when this is invoked. Also tell RCU about it.
> - *
> - * 1) Trace interrupts on state
> - * 2) Invoke context tracking if enabled to adjust RCU state
> - * 3) Invoke architecture specific last minute exit code, e.g. speculation
> - *    mitigations, etc.: arch_exit_to_user_mode()
> - * 4) Tell lockdep that interrupts are enabled
> - *
> - * Invoked from architecture specific code when syscall_exit_to_user_mode()
> - * is not suitable as the last step before returning to userspace. Must be
> - * invoked with interrupts disabled and the caller must be
> - * non-instrumentable.
> - * The caller has to invoke syscall_exit_to_user_mode_work() before this.
> - */
> -void exit_to_user_mode(void);

Oh well. There is this in the C code:

>  /* See comment for enter_from_user_mode() in entry-common.h */
>  static __always_inline void __exit_from_user_mode(void)

>  /* See comment for exit_to_user_mode() in entry-common.h */
>  static __always_inline void __exit_to_user_mode(void)

So the comments are now stale and the documentation is lost.

Making the diffstat impressive is not the primary goal here.

And looking at the rest of the comments there are still references to
stuff you deleted. This is really not how it works.

Thanks,

        tglx

