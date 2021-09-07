Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1F402F86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbhIGUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:19:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbhIGUTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:19:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631045893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UOXtuhpxa2Uvzi3wL8Ac7kEQaY5QeuXJwt0YUgkORE=;
        b=l4sEv/R+PAVFLG0WMly7bhHBeMxdZQ4XjIlXZKvaVrhQBwxlIcGbEbbMJVOAlNjbnDidSP
        F4RGdK7m7rXHVfyqpv9O6d8kFpZfDzdok0Lf1b+aBQmf7xolusP86FY4v6aNXXMmLbbIAU
        DFbxj5TY+WegDlew77qbC24GoFXZA9rOPnHR5kigY/B+0dpPv3v7dsh4kURgej9MSMJxNa
        E3FYfjAoIhh1O+jPCBTQTFA9o18UdxVvlhcJs0hsVHh8eBKIq/tv9Sy1MzwUS9OWWeaZVi
        1GygykMf/EGYmpinZE3kEpioisN8c7H1CMZtXgvqeA1yKTZnweU3vGd9CS8s5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631045893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UOXtuhpxa2Uvzi3wL8Ac7kEQaY5QeuXJwt0YUgkORE=;
        b=r0hT9gJkuY7WHJNeSCVCXqxbySj9HnLsrhqsfJyFWNrIBvTtZTnE29muN2CjPsh0mtK+u6
        jq8aFC/ejTAeXmAA==
To:     "Luck, Tony" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: RE: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
In-Reply-To: <e190b62e3f954cc1804a41149a842641@intel.com>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
Date:   Tue, 07 Sep 2021 22:18:13 +0200
Message-ID: <871r609m2i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2021 at 20:07, Tony Luck wrote:

>> Please ignore. My quilt scripts went berserk for some weird reason.
>
> Was it just the email post that was bad? I.e. are the patches in:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
>
> ok?  I just compiled that, should I boot it, or wait?

Just the mail script went south. The git tree is fine.

Thanks,

        tglx
