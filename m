Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D373E1C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241966AbhHETE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242738AbhHETEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B181E61040;
        Thu,  5 Aug 2021 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628190273;
        bh=MCjQlxL9X2EkS0NeQyUENlq89cm31kXmcOUCJ7S5w88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSHeL83kJiujAp3E2VNZ5OVoar3YqffDDKloJt/BA1uRmgNRI9incZpNZDIAAcN1K
         MeBj8BpWE351bla1Jc49Sih1o+Y9zRULjZSmUuG7swPSsI+FXdyAcJfQPVL03QnsKQ
         9hsoJwIfDMs0A5iEs8wffChG4iWsnBDbeO882OWpgU3syrWd7ucqhWfSuA8MLKMoDW
         fpMdMX8L7ra72Z622VVYxOPRaIYjW7QsR/m5Q4ZioFp/MMdJl0JoZbwxUt5dsM1kLd
         fZPK9kGtmKHV0/x0EeQT8RZ2IjOdWs+yPaCuNjKSfptZh3XRYC94qvKPBnGSTDYTXm
         NUijFVea6Pumw==
Date:   Thu, 5 Aug 2021 12:04:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars-linux:for-next/clang-fallthrough 1/1] warning:
 fallthrough annotation in unreachable code/
Message-ID: <YQw2P8esj8PMNRQn@Ryzen-9-3900X.localdomain>
References: <202108051403.tBfqfI49-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108051403.tBfqfI49-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 02:21:34PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/clang-fallthrough
> head:   58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00
> commit: 58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00 [1/1] Revert "Revert "Makefile: Enable -Wimplicit-fallthrough for Clang""
> config: hexagon-randconfig-r023-20210804 (attached as .config)
> compiler: clang version 12.0.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00
>         git remote add gustavoars-linux https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
>         git fetch --no-tags gustavoars-linux for-next/clang-fallthrough
>         git checkout 58d0d2d2e7dc1b1a4997bb9c47d6cf428f2d3a00
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
> >> warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>    2 warnings generated.

With a newer version of clang that shows proper line numbers:

sound/core/pcm_native.c:3812:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
                fallthrough;
                ^
include/linux/compiler_attributes.h:211:41: note: expanded from macro 'fallthrough'
# define fallthrough                    __attribute__((__fallthrough__))
                                        ^
sound/core/pcm_native.c:3820:3: warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
                fallthrough;
                ^
include/linux/compiler_attributes.h:211:41: note: expanded from macro 'fallthrough'
# define fallthrough                    __attribute__((__fallthrough__))
                                        ^
2 warnings generated.

Which is already being tracked: https://github.com/ClangBuiltLinux/linux/issues/1429

Cheers,
Nathan
