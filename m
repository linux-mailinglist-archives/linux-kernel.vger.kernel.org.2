Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64740C6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhION7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbhION7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:59:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:58:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x5so2324103qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=j7F4OhupuEb6jt4oCrBdO2k5ZYwBESobEAtwAMK2gYE=;
        b=vbs1cZg30L6WP2BfD2X2u4qRXc7cOdrvi4uc/GTN9IGfiWF35ZFEzxc7byJF7v7TwU
         7fAP8Slm82zd/npPXX0VHyHxRepP15H0h3WhPuJ8GYdjtFqlbLH199U4ClweMjpCiIl7
         eamuMz3W+Bzwr1kxvjVd/T6f3mqbxqzinwQLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=j7F4OhupuEb6jt4oCrBdO2k5ZYwBESobEAtwAMK2gYE=;
        b=7u6h8N79zsdvB0gaYxARKSHnjKofxZZg80xqlJkZCgmwJOhPds5xyWJOJPZdER5Erz
         bBMOlEgaAXoMzCpDxA7kl6VNqAt8Q0IDK+4Sy1d9r1ga9/4XUj98Aj1Fgwg7q1c0++7n
         coTofkDkVJsNKAsUoEZzgO16Cvkj73Pc9PN3H3ZaTK9jG6Jf12ZT6QM3JiCFltZ6opCQ
         Zgd/10H5FeuP1hMr9hGCceksbwiOolMthGRWMJxT1AIHTqFRisMOzTtU37SwPfCbN5iK
         +dJACkKVW4UIIOQJaOphWDVR14wKwnOLfefEys5Z2F6nnYMeZmlHTI6yCkWp2X5eQPVR
         VNQw==
X-Gm-Message-State: AOAM532VFb67s9wvuUZtw/h/t6jATwljJgvvfU51xGa4IB0d+v1BEVNe
        W5S1Pt2rW0NgKJ/dQ0w++4zC8Q==
X-Google-Smtp-Source: ABdhPJygNeXQKoTJzVhhCRvRmxlTV1a88tZZk81IsttCzR2c9PKQ19nOgodRrh78dqHj8mHFm94UkQ==
X-Received: by 2002:a05:622a:1651:: with SMTP id y17mr10295686qtj.332.1631714313291;
        Wed, 15 Sep 2021 06:58:33 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id z6sm52309qke.24.2021.09.15.06.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 06:58:32 -0700 (PDT)
Message-ID: <b90db9e7-9b6b-c415-d087-3505ba0be0d6@labbott.name>
Date:   Wed, 15 Sep 2021 09:58:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
Content-Language: en-US
From:   Laura Abbott <laura@labbott.name>
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
References: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
In-Reply-To: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 12:49, Laura Abbott wrote:
> Hi,
> 
> Reminder that the Linux Foundation Technical Advisory Board (TAB) annual
> election will be held virtually during the 2021 Kernel Summit and Linux
> Plumbers Conference. Voting will run from September 20th to September
> 23rd 16:00 GMT-4 (US/Eastern). The voting criteria for the 2021 election
> are:
> 
> There exist three kernel commits in a mainline or stable released
> kernel that both
> - Have a commit date in the year 2020 or 2021
> - Contain an e-mail address in one of the following tags or merged
> tags (e.g. Reviewed-and-tested-by)
> -- Signed-off-by
> -- Tested-by
> -- Reported-by
> -- Reviewed-by
> -- Acked-by
> 
> If you have more than 50 commits that meet this requirement you will
> receive a ballot automatically.
> 
> If you have between 3 and 49 commits that meet this requirement please
> e-mail tab-elections@lists.linuxfoundation.org to request your ballot.
> We strongly encourage everyone who meets this criteria to request a
> ballot.
> 
> We will be using Condorcet Internet Voting
> Service (CIVS) https://civs1.civs.us/ . This is a voting service
> focused on security and privacy. There are sample polls on the
> website if you would like to see what a ballot will look like.
> 
> If you have any questions please e-mail 
> tab-elections@lists.linuxfoundation.org.
> 
> Thanks,
> Laura
> 
> P.S. Please also consider this another reminder to consider running for
> the TAB as well

Final reminder: please remember to request your ballot for the TAB
elections. If you know others who are eligible please encourage
them to request a ballot as well.
