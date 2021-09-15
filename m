Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB440CE53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhIOUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:44:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:42:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a66so5030441qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lp9BcrYEoWKcuQnHekVsPUayGkvggC22Su0oQv+i85o=;
        b=GiWElmFJzNdwHBE9n+AZPKP9386jxN7qdlvv3UBVhj+z5A/iDrAX03QjSP1NCw5ynd
         qI45NbMiQHt4gEW6Jr/NECVdE5hEBgQxZxk0KDZJpmBVeD+jtwgsk1ijU+fPLLo8cs6a
         CPWSd4Gg+tKBwS6njE6w4osrVPymnGft1Md8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lp9BcrYEoWKcuQnHekVsPUayGkvggC22Su0oQv+i85o=;
        b=rv+QDltmzGTSRg+hm482rtGDG5/lEKOls/ygwS9+MoG/KJc6VEryklXtKk7kdg+/cn
         kQKGuXFVZx5bwthUDszXEW0NDYFhPz2JidG0wpEKiC7myr8eyyu/wPkG37HJCLemjjCG
         KZ59vGkjehYLMFfTM2aBdDuLfIZYulTXy7MGI0H31QiveEj+R/htjEmfPXWiNg+QSwCp
         tV7OXlqONXC8KcLlnta927FvYg395WavyyFkf0O2OfQJYmwoxG6VkJ3U6x1CAQ3LTdTv
         UZuDJ2DskZ6EGz+t7QizH6CbDROhg/Oq1PLOEHO0ZwXLT6KXUURWZh/RdRLtrah8Hwou
         xf+g==
X-Gm-Message-State: AOAM531rqYimtqTt43ZqJEHx0CQGxVFevuM2InzHPf71iyxOgoBPEaXh
        8FdJ80Io9MuVw/PLxWzwpArjlgsTkZlTog==
X-Google-Smtp-Source: ABdhPJylOsgGJRsV5S4hRGcjaKmzLzjQCYf6UZtfdCp568buUXfjwXEVvu2eiMPGV2InwyKcZNDXoQ==
X-Received: by 2002:a05:620a:f8a:: with SMTP id b10mr1905150qkn.424.1631738564361;
        Wed, 15 Sep 2021 13:42:44 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id c15sm819419qka.46.2021.09.15.13.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 13:42:43 -0700 (PDT)
Message-ID: <00b4158c-a0c8-b4c2-a0e5-3c646079393a@labbott.name>
Date:   Wed, 15 Sep 2021 16:42:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [Tech-board-discuss] Reminder: Voting procedures for the Linux
 Foundation Technical Advisory Board
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
 <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
 <YUH+DO5aHWGVdNb7@pendragon.ideasonboard.com>
 <dc45975a-86df-a70d-ff15-58a3bdcf09ee@labbott.name>
 <YUIHPv3uvAZjJxfB@pendragon.ideasonboard.com>
 <90e00588-3596-01f5-e5a0-73516224b883@labbott.name>
 <YUIbvmPUEUtf/BDU@pendragon.ideasonboard.com>
 <9af9f018-5df5-f5d6-5472-2387c1bb594a@linuxfoundation.org>
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <9af9f018-5df5-f5d6-5472-2387c1bb594a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 15:34, Shuah Khan wrote:
> On 9/15/21 10:13 AM, Laurent Pinchart wrote:
>> Hi Laura,
>>
>> On Wed, Sep 15, 2021 at 12:07:13PM -0400, Laura Abbott wrote:
>>> On 9/15/21 10:46, Laurent Pinchart wrote:
>>>> On Wed, Sep 15, 2021 at 10:36:45AM -0400, Laura Abbott wrote:
>>>>> On 9/15/21 10:07, Laurent Pinchart wrote:
>>>>>> On Wed, Sep 15, 2021 at 09:58:32AM -0400, Laura Abbott wrote:
>>>>>>> On 9/9/21 12:49, Laura Abbott wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Reminder that the Linux Foundation Technical Advisory Board 
>>>>>>>> (TAB) annual
>>>>>>>> election will be held virtually during the 2021 Kernel Summit 
>>>>>>>> and Linux
>>>>>>>> Plumbers Conference. Voting will run from September 20th to 
>>>>>>>> September
>>>>>>>> 23rd 16:00 GMT-4 (US/Eastern). The voting criteria for the 2021 
>>>>>>>> election
>>>>>>>> are:
>>>>>>>>
>>>>>>>> There exist three kernel commits in a mainline or stable released
>>>>>>>> kernel that both
>>>>>>>> - Have a commit date in the year 2020 or 2021
>>>>>>>> - Contain an e-mail address in one of the following tags or merged
>>>>>>>> tags (e.g. Reviewed-and-tested-by)
>>>>>>>> -- Signed-off-by
>>>>>>>> -- Tested-by
>>>>>>>> -- Reported-by
>>>>>>>> -- Reviewed-by
>>>>>>>> -- Acked-by
>>>>>>>>
>>>>>>>> If you have more than 50 commits that meet this requirement you 
>>>>>>>> will
>>>>>>>> receive a ballot automatically.
>>>>>>>>
>>>>>>>> If you have between 3 and 49 commits that meet this requirement 
>>>>>>>> please
>>>>>>>> e-mail tab-elections@lists.linuxfoundation.org to request your 
>>>>>>>> ballot.
>>>>>>>> We strongly encourage everyone who meets this criteria to request a
>>>>>>>> ballot.
>>>>>>>>
>>>>>>>> We will be using Condorcet Internet Voting
>>>>>>>> Service (CIVS) https://civs1.civs.us/ . This is a voting service
>>>>>>>> focused on security and privacy. There are sample polls on the
>>>>>>>> website if you would like to see what a ballot will look like.
>>>>>>>>
>>>>>>>> If you have any questions please e-mail
>>>>>>>> tab-elections@lists.linuxfoundation.org.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Laura
>>>>>>>>
>>>>>>>> P.S. Please also consider this another reminder to consider 
>>>>>>>> running for
>>>>>>>> the TAB as well
>>>>>>>
>>>>>>> Final reminder: please remember to request your ballot for the TAB
>>>>>>> elections. If you know others who are eligible please encourage
>>>>>>> them to request a ballot as well.
>>>>>>
>>>>>> When are the ballots supposed to be sent ? It would be nice to avoid
>>>>>> requiring everybody to check whether they're below or above the 50
>>>>>> commits threshold manually :-)
>>>>>
>>>>> The ballots will be sent sometime after Monday September 20th
>>>>> 9:00am GMT-4 (US/Eastern).
>>>>>
>>>>> I did make an attempt to send e-mails to the > 50 commits individuals
>>>>> but there is a chance my e-mail got eaten by spam filters or just
>>>>> didn't get sent out. I discovered Google Apps' e-mail limits and
>>>>> that you should not attempt to bcc too many people. This is something
>>>>> I'd like to handle in a more automated fashion next year to make
>>>>> it easier for both voters and those running the elections.
>>>>
>>>> Does it mean I should ask for a ballot after the 20th if I don't get
>>>> one, or request one *before* ? I meet the above criteria but haven't
>>>> received any ballot yet, so I was unsure whether I should ask or wait.
>>>
>>> The intention was that if you were in the range of between 3-49 commits
>>> you would ask for a ballot now.
>>
>> Would it be possible to share the script that you are using to check in
>> which category a developer is, to avoid the criteria being applied in
>> slightly different ways ?
>>
> 
> Same request. Is this the same script that gets used to determine candidate
> eligibility before they get added to the ballot?
> 
> thanks,
> -- Shuah

You can thank Kees for the script

https://github.com/kees/kernel-tools/blob/trunk/identity-canonicalizer

This is the same script for both voting and nomination

The set generated is

# Find people participating in 50+ commits since 2020-01-01:
git log --since=2020-01-01 | ~/bin/identity-canonicalizer | sort -g > 
contributors.txt
cat contributors.txt | awk '{if ($1 > 2) {print $0}}' >eligible.txt
cat eligible.txt | awk '{if ($1 > 49) {print $0}}' >ballots.txt
