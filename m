Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D55341C10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:16:25 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:59009 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhCSMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:16:03 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lNE2q-003JAk-Au; Fri, 19 Mar 2021 13:16:00 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lNE2p-000jNP-U2; Fri, 19 Mar 2021 13:16:00 +0100
Subject: Re: sparc: clang: error: unknown argument: '-mno-fpu'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
References: <CA+G9fYseDSQ2Vgg5Cb=8HHdpm56aeVQH0Vdx7JK1SktGpRRkgw@mail.gmail.com>
 <CAK8P3a3Za8N2-Hs02nG0CcGJ+RcTrR0UqDOesd8E6PmhYRR2_A@mail.gmail.com>
 <ebf12838-4525-a525-93bd-2229927e50ca@physik.fu-berlin.de>
 <CAK8P3a2WCYxG4-4x49Uc-+pXPciY5EsDqmNcEfufcXZp6Q3+MQ@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <88ab1610-3096-b4a0-e1af-9443cb8b9953@physik.fu-berlin.de>
Date:   Fri, 19 Mar 2021 13:15:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2WCYxG4-4x49Uc-+pXPciY5EsDqmNcEfufcXZp6Q3+MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 12:56 PM, Arnd Bergmann wrote:
>> We'll get there. There are some other SPARC-related clang bugs that need
>> to be squashed first. We have made quite some improvements and it's actually
>> maintained by the community. Of course, we don't have a commercial backer
>> but that shouldn't be necessary for open source to work.
> 
> I meant there is no point for Naresh to do it as part of his build
> testing with tuxmake.
> If someone else gets it working, they can tell Naresh to try again, but until
> then, I'd limit clang regression testing to x86, arm, powerpc, s390, mips, riscv
> and arc.

It's definitely a useful report as I haven't done any tests in this regard yet
and we're certainly interested in getting this to work. We previously had Nick
give a session on building the kernel with clang in our monthly m68k meeting [1]
and he said, they are interested in supporting as many architectures as possible
in their efforts.

Adrian

> [1] http://m68k.info/#llvm:linux:video

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

