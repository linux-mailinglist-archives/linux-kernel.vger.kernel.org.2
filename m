Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDC3824BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhEQGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEQGu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:50:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bTvNkZ4FaueyiFDTNmggsWinN6rRWrOb4IoJCla3pDg=; b=LsXYJzD/anm0GHZHFNLrGpvTNd
        cf1CGjGR3zd1kP/K+nyllr9p3tMPVOYcKmemiLyef98oIkjNzd4kJws+gE59dT0F9P+tRAQILTrMs
        j1NOVJKjCHGWoUbeTdCynDF+39CiTI6M+4aKi5Xmt7UnvrN7btN4WjZG6j84PPrWYClanqVwfB3ez
        Qo+9ENJc7rXrJF+p0qrWUI/rrAIf6mtytorQEicOXt5P+FQnbYak7WggcAisdPgYwJz7oBBypuoGs
        y2A/xDlnQ1h0syuB2pIWbJaO+GqV9wHg87JkAJ2/Nga2HpYgWvrthoXsUoLOjWnXI+7FbqE0dDpiS
        jBlSLJzw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liX3s-00DWdm-Sm; Mon, 17 May 2021 06:49:08 +0000
Subject: Re: ioctl.c:undefined reference to `__get_user_bad'
To:     kernel test robot <lkp@intel.com>,
        Steve French <stfrench@microsoft.com>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shyam Prasad N <sprasad@microsoft.com>
References: <202105110829.MHq04tJz-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a022694d-426a-0415-83de-4cc5cd9d1d38@infradead.org>
Date:   Sun, 16 May 2021 23:49:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202105110829.MHq04tJz-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 5:53 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   142b507f911c5a502dbb8f603216cb0ea8a79a48
> commit: 7ba3d1cdb7988ccfbc6e4995dee04510c85fefbc smb3.1.1: allow dumping keys for multiuser mounts
> date:   7 days ago
> config: arm-randconfig-s031-20210510 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7ba3d1cdb7988ccfbc6e4995dee04510c85fefbc
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7ba3d1cdb7988ccfbc6e4995dee04510c85fefbc
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: fs/cifs/ioctl.o: in function `cifs_dump_full_key':
>>> ioctl.c:(.text+0x44): undefined reference to `__get_user_bad'
> 
> ---

# CONFIG_MMU is not set

and arch/arm/include/asm/uaccess.h does not implement get_user(size 8 bytes)
for the non-MMU case:

#define __get_user_err(x, ptr, err)					\
do {									\
	unsigned long __gu_addr = (unsigned long)(ptr);			\
	unsigned long __gu_val;						\
	unsigned int __ua_flags;					\
	__chk_user_ptr(ptr);						\
	might_fault();							\
	__ua_flags = uaccess_save_and_enable();				\
	switch (sizeof(*(ptr))) {					\
	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err);	break;	\
	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err);	break;	\
	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err);	break;	\
	default: (__gu_val) = __get_user_bad();				\
	}								\
	uaccess_restore(__ua_flags);					\
	(x) = (__typeof__(*(ptr)))__gu_val;				\
} while (0)


-- 
~Randy

