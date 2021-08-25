Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266D33F7758
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbhHYO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbhHYO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:27:48 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD827C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:27:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e14so27312167qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zxRItIv5/KmrHNklPqLyl6czPSnqTRRvXU2tQu9c+wU=;
        b=I5bg56mae18GQxqYdVd6HpBnK6dCUfvfgN3fDKVzHFe0b9+7QFcVKnsOvgrh39Da8X
         OYXfElQ3/qcIP+ykU0pyzY5UseWsd6AFSErBxPHZ1+K6Nkwtnl+ITFpqKT2Gw7cMmTCJ
         w45q6vbewY5UJM4EseqTZKrjoF2L8DKNk4Z40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zxRItIv5/KmrHNklPqLyl6czPSnqTRRvXU2tQu9c+wU=;
        b=WBspBDZGn9Es0g0Cn1MYJcZkjBdBxnnN4bLvpTwrtfdvhDrhQhJ8iwCMGRBfvnduNh
         N1Au/pQaCxW6WxPeCnCXS26PBZSllNyqGsAadtZxShVx6Z637uPY2HvckwgRDOXIbuDh
         Klvgj9ev/7QN65RYAO+D/ovKmu5CV3G/GNQnFdvzL/NAWu2DzND8cfBp+nmzSf46y7NL
         OY+hsXM/YC7XkgnnCz6zGyjpYgtl4FJl5DG5yLuO0Sl/GWXIL6O65s90tJcVCYq8DO17
         P357KP3jZWHUWekjZjEfV+MaWQVRlaU1Q0iQpUD0imos+pGj4heh++TFAWaxuPnTMcZh
         k5JA==
X-Gm-Message-State: AOAM532jarnDG0AYkG1InwOO4as4kZvcxuYUBH+fj/VlaCetHTov8Ygd
        qtRLnWRl+RgUQStQYhyNLls22cXe2kafiw==
X-Google-Smtp-Source: ABdhPJzHThhSi17JTxaaFEzeYJthssB+RLpahOv95CLKJM6WE5EDCEKxnKRxAdB0s8pFcPGd6XF/Zg==
X-Received: by 2002:a37:e06:: with SMTP id 6mr29250119qko.290.1629901621831;
        Wed, 25 Aug 2021 07:27:01 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id u7sm9100912qtc.75.2021.08.25.07.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:27:01 -0700 (PDT)
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
From:   Laura Abbott <laura@labbott.name>
Subject: Linux Foundation Technical Advisory Board election: call for nominees
Message-ID: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
Date:   Wed, 25 Aug 2021 10:27:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The election for the Linux Foundation Technical Advisory Board (TAB)
will be held virtually during the 2021 Kernel Summit and Linux Plumbers
Conference, September 20th-24th 2021. Nominations for candidates
interested in serving on the TAB are currently being sought.

The TAB serves as the interface between the kernel development community
and the Linux Foundation, advising the Foundation on kernel-related
matters, helping member companies learn to work with the community, and
working to resolve community-related problems (preferably before they
get out of hand). We also support the Code of Conduct committee in
their mission.

Over the last year, matters tended to by the TAB include proposals for
developer workflow improvement, overseeing the Linux Plumbers 
Conference, supporting the review of the University of Minnesota
patches and more.  Minutes from TAB meetings can be found here:

     https://git.kernel.org/pub/scm/docs/tab/tab.git/tree/minutes

The board has ten members, one of whom sits on the Linux Foundation
board of directors.  Half of the board (five members) is elected every
year to serve a two-year term.  The members whose terms are expiring
this year are:

     Greg Kroah-Hartman
     Jonathan Corbet
     Sasha Levin
     Steven Rostedt
     Ted Ts'o

The remaining members' terms will expire in 2022:

     Chris Mason (chair)
     Dan Williams
     Kees Cook
     Laura Abbott
     Christian Brauner

The eligibility to run for the TAB is the same as the voting criteria:

There exist three kernel commits in a mainline or stable released
kernel that:
- Have a commit date in the year 2020 or 2021
- Contain an e-mail address in one of the following tags or merged
tags (e.g. Reviewed-and-tested-by)
-- Signed-off-by
-- Tested-by
-- Reported-by
-- Reviewed-by
-- Acked-by

Please send your nomination to:

     tech-board-discuss@lists.linux-foundation.org

With your nomination, please include a short (<= 200 words) candidate
statement focusing on why you are running and what you hope to
accomplish on the TAB. We will be collecting these statements and making
them publicly available.

The deadline for receiving nominations is 9:00AM GMT-4 (US/Eastern) on
September 20th (the first day of Kernel Summit). Due to the use of
electronic voting, this will be a hard deadline!

As always, please let us know if you have questions (the TAB can be
reached at tab@lists.linuxfoundation.org), and please do consider
running and encouraging others to vote.
