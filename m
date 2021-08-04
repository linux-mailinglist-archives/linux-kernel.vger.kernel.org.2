Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E8A3DF9EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhHDDLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbhHDDL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:11:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3AC061575
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=b7ea5nZ+ckbjTfjPzMM7oA1gBGqNWHn29Te70wk2vTk=; b=CIpWxlF2JRoECOxo8dm2l2bNxJ
        PN5XKNWTxw29IfkeRxl4tV8tbzI8SGoF7vr0JqPeEyXtw1z8zDeiybZb/wbwcIOsr+gfpKD4DcyTs
        WysDWtE6Ay/gaKRBYnfXTktSVft8GGPgDAyRzUegpSVDdTvzDtoA7t+/9vigLAFk6p4E5BpUI60dL
        f5sPF2o+Rl8/3h9KsmkVAsPcRwrw4L7NPFn1Zmdi6jj+COQb+c0YxxMz5fN/NkNSyDFhirKST2kGO
        x0E5j8B7DXKjSa/ggSMBkFLqQI8hwYvgNaaP4xJbotk5+vjDE5W7CdZ6pszzU98jBN294Q8aIrnvZ
        X7Fg8DbQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB7ID-005LsP-15; Wed, 04 Aug 2021 03:10:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: make[2]: *** [arch/powerpc/Makefile.postlink:31: vmlinux] Error 1
To:     kernel test robot <lkp@intel.com>, Feng Tang <feng.tang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202107301612.rQ29n76B-lkp@intel.com>
Message-ID: <c3e9247d-95cd-718c-d8a5-f0cd5e5a3598@infradead.org>
Date:   Tue, 3 Aug 2021 20:10:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202107301612.rQ29n76B-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 1:29 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
> commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B aligned debug option to 64B aligned
> date:   10 weeks ago
> config: powerpc64-randconfig-c023-20210730 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf536e185869d4815d506e777bcca6edd9966a6e
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout cf536e185869d4815d506e777bcca6edd9966a6e
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=powerpc64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> make[2]: *** [arch/powerpc/Makefile.postlink:31: vmlinux] Error 1
> 
> ---

Hi ktr/lkp,

This is not "All errors". I suggest that you improve your output by
(also) grepping for "ERROR:", so that the following lines would be
included here:

ERROR: start_text address is c000000000000200, should be c000000000000100
ERROR: try to enable LD_HEAD_STUB_CATCH config option
ERROR: see comments in arch/powerpc/tools/head_check.sh


and yes, enabling LD_HEAD_STUB_CATCH does fix this build error.

thanks.
-- 
~Randy

