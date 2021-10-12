Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF03942AF64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhJLV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhJLV54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:57:56 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888AAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=uxQ7nLZzmivndg0FxAUA4ShGoEhQFmaES824qLb/QeE=; b=RVMdfmkmHA8NbIUGAicwBbyEmv
        5INLwcl8WAhoTpcGuiGnmPGnWjdkTXUogDGRUKIFoABl+1EfDQN1c3lZFvZ77QYuWl8P4/WPy075b
        hdYwFvkkAQfLmZmwF1rrfr2KleEqfGO+h2w5OGdb6eXo8bARIuP57VV9bAyYUAsgDMJON1qI/VNHj
        CadbiyCAb5mqeToKDdGFU+eMVluEoHzG3C7yPLDCIwVgDxJhaoYmNdP5JCj136rHv0DR8xzhSfkw6
        lUyIfCkOrRFM+Gzo4/GzM3ciQWfhv9cQ9OgnnUixV32r1nofPbfFcM8kyVDitYgKnFTKGTs0mEZvL
        rgnAxduw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maPkX-00E4Br-AX; Tue, 12 Oct 2021 21:55:53 +0000
Subject: Re: undefined reference to `memcg_bulk_charge_hook'
To:     kernel test robot <lkp@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <202110130513.t6y4KgaP-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a5a496b-5b5e-0039-5bb2-d04268215e37@infradead.org>
Date:   Tue, 12 Oct 2021 14:55:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202110130513.t6y4KgaP-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/21 2:34 PM, kernel test robot wrote:
> tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211012-182031/Vasily-Averin/memcg-enable-memory-accounting-in-__alloc_pages_bulk/20211008-172703
> head:   e10c5e64a0799c75d26d2a82c03f757335616711
> commit: e10c5e64a0799c75d26d2a82c03f757335616711 memcg: enable memory accounting in __alloc_pages_bulk
> date:   11 hours ago
> config: powerpc64-randconfig-r001-20211012 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/e10c5e64a0799c75d26d2a82c03f757335616711
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review UPDATE-20211012-182031/Vasily-Averin/memcg-enable-memory-accounting-in-__alloc_pages_bulk/20211008-172703
>          git checkout e10c5e64a0799c75d26d2a82c03f757335616711
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

Hi ktr/lkp,

Can you explain why the (previously) attached .config file says:
CONFIG_32BIT=y

but in the email text above, it says:
config: powerpc64-randconfig-r001-20211012

I would expect a powerpc64 randconfig to say
CONFIG_64BIT=y

Am I just confused?

Also, using (Arnd's) crosstools, the compiler for powerpc64 shows up
as powerpc64-linux-ld, not as powerpc-linux-ld.
Is that different for the 0day toolchains?
(not AFAICT)


> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     powerpc-linux-ld: mm/page_alloc.o: in function `__alloc_pages_bulk':
>>> (.text+0x857c): undefined reference to `memcg_bulk_charge_hook'
>>> powerpc-linux-ld: (.text+0x86d0): undefined reference to `memcg_bulk_post_charge_hook'
>     powerpc-linux-ld: (.text+0x870c): undefined reference to `memcg_bulk_post_charge_hook'
>>> powerpc-linux-ld: (.text+0x87c8): undefined reference to `memcg_bulk_pre_charge_hook'
> 
> ---

thanks.
-- 
~Randy
