Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A578A3668B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhDUKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:00:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:42598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234605AbhDUKAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:00:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B3A3B2E4;
        Wed, 21 Apr 2021 10:00:13 +0000 (UTC)
Subject: Re: next-20210420 build breakage on 32-bit -
 include/uapi/linux/bcache-nvm.h
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     linux-kernel@vger.kernel.org, Jianpeng Ma <jianpeng.ma@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Qiaowei Ren <qiaowei.ren@intel.com>
References: <697668.1618991971@turing-police>
From:   Coly Li <colyli@suse.de>
Message-ID: <046326c5-8059-355a-9991-2eac7be282a4@suse.de>
Date:   Wed, 21 Apr 2021 18:00:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <697668.1618991971@turing-police>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 3:59 PM, Valdis Klētnieks wrote:
> commit 97d69b16cb973e04ea5309b9cb4356aa6b42c54e
> Author: Coly Li <colyli@suse.de>
> Date:   Wed Apr 14 13:46:36 2021 +0800
> 
>     bcache: add initial data structures for nvm pages
> 
> contains this code:
> 
> +#if (__BITS_PER_LONG != 64)
> +       #error "Non-64bit platform is not supported"
> +#endif
> 
> This breaks the build on arm and other 32-bit systems:
> 
>   HDRTEST usr/include/linux/bcache-nvm.h
> In file included from <command-line>:32:
> ./usr/include/linux/bcache-nvm.h:109:3: error: #error "Non-64bit platform is not supported"
>   #error "Non-64bit platform is not supported"
>    ^~~~~
> make[3]: *** [/usr/src/linux-next/usr/include/Makefile:106: usr/include/linux/bcache-nvm.hdrtest] Error 1
> make[2]: *** [/usr/src/linux-next/scripts/Makefile.build:534: usr/include] Error 2
> make[1]: *** [/usr/src/linux-next/Makefile:1967: usr] Error 2
> 

Hi Valdis,

This series is withdrawn from 5.13 queue, this failure can be safely
ignored.

Thanks.

Coly Li
