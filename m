Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7233C40B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhCORXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhCORXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:23:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D88C06174A;
        Mon, 15 Mar 2021 10:23:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0786001d9615583ace417a.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8600:1d96:1558:3ace:417a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78B0B1EC01E0;
        Mon, 15 Mar 2021 18:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615829014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zHC3blqSNPKWJ830IEWlMeLd4dUxTY7L0fyE2191Pxk=;
        b=PE+5nFQHuWhAEeZDZ9lgcQPQnLK9WDotyFUN6wwIp3nffXCY9VxzJw7Q53LCcyHn9iNfez
        QiNbUE1CuGYF0lS+JcXSQNPH/Z9Dvq8I8AYuWrHGQh5UTNART/Nu1rjBU2C3vWu914PGlo
        8NHdRMoGVAQHcb/Cm6KjnYvJGMxJaGQ=
Date:   Mon, 15 Mar 2021 18:23:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210315172337.GH20497@zn.tnic>
References: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic>
 <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic>
 <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic>
 <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
 <20210315171516.GG20497@zn.tnic>
 <CA+icZUVOf4T65H2t_q-h_eAN24WOEN-cc8eNubT3GojJrGJ0vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUVOf4T65H2t_q-h_eAN24WOEN-cc8eNubT3GojJrGJ0vA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 06:19:34PM +0100, Sedat Dilek wrote:
> With my next build I try to apply this.

Your perf tool command should look something like this:

perf stat --repeat 5 --sync --pre=/root/bin/pre-build-kernel.sh -- make -s -j9 LLVM=1 LLVM_IAS=1 bzImage

Also, needless to say, your box needs to not run anything else during
the measurement.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
