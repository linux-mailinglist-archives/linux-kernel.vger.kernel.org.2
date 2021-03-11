Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BDB33816D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCKX0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhCKX0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:26:09 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285FBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:26:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DxQ711CXQz9sVt;
        Fri, 12 Mar 2021 10:26:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1615505165;
        bh=E/wjRfTwLwTeZtdF+8K681lQgpnJDWERQYIyr2pWj1A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Mp9KtA2wbabfGNEAG4yTlb3/fMM0Tv1eaZo6pwYit0dnQQf2ydQGk3IHRd5RQTCwl
         /0wzOYdhQ1nqZRO9YxSYrX81QsYksW6q1EG4QBAhaWsfbW9L/56v32LBvwbpE0fkjb
         acBf9fVvF3ss2/CCA+jka/ZahwElg+HaUEEhbWAHcIGj/sep5vlj1x3RJ8dXIKD1XU
         l2tcL3b+FufTlHB77twz4EiPRYz8rAOUM6MhHhnfjLaNseZiQB/xG4BlaOjo9PazuR
         0k/JMy6SguGvK9L/Yct1RltMbwMp+5U0cSR8eiRGl9Gfwsbr9AHG38SzGUF6HOQuK2
         FwybpQUleqVVg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 25/43] powerpc/32: Replace ASM exception exit by C
 exception exit from ppc64
In-Reply-To: <0296d1bc-b37e-43c8-06cf-00ec458fb74e@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
 <a9a50f475db97fc53795dd778bc14f58029fdd55.1615291473.git.christophe.leroy@csgroup.eu>
 <87tuphkdkz.fsf@mpe.ellerman.id.au>
 <0296d1bc-b37e-43c8-06cf-00ec458fb74e@csgroup.eu>
Date:   Fri, 12 Mar 2021 10:26:02 +1100
Message-ID: <87r1kljmr9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 11/03/2021 =C3=A0 14:46, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> This patch replaces the PPC32 ASM exception exit by C exception exit.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/kernel/entry_32.S  | 481 +++++++++-----------------------
>>>   arch/powerpc/kernel/interrupt.c |   4 +
>>>   2 files changed, 132 insertions(+), 353 deletions(-)
>>=20
>> Bisect points to this breaking qemu mac99 for me, with pmac32_defconfig.
>>=20
>> I haven't had time to dig any deeper sorry.
>
> Embarrasing ...

Nah, these things happen.

> I don't get this problem on the 8xx (nohash/32) or the 83xx (book3s/32).
> I don't get this problem with qemu mac99 when using my klibc-based initra=
mfs.
>
> I managed to reproduce it with the rootfs.cpio that I got some time ago f=
rom linuxppc github Wiki.

OK.

I'm using the ppc-rootfs.cpio.gz from here:

  https://github.com/linuxppc/ci-scripts/blob/master/root-disks/Makefile

And the boot script is:

  https://github.com/linuxppc/ci-scripts/blob/master/scripts/boot/qemu-mac99

I've been meaning to write docs on how to use those scripts, but haven't
got around to it.

There's nothing really special though it's just a wrapper around qemu -M ma=
c99.

> I'll investigate it tomorrow.

Thanks.

cheers
