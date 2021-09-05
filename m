Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498A401125
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhIESOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 14:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbhIESOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 14:14:08 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9064C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=/9khH02TVTG09S95hSgvcD2HLVg006dQ6YBsJSlln8A=; b=GA/r+IlgGbavOGI9aRDxQU9BqC
        Y1mKZbdbhG09rl2pJqpCy396Djet1jBB9RtQ3c+uuoHz8KSqOGQ2QXtFNKnoJANpveKeSO2+vSI9E
        o6plInaA2/fytqrO9D57Gcdv5e0TxiOvCWK6kjSIwm6OelSf1l40Z5f0CPiUgS6iyplumhKhbJxtI
        gH0/LMANOSgHrW5LjlMXz2oAJx9HDrL3/wKjOtdYMdKuPM5oI86izBXQalxiphYqJu1PcruG7yt1R
        tUdMbi++xTyC+Sr+2Exqw4KxTJDkuteFxP1Vh6jXJ4sCaVtlcJ9rpZScdDJ7mtINIxcKtaY+neNeP
        gtNT8ySQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMwda-00GDX2-J2; Sun, 05 Sep 2021 18:13:02 +0000
Subject: Re: ERROR: start_text address is c000000000000200, should be
 c000000000000100
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202109051525.iZrjm1vj-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5de53d5c-f2c9-9aad-5981-76a6357b3e02@infradead.org>
Date:   Sun, 5 Sep 2021 11:13:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202109051525.iZrjm1vj-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/21 12:17 AM, kernel test robot wrote:
> Hi Randy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   49624efa65ac9889f4e7c7b2452b2e6ce42ba37d
> commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
> date:   3 weeks ago
> config: powerpc64-randconfig-s031-20210904 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-rc1-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47c258d71ebfc832a760a1dc6540cf3c33968023
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 47c258d71ebfc832a760a1dc6540cf3c33968023
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: start_text address is c000000000000200, should be c000000000000100
>>> ERROR: try to enable LD_HEAD_STUB_CATCH config option
>>> ERROR: see comments in arch/powerpc/tools/head_check.sh


Following those instructions fixes this build error for me.
Can ktr/lkp do that?
Otherwise just ignore this ERROR.

Set CONFIG_EXPERT=y
and CONFIG_LD_HEAD_STUB_CATCH=y.

However, after doing that, I get these messages:

INFO: Uncompressed kernel (size 0x30ef664) overlaps the address of the wrapper(0x400000)
INFO: Fixing the link_address of wrapper to (0x3100000)

-- 
~Randy

