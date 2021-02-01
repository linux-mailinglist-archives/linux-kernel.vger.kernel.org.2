Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1493F30B2F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBAWuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:50:37 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:48482 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhBAWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:50:35 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 9E35B7A28;
        Mon,  1 Feb 2021 14:49:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9E35B7A28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1612219784;
        bh=gXml1x7AeRWAko8NYg61vJptfElb3mouLAr7jiR6V00=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PSstxdZZ8clRqktDowAmbVoFONhDPjed19QdSq4iSIncscpsigy8I9Cqg6z6Vp3ab
         +Km/RBKIo3lNP1yqmkFPnBXR/W1xdC9mMTWKSPYCqCHPBNj9HQWYSIbKJVSk07Urd9
         yoPLPpqAxJ64aiokkYrNvVaokBHeehjvOYR9UhOY=
Subject: Re: [PATCH] misc: bcm-vk: unlock on error in bcm_to_h_msg_dequeue()
To:     Desmond Yan <desmond.yan@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YBfyb+jU5lDUe+5g@mwanda>
 <CAEuuh2_BH4_7bm7tTZ2VSKNv7eCjj-ZU=zcV3vKbD1H_tJRLcQ@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f4f98962-5c0e-c32a-6e12-ae3b830b19c1@broadcom.com>
Date:   Mon, 1 Feb 2021 14:49:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEuuh2_BH4_7bm7tTZ2VSKNv7eCjj-ZU=zcV3vKbD1H_tJRLcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great, looks good then.

On 2021-02-01 10:32 a.m., Desmond Yan wrote:
> Acked-by: Desmond Yan <desmond.yan@broadcom.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
>
> On Mon, Feb 1, 2021 at 4:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> Unlock before returning on this error path.
>>
>> Fixes: 111d746bb476 ("misc: bcm-vk: add VK messaging support")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  drivers/misc/bcm-vk/bcm_vk_msg.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
>> index eec90494777d..fc972e43258a 100644
>> --- a/drivers/misc/bcm-vk/bcm_vk_msg.c
>> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
>> @@ -849,7 +849,8 @@ s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk)
>>                                  * that is fatal.
>>                                  */
>>                                 dev_crit(dev, "Kernel mem allocation failure.\n");
>> -                               return -ENOMEM;
>> +                               total = -ENOMEM;
>> +                               goto idx_err;
>>                         }
>>
>>                         /* flush rd pointer after a message is dequeued */
>> --
>> 2.29.2
>>

