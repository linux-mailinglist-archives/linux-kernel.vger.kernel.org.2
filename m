Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1040C6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhION6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhION6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:58:09 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B940C0613E3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:56:43 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b64so3550167qkg.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=g1W7nkFu71FquB758ZH+G16B1Ve549PwW0sivEWT0R4=;
        b=muP4nCc8ulz6wia9QNmyKCQQhEFtc8unNXBQDW4lJ4Tz3r8Eilz/GzhEG04U+qsHnd
         wqrAQ6RcYmArV9uOd24RIJ6wCQ9S3TzREM8iUflunEZXmuQVKafuMwzN9Rtd0AF5gLiv
         5gNxmzGDHl8P/JwlYeEHtFu0UtLA47+7wEihU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=g1W7nkFu71FquB758ZH+G16B1Ve549PwW0sivEWT0R4=;
        b=Q/2KaEbJZfxAm9PA/gXngshR8ji1wdETFJCRxSqfN23BDArlxk48CciKzSUMB4cv1g
         R8vGy+NsnNHTqUifoM4nBewHmtPKog7oBNGzmhkXreqnaKSQTaODDqvIRhJR3w962bhx
         3ndrXr2xwGu7nRCk/3rf5qqXBBFVcvQ/W8wHEDvd4xD47SdHOEW1kOQ4d2T2tRolZ/DB
         rX8RqBT+8pzSmYnMNIjHBJnwgaGxf+D63LCnxJVQDb0RA4KXatg4j3ur1pgXW+sdgi+w
         MogBGwP/9QaBGiGCPXR7a/Avcvi/vlyWRPha7hCkahVrswCxKKM200jUcinFMMH9RLtI
         V/6g==
X-Gm-Message-State: AOAM531QekAfbJ7LXjEuyDoFf8/0bNo1J/ZgKue7UmhA7zVgZeeQJ5il
        6Jkg4HeZBcKuqVJaxnxxkWQzXfrgJ49xHA==
X-Google-Smtp-Source: ABdhPJx4Hdob/aMAOGVcUID4aj5rmtyioEyRAY/le8QyZJCp/3IZUzn3QB+4x9h/bTSn1qDrJ1SXEQ==
X-Received: by 2002:a05:620a:21dc:: with SMTP id h28mr66363qka.198.1631714202287;
        Wed, 15 Sep 2021 06:56:42 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id d20sm53403qkl.13.2021.09.15.06.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 06:56:41 -0700 (PDT)
Message-ID: <eb330698-2c79-b027-1b96-404aa954277a@labbott.name>
Date:   Wed, 15 Sep 2021 09:56:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Linux Foundation Technical Advisory Board election: call for
 nominees
Content-Language: en-US
From:   Laura Abbott <laura@labbott.name>
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>
References: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
In-Reply-To: <a52baa8b-6743-7570-aaa6-411b5b13c8aa@labbott.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 10:27, Laura Abbott wrote:
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

Final reminder: nominations are due September 20th at 9:00AM GMT-4
(US/Eastern)
