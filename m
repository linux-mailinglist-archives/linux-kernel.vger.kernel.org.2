Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84914393AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 03:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhE1B24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:28:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhE1B2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:28:52 -0400
Received: from dggeml707-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Frn4065XnzWnNy;
        Fri, 28 May 2021 09:22:40 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggeml707-chm.china.huawei.com (10.3.17.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 09:27:16 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 09:27:16 +0800
Subject: Re: [PATCH next] staging: rtl8723bs: HalBtc8723b1Ant.c: Remove unused
 variables
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <dan.carpenter@oracle.com>, <desmondcheongzx@gmail.com>,
        <marcocesati@gmail.com>, <fabioaiuto83@gmail.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20210526074537.46259-1-cuibixuan@huawei.com>
 <YK98CL3+Gg5hGH9g@kroah.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <d8401186-585f-deec-5eea-869b896b0ab1@huawei.com>
Date:   Fri, 28 May 2021 09:27:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YK98CL3+Gg5hGH9g@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/27 19:01, Greg KH wrote:
>>  		halbtc8723b1ant_PsTdma(pBtCoexist, FORCE_EXEC, false, 8);  /* Force antenna setup for no scan result issue */
>> -		u4Tmp = pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
>> -		u1Tmpa = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
>> -		u1Tmpb = pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
>> +		pBtCoexist->fBtcRead4Byte(pBtCoexist, 0x948);
>> +		pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x765);
>> +		pBtCoexist->fBtcRead1Byte(pBtCoexist, 0x67);
>>  	} else {
>>  		pCoexSta->bWiFiIsHighPriTask = false;
>>  
>> -- 
>> 2.17.1
>>
>>
> Does not apply to my tree :(
Hi,
This warning has been fixed by commit db52e8f48067. Please ignore my patch.

Thanks
Bixuan Cui


> .
