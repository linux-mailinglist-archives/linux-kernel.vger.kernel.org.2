Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8B33C3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCORPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:15:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37624 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhCORP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:15:26 -0400
Received: from zn.tnic (p200300ec2f0786001d9615583ace417a.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8600:1d96:1558:3ace:417a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C24401EC009F;
        Mon, 15 Mar 2021 18:15:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615828524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r5BUsq1SAuUJ7ZD0GYrjtLkJBkXKoZyJkdDAfizs+Ms=;
        b=VNffTpmtxNFojpDVmtHvkx8BS8d42JKHiQ2TS1CGqu/nynpuhR2IKXpThOM48pnqCiQ3+1
        Ej5omPJR1OGPiTSJDDzsJ8KYHtIf77BnyAz+kA2ntpW9Hsaoe6yFkCpWYKmi0+P8HOjwHn
        ZK+DdPQKFH5fRCsuqJcdgDL7GVCIvos=
Date:   Mon, 15 Mar 2021 18:15:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210315171516.GG20497@zn.tnic>
References: <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic>
 <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic>
 <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic>
 <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic>
 <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 06:04:41PM +0100, Sedat Dilek wrote:
> Here some fresh numbers:

Lemme paste my previous reply which still holds true here:

"There's a reason I have -s for silent in the build - printing output
during the build creates a *lot* of variance. And you have excessive
printing with V=1 and KBUILD_VERBOSE=1.

Also, you need to repeat those workloads a couple of times - one is not
enough. That's why I have --repeat 5 in there.

Also, you need --pre=/root/bin/pre-build-kernel.sh where that script is:

---
#!/bin/bash
echo $0

make -s clean
echo 3 > /proc/sys/vm/drop_caches
---

so that you can avoid pagecache influence."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
