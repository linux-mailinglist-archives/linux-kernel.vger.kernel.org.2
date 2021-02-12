Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D7319863
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 03:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhBLCx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 21:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBLCxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 21:53:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D9FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 18:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mxVrexMn+Usujjpp3mumO4bl8uz++eXZX7zFnkCAvVk=; b=0QvSa34SKaNOjl+eRicAa2RiG1
        3LS9gGoOUyWPufYDf0FCb5B3OgZ3hzc2scPqQuFfOa7ZuKf9uip57I5ighlvz001FOsSvOcGwAGmD
        iiLK5++YMGDMVorqqw0ua380zH5SY4O/58+vYJhJk+RocCMio5aoMpHC9K957uslPx47mOOI6XOh3
        aERkthujK++5OF12TTumyIujkCh3+LdptO45gTNeqinfRGev+ntHrw/lxOcWuJ1UFDgnOV8MYJSID
        xuZkPCjzqir/47m46pHw74QIyNnyqVi/hp7eqZvxW+6JJPdCrUL6qroksfX9Wio4Syfn3zzjTqD3z
        WDxNNaGQ==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAOZT-0003ws-RG; Fri, 12 Feb 2021 02:52:40 +0000
Subject: Re: arch/alpha/lib/csum_partial_copy.c:328:1: error: no previous
 prototype for 'csum_and_copy_from_user'
To:     kernel test robot <lkp@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202102120715.fQ8OSFnI-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8b064ade-ccc2-909f-5ef9-ca8287212049@infradead.org>
Date:   Thu, 11 Feb 2021 18:52:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102120715.fQ8OSFnI-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 3:26 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   291009f656e8eaebbdfd3a8d99f6b190a9ce9deb
> commit: 808b49da54e640cba5c5c92dee658018a529226b alpha: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
> date:   9 months ago
> config: alpha-defconfig (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=808b49da54e640cba5c5c92dee658018a529226b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 808b49da54e640cba5c5c92dee658018a529226b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/alpha/lib/csum_partial_copy.c:328:1: error: no previous prototype for 'csum_and_copy_from_user' [-Werror=missing-prototypes]
>      328 | csum_and_copy_from_user(const void __user *src, void *dst, int len,
>          | ^~~~~~~~~~~~~~~~~~~~~~~
>    arch/alpha/lib/csum_partial_copy.c:375:1: error: no previous prototype for 'csum_partial_copy_nocheck' [-Werror=missing-prototypes]
>      375 | csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

I can't reproduce this (wrong version of gcc) but it looks like adding
#include <asm/checksum.h>
to arch/alpha/lib/csum_partial_copy.c should fix the warnings.

-- 
~Randy

