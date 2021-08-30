Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9A3FAFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 04:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhH3CbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 22:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhH3CbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 22:31:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A926AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=plhQoVMNscwSIcKlufCcpX0gftipAv5Nezqut8/rzHY=; b=S4Ywq9d55WN3JialcBo3tRnKCP
        JBdUO56SBeveEmA6hGP16zYheZG7+bWubAa0ePtXgLVkPYQD/NVylt1Vrg/FypfyEleC86nKIfA9n
        J/sDS4ZMl6Q+9pRbbcMbhVdUr1PQhi2a161v5qDdteRkZq2+fzc17F6Fz5hQx6B7p668XpKj5LhsW
        CgZZ8LExKQtyfSJ6TYFyzWAHj+LjEnXZ+AsUIajKnGzZlTOs5/lnf0EFCld/KFaLe4lQX5fF4ARPf
        5SW/7vnADIP/p3Spr1MO77R3tozekv+baIvS0mHBQ7XkVLpYWyUXRUtO889ta2w/Oit+UYF1Z9C+1
        7VcZ4TXg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKX43-00GJ6T-1g; Mon, 30 Aug 2021 02:30:23 +0000
Subject: Re: decompress.c:undefined reference to `__decompress'
To:     kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202105211642.tUeKonkw-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <daa93504-5d42-a5f1-ae7a-3b802fd661f7@infradead.org>
Date:   Sun, 29 Aug 2021 19:30:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202105211642.tUeKonkw-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 1:20 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   79a106fc6585979022012e65a1e45e3d2d28b77b
> commit: 665d8d58761cba41147fe7e98e2ceed1cbf603a2 powerpc/akebono: Fix unmet dependency errors
> date:   3 months ago
> config: powerpc64-randconfig-r023-20210521 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=665d8d58761cba41147fe7e98e2ceed1cbf603a2
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 665d8d58761cba41147fe7e98e2ceed1cbf603a2
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     powerpc-linux-ld: arch/powerpc/boot/wrapper.a(decompress.o): in function `partial_decompress':
>>> decompress.c:(.text+0x1f0): undefined reference to `__decompress'
> 
> ---

Hi Christophe,

Didn't you have a patch that adds boot support in Powerpc for
LZMA and LZO?  What happened to that patch?


thanks.
-- 
~Randy

