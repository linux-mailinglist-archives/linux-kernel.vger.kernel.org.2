Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C6A350CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhDACgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:36:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14982 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhDACfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:35:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9nL63XpkzyNJ6;
        Thu,  1 Apr 2021 10:33:34 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 10:35:37 +0800
Subject: Re: [PATCH -next] staging: rtl8723bs: os_dep: remove unused variable
 'ret'
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
References: <20210331094247.2169606-1-yangyingliang@huawei.com>
 <YGROp83Mnf8hGjY4@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <7910bfa1-e903-68a1-4ece-221610fbd8d4@huawei.com>
Date:   Thu, 1 Apr 2021 10:35:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YGROp83Mnf8hGjY4@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/3/31 18:27, Greg KH wrote:
> On Wed, Mar 31, 2021 at 05:42:47PM +0800, Yang Yingliang wrote:
>> GCC reports the following warning with W=1:
>>
>> drivers/staging/rtl8723bs/os_dep/recv_linux.c:101:6: warning:
>>   variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>    101 |  int ret;
>>        |      ^~~
>>
>> This variable is not used in function , this commit
>> remove it to fix the warning.
>>
>> Fixes: de69e2b3f105 ("staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/recv_linux.c")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/staging/rtl8723bs/os_dep/recv_linux.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
>> index fbdbcd04d44a..f6a9482be8e3 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
>> @@ -98,7 +98,6 @@ struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_L
>>   void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
>>   {
>>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>> -	int ret;
>>   
>>   	/* Indicate the packets to upper layer */
>>   	if (pkt) {
>> @@ -140,7 +139,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, str
>>   
>>   		pkt->ip_summed = CHECKSUM_NONE;
>>   
>> -		ret = rtw_netif_rx(padapter->pnetdev, pkt);
>> +		rtw_netif_rx(padapter->pnetdev, pkt);
> Why not handle the result of this call properly?

The return type of rtw_os_recv_indicate_pkt() is void, it can't use this 
return code.

I will try to make a patch to change return type of 
rtw_os_recv_indicate_pkt() to use
this return code later.

Thanks,

Yang

>
> .
