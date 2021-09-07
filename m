Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DEA402CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhIGQYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:24:25 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:52324 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhIGQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:24:24 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 42E43821B6;
        Tue,  7 Sep 2021 19:23:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631031794;
        bh=DyFRy6mgDgXsW8PfqWeNWX+7xung96yyOFRQPeJPy/M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hoAGxUBFPTEBhZOZLuy7ZvLiqjuUOs26qv0erv/QQAxE/wei2tG7zarTQLLB7Qun3
         j7T8PN8QV8Tif8w+jxPLJHPQzAn0Qdjc3rbbDGs/pteOrBffKiiEwwkHoqsPXygwV+
         SR8e7cG17Ci0v/n51GYU7A7U8fO4fK1llG8aS6Z4=
Received: from [192.168.211.115] (192.168.211.115) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 7 Sep 2021 19:23:13 +0300
Subject: Re: [PATCH 2/5] fs/ntfs3: Use consistent spacing around '+'
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     Joe Perches <joe@perches.com>, <ntfs3@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
 <20210831181505.1074767-3-kari.argillander@gmail.com>
 <1d303f4553e67abee4f0c4cdc32231813a4bcb3f.camel@perches.com>
 <20210902081020.g5hclc45zjng3ll2@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <bb8fff4c-ae09-cab0-cd71-c34b872c9211@paragon-software.com>
Date:   Tue, 7 Sep 2021 19:23:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902081020.g5hclc45zjng3ll2@kari-VirtualBox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.115]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.09.2021 11:10, Kari Argillander wrote:
> On Wed, Sep 01, 2021 at 09:22:19PM -0700, Joe Perches wrote:
>> On Tue, 2021-08-31 at 21:15 +0300, Kari Argillander wrote:
>>> Use consistent spacing around '+' for better code reading. Checkpatch
>>> will also be happy.
>>
>> I think you should remove the + instead
> 
> Konstantin can you look this as this was introduce by you just couple
> days ago? 
> 
>>
>>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>> []
>>> @@ -1451,7 +1451,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
>>>  		attr->res.flags = RESIDENT_FLAG_INDEXED;
>>>  
>>>
>>>  		/* is_attr_indexed(attr)) == true */
>>> -		le16_add_cpu(&ni->mi.mrec->hard_links, +1);
>>> +		le16_add_cpu(&ni->mi.mrec->hard_links, + 1);
>>
>> 		le16_add_cpu(&ni->mi.mrec->hard_links, 1);
>>
>>

Hi, Kari, Joe!
Yes, '+' can be removed, it was added for better visibility,
but it's subjective. 
After checking code - it's the only place with '+1', so let's remove it.
