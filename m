Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE6395154
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhE3OjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhE3OjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 10:39:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=sE++xAt9mQbKzLlM4uqfYQKbCz2pbWA6dqC/0cXV17k=; b=tZKXqLWq4pIj8bhWgWAGKuTEc4
        9P1Cgn5w28PBHNbQV6lu5JS0AUhWdZK7DeG8aqegJXgUkP0No2nzv58ag7AjbJHKS9a5YUl8pCd6y
        8NddidznZ9Jb3+9YsjTzK8NzQNxkgKK+kO16JrEjjKtPl+cZ5OKe2lZMTF1DqWup7/0lL4/YfSyVf
        xdRV3G++/hZ1a7veaQ25ueJSYKQHXoninpQDbrV3BEsp74MQFptUpAExNykyvLSDOSzgl5SSFPhUk
        ebTlxkOV0pDcOjUCzeO7x37YkcI6zYD7iLmwX3eWG9KmVb604TKB0KGyND+yg+rnDF39WBFTDbEYe
        zXGNYYIg==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnMZJ-009l38-IO; Sun, 30 May 2021 14:37:33 +0000
Subject: Re: arch/ia64/include/uapi/asm/siginfo.h:15:27: error: expected ':',
 ',', ';', '}' or '__attribute__' before '.' token
To:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
References: <202105301826.MwSrFnm9-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ddd58e03-2f30-101a-d4b1-3304cc9212e6@infradead.org>
Date:   Sun, 30 May 2021 07:37:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202105301826.MwSrFnm9-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/21 3:07 AM, kernel test robot wrote:
> Hi Christoph,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b90e90f40b4ff23c753126008bf4713a42353af6
> commit: 8cad3b66bff4ee7c7d52b9a663cb6a2c5f66a7f7 Buslogic: remove ISA support
> date:   8 weeks ago
> config: ia64-allyesconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8cad3b66bff4ee7c7d52b9a663cb6a2c5f66a7f7
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8cad3b66bff4ee7c7d52b9a663cb6a2c5f66a7f7
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/uapi/linux/signal.h:6,
>                     from include/linux/signal_types.h:10,
>                     from include/linux/sched.h:30,
>                     from arch/ia64/include/asm/hw_irq.h:11,
>                     from include/linux/irq.h:589,
>                     from arch/ia64/include/asm/hardirq.h:19,
>                     from include/linux/hardirq.h:10,
>                     from include/linux/interrupt.h:11,
>                     from drivers/scsi/BusLogic.c:27:
>>> arch/ia64/include/uapi/asm/siginfo.h:15:27: error: expected ':', ',', ';', '}' or '__attribute__' before '.' token
>       15 | #define si_flags _sifields._sigfault._flags
>          |                           ^
>    drivers/scsi/FlashPoint.c:43:6: note: in expansion of macro 'si_flags'
>       43 |  u16 si_flags;
>          |      ^~~~~~~~

> vim +15 arch/ia64/include/uapi/asm/siginfo.h
> 
> 43e40f25d2c0903 David Howells 2012-10-09  13  
> 43e40f25d2c0903 David Howells 2012-10-09  14  #define si_imm		_sifields._sigfault._imm	/* as per UNIX SysV ABI spec */
> 43e40f25d2c0903 David Howells 2012-10-09 @15  #define si_flags	_sifields._sigfault._flags
> 43e40f25d2c0903 David Howells 2012-10-09  16  /*
> 43e40f25d2c0903 David Howells 2012-10-09  17   * si_isr is valid for SIGILL, SIGFPE, SIGSEGV, SIGBUS, and SIGTRAP provided that
> 43e40f25d2c0903 David Howells 2012-10-09  18   * si_code is non-zero and __ISR_VALID is set in si_flags.
> 43e40f25d2c0903 David Howells 2012-10-09  19   */
> 43e40f25d2c0903 David Howells 2012-10-09  20  #define si_isr		_sifields._sigfault._isr
> 43e40f25d2c0903 David Howells 2012-10-09  21  
> 
> :::::: The code at line 15 was first introduced by commit
> :::::: 43e40f25d2c090392fc36cb900b42972e88cc2e2 UAPI: (Scripted) Disintegrate arch/ia64/include/asm
> 
> :::::: TO: David Howells <dhowells@redhat.com>
> :::::: CC: David Howells <dhowells@redhat.com>


Patch is here:
  https://lore.kernel.org/linux-scsi/b631c661-44fa-57f5-6540-1721f3df61e8@suse.de/T/#ma8097b011095a7b4cc73381f45312eb634166187


-- 
~Randy
https://people.kernel.org/tglx/notes-about-netiquette
