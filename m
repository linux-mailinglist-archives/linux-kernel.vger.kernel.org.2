Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9A93A0A64
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhFIDDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:03:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5340 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhFIDDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:03:16 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0Bbr6pQ0z6vPw;
        Wed,  9 Jun 2021 10:57:28 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:01:18 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 11:01:18 +0800
Subject: Re: [PATCH -next 2/2] staging: r8188eu: use eth_broadcast_addr() to
 assign broadcast address
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210608141620.525521-1-liushixin2@huawei.com>
 <YL96vz4okNehxCBG@kroah.com>
 <b77a3e7b0923344e8c5b9b17f4788d28f3ccfb4f.camel@perches.com>
 <YL+ib+tJwKckXagY@kroah.com>
 <eb8d5431301686000746524882c06121a2d21189.camel@perches.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <4773dedc-dd39-ce1c-f7a6-58a93799fd92@huawei.com>
Date:   Wed, 9 Jun 2021 11:01:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <eb8d5431301686000746524882c06121a2d21189.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/9 1:34, Joe Perches wrote:
> On Tue, 2021-06-08 at 19:01 +0200, Greg Kroah-Hartman wrote:
>> On Tue, Jun 08, 2021 at 09:45:49AM -0700, Joe Perches wrote:
>>> On Tue, 2021-06-08 at 16:12 +0200, Greg Kroah-Hartman wrote:
>>>> On Tue, Jun 08, 2021 at 10:16:20PM +0800, Liu Shixin wrote:
>>>>> Use eth_broadcast_addr() to assign broadcast address.
>>>> That says what you do, but not _why_ you are doing this?
>>>>
>>>> Why make this change?  What benifit does it provide?
>>> The commit message is clear and concise as using available kernel
>>> mechanisms is better than homegrown or duplicative ones.
>>>
>>> Are you asking merely becuse Liu Shixin hasn't had many staging
>>> commits?
>> I'm asking because this changelog text does not explain why this is
>> needed at all and needs to be changed to do so.
> IYO.
>
> IMO it's obvious and fine as is and you are asking for overly
> fine-grained analyses in commit messages.
>
> The subject is clear though the commit message is merely duplicative.
>
> It _could_ show the reduction in object size for some versions of gcc.
>
> $ size drivers/staging/rtl8188eu/core/rtw_mlme_ext.o*
>    text	   data	    bss	    dec	    hex	filename
>   53259	    372	   2430	  56061	   dafd	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc6.new
>   53355	    372	   2430	  56157	   db5d	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc6.old
>   54673	    372	   2430	  57475	   e083	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc10.new
>   54673	    372	   2430	  57475	   e083	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc10.old
>
> It _could_ describe how the kernel mechanisms depend on a minimum
> alignment of __aligned(2) in the tested address and also show that
> the address is properly minimum aligned.
>
> struct ieee80211_hdr {
> 	__le16 frame_control;
> 	__le16 duration_id;
> 	u8 addr1[ETH_ALEN];
> 	u8 addr2[ETH_ALEN];
> 	u8 addr3[ETH_ALEN];
> 	__le16 seq_ctrl;
> 	u8 addr4[ETH_ALEN];
> } __packed __aligned(2);
> [...]
> 	struct ieee80211_hdr *pwlanhdr;
> [...]
> -	ether_addr_copy(pwlanhdr->addr1, bc_addr);
> +	eth_broadcast_addr(pwlanhdr->addr1);
>
> It _could_ show that the commit has some effect on runtime.
> It _could_ show that it passes some (unavailable) regression test.
>
> IMO: None of those are really necessary here.
>
>
> .
>
The variable bc_addr is repeated many times in the code and looks like magic number. I want to simplify the code by remoing unnecessary bc_addr.
And I think it's better using eth_broadcast_addr() directly rather than using ether_addr_copy() + bc_addr.

Thanks to Joe for the data.

Thanks,


