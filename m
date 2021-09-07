Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77B402D93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbhIGRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345629AbhIGRTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:19:54 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E4C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:18:48 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id u4so2638295qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zFBF2FtmVm8morVewaDgIv9w9w1R5lE0wUYJdQqmTWE=;
        b=UwHBl9bVPqFf3uyFwGTx7L6oXVXEGITgZXcCXy+CWGQI3cVuYsMWTCcjuPIzs1ANKn
         SLUoj2QwFZneBI1II9Na28+IEIAKen8NwhI8L7RkJYh8GXfto1vRzYF4KBHpO7knTpCJ
         RzTcMM2PP8bOsOKvDnY/GnFjodnFTtc3Txe9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFBF2FtmVm8morVewaDgIv9w9w1R5lE0wUYJdQqmTWE=;
        b=G3WkAaspF/930udMplaP7C8ViQJXmiSPCnoG03IEL4m6XbjISAVwRB0GqhMcVHX4kC
         Rnnwh7PkpNIvqWeBn/645RIgIIjgVcxN0vOxF5URfg4CFKsvyZOBIK09yotWO+AfauOn
         9Xst+fuc7b0A0iQNDPDMzknMfz1pCjoTuLffBfIGiygD57dTZNWHB391UeHQd6FnAqfT
         U04Wm6NikjDyIxZTaVv8v4jbTt3lzTwdisDV6yM2OXpQp0aifyJIga8PMvP2Qhe7kib8
         0//X2wq7xCYteQoGoViRsdngFPo7h7/pLxxmaBMgSLLydZo8hfCKHrIEleRbwcU2tww4
         VKmg==
X-Gm-Message-State: AOAM530ChMURSLUaddi7ufzZBP3Kid5OY3naP8xCztfRHKmALw5bLr9P
        sVBA+aKcAQli5w4wClMX1zzEXBpHTbqfxw==
X-Google-Smtp-Source: ABdhPJxOOcgEKeWKP4AJio0KjpS65g0Cb+tOC27x2LqIewTkRaUWrUzQIkjOYGk243t1xKTIKty5IQ==
X-Received: by 2002:a0c:e1ce:: with SMTP id v14mr3581882qvl.28.1631035127472;
        Tue, 07 Sep 2021 10:18:47 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id t24sm9642164qkg.28.2021.09.07.10.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:18:47 -0700 (PDT)
Subject: Re: Linux Foundation Technical Advisory Board election: call for
 nominees
From:   Laura Abbott <laura@labbott.name>
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
References: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
Message-ID: <42112cbe-52ab-7e0f-871b-9940e2f37b04@labbott.name>
Date:   Tue, 7 Sep 2021 13:18:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 10:27 AM, Laura Abbott wrote:
> The election for the Linux Foundation Technical Advisory Board (TAB)
> will be held virtually during the 2021 Kernel Summit and Linux Plumbers
> Conference, September 20th-24th 2021. Nominations for candidates
> interested in serving on the TAB are currently being sought.
> 
> The TAB serves as the interface between the kernel development community
> and the Linux Foundation, advising the Foundation on kernel-related
> matters, helping member companies learn to work with the community, and
> working to resolve community-related problems (preferably before they
> get out of hand). We also support the Code of Conduct committee in
> their mission.
> 
> Over the last year, matters tended to by the TAB include proposals for
> developer workflow improvement, overseeing the Linux Plumbers 
> Conference, supporting the review of the University of Minnesota
> patches and more.  Minutes from TAB meetings can be found here:
> 
>      https://git.kernel.org/pub/scm/docs/tab/tab.git/tree/minutes
> 
> The board has ten members, one of whom sits on the Linux Foundation
> board of directors.  Half of the board (five members) is elected every
> year to serve a two-year term.  The members whose terms are expiring
> this year are:
> 
>      Greg Kroah-Hartman
>      Jonathan Corbet
>      Sasha Levin
>      Steven Rostedt
>      Ted Ts'o
> 
> The remaining members' terms will expire in 2022:
> 
>      Chris Mason (chair)
>      Dan Williams
>      Kees Cook
>      Laura Abbott
>      Christian Brauner
> 
> The eligibility to run for the TAB is the same as the voting criteria:
> 
> There exist three kernel commits in a mainline or stable released
> kernel that:
> - Have a commit date in the year 2020 or 2021
> - Contain an e-mail address in one of the following tags or merged
> tags (e.g. Reviewed-and-tested-by)
> -- Signed-off-by
> -- Tested-by
> -- Reported-by
> -- Reviewed-by
> -- Acked-by
> 
> Please send your nomination to:
> 
>      tech-board-discuss@lists.linux-foundation.org
> 
> With your nomination, please include a short (<= 200 words) candidate
> statement focusing on why you are running and what you hope to
> accomplish on the TAB. We will be collecting these statements and making
> them publicly available.
> 
> The deadline for receiving nominations is 9:00AM GMT-4 (US/Eastern) on
> September 20th (the first day of Kernel Summit). Due to the use of
> electronic voting, this will be a hard deadline!
> 
> As always, please let us know if you have questions (the TAB can be
> reached at tab@lists.linuxfoundation.org), and please do consider
> running and encouraging others to vote.

Reminder: Please send in your nominations for the TAB. The deadline is
September 20th.
