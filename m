Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B18E443987
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKBXWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:22:44 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:52287 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhKBXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:21:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HkQnt2VGhz4xbC;
        Wed,  3 Nov 2021 10:18:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1635895138;
        bh=YFiZDGWUC1/1vtgCtfKwz+BIRJgxcnCFDDMQt4TIZ2A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CPycaGj8D5pOC4yfecRW+Ke8e5re9XWdhjA65Qiq8chCXBm3ZYrhm93zLw7ZbC3zA
         QapfvYm0yp2EYcSi1/9oXEq+IvKwtW+G+X0nFTHE1jqIaIT9dlt3l8YcrdaEW2ZoPw
         EsUBNhd77eObxHsm3TUjXmADxgCSCwEs+uLekAX08vCAR0HEWsCs3wJrLiJL/F/28g
         UGeGrOz6nYuyjwlsSEy2o5iL8Sp+dcMy2i0r7swWhgKjjs7k8buxQK8YFpNhfsfYcE
         AHLnlV+df3R8pm0+Z45YaFRQWEaSrMNsH9plxeUD14bDkA9xVIrJYZcqwrgx0Q1Xw1
         n9lTkWgpbnz7w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Paul Moore <paul@paul-moore.com>,
        patch-notifications@ellerman.id.au
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
In-Reply-To: <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com>
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
 <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com>
Date:   Wed, 03 Nov 2021 10:18:57 +1100
Message-ID: <87a6im87tq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:
> On Tue, Nov 2, 2021 at 7:38 AM Michael Ellerman
> <patch-notifications@ellerman.id.au> wrote:
>>
>> On Tue, 24 Aug 2021 13:36:13 +0000 (UTC), Christophe Leroy wrote:
>> > Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>> > targets") added generic support for AUDIT but that didn't include
>> > support for bi-arch like powerpc.
>> >
>> > Commit 4b58841149dc ("audit: Add generic compat syscall support")
>> > added generic support for bi-arch.
>> >
>> > [...]
>>
>> Applied to powerpc/next.
>>
>> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
>>       https://git.kernel.org/powerpc/c/566af8cda399c088763d07464463dc871c943b54
>
> Did the test failure discussed earlier in this thread ever get
> resolved?  If not, this really shouldn't be in linux-next IMO.

It's not in next, that notification is from the b4 thanks script, which
didn't notice that the commit has since been reverted.

cheers
