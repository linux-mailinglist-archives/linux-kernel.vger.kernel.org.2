Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552A240C78D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhIOOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhIOOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:38:07 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94650C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:36:48 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a13so1981412qvo.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2H7DzI+go8EOc+36ORDqjtNoZm8AbQrnLy9kD0rxxtc=;
        b=ZU6w5lZQHlgdde9E2wHoIO/rj0um8v8hFdyIKtuXBBtJUs0mFo1wV/6EADZOzWJpB9
         NW0MnoVm+LcLeJcZsb/QZRe1qTe4rop4et8kVcS1yeKSrQnMuFLoN+2h1eqf7ZuBgFrh
         LHa5fNoQzsHBbtHoNo8RTq9CaJGkrX9LdQ89k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2H7DzI+go8EOc+36ORDqjtNoZm8AbQrnLy9kD0rxxtc=;
        b=xdNHY2R4ZSTs1oZhuWmMshv8qKCfvU14601UlXtkxVQEain7L3EC0+MFVN9kMUP3Km
         hW/0AAwcgTncwj/2zCGAt/xc4/z/8ge8At9j8+O28v/QF/l3lZR+QmyPnk+KMrQKUDky
         rhbOpQZpO3eJM2/2yHRmcRrkaISxbcrqTGwTHCX42zWLtDusBQwp7aabLMrcm+06P4Ut
         TJhCICkXWiiy4pSnC+0Crp1EnwPhy9wTsjWQldYkwiiWicjl57LK1MKzOyZE5XR9EsRr
         9fk6vCPshRnKq0kaP7PeZwng+7QNyMXj7SyK6AYzc/Fgjn71FEs3BRaTrEBKLkXqR00s
         XLHw==
X-Gm-Message-State: AOAM531EDFSCb8nVVCb/WLCLMuO3nk5g3ZulVWw91F/WywW1Ho1Y9F+K
        Fzr29SokNvKC9sbRNwRzfCZijg==
X-Google-Smtp-Source: ABdhPJxxteW0dULHX34Lzt8pxnIcdiKoz1yKv0VX+J6HlXzEVnnaGcucetHMs9J9FPM6HwxwvOegKg==
X-Received: by 2002:a05:6214:2609:: with SMTP id gu9mr11501239qvb.35.1631716606236;
        Wed, 15 Sep 2021 07:36:46 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id s28sm112172qkm.43.2021.09.15.07.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 07:36:45 -0700 (PDT)
Message-ID: <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
Date:   Wed, 15 Sep 2021 10:36:45 -0400
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
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 10:07, Laurent Pinchart wrote:
> Hi Laura,
> 
> On Wed, Sep 15, 2021 at 09:58:32AM -0400, Laura Abbott wrote:
>> On 9/9/21 12:49, Laura Abbott wrote:
>>> Hi,
>>>
>>> Reminder that the Linux Foundation Technical Advisory Board (TAB) annual
>>> election will be held virtually during the 2021 Kernel Summit and Linux
>>> Plumbers Conference. Voting will run from September 20th to September
>>> 23rd 16:00 GMT-4 (US/Eastern). The voting criteria for the 2021 election
>>> are:
>>>
>>> There exist three kernel commits in a mainline or stable released
>>> kernel that both
>>> - Have a commit date in the year 2020 or 2021
>>> - Contain an e-mail address in one of the following tags or merged
>>> tags (e.g. Reviewed-and-tested-by)
>>> -- Signed-off-by
>>> -- Tested-by
>>> -- Reported-by
>>> -- Reviewed-by
>>> -- Acked-by
>>>
>>> If you have more than 50 commits that meet this requirement you will
>>> receive a ballot automatically.
>>>
>>> If you have between 3 and 49 commits that meet this requirement please
>>> e-mail tab-elections@lists.linuxfoundation.org to request your ballot.
>>> We strongly encourage everyone who meets this criteria to request a
>>> ballot.
>>>
>>> We will be using Condorcet Internet Voting
>>> Service (CIVS) https://civs1.civs.us/ . This is a voting service
>>> focused on security and privacy. There are sample polls on the
>>> website if you would like to see what a ballot will look like.
>>>
>>> If you have any questions please e-mail
>>> tab-elections@lists.linuxfoundation.org.
>>>
>>> Thanks,
>>> Laura
>>>
>>> P.S. Please also consider this another reminder to consider running for
>>> the TAB as well
>>
>> Final reminder: please remember to request your ballot for the TAB
>> elections. If you know others who are eligible please encourage
>> them to request a ballot as well.
> 
> When are the ballots supposed to be sent ? It would be nice to avoid
> requiring everybody to check whether they're below or above the 50
> commits threshold manually :-)
> 

The ballots will be sent sometime after Monday September 20th
9:00am GMT-4 (US/Eastern).

I did make an attempt to send e-mails to the > 50 commits individuals
but there is a chance my e-mail got eaten by spam filters or just
didn't get sent out. I discovered Google Apps' e-mail limits and
that you should not attempt to bcc too many people. This is something
I'd like to handle in a more automated fashion next year to make
it easier for both voters and those running the elections.

Thanks,
Laura
