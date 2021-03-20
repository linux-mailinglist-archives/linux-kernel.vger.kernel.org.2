Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399DF342CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 13:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCTMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:45:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8694C061762;
        Sat, 20 Mar 2021 05:45:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y200so7787361pfb.5;
        Sat, 20 Mar 2021 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ErfJAt/mRnqXnYm4yKcWK3E+xKBF1KIHjNRm05dEwgo=;
        b=hXTcIhBPBRlr0bycdoJINwO5S5KzxcgTl/+FD8X8BiD/498zCDr/6abLhbnvG5lRS1
         bXWLT/AgOh06CWltzjPOxC1690Ng3p0avNClSLcwM6fzmHT3YnZbWPHyPr3I56G5fqBp
         9UxnvAUnHEPtm/0Ig6SosTspkSZ9y2ydZuvClR3Pghhfdq601vD7lSWzrS+IW9yfg22u
         63BbJGgfE1pQV3WK80mxh8XSrpJZufV+1hyW+U/F7EqL/QC9QS9zeGSmbOUE9oPkt23K
         PheW2zD5GuO1pHA3iqRvXyctr2zcFrb3Nz9l2tRxbk/9JDq/a/jOy+QmMf62tHTP68cA
         Vgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ErfJAt/mRnqXnYm4yKcWK3E+xKBF1KIHjNRm05dEwgo=;
        b=N0w+PhHnCGvgtzmBkzdgDu/GSYFkXEZZCODWp2zcg0Fi1go9IseiE+1NE2VRz3fT01
         UnllWJE8CnVAnhND9x7iXoZ/Rr04h+YTrvFID4eJ+JkmXh9S8wxu12Z8gAoKtxLwYHMB
         yxj/Xc7a0pD69bg6xU45lINqSb9IYG+UiRb8nGOANC69EqxJzLoqe8TCTtVznq1kHiQy
         PGtlPUQ5f3ehnpKVtE2sStuCwKFGF5yM7ji87nwDRVYnScZCzfjG4JkbDieVtIroUnyG
         rvC0mGKD2cztZu8OaLBwvc1hN+bMqPFzbYcGQ7/K06leQAqOfzpsr/HWY1vPFZqLhJsk
         /O7g==
X-Gm-Message-State: AOAM531bWDDA87npNkYz91zR0qkRv410U8KI0JcZlLw4djgZWkuhJoJf
        0jkjqjHuRFn/u0Y0BiyGGraWJEXBoF21yA==
X-Google-Smtp-Source: ABdhPJyYjTZEParm4KJEnGN9fEm1eobKloCYmqPEEe4IdwIaAE14Hhg6+pdQYrGpyKGCe9AObi4dKQ==
X-Received: by 2002:aa7:952c:0:b029:1f1:533c:40d7 with SMTP id c12-20020aa7952c0000b02901f1533c40d7mr13584388pfp.81.1616244329328;
        Sat, 20 Mar 2021 05:45:29 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:1ce8:18d9:6e3d:8c29? ([2405:201:600d:a089:1ce8:18d9:6e3d:8c29])
        by smtp.gmail.com with ESMTPSA id v27sm8420641pfi.89.2021.03.20.05.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 05:45:28 -0700 (PDT)
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210309125324.4456-1-yashsri421@gmail.com>
 <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
 <871rcg2p8g.fsf@meer.lwn.net>
 <CAKXUXMzwTp1H_vokVEAJSnmm7jNHfWzhhmLfpcrrBD9b8ak+dA@mail.gmail.com>
 <878s6kto3g.fsf@meer.lwn.net>
 <CAKXUXMxWOvM5HRwmAAWEsqQc2k6_ReqRw0uD=VANLO5D7OpFtg@mail.gmail.com>
 <87o8fgpbpx.fsf@meer.lwn.net>
 <99a21e10-266e-b997-7048-c29a570afe0b@gmail.com>
Message-ID: <30051ed8-33e4-a303-199c-f4bdcb0e448a@gmail.com>
Date:   Sat, 20 Mar 2021 18:15:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <99a21e10-266e-b997-7048-c29a570afe0b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/3/21 12:23 pm, Aditya wrote:
> On 18/3/21 11:48 pm, Jonathan Corbet wrote:
>> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>>
>>> Yeah, and as this line-counting is really just a poor man's
>>> heuristics, we might just be better to really turn this heuristics
>>> into a dedicated cleanup warning script, then we can check for more
>>> indicators, such as "does it contain the word Copyright" somewhere in
>>> the kernel-doc comment, which tells us even more that this is not a
>>> kernel-doc as we would expect it.
>>
>> I really don't think we need that kind of heuristic.  The format of
>> kerneldoc comments is fairly rigid; it shouldn't be too hard to pick out
>> the /** comments that don't fit that format, right?  Am I missing
>> something there?
>>
>> Thanks,
>>
>> jon
>>

Hi Lukas and Jon!
I have a question, should I clean up the files with '/**' like
comments in only header lines? Or as we are planning for making it
generic, for other lines as well?

Thanks
Aditya
