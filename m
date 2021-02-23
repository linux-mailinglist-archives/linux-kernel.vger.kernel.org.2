Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448F1322D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhBWPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:22:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhBWPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:22:26 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614093702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/AFvTPncWowuUW0ABTizhzarZQWNjA+MxWzWwUdQGuk=;
        b=L7fEfc7A/JixohE2jLHmlsYMa/EiyG9EKWQrxnv8UAcP/Yr0ZsS76XprVfGfkdZcpOcHDY
        t8QnAI8JQCDETCI86cWb1Jt+bEpYSf+n0ikx4Hg0XNmFNeNcz1oHkR0/S9jznt//rflhcH
        YRCMMLqbG7Bk8nw6rN0x3jTsP3LmPwnKwva3YJA+vpl/JSXiTpCs68nJy4mb/885hUmN61
        6HnyoYELSy67tF17zaFd5H6bwkvHnjD5egAj+vEw3rkrNM8f1EPARbyqB5j3oNTG2ylSRX
        CLQe9QzElOZEN8XpPSArrsXqqRGEM6qeqVyH3pXMNdzwrm2b6DemRFy9vJIsiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614093702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/AFvTPncWowuUW0ABTizhzarZQWNjA+MxWzWwUdQGuk=;
        b=sNQWuMjo4KhBXl2K6RjNVdgh/je5FcV62OfmN10ffcNBLtSXkClqAMRkONXO2GStgu5HH0
        4h1TqCX2I4eLTSBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] objtool/core for 5.12
In-Reply-To: <161409254266.2358.17202318838981714361.tglx@nanos>
References: <161409254266.2358.17202318838981714361.tglx@nanos>
Date:   Tue, 23 Feb 2021 16:21:42 +0100
Message-ID: <87pn0q6c8p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23 2021 at 15:02, Thomas Gleixner wrote:
> Linus,
>
> please pull the latest objtool/core branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-02-23
>
> up to:  aafeb14e9da2: objtool: Support stack-swizzle
>
> objtool updates:
>
>  - Make objtool work for big-endian cross compiles
>
>  - Make stack tracking via stack pointer memory operations match push/pop
>    semantics to prepare for architectures w/o PUSH/POP instructions.
>
>  - Add support for analyzing alternatives
>
>  - Improve retpoline detection and handling
>
>  - Improve assembly code coverage on x86
>
>  - Provide support for inlined stack switching

There is a trivial merge conflict in the XEN assembly code. xen_sysret64
got removed upstream and objtool modifies it. Removal is the way to go.

Thanks,

        tglx
