Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD73953A4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 03:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEaBYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 21:24:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2473 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaBYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 21:24:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FtcsR3BcHz68BY;
        Mon, 31 May 2021 09:19:55 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:22:51 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:22:51 +0800
Subject: Re: [kbuild-all] Re: [PATCH 2/3] crypto: hisilicon/sec - add fallback
 tfm supporting for XTS mode
To:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        <herbert@gondor.apana.org.au>
References: <1622202126-19237-3-git-send-email-yekai13@huawei.com>
 <202105282256.hUBoOJ3Z-lkp@intel.com>
 <c265adb3-4cba-a6f7-6ba5-9a065fe5aeca@huawei.com>
 <7c435436-cf38-7c09-9141-8410a8c18cc8@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <ee6a4b40-de82-57e9-ba7a-4e3aceac12a4@huawei.com>
Date:   Mon, 31 May 2021 09:22:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <7c435436-cf38-7c09-9141-8410a8c18cc8@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/31 8:51, Rong Chen wrote:
>
>
> On 5/29/21 5:22 PM, yekai(A) wrote:
>>
>>
>> On 2021/5/28 22:13, kernel test robot wrote:
>>> Hi Kai,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on cryptodev/master]
>>> [also build test ERROR on crypto/master linux/master linus/master
>>> v5.13-rc3 next-20210528]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch]
>>>
>>> url:
>>> https://github.com/0day-ci/linux/commits/Kai-Ye/crypto-hisilicon-supports-new-skciphers-for-new-hardware/20210528-194644
>>>
>>> base:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>>> master
>>> config: ia64-allmodconfig (attached as .config)
>>> compiler: ia64-linux-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>         wget
>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>> -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         #
>>> https://github.com/0day-ci/linux/commit/60bae5ed49c53ea90c82125a8295fb72833a3b68
>>>
>>>         git remote add linux-review https://github.com/0day-ci/linux
>>>         git fetch --no-tags linux-review
>>> Kai-Ye/crypto-hisilicon-supports-new-skciphers-for-new-hardware/20210528-194644
>>>
>>>         git checkout 60bae5ed49c53ea90c82125a8295fb72833a3b68
>>>         # save the attached .config to linux build tree
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0
>>> make.cross ARCH=ia64
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/crypto/hisilicon/sec2/sec_crypto.c: In function
>>> 'sec_aead_crypto':
>>>>> drivers/crypto/hisilicon/sec2/sec_crypto.c:1751:40: error: 'sk_req'
>>>>> undeclared (first use in this function); did you mean 'a_req'?
>>>     1751 |   return sec_skcipher_soft_crypto(ctx, sk_req, encrypt);
>>>          |                                        ^~~~~~
>>>          |                                        a_req
>>>    drivers/crypto/hisilicon/sec2/sec_crypto.c:1751:40: note: each
>>> undeclared identifier is reported only once for each function it
>>> appears in
>>>
>>>
>>> vim +1751 drivers/crypto/hisilicon/sec2/sec_crypto.c
>>>
>>>   1733
>>>   1734    static int sec_aead_crypto(struct aead_request *a_req, bool
>>> encrypt)
>>>   1735    {
>>>   1736        struct crypto_aead *tfm = crypto_aead_reqtfm(a_req);
>>>   1737        struct sec_req *req = aead_request_ctx(a_req);
>>>   1738        struct sec_ctx *ctx = crypto_aead_ctx(tfm);
>>>   1739        int ret;
>>>   1740
>>>   1741        req->flag = a_req->base.flags;
>>>   1742        req->aead_req.aead_req = a_req;
>>>   1743        req->c_req.encrypt = encrypt;
>>>   1744        req->ctx = ctx;
>>>   1745
>>>   1746        ret = sec_aead_param_check(ctx, req);
>>>   1747        if (unlikely(ret))
>>>   1748            return -EINVAL;
>>>   1749
>>>   1750        if (unlikely(ctx->c_ctx.fallback))
>>>> 1751            return sec_skcipher_soft_crypto(ctx, sk_req, encrypt);
>>>   1752
>>>   1753        return ctx->req_op->process(ctx, req);
>>>   1754    }
>>>   1755
>>>
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>>
>>
>>
>> You shouldn't git am this patchset directly, because this patchset
>> depends on previous patchset.
>> the series is "crypto: hisilicon - add new type of sqe for Kunpeng930",
>> the patchwork is
>> https://patchwork.kernel.org/project/linux-crypto/list/?series=490143,
>> thank you
>> Kai
>
> Hi Kai,
>
> Thanks for the clarification, it could be very helpful for us if
> '--base' for git format-patch used or
> there is a patchwork link in cover letter file.
>
> Best Regards,
> Rong Chen
> .
>
thanks for your suggestion.

Best Regards
Kai
