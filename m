Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B03E1CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbhHETcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhHETcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:32:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE7C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=GbnUV28bxkOp7gCXE/AS1YBxe5QFYfSNYycGqaP8y10=; b=OH0IAeHpUImkTwBEYEVKJ/88ip
        pi2GLuVtwMBuBVg4pLCGAijvR1GC6Xa0X4zc5h9uwcYNJzsA0YGZ2FLOCxxFwsHmspsYuYFS4RX+4
        qqeiHWTLUx/SWGArKspUWhXYS5IbLuBnvVv45iVz03el/CXwGb69HVCbebf8N68Aj/46CI7g0Dg0S
        9EYwvXHaZ1LwXipPw+1Nd84MG1VlrVMIahWOqekza7QcB0YKdS+yFmkoJHW4S+8c2OHPYM3X+N808
        VbEM+3k/orhmjIprEOydp/XXApn/zJIKqJaDIaVvh8P56iYP+c/zbeE8FD+K1y2U2dGi4SM3in4QO
        98r2HgIA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBj5i-0069hG-Ib; Thu, 05 Aug 2021 19:31:42 +0000
Subject: Re: [PATCH] openrisc: Fix compiler warnings in setup
To:     Stafford Horne <shorne@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210805030035.2994973-1-shorne@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <655ef6e0-defb-7467-25df-f9a13ab96694@infradead.org>
Date:   Thu, 5 Aug 2021 12:31:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805030035.2994973-1-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 8:00 PM, Stafford Horne wrote:
> This was pointed out with the recent name change of or32_early_setup to
> or1k_early_setup.  Investigating the file I found a few other warnings
> so cleaning them up here.
> 
>      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
>        220 | void __init or1k_early_setup(void *fdt)
> 	  |             ^~~~~~~~~~~~~~~~
> 
> Fix this the missing or1k_early_setup prototype warning by adding an
> asm/setup.h file to define the prototype.
> 
>      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
>        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> 	  |             ^~~~~~~~~~~~~~~~~~
> 
> The function detect_unit_config is not used, just remove it.
> 
>      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> 
> Add @fdt docs to the function comment to suppress this warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Hi Stafford,

Does this patch apply to your openrisc tree, but not to
linux-next?  I get a patch error when trying to apply it
to linux-next-20210805 and this warning is still present:

../arch/openrisc/kernel/setup.c:221:13: warning: no previous prototype for 'or32_early_setup' [-Wmissing-prototypes]
   221 | void __init or32_early_setup(void *fdt)
       |             ^~~~~~~~~~~~~~~~

presumably because some openrisc patches are not yet in linux-next??

thanks.

> ---
>   arch/openrisc/include/asm/setup.h | 14 ++++++++++++++
>   arch/openrisc/kernel/setup.c      | 16 +---------------
>   2 files changed, 15 insertions(+), 15 deletions(-)
>   create mode 100644 arch/openrisc/include/asm/setup.h
> 



-- 
~Randy

