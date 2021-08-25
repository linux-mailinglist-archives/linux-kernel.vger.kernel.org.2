Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F43F773D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbhHYO0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241406AbhHYO0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:26:23 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:37 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id jz1so13809216qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WjKM8CL3vH0BYmBPgF93QuNRkfZ4NCa+wfRQ23BQwRw=;
        b=NW4MFK4nH+Zy9et2Z7+/Rty3fAdaofnRjuTHfH8da1gPvR1hpPP5zmwwcQCspWVLxQ
         9Fhl61jb47Y88bt4kgXQ7riTTYklZ0hc71A3ft9yI1FkoMu/ZO+QKCqSeMTqo6p3fIpm
         petRAg6WidaoFz+TC/Qpd83GXbPC1NNbPtOeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WjKM8CL3vH0BYmBPgF93QuNRkfZ4NCa+wfRQ23BQwRw=;
        b=k4amqiRcrPTWVh2rqR1h0Xck2TLkp+iEv2MwAwZYM5fZQPnwLBNTH7kH6yqY1wGsjU
         i8HuCaRCYULGGGB7WWcsEbbEhMqiEOTsV4bCgl4Bbwb+EwkggX+ivytDy/5dSQT3Bpxt
         QzRp/ddioxHaYxeDEK++gT6TKK+aX/fa1S9umHiCaBWFMfgWpJv6rqoc9seE5p3S6l1I
         uKKk9jWWK4wVKTveYN8WN3e/AOKBFv5zdPbImCMnIfNQx6MlyiRxpRXTv2dC0bWs2Wmb
         KyqkcUCdJvaqTH88oBXVvREhPwQEXuJZn6zbnCmmV3UOBNPqtF4t6XOVKVSDX/xcLeJq
         g/FA==
X-Gm-Message-State: AOAM533G/XjcYIoyPiuYYo0q/STOmTJ+mCIwRJFAi/kcwVziMEQelMXJ
        KgeQHPVnr4ynQUCIZ2P1obJRHA==
X-Google-Smtp-Source: ABdhPJzJm+n0AV1U7o+8RhRgHR6L6pnrMzGrAIMk6bPNDJfSLjfRlH8g2XdLsLuZMIkQ7m3sFqZksg==
X-Received: by 2002:ad4:522c:: with SMTP id r12mr44279608qvq.17.1629901536703;
        Wed, 25 Aug 2021 07:25:36 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id h16sm10116036qtx.23.2021.08.25.07.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:25:36 -0700 (PDT)
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
From:   Laura Abbott <laura@labbott.name>
Subject: Linux Foundation Technical Advisory Board election: procedures
Message-ID: <f744b489-ba9f-8688-1c08-4dd98b9ab22b@labbott.name>
Date:   Wed, 25 Aug 2021 10:25:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On behalf of the Linux Foundation Technical Advisory Board (TAB), I'd
like to announce the voting and nomination procedures for the 2021
election. The TAB has made some changes to its charter regarding voting
procedures. The full changes are still being finalized to be published
but the important parts are:

1) Anyone who is running for the TAB in a given election year must be
eligible to vote in that election.

2) Voting for the TAB election is now completely decoupled from Kernel
Summit and tied to activity in the Linux kernel instead.

TAB voting has been discussed off and on for many years now
(https://lists.linuxfoundation.org/pipermail/tech-board-discuss/2007-August/000029.html 
is one such example) and the TAB has made smaller
changes over the past few years (See
https://lore.kernel.org/ksummit/5A0ABD9B-34F3-44FE-838E-D66F3BB5D15B@labbott.name/ 
and
https://lore.kernel.org/ksummit/ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name/)

The elections will be held virtually during the week of 2021 Kernel
Summit and Linux Plumbers Conference held September 20th-24th.
Nominations are due by 9:00AM GMT-4 (US/Eastern) on September 20th.
Voting will then run from September 23rd 16:00 GMT (US/Eastern).

The following are the eligibility criteria for 2021:

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

The TAB members carefully weighed various options. The goal is to
have a representative voting pool of the upstream kernel community.
This represents a significant increase in the number of people who
are eligible to vote in the TAB elections over just kernel summit
attendees to just over 4000 people in total.

As last year, an online voting platform will be used. To avoid spamming
too many people, ballots will be automatically sent to individuals
who have more than 50 commits in this range. Anyone who has between
3-49 commits that meet the criteria may request a ballot as well.
We have a script to audit all names and catch duplicates (different
e-mails for work vs personal). If you know people who fall into
this category we strongly encourage you to encourage them to vote.

If you have any questions, feel free to reach out to the TAB at
tab@lists.linuxfoundation.org
