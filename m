Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B800B35529B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbhDFLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:44:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59822 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343523AbhDFLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:44:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136BhpsB056177;
        Tue, 6 Apr 2021 06:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617709431;
        bh=QSG4b7m1t5DUwLSSKalMTsywrLdqOmMYeBMn11ljLTw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y69pvXZ2Wo9aglIaKqzt34mORRsxN+QFB7RkFdRv5uPLi7MYoV6mS+8m8OLwZfk6s
         hkPjpDBnh37TB3E9Rg7zRTbgSj8vglG4UM1ME/TyXv9iXXCPCOmofMIXBj8rPv21nI
         6cB7TPc59zgQAGfxGCuETzA8Tsi1joeZU2nSe/LY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136Bhp8Y008077
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 06:43:51 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 06:43:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 06:43:51 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136Bhm5Y107532;
        Tue, 6 Apr 2021 06:43:49 -0500
Subject: Re: [PATCH 2/2] mtd: spi-nor: add initial sysfs support
To:     Michael Walle <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-3-michael@walle.cc>
 <658af7ad-c4ee-1c25-b51b-1f66b657aade@ti.com>
 <4f1de957288118d5a627027ec4c37973@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <e14029f2-587d-0f89-98ee-c08b550bf282@ti.com>
Date:   Tue, 6 Apr 2021 17:13:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4f1de957288118d5a627027ec4c37973@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/21 2:17 PM, Michael Walle wrote:
> Hi,
> 
> Am 2021-04-06 09:56, schrieb Vignesh Raghavendra:
>> Hi,
>>
>> On 3/18/21 2:54 PM, Michael Walle wrote:
>>> Add support to show the name and JEDEC identifier as well as to dump the
>>> SFDP table. Not all flashes list their SFDP table contents in their
>>> datasheet. So having that is useful. It might also be helpful in bug
>>> reports from users.
>>>
>>
>> Sorry for the delay..
>>
>> There is already debugfs support for dumping JEDEC ID [1]. Any reason to
>> add sysfs entry as well?
> 
> This is per mtd while the sfdp is per flash device. IMHO both should
> be at the same place.
> 
>> That brings up another question. Since SFDP dumps are more of a debug
>> aid, should this be a debugfs entry rather than sysfs entry?
> 
> And you're not the first one asking that. My argument was that the
> debugfs might not be available just when you need it. A developer
> could easily rebuild a kernel, but imagine some user with a COTS
> distro and some problems, then it is not that easy anymore. But
> thats your call to make.
> 
>> Note that sysfs entries are userspace ABIs just like syscalls and thus
>> need to be documented in Documentation/ABI/testing/ or
>> Documentation/ABI/stable. Thus need to be carefully designed compared to
>> debugfs which are much more flexible.
> 
> Ok. But I don't see a problem adding these read-only files
>  /sfdp
>  /name
>  /jedec-id
> 

Hmm, ok. but do add documentation please.

Regards
Vignesh
