Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4130B2D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBAWji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBAWjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:39:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C8C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 14:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=X/xiaVfYJ8u/JiSK0Gpt+YqRJoOFLgHoj/ler9WbpGs=; b=EZxqYyBbu5vU8CEJuhPD7gdJIB
        judphNZNpSyy1dK+czKk5udPaJh5vc9loUi6eeEdzC+bCTlm/9dZ+CkAA7AkmuJTtFPqkpYNIKS3v
        BLPXliyex11HZr6w0uuvVR1wpcMuJa7J5AljGzO2NED5olCRUm70xVWumLs9oWPJ+KIl1k7+8oAoa
        cvOTZV9V8iuuB4b3+yzTneaef1IOA6lxVSj/Km42K20ff7ubWSZS1pBirjDSk7xiNvLGt4rmLmSEZ
        sdENIV+eHABtPb/euEWmKkCDWrkOou76Aae4h7W9tw0CIoqaE576EoUkJrJ7JyhHnUE9JMUqQrLAz
        LAkdDNxg==;
Received: from [2601:1c0:6280:3f0::1d53]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6hqP-00EPbV-Dl; Mon, 01 Feb 2021 22:38:53 +0000
Subject: Re: s390-linux-ld: ll_temac_main.c:undefined reference to
 `devm_platform_ioremap_resource_byname'
To:     kernel test robot <lkp@intel.com>, Wang Hai <wanghai38@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202102010812.qthaghhK-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ac0c1ba8-d7c7-1868-db25-ccf063effec8@infradead.org>
Date:   Mon, 1 Feb 2021 14:38:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102010812.qthaghhK-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/21 4:06 PM, kernel test robot wrote:
> Hi Wang,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1048ba83fb1c00cd24172e23e8263972f6b5d9ac
> commit: bd69058f50d5ffa659423bcfa6fe6280ce9c760a net: ll_temac: Use devm_platform_ioremap_resource_byname()
> date:   6 months ago
> config: s390-randconfig-r034-20210201 (attached as .config)

Hi robot,

Instead of hit & miss with s390 randconfigs, you could do what I did:
(all for arch/s390/):

$ make allmodconfig
$ scripts/config -d PCI  ## this also disables HAS_IOMEM
$ make oldconfig
$ make all

The latter gives a full list of drivers etc. that use iomemp/ioremap 
etc. as well as dev_io* variants instead of just a few random ones.


> All errors (new ones prefixed by >>):
> 
>     s390-linux-ld: drivers/net/ethernet/xilinx/ll_temac_main.o: in function `temac_probe':
>     ll_temac_main.c:(.text+0x39b6): undefined reference to `devm_platform_ioremap_resource_byname'
>>> s390-linux-ld: ll_temac_main.c:(.text+0x3a4c): undefined reference to `devm_platform_ioremap_resource_byname'
>     s390-linux-ld: ll_temac_main.c:(.text+0x3bce): undefined reference to `devm_ioremap'
>     s390-linux-ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
>     xilinx_axienet_main.c:(.text+0x844): undefined reference to `devm_ioremap_resource'

