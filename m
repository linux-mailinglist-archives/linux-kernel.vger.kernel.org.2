Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC63444EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhKDGXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhKDGW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:22:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601FC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:20:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HlD5b0n9Vz4xd3;
        Thu,  4 Nov 2021 17:20:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1636006820;
        bh=2SNIkm5qUho28abvnF4QlEf2hkq7CW4M7metdPf2QTM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MFQUNQ+GP+C2P8TdN24VsueDWWzioLH7ID41VsHLgoF4lV/ZgG1BH+54S0a0PBK5s
         SBmj55YPAPd5xVBnZXzYT5Zq27Ai9HugvEYmm2R9LEUyEGe18udAGaTOQp29tK9/tV
         3Bl5hVL/+btrOxlHrR8KWTFNCp88NeY+wI9ZJx/kwIFFl+OJcVLBbnO8BAC1REG1O9
         c8AOsJkIIwF2zMn4S44Ib0uYE4DkT+/UtNsDMzazfo5eumt3SZwRPy1t7Cm507Igzi
         aJQJZIi86WiA1MC0PD6xdkRk30kamaOYWVWZgh3pX4eI87VgXDR2LkxIFQIn61bgUA
         xKvtn6zIKQ1vA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        patch-notifications@ellerman.id.au,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
In-Reply-To: <20211102235449.rwtbgmddkzdaodhv@meerkat.local>
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
 <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com>
 <87a6im87tq.fsf@mpe.ellerman.id.au>
 <20211102235449.rwtbgmddkzdaodhv@meerkat.local>
Date:   Thu, 04 Nov 2021 17:20:18 +1100
Message-ID: <871r3w8msd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> On Wed, Nov 03, 2021 at 10:18:57AM +1100, Michael Ellerman wrote:
>> It's not in next, that notification is from the b4 thanks script, which
>> didn't notice that the commit has since been reverted.
>
> Yeah... I'm not sure how to catch that, but I'm open to suggestions.

I think that's probably the first time I've had a commit and a revert of
the commit in the same batch of thanks mails.

And the notification is not wrong, the commit was applied with that SHA,
it is in the tree.

So I'm not sure it's very common to have a commit & a revert in the tree
at the same time.


On the other hand being able to generate a mail for an arbitrary revert
would be helpful, ie. independent of any thanks state.

eg, picking a random commit from the past:

  e95ad5f21693 ("powerpc/head_check: Fix shellcheck errors")


If I revert that in my tree today, it'd be cool if I could run something
that would detect the revert, backtrack to the reverted commit, extract
the message-id from the Link: tag, and generate a reply to the original
submission noting that it's now been reverted.

In fact we could write a bot to do that across all commits ever ...

cheers
