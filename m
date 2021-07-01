Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8536C3B93D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhGAPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:21:38 -0400
Received: from atlmailgw1.ami.com ([63.147.10.40]:63389 "EHLO
        atlmailgw1.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbhGAPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:21:37 -0400
X-AuditID: ac1060b2-3edff70000000c56-29-60dddcea2ebe
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw1.ami.com (Symantec Messaging Gateway) with SMTP id 9B.86.03158.AECDDD06; Thu,  1 Jul 2021 11:19:06 -0400 (EDT)
Received: from ami-us-wk.us.megatrends.com (172.16.98.207) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Thu, 1 Jul 2021 11:19:05 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     Michael Walle <michael@walle.cc>
CC:     Hongwei Zhang <hongweiz@ami.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mtd: spi-nor: Add some M45PEx ids
Date:   Thu, 1 Jul 2021 11:18:39 -0400
Message-ID: <20210701151839.3011-1-hongweiz@ami.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210629150846.21547-2-hongweiz@ami.com>
References: <20210629150846.21547-1-hongweiz@ami.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.207]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWyRiBhgu6rO3cTDBbe1ra4vGsOm8XupmXs
        Fm9Pb2C3uPv8B7vFxyUODqwem5fUe9z5sZTR4/iN7UwenzfJeRzY28IWwBrFZZOSmpNZllqk
        b5fAlfF98jvGgkm8FXMv9zE2MP7n6mLk5JAQMJHYM/MCaxcjF4eQwC4mie2zV0E5Oxkl/hz4
        zQ5SxSagJrF38xwmEFtEQEXi8ecLjCBFzALbGSU6G76xgSSEBSwlJm58yQpiswAVff93kRnE
        5gVa8XHXV3aIdfISqzccAItzCphJzG1/ANYrJGAq8WxNDxtEvaDEyZlPWEBsZgEJiYMvXjBD
        1MhK3Dr0mAlijqLEg1/fWScwCsxC0jILScsCRqZVjEKJJTm5iZk56eWGeom5mXrJ+bmbGCEh
        u2kHY8tF80OMTByMhxglOJiVRHgnTL+bIMSbklhZlVqUH19UmpNafIhRmoNFSZx3lfvReCGB
        9MSS1OzU1ILUIpgsEwenVANjmtpPc990n7erOkR+ugVxZ1+pPl5RY6Tto/fRSuvqjC+zoyeY
        x26/fVJzZvZMXf7ong5Dh6qzK264yT1LmH10qZWxDdcZjs/1Vw49bWJbpsNme+fYHNt7V/Km
        3ljl47JwDdf5oz7OB2TZ1/9/LzLLab7Zt6leyXxB8Tfqf3zZ8bXwVNxnLdVzSizFGYmGWsxF
        xYkAbKvRwEcCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Ok, I will separately resubmit a revised patch with update later.

Regards,
--Hongwei

>Subject:	[EXTERNAL] Re: [PATCH v1 1/1] mtd: spi-nor: Add some M45PEx ids
>
>>> Am 2021-06-29 17:08, schrieb Hongwei Zhang:
>>>> Add some Micron M45PEx flash memeories into the IDs table.
>>>
>>> Did you test all these flashes?
>>>
>> No, the patch was added in porting drivers related to AST2600 EVB.
>
>Please note, that all flashes which are added must be tested.
>
>>>> Fixes: dd1e9367157f900616f (ARM: dts: everest: Add phase corrections 
>>>> for
>>>> eMMC)
>>>
>>> Bogus Fixes tag. First, I cannot find this commit id, which tree is 
>>> that? Secondly, adding new flash ids don't fix anything, esp not 
>>> something related to eMMC.
>>>
>> Sorry for the confusion, I thought Fixes tag could be also used for 
>> referencing the revision base for the patch to aplly on.
>> I used dev-5.10 branch from 
>> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
>> 
>ub.com%2Fopenbmc%2Flinux.git&amp;data=04%7C01%7Chongweiz%40ami.com%7C72a7d2569f6a4cb
>629fe08d93c775f8a%7C27e97857e15f486cb58e86c2b3040f93%7C1%7C0%7C637607305682606148%7
>CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>%3D%7C1000&amp;sdata=h%2BoFfg9m0udXdQgb85oq0NKEIcL1DFNha186lP0HwG8%3D&amp;reserve
>d=0 , should I use a different repository?
>
>AFAIK commits in fixes tags must be relative to Linus Torvalds' tree (or a subtree must not rebase, like 
>the networking trees, which means they will end up in Torvalds' tree).
>
>Anyway, this is not a fix and therefore there must be no Fixes: tag.
>
>-michael
