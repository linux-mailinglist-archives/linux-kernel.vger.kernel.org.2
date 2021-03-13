Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA685339ADB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 02:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCMBbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 20:31:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13507 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhCMBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 20:30:55 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dy4pN09P2zjTPp;
        Sat, 13 Mar 2021 09:29:00 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 09:30:43 +0800
Subject: Re: [PATCH v3 1/2] crypto: hisilicon/sec - fixes some log printing
 style
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1614838735-52668-1-git-send-email-liulongfang@huawei.com>
 <1614838735-52668-2-git-send-email-liulongfang@huawei.com>
 <20210312125918.GA12149@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <14684f5f-0223-7e33-3891-0f578648d422@huawei.com>
Date:   Sat, 13 Mar 2021 09:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210312125918.GA12149@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/12 20:59, Herbert Xu wrote:
> On Thu, Mar 04, 2021 at 02:18:54PM +0800, Longfang Liu wrote:
>>
>> @@ -727,7 +725,7 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
>>  	struct aead_request *aead_req = req->aead_req.aead_req;
>>  	struct sec_cipher_req *c_req = &req->c_req;
>>  	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
>> -	struct device *dev = SEC_CTX_DEV(ctx);
>> +	struct device *dev = ctx->dev;
>>  	int copy_size, pbuf_length;
>>  	int req_id = req->req_id;
>>  
>> @@ -737,11 +735,9 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
>>  		copy_size = c_req->c_len;
>>  
>>  	pbuf_length = sg_copy_from_buffer(dst, sg_nents(dst),
>> -				qp_ctx->res[req_id].pbuf,
>> -				copy_size);
>> -
>> +			qp_ctx->res[req_id].pbuf, copy_size);
>>  	if (unlikely(pbuf_length != copy_size))
>> -		dev_err(dev, "copy pbuf data to dst error!\n");
>> +		dev_err(ctx->dev, "copy pbuf data to dst error!\n");
>>  }
> 
> This triggers an unused warning on dev.  Please fix.
> 
> Thanks,
> Ok! I will check if this problem exists elsewhere.
Thanks,
Longfang
