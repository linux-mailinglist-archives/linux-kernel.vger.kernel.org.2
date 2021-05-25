Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B795038F7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhEYB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhEYB5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:57:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267B8C061574;
        Mon, 24 May 2021 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=JIPErQUyisH0HpDDiUm0SZk1nmoFpmh5vdb6lgAqhWE=; b=asNHHyg9DLfTbvsXWy7tB1ux3v
        muiW/yT1sugvu23RBd/SUM7ciu+WzfsBFeLxrC1Bqb4AIbzm1wQF37zXHoOJ80XziZqYdwkrZh1FM
        X0E+7P0cVBWLHQjstXfvQSQbxOjGDWBg1MMNbV/rLSw3RyrBWAWTdn/HQPCdnn9PRW0Yp/YX1F6RJ
        99dtyjFJJg3tNuLEqSh8ybkKhv0BGl4FZP66XFvEy+mU/fOF96FofzAD7+K+8NyQcJYdwVrufZ5R9
        0o1GpmDWdFu47uS/YP9dzkiQteptrzaIRQoq5XnkYZ+1cADxVlTjCVU2Ak0YdS+nmDD0X1uTimvCp
        xOV5Z0DA==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llMIj-002pHi-KS; Tue, 25 May 2021 01:56:09 +0000
Subject: Re: [PATCH v2] OF: of_address: clean up OF stub & extern functions
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210524190919.2616-1-rdunlap@infradead.org>
 <202105250652.aSwyXJ3a-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e16ec6e1-9699-9146-8516-7b792d0b959d@infradead.org>
Date:   Mon, 24 May 2021 18:56:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202105250652.aSwyXJ3a-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 4:02 PM, kernel test robot wrote:
> Hi Randy,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linux/master linus/master v5.13-rc3 next-20210524]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Randy-Dunlap/OF-of_address-clean-up-OF-stub-extern-functions/20210525-031115
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: s390-randconfig-r001-20210524 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/8a9c54f1437e3af04c6de3b9606b46437ea69a12
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Randy-Dunlap/OF-of_address-clean-up-OF-stub-extern-functions/20210525-031115
>         git checkout 8a9c54f1437e3af04c6de3b9606b46437ea69a12
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Yes, this patch wasn't expected to fix all of these arch/s390/ build errors.

Before this patch: (9 undefined symbols)

ERROR: modpost: "devm_ioremap_resource" [drivers/crypto/ccree/ccree.ko] undefined!
ERROR: modpost: "debugfs_create_regset32" [drivers/crypto/ccree/ccree.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/media/rc/ir-hix5hd2.ko] undefined!
ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!
ERROR: modpost: "iounmap" [drivers/pcmcia/pcmcia.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma_mgmt.ko] undefined!
ERROR: modpost: "of_address_to_resource" [drivers/dma/qcom/hdma_mgmt.ko] undefined!

This patch only affected the last symbol above. And it covers of_iomap()
in my build testing as well.

After this patch: (8 undefined symbols)

> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: "devm_ioremap_resource" [drivers/crypto/ccree/ccree.ko] undefined!
> ERROR: modpost: "debugfs_create_regset32" [drivers/crypto/ccree/ccree.ko] undefined!
> ERROR: modpost: "devm_ioremap_resource" [drivers/media/rc/ir-hix5hd2.ko] undefined!
> ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!
> ERROR: modpost: "iounmap" [drivers/pcmcia/pcmcia.ko] undefined!
>>> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
> ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma.ko] undefined!
> ERROR: modpost: "devm_ioremap_resource" [drivers/dma/qcom/hdma_mgmt.ko] undefined!


I think that all of these arch/s390/ builds undefined symbols when CONFIG_HAS_IOMEM
is not set are low priority (or no priority) for most people.

-- 
~Randy

