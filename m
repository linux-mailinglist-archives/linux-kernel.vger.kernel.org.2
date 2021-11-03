Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C539443971
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKBXUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:20:00 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:38391 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhKBXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:19:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HkQm10VJcz4xbc;
        Wed,  3 Nov 2021 10:17:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1635895042;
        bh=ps6Fsd1Kfh3xQmGesz/FWIJjeJpokinvWr6rUJKMid4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z2bW7gwFcu1oO29X03+OyZOp+qhqgWkfVtDpTYwBJa29iPGx/3kz7Y6vBq2EN27A9
         n9UUDh60+QOfWHEH0D4v3e6ee8ALXEpSvOq3LtWlLqWeFwrNHvq3Q4on68gQl4h5bp
         9in53ycpN6mG+zyV9z0iLTNYFhGryEt60/YXpw/h6BeuVsCaOQRG4AiUi5Jl/3lyHa
         R3G4Hrb59Ac2kJIzzCD1LxGqZPu9GhT2sXPg0H5fm68wj9tqk7AzZ2BRHc2a0rxwlx
         W3shWRLkKtErwTOIyQUDKm2++QdIfqo37nYlXJ8dhqCiLJYQBJxoPXqK/djIm7VZvc
         UW9Z95mNHF5/w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
In-Reply-To: <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
Date:   Wed, 03 Nov 2021 10:17:19 +1100
Message-ID: <87czni87wg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 24 Aug 2021 13:36:13 +0000 (UTC), Christophe Leroy wrote:
>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>> targets") added generic support for AUDIT but that didn't include
>> support for bi-arch like powerpc.
>> 
>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>> added generic support for bi-arch.
>> 
>> [...]
>
> Applied to powerpc/next.
>
> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
>       https://git.kernel.org/powerpc/c/566af8cda399c088763d07464463dc871c943b54

And then reverted in:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=b7472e1764bfc0fe3d6578cb281e81c812ca5886

cheers
