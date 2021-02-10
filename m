Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34B4316A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhBJPfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:35:06 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:30532 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230171AbhBJPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:34:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612971252; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=gYDWp2DBmUwEH+WiGYQHXHVYycuwNIh7HiMRKaFXJXs=; b=X/xh3EHLEDx5MPvNd8gIod5iaL+82R4+UF5OI0oOact/GpK5MIkrqJWDPDchkuJ/FpoNitKD
 zmNFM1dWjQWOYnX0rx/vKSnliTjeLFRueE3NoeGfoDJIjJWeZOryq5t8tD9pAMc3K+oWkRkC
 zIr7ziPLDxw3ii1n62vZc9Sxi2k=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6023fcd634db06ef79374eb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 15:33:42
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A403C433CA; Wed, 10 Feb 2021 15:33:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.2] (unknown [49.37.87.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7273EC433C6;
        Wed, 10 Feb 2021 15:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7273EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
Subject: Re: Pstore : Query on using ramoops driver for DDR
To:     "Luck, Tony" <tony.luck@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
References: <f71919bd-acd1-843c-3c9b-1d518f0d7b88@codeaurora.org>
 <e28daeb8a1d74d60a3acb5c582f92123@intel.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9a653cf1-ab22-15c1-d021-a7cfe2b78276@codeaurora.org>
Date:   Wed, 10 Feb 2021 21:03:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <e28daeb8a1d74d60a3acb5c582f92123@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/2021 2:32 AM, Luck, Tony wrote:
>> Can we use existing backend pstore ram driver (fs/pstore/ram.c) for DDR
>> instead of SRAM ?
> The expectation for pstore is that the system will go through a reset when it
> crashes. Most systems do not preserve DDR contents across reset.
>
> to support DDR, If we have a mechanism to copy stored data from DDR to
> external device after the crash.
>> Was the current driver written only to support persistant RAM like SRAM
>> or it can accept further change
> Linux is in a constant state of change :-)
>
> See above about DDR contents.   But if you have a platform that does preserve
> DDR contents until your "mechanism" can copy the pstore buffer, then post
> a patch.

Thanks for the reply

I have posted the patch.

https://lore.kernel.org/patchwork/patch/1378949/

-Mukesh


>

> -Tony
