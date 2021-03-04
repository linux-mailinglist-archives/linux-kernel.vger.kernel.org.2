Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6232C32D650
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhCDPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:17:41 -0500
Received: from z11.mailgun.us ([104.130.96.11]:43706 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233886AbhCDPRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:17:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614871007; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dyltIQ8oRrwKvMEyJ11sgR7hrRe+moPL6rUKrk/x2wk=;
 b=XN4l+55C+Wcp6wI2J0nDolVNvlPcSJo9UBhnSFdJ2+zZRzDvZ1q8mlYdULz3uT67KuII9t4S
 B/hXV39UGdGdlKHdXG2uB0QBBpaTlnR4NrUU2BLEGmCU/xask6Th8UFGw1qO+psbhFP0jwZT
 vMi1Ml4lOf+0Lp0/OckAPuCM/uI=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6040f9d4c862e1b9fd27f3f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Mar 2021 15:16:36
 GMT
Sender: pragalla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B837C43461; Thu,  4 Mar 2021 15:16:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pragalla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EED9C433CA;
        Thu,  4 Mar 2021 15:16:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Mar 2021 20:46:35 +0530
From:   pragalla@codeaurora.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mmc: sdhci: Check for reset prior to DMA address unmap
In-Reply-To: <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com>
References: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com>
Message-ID: <3962320b58beaa4626ed69b3120d4246@codeaurora.org>
X-Sender: pragalla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-04 19:19, Ulf Hansson wrote:
> On Wed, 3 Mar 2021 at 09:32, Pradeep P V K <pragalla@qti.qualcomm.com> 
> wrote:
>> 
>> From: Pradeep P V K <pragalla@codeaurora.org>
>> 
>> For data read commands, SDHC may initiate data transfers even before 
>> it
>> completely process the command response. In case command itself fails,
>> driver un-maps the memory associated with data transfer but this 
>> memory
>> can still be accessed by SDHC for the already initiated data transfer.
>> This scenario can lead to un-mapped memory access error.
>> 
>> To avoid this scenario, reset SDHC (when command fails) prior to
>> un-mapping memory. Resetting SDHC ensures that all in-flight data
>> transfers are either aborted or completed. So we don't run into this
>> scenario.
>> 
>> Swap the reset, un-map steps sequence in sdhci_request_done().
>> 
>> Changes since V1:
>> - Added an empty line and fixed the comment style.
>> - Retained the Acked-by signoff.
>> 
>> Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Hi Uffe,
> 
> Seems like it might be a good idea to tag this for stable? I did that,
> but awaiting for your confirmation.
> 
Yes, this fix is applicable for all stable starting from 4.9 (n/a for 
4.4).
Kindly go ahead.

> So, applied for next, thanks!
> 
> Kind regards
> Uffe
> 
Thanks and Regards,
Pradeep

> 
>> ---
>>  drivers/mmc/host/sdhci.c | 60 
>> +++++++++++++++++++++++++-----------------------
>>  1 file changed, 31 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 646823d..130fd2d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2998,6 +2998,37 @@ static bool sdhci_request_done(struct 
>> sdhci_host *host)
>>         }
>> 
>>         /*
>> +        * The controller needs a reset of internal state machines
>> +        * upon error conditions.
>> +        */
>> +       if (sdhci_needs_reset(host, mrq)) {
>> +               /*
>> +                * Do not finish until command and data lines are 
>> available for
>> +                * reset. Note there can only be one other mrq, so it 
>> cannot
>> +                * also be in mrqs_done, otherwise host->cmd and 
>> host->data_cmd
>> +                * would both be null.
>> +                */
>> +               if (host->cmd || host->data_cmd) {
>> +                       spin_unlock_irqrestore(&host->lock, flags);
>> +                       return true;
>> +               }
>> +
>> +               /* Some controllers need this kick or reset won't work 
>> here */
>> +               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
>> +                       /* This is to force an update */
>> +                       host->ops->set_clock(host, host->clock);
>> +
>> +               /*
>> +                * Spec says we should do both at the same time, but 
>> Ricoh
>> +                * controllers do not like that.
>> +                */
>> +               sdhci_do_reset(host, SDHCI_RESET_CMD);
>> +               sdhci_do_reset(host, SDHCI_RESET_DATA);
>> +
>> +               host->pending_reset = false;
>> +       }
>> +
>> +       /*
>>          * Always unmap the data buffers if they were mapped by
>>          * sdhci_prepare_data() whenever we finish with a request.
>>          * This avoids leaking DMA mappings on error.
>> @@ -3060,35 +3091,6 @@ static bool sdhci_request_done(struct 
>> sdhci_host *host)
>>                 }
>>         }
>> 
>> -       /*
>> -        * The controller needs a reset of internal state machines
>> -        * upon error conditions.
>> -        */
>> -       if (sdhci_needs_reset(host, mrq)) {
>> -               /*
>> -                * Do not finish until command and data lines are 
>> available for
>> -                * reset. Note there can only be one other mrq, so it 
>> cannot
>> -                * also be in mrqs_done, otherwise host->cmd and 
>> host->data_cmd
>> -                * would both be null.
>> -                */
>> -               if (host->cmd || host->data_cmd) {
>> -                       spin_unlock_irqrestore(&host->lock, flags);
>> -                       return true;
>> -               }
>> -
>> -               /* Some controllers need this kick or reset won't work 
>> here */
>> -               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
>> -                       /* This is to force an update */
>> -                       host->ops->set_clock(host, host->clock);
>> -
>> -               /* Spec says we should do both at the same time, but 
>> Ricoh
>> -                  controllers do not like that. */
>> -               sdhci_do_reset(host, SDHCI_RESET_CMD);
>> -               sdhci_do_reset(host, SDHCI_RESET_DATA);
>> -
>> -               host->pending_reset = false;
>> -       }
>> -
>>         host->mrqs_done[i] = NULL;
>> 
>>         spin_unlock_irqrestore(&host->lock, flags);
>> --
>> 2.7.4
>> 
