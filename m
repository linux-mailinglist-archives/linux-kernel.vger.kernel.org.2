Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD34464FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhKEOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhKEOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:35:50 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB11C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 07:33:10 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i16-20020a9d68d0000000b0055c630be045so2638338oto.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/7mQHILIjE0WuW2DTcTAEKZmtnanU22O0J8/ZltgDY4=;
        b=mqrJl2MDRrGkpbPDy5yXVf4SrSoMYlT+Wbcbubv01yJYrz7/kAeegoLVMAIhc5ZtqG
         W0klQfWMbxkSKFV6i9t7HlFl4Zdofssr2vb9y7BUx+LDiLHSbIBSeMK/8EPs2kMsGZEu
         PBRs1RfI7DFUp0hEfXHPA3iheYbfaAjTvnZxU6VTKp06q+Z2xBy5eyT60NoohHoItpgt
         QSEiPsj32ZLNUwzfKh81ZBJy0zZi5sJScpIZyFJeVIwg3yDv5cTlV2wCGD0BKP3vKKMC
         uHaTBWvd8BAWgQKm8Sa+haTIzdI6yoVILRmCUwX4KgnzDryLT6r1BfkSJSLiAS9UtAyD
         RmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/7mQHILIjE0WuW2DTcTAEKZmtnanU22O0J8/ZltgDY4=;
        b=duARqlo6Ix+Bio92Z9CmbCQLfE2T8IK0/qPpN/Iap4Vap+VrbXIFaB18XSGaD3hapK
         neqTWqZX55JIA+8GnzydXkNCXkEasobLDJWA4jRGArX3i0dmUcUgcAehzYYd+dWY6FaP
         S0AXfKTpd21Uy/QdUU89+fVU0qhSXn+sOg9aByd6js5cOOdd1eWmkPMW0lhfiFibAy7t
         MCSSZPFsH191ySxZQb+nk5nxII1Dp3ctOlo+fFl4v+KOyr0gEXumZRj6SjWFA7b0tzrL
         OUOOQ7lS4Q4nNKEztaPoAUb6x++4iUArH0w0yh4IBBlYxe9QC+RJsPzPo7OLNesfmjJG
         zUBA==
X-Gm-Message-State: AOAM5324krHpucCHiGks1WDrJ2EYwkK64VK2lgd0u9i/n+W4yb3QQETj
        5492eg02eGIN1sC/zebFQuCY0A==
X-Google-Smtp-Source: ABdhPJxC9yVwl4BlD9uLB6eyzukIVge49E7REaXFJNYzzspIP1w32KFfNED30RPrMJ2pQlyYwhsvsg==
X-Received: by 2002:a9d:5881:: with SMTP id x1mr43244663otg.332.1636122789364;
        Fri, 05 Nov 2021 07:33:09 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z6sm2550573otp.22.2021.11.05.07.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 07:33:09 -0700 (PDT)
Subject: Re: [axboe-block:for-5.16/block 189/189] block/fops.c:530:23: error:
 implicit declaration of function 'bdev_nr_bytes'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <202111052254.V6mctXgK-lkp@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4d42597-3fd3-fa85-af49-ba8b9bbd436f@kernel.dk>
Date:   Fri, 5 Nov 2021 08:33:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202111052254.V6mctXgK-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 8:01 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.16/block
> head:   d4e76b1ad0065477119b544fd93c2f03550ef548
> commit: d4e76b1ad0065477119b544fd93c2f03550ef548 [189/189] block: use new bdev_nr_bytes() helper for blkdev_{read,write}_iter()
> config: ia64-defconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=d4e76b1ad0065477119b544fd93c2f03550ef548
>         git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>         git fetch --no-tags axboe-block for-5.16/block
>         git checkout d4e76b1ad0065477119b544fd93c2f03550ef548
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    block/fops.c: In function 'blkdev_write_iter':
>>> block/fops.c:530:23: error: implicit declaration of function 'bdev_nr_bytes' [-Werror=implicit-function-declaration]
>      530 |         loff_t size = bdev_nr_bytes(bdev);
>          |                       ^~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Doh, applied it to the wrong branch. Moved it now, should be fine in the
current state.

-- 
Jens Axboe

