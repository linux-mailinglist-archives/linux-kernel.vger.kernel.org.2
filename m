Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EB7357155
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354076AbhDGQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354057AbhDGQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:05:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9ECC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:04:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s11so13227087pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FcJ28S0ovo6BtJGz/fpmjvkKUjvV8E2lcWibpPKseko=;
        b=vLzIrzOZwrbQb+XmH2+qRynZP4JyacNCcmSRRRB6xthR7ZSg8pwCGrUS1eanfwh6ns
         bk9WVxPUyGyB+ty+EvYzd2V6V/yul16OszooefcN+nOeUEwX6LnIotDOM6LiXlJfT7jC
         qUZ2Z2PrXePGK5YjOUnSXWSu+sWvIy4bZXTnJrUuxcdGS5Mr4l4oX8PhK2ZRi1/Cm7AU
         DKD2nRqNls9ouaI2w+PfgYo4KCdIh1CzzXdkSc4ZevXII/PMpJTY+5e1ppfHp119xWZy
         wNsLO1Lm1kSG/6n6IKVNpQEKr3GNUZemFRI6y9A2caWNN4+0qZGGUByLoqDcWMuBuTv/
         HUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FcJ28S0ovo6BtJGz/fpmjvkKUjvV8E2lcWibpPKseko=;
        b=ga0ff1wM7jg8v0j4q2VfwE4hivGH4HWXIasG52+OFfnOYNOFvUDpkrF0B+y0yhwusk
         +nxa6r1tafty55YiNABk272EoJDsiBAsg1jp+O8dTSiS1lbDsk2GVLlDN16FaCrVdMNT
         DgJYaf6Jm3+o9e76FiNojDav6kCNgeHpHhwRxfklcajZcZKzM3N8ZlplZ3LcBrAkoqkF
         gbjo66M0T1sG1wgmVBF+vMqfsuA/JV1+7LJeiB6Pm5XrJpCv+GirOOPz2CDCZd4WUiCl
         eci7vs9O2JaxdAlM4Pq3PmlnqteZX3YSgBQtIXTjmelr6BQKTDqmGim0kju+/0EGvI6C
         DJBg==
X-Gm-Message-State: AOAM530SWOO6Gky94KIDYB51KFRQludnnOadaVJCjofmuvIG8Ax+YO94
        QeMl54QQZG/r3eE/PnrQVH0NRQ==
X-Google-Smtp-Source: ABdhPJxa05rl1eZC8U+FSYTlP4fBwnnhI6BDIP6BLwyEV8PffLv1MO6aeXgs7kZJmx4DOnsp9KqnRg==
X-Received: by 2002:a63:1347:: with SMTP id 7mr707475pgt.112.1617811492389;
        Wed, 07 Apr 2021 09:04:52 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id o3sm6161239pjm.30.2021.04.07.09.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 09:04:51 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
 <202104072325.Zv0JLqbH-lkp@intel.com> <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5111151e-35a5-0422-8414-7b900f01d316@kernel.dk>
Date:   Wed, 7 Apr 2021 10:04:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 10:03 AM, Andy Shevchenko wrote:
> On Wed, Apr 07, 2021 at 11:51:31PM +0800, kernel test robot wrote:
>> Hi Andy,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on block/for-next]
>> [also build test ERROR on v5.12-rc6 next-20210407]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/ata-Drop-unneeded-inclusion-of-kernel-h-in-the-header/20210407-214746
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
>> config: x86_64-randconfig-s021-20210407 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce:
>>         # apt-get install sparse
>>         # sparse version: v0.6.3-279-g6d5d9b42-dirty
>>         # https://github.com/0day-ci/linux/commit/d2574103b692b4fc73f1ed36ee9e4d3324902fd9
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Andy-Shevchenko/ata-Drop-unneeded-inclusion-of-kernel-h-in-the-header/20210407-214746
>>         git checkout d2574103b692b4fc73f1ed36ee9e4d3324902fd9
>>         # save the attached .config to linux build tree
>>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
> 
> Thanks, we need to include bits.h.
> (It passed my simple build, but appears I have no such driver included)
> 
> Jens, I saw your message, should I send a follow up fix, or a v2?

Let's just drop it, not worth it for the risk imho.

-- 
Jens Axboe

