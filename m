Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA66405B44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhIIQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhIIQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:50:50 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0549C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:49:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c19so1989675qte.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7EsbivK71P1e8bO206IiNcmpNFbYB/rwlYkekF7WVpA=;
        b=rg22EH8oPa2UtSFo4o58oKKq0IgbnmTiFcU5r2NQn36mpg3WhfVpH2yC1rTYNi2rEj
         Pa6uTEAcCm3dTFqMZyQiAJRn5G/guuoepQG2NdzsE44OD4HeVn39EZZf068fY7InA+yY
         d2xDr0F1L57JC8/Vxr/HU+u39UmoUQVYoiZLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7EsbivK71P1e8bO206IiNcmpNFbYB/rwlYkekF7WVpA=;
        b=O2ccQwvFQmt59BAuiASXKb29WfLRlOgyuKtQISDICpbRw7ZyEeAm67Yazpam+4ie6L
         CZOH1egjlW7GYnDMSn84yOvo/tY4Q67P3OP2QxQ0gC24Jyd6/GV84GtVhuTR/whhcyXn
         +pwU5asm6cx4z4g8+zfd2267/NDa7lKhWxlSQUc2c+ekbfrrmQz/NWU9LDJPYpPNZbLW
         kRgKyyTe6h4HdEX34/DBucxAtgg8upItks6ES50m0fTklKgguiPYBDkPDCEgTmErX7Sl
         VI3lrW4LdJHiltVhCgo3IBIL6/r6ggn7EvNxAHdVOouOhkvRtd6T2/X6WTjipcqOUDod
         FK0Q==
X-Gm-Message-State: AOAM531qJhbuMnZfRfEVKcaBS9ABuG7IdZ2JmBzRgEYdqWYz6cs33UJC
        XaDhLfAVS86pOHHaHyCkeQv/PRFJdizjZQ==
X-Google-Smtp-Source: ABdhPJyHiFTiCv41LoyjxABqn9ZNC1MT0IdS8abyUHfAvtnIw9vRkaq0eOknKr9nLtClttE8V53AYA==
X-Received: by 2002:ac8:7f83:: with SMTP id z3mr3921439qtj.346.1631206180012;
        Thu, 09 Sep 2021 09:49:40 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id f20sm1612683qka.64.2021.09.09.09.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 09:49:39 -0700 (PDT)
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
From:   Laura Abbott <laura@labbott.name>
Subject: Reminder: Voting procedures for the Linux Foundation Technical
 Advisory Board
Message-ID: <fccbdadc-a57a-f6fe-68d2-0fbac2fd6b81@labbott.name>
Date:   Thu, 9 Sep 2021 12:49:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reminder that the Linux Foundation Technical Advisory Board (TAB) annual
election will be held virtually during the 2021 Kernel Summit and Linux
Plumbers Conference. Voting will run from September 20th to September
23rd 16:00 GMT-4 (US/Eastern). The voting criteria for the 2021 election
are:

There exist three kernel commits in a mainline or stable released
kernel that both
- Have a commit date in the year 2020 or 2021
- Contain an e-mail address in one of the following tags or merged
tags (e.g. Reviewed-and-tested-by)
-- Signed-off-by
-- Tested-by
-- Reported-by
-- Reviewed-by
-- Acked-by

If you have more than 50 commits that meet this requirement you will
receive a ballot automatically.

If you have between 3 and 49 commits that meet this requirement please
e-mail tab-elections@lists.linuxfoundation.org to request your ballot.
We strongly encourage everyone who meets this criteria to request a
ballot.

We will be using Condorcet Internet Voting
Service (CIVS) https://civs1.civs.us/ . This is a voting service
focused on security and privacy. There are sample polls on the
website if you would like to see what a ballot will look like.

If you have any questions please e-mail 
tab-elections@lists.linuxfoundation.org.

Thanks,
Laura

P.S. Please also consider this another reminder to consider running for
the TAB as well
