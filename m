Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1630A5BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhBAKpu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 05:45:50 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41421 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhBAKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:45:46 -0500
Received: from marcel-macpro.holtmann.net (p4fefc84e.dip0.t-ipconnect.de [79.239.200.78])
        by mail.holtmann.org (Postfix) with ESMTPSA id 070B4CED1B;
        Mon,  1 Feb 2021 11:52:29 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] bluetooth: fix memory leak in btusb_mtk_wmt_recv
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210201120853.00002791@163.com>
Date:   Mon, 1 Feb 2021 11:45:02 +0100
Cc:     zhongjupeng <zhongjupeng@yulong.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Markus=C2=A0Elfring?= <Markus.Elfring@web.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <A3F983DE-36C0-43EB-BE8F-086FECCE63B8@holtmann.org>
References: <20210129020827.27784-1-zjp734690220@163.com>
 <949194D0-DD66-4626-8577-9F228D142BF9@holtmann.org>
 <20210130153909.00001f48@163.com> <20210201120853.00002791@163.com>
To:     Jupeng Zhong <zjp734690220@163.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jupeng,

>>>> In btusb_mtk_wmt_recv if skb_clone fails, the alocated skb should
>>>> be released.
>>>> 
>>>> Signed-off-by: zhongjupeng <zhongjupeng@yulong.com>    
>>> 
>>> please provide a proper From: and Signed-off-by line with full name.
>>> 
>>> Regards
>>> 
>>> Marcel  
>> 
>>  Hi,
>> 
>> 
>>    Update the patch From: and Signed-off-by: as follows:
>> 
>> 	Jupeng Zhong <zhongjupeng@yulong.com>
> 
> 
>  Hi,
> 
>    Thanks to Markus Elfring for the suggestion:
> 
>    1. add the tag “Fixes”.
>    2. omit the labels “err_out” and “err_free_skb” in this function
>       implementation.
> 
>    The patch has been updated, please check.
> 
>    Thanks.
> <0001-Bluetooth-btusb-Fix-memory-leak-in-btusb_mtk_wmt_rec.patch>

please send patch inline via git-send-email or similar so that they are easy to review.

Regards

Marcel


