Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423DF4111ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhITJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:32:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38501 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhITJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:32:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632130290; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rArp1RA0/MIPIrJ9K0lLkQd4he/8EHpqu1s9srPsVr0=;
 b=NJ/QdPaxd9PmuyN+9KXYNseJMLgIrzjGq7twYJa+rRxA95EMtQnLOXejTio26tkOZ6AbBlBg
 BKuyZAicO5DUhP407th1Cfh2L7xSk/U5Ip6yXG2OkDdyXnLVPV+tJFzRxb9KFRm3Q0PZufsy
 c8D9Pnc9S5PfY+HV2ayNd8AzkmQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 614854dcec62f57c9a028217 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Sep 2021 09:31:08
 GMT
Sender: jeyr=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F469C4360C; Mon, 20 Sep 2021 09:31:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jeyr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8547BC4338F;
        Mon, 20 Sep 2021 09:31:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Sep 2021 15:01:07 +0530
From:   jeyr@codeaurora.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH] misc: fastrpc: fix improper packet size calculation
In-Reply-To: <YUhPlj8eeszBNZTE@kroah.com>
References: <1632125731-18768-1-git-send-email-jeyr@codeaurora.org>
 <YUhPlj8eeszBNZTE@kroah.com>
Message-ID: <6b3663fcadfdc5bc0cc82eedce533905@codeaurora.org>
X-Sender: jeyr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-20 14:38, Greg KH wrote:
> On Mon, Sep 20, 2021 at 01:45:31PM +0530, Jeya R wrote:
>> The buffer list is sorted and this is not being
>> considered while calculating packet size. This
>> would lead to improper copy length calculation
>> for non-dmaheap buffers which would eventually
>> cause sending improper buffers to DSP.
> 
> You do have the full 72 columns to use :)

Thanks, will update the commit message considering this.

> 
>> 
>> Signed-off-by: Jeya R <jeyr@codeaurora.org>
>> ---
>>  drivers/misc/fastrpc.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> What commit does this fix?
> 
> thanks,
> 
> greg k-h

Payload calculation function was modified to handle buffer overlapping 
calculation in this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/misc/fastrpc.c?h=v5.15-rc2&id=25e8dfb83cda0a123bb1e091d6c3599cde050d76

Here during buffer overlap calculation, the buffer list is getting 
sorted. This needs to be considered during the calculation of payload 
size also by using unsorted buffer index "raix".
