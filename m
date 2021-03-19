Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E18341B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCSLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:38:00 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38209 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhCSLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:37:59 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lNDRx-0031tS-41; Fri, 19 Mar 2021 12:37:53 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lNDRw-000ehS-Tw; Fri, 19 Mar 2021 12:37:53 +0100
Subject: Re: sparc: clang: error: unknown argument: '-mno-fpu'
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
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
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <ebf12838-4525-a525-93bd-2229927e50ca@physik.fu-berlin.de>
Date:   Fri, 19 Mar 2021 12:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Za8N2-Hs02nG0CcGJ+RcTrR0UqDOesd8E6PmhYRR2_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 12:31 PM, Arnd Bergmann wrote:
> On Fri, Mar 19, 2021 at 8:36 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
>>
>> Linux mainline master build breaks for sparc defconfig.
>> There are multiple errors / warnings with clang-12 and clang-11 and 10.
>>  - sparc (defconfig) with clang-12, clang-11 and clang-10
>>  - sparc (tinyconfig) with clang-12, clang-11 and clang-10
>>  - sparc (allnoconfig) with clang-12, clang-11 and clang-10
>>
>> make --silent --keep-going --jobs=8
>> O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sparc
>> CROSS_COMPILE=sparc64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
>> clang'
> 
> I don't think anyone has successfully built a sparc kernel with clang,
> and I don't
> think it's worth trying either, given how little upstream work the
> sparc port sees
> overall.

We'll get there. There are some other SPARC-related clang bugs that need
to be squashed first. We have made quite some improvements and it's actually
maintained by the community. Of course, we don't have a commercial backer
but that shouldn't be necessary for open source to work.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

