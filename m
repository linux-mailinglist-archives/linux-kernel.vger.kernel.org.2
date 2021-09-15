Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE76240C9BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhIOQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhIOQIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:08:34 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95898C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:07:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x5so2726265qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VQvaj+BATVuAU9GeASbA/D0cvm8/Buiuj4FOo4+QV9E=;
        b=R3pzufHKwAcdJsYtIx3BndJSeQ4l2vKzndidaFHWAnBrTlHnJhhzlJzHIjC7NhUksI
         h26AltiD3bVuRMUqXWuqEXFCot/xXRzPYAvBULTUiXfTLwqzs/wrdkyjeQjlgLK2cwS3
         YvTbf7GTfgHLtbMltAleMZVRSCC/ApcOZSzdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VQvaj+BATVuAU9GeASbA/D0cvm8/Buiuj4FOo4+QV9E=;
        b=c+P7XUQjuYmqx7y54XVojMv93VGIZJ4IwfreHvLNvsO4/Duhg1fxOvpr9HnqaChAoU
         5b+ppkSTYhsLsG9GxNhnw7yFCG26IQmjdzswilHUz1SptZoCWm4nNOgurRjN9YEsmPni
         yq7gb3+6/6rAjW47S7HHbSf4EGhHF6fq79ObtMtUjhhFsRSsQoGgK2ixkkr1F7YyCttQ
         G4UYGyhKdoTJ2MKPmv1GyHePhLTWyxoerAZY+/pOzVj35mfgeoooDBNH8edGMbGGpGTG
         FMzfLSgg0BW42PMQqRh2UX9MOHxESk+1Hwi5luBFViszkXyO1sGdYh6d6PKN2w5geEyx
         NPQw==
X-Gm-Message-State: AOAM533Bk1C1NQQBjkbO0tPnUj3jSiCOAZqbnK35Yj7JfLT8XU25foAi
        1+ZGWLBCpGYdgTGI4xb0N1XmVA==
X-Google-Smtp-Source: ABdhPJyYbBv8KS4VnwIeQ+1TDX/GR6PuzRd4p00a+oxpjjV9ggNIw610I/iO0OhJfdfxZwv75wTVvQ==
X-Received: by 2002:ac8:202:: with SMTP id k2mr579857qtg.398.1631722034606;
        Wed, 15 Sep 2021 09:07:14 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id q184sm314997qkd.35.2021.09.15.09.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:07:14 -0700 (PDT)
Message-ID: <90e00588-3596-01f5-e5a0-73516224b883@labbott.name>
Date:   Wed, 15 Sep 2021 12:07:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
 <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
 <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
 <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
 <YUIHPv3uvAZjJxfB@pendragon.ideasonboard.com>
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <YUIHPv3uvAZjJxfB@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 10:46, Laurent Pinchart wrote:
> Hi Laura,
> 
> On Wed, Sep 15, 2021 at 10:36:45AM -0400, Laura Abbott wrote:
>> On 9/15/21 10:07, Laurent Pinchart wrote:
>>> On Wed, Sep 15, 2021 at 09:58:32AM -0400, Laura Abbott wrote:
>>>> On 9/9/21 12:49, Laura Abbott wrote:
>>>>> Hi,
>>>>>
>>>>> Reminder that the Linux Foundation Technical Advisory Board (TAB) annual
>>>>> election will be held virtually during the 2021 Kernel Summit and Linux
>>>>> Plumbers Conference. Voting will run from September 20th to September
>>>>> 23rd 16:00 GMT-4 (US/Eastern). The voting criteria for the 2021 election
>>>>> are:
>>>>>
>>>>> There exist three kernel commits in a mainline or stable released
>>>>> kernel that both
>>>>> - Have a commit date in the year 2020 or 2021
>>>>> - Contain an e-mail address in one of the following tags or merged
>>>>> tags (e.g. Reviewed-and-tested-by)
>>>>> -- Signed-off-by
>>>>> -- Tested-by
>>>>> -- Reported-by
>>>>> -- Reviewed-by
>>>>> -- Acked-by
>>>>>
>>>>> If you have more than 50 commits that meet this requirement you will
>>>>> receive a ballot automatically.
>>>>>
>>>>> If you have between 3 and 49 commits that meet this requirement please
>>>>> e-mail tab-elections@lists.linuxfoundation.org to request your ballot.
>>>>> We strongly encourage everyone who meets this criteria to request a
>>>>> ballot.
>>>>>
>>>>> We will be using Condorcet Internet Voting
>>>>> Service (CIVS) https://civs1.civs.us/ . This is a voting service
>>>>> focused on security and privacy. There are sample polls on the
>>>>> website if you would like to see what a ballot will look like.
>>>>>
>>>>> If you have any questions please e-mail
>>>>> tab-elections@lists.linuxfoundation.org.
>>>>>
>>>>> Thanks,
>>>>> Laura
>>>>>
>>>>> P.S. Please also consider this another reminder to consider running for
>>>>> the TAB as well
>>>>
>>>> Final reminder: please remember to request your ballot for the TAB
>>>> elections. If you know others who are eligible please encourage
>>>> them to request a ballot as well.
>>>
>>> When are the ballots supposed to be sent ? It would be nice to avoid
>>> requiring everybody to check whether they're below or above the 50
>>> commits threshold manually :-)
>>
>> The ballots will be sent sometime after Monday September 20th
>> 9:00am GMT-4 (US/Eastern).
>>
>> I did make an attempt to send e-mails to the > 50 commits individuals
>> but there is a chance my e-mail got eaten by spam filters or just
>> didn't get sent out. I discovered Google Apps' e-mail limits and
>> that you should not attempt to bcc too many people. This is something
>> I'd like to handle in a more automated fashion next year to make
>> it easier for both voters and those running the elections.
> 
> Does it mean I should ask for a ballot after the 20th if I don't get
> one, or request one *before* ? I meet the above criteria but haven't
> received any ballot yet, so I was unsure whether I should ask or wait.
> 

The intention was that if you were in the range of between 3-49 commits
you would ask for a ballot now.

Thanks,
Laura
