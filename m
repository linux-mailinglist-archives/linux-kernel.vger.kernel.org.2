Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5173E3EC283
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhHNMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbhHNMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 08:00:14 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A384C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 04:59:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GmzW15xPNz9sWS;
        Sat, 14 Aug 2021 21:59:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1628942382;
        bh=g2G5hFPZF1lKhi3yGSAgG83UWIDupBfi4QPY+qfq8Ks=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FQidGTPhoSPHk+7MUkS1XOt7q1mfSsaWmyfom77eiQuSbVMsn6TqP69Id9NYkwwPW
         nduK249GoXidT8AYETQWmqCbcQKJvMyKrTQl6GskubYpekRwOjZlkmBRhkUFEL1Mi2
         8qWUtBPx3WI6SO9WgTdID53BPzo316jWb0bQxuU3E5Isb52IVpStcBWm4h824hT8Fu
         LGhm34VNFBBWLNyp+gztGESFnSBB3zjGoSpvQrcUC88bm8v9dLbP+At5kBbq/22icG
         mQ2J1rt2Y6nXJVwwsceAGkjwc2qBogmj9TeLU1XDSTp501O9L95w6rjZSEZkYYJR1z
         Isf1s9ZkWN7yg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bill Wendling <morbo@google.com>, Daniel Axtens <dja@axtens.net>,
        Fangrui Song <maskray@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
In-Reply-To: <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com>
References: <20210812204951.1551782-1-morbo@google.com>
 <87sfzde8lk.fsf@linkitivity.dja.id.au>
 <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com>
Date:   Sat, 14 Aug 2021 21:59:40 +1000
Message-ID: <87a6lkme37.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Wendling <morbo@google.com> writes:
> On Fri, Aug 13, 2021 at 7:13 AM Daniel Axtens <dja@axtens.net> wrote:
>> Bill Wendling <morbo@google.com> writes:
...
>> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> > index 6505d66f1193..17a9fbf9b789 100644
>> > --- a/arch/powerpc/Makefile
>> > +++ b/arch/powerpc/Makefile
>> > @@ -122,6 +122,7 @@ endif
>> >
>> >  LDFLAGS_vmlinux-y := -Bstatic
>> >  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
>> > +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext
...
>
> Unrelated question: Should the "-pie" flag be added with "+= -pie"
> (note the plus sign)?

I noticed that too.

It's been like that since the original relocatable support was added in
2008, commit 549e8152de80 ("powerpc: Make the 64-bit kernel as a
position-independent executable"), which did:

-LDFLAGS_vmlinux	:= -Bstatic
+LDFLAGS_vmlinux-yy := -Bstatic
+LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-yy)


There's no mention of those flags in the change log. But the way it's
written suggests the intention was to not pass -Bstatic for relocatable
builds, otherwise it could have been more simply:

+LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux	:= -Bstatic $(LDFLAGS_vmlinux-yy)


So I think it was deliberate to not use +=, but whether that's actually
correct I can't say. Maybe in the past -Bstatic and -pie were
incompatible?

cheers
