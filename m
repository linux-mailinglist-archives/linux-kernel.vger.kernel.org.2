Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11A35AC79
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhDJJag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:30:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55690 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:30:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618047018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYeng7QY6h7mjvFeTTLz4lHKhsIHz/oD5/WrQR67yR8=;
        b=0TZMKVYHFJFYzE/Dw8YBI70NqkazjTSpqArmVDySc0teJCFexqbcD9DpjM6DhP8bQrEy3D
        /qFMmKjC0G0K4g7K5bZfySrySirOMC4YbkAfLeZgN2U4BYHaEzU8YJJ2QwHnTDyNxbR/L4
        yc2HaVfrWU0fdFhDuTZvC5D/bx4U9dZlXebOuLtLOH0DnbGwsYWaMk0FE8SLhNKxzqlhHV
        wL9P3Y92hoaFZAeovrk5n4teTEvEwC6/OmlvBd9LkTf/VvblubbWljIkeMDPIx+GHfx3Pe
        1VwPLTjFUoCl/oXCEtVXuEC+rSFevunnTuXuE9Ns0Rs1qaiv5rusU7sD/nGZag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618047018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYeng7QY6h7mjvFeTTLz4lHKhsIHz/oD5/WrQR67yR8=;
        b=xocQgvuFWLeehFJQ5iQ2EFw4ko3z0n+iDFVJd3TTpjSGocfOvcHnZplomINSiBSRnnKc0E
        0IF7mBy335IHOrCQ==
To:     Luke Dashjr <luke@dashjr.org>, linux-kernel@vger.kernel.org,
        trivial@kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] arch/x86: Encourage rather than discourage x2apic support
In-Reply-To: <202103310516.42497.luke@dashjr.org>
References: <202103310516.42497.luke@dashjr.org>
Date:   Sat, 10 Apr 2021 11:30:18 +0200
Message-ID: <87v98u32s5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31 2021 at 05:16, Luke Dashjr wrote:

> Multi-core SMP doesn't work on modern Intel CPUs (at least Comet Lake) without
> x2apic. Unsure users should say Y.

I'd rather make it explicit by also adding

    default y
   
Thanks,

        tglx
