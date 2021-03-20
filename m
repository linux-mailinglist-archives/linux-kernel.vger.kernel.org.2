Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C027342D18
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 14:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCTNd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCTNdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 09:33:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A3C061762;
        Sat, 20 Mar 2021 06:33:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w11so4261346ply.6;
        Sat, 20 Mar 2021 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zel7VqglAbcHE+3PfYSn3C2SSRsn+gUENwKUKP8d3qQ=;
        b=q849W2hb8iEUQSYVDml8xNerfLqjVM6pFSoaH9UQvE023n9zur+gEmAzmxdGYuZlu3
         unuM06eYUZLjfYekvNf+Gbe3I5TL5Jn1jGdFjX2nwWtJxqdqcohdRX7/L3qUROKxQVx/
         gtLCQGOmchV/YYXcsljpbSGQ0o2UO+tdwsaK581Z1mHe2NeiaMnO6SeNpEtILdGg7mAf
         TLPbLqCUooDmf4eGHK5mZNpdyacAnSy6tepkUTgTANu7nDJoWEB6eaIz/fAb0jtgtoin
         xVOeBpPdzYIf+KJua9VPW5pJD6zkkUwXEVgyzfg3dLRuRtemppPnwsfJF2ROoEz0BIMw
         IVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zel7VqglAbcHE+3PfYSn3C2SSRsn+gUENwKUKP8d3qQ=;
        b=YWIrJy4bq20OibGGPkSx7d38dZ96j4n04wL42Peydiq9Gr4jS95xaWPDlQsjieEbjp
         PGLpU/wxLHRF5uBH0amaFzt/j0Npj9UMm2DGmn22e+k1YV7MZyEfIZabRth56rgEejAU
         GZn1osRZu9RenutOn59uEaNl9Gkavs529050DryzuC57BtHgUYBo4ShmW4TJXrQ3KWrS
         TwTdae+pQkifkgf+Tja1YjvK7jd9jPWZKaE0zZPwghs9kePVMF8O6GO4JQkjqj9MDFur
         maWPV57FOGp+ovcBMSHcVlWJadbdU1jC8mzmlwZtCi8gULUNAOf1xYeERFvHrgdoDFqE
         QPXw==
X-Gm-Message-State: AOAM5334YPZzD9BcYVFi4OmsYZ5ktzg+bK0LoX6qrv5SBmSUuWkWsrEH
        LG24EyiLd2JyNhj2CJpiN5w=
X-Google-Smtp-Source: ABdhPJybaAFXeZ6T0sj4b5mmasN9VIRTo3lbhyUoFsf6/R1eDA0zQAxvynj0PQ+s4govMuXMZgnYiA==
X-Received: by 2002:a17:90a:e7cc:: with SMTP id kb12mr3628046pjb.31.1616247192421;
        Sat, 20 Mar 2021 06:33:12 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:1ce8:18d9:6e3d:8c29? ([2405:201:600d:a089:1ce8:18d9:6e3d:8c29])
        by smtp.gmail.com with ESMTPSA id p17sm8386881pjv.49.2021.03.20.06.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 06:33:12 -0700 (PDT)
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Markus Heiser <markus.heiser@darmarit.de>,
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
 <30051ed8-33e4-a303-199c-f4bdcb0e448a@gmail.com>
 <CAKXUXMyQRY9GC7sUG+_W5hQe3EFdvxKrYTEO7JL3E5LD3cCPKQ@mail.gmail.com>
From:   Aditya Srivastava <yashsri421@gmail.com>
Message-ID: <9f5d3dc7-ed79-a420-346a-914004964569@gmail.com>
Date:   Sat, 20 Mar 2021 19:03:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMyQRY9GC7sUG+_W5hQe3EFdvxKrYTEO7JL3E5LD3cCPKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/3/21 6:51 pm, Lukas Bulwahn wrote:
> On Sat, Mar 20, 2021 at 1:45 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>>
>> On 20/3/21 12:23 pm, Aditya wrote:
>>> On 18/3/21 11:48 pm, Jonathan Corbet wrote:
>>>> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>>>>
>>>>> Yeah, and as this line-counting is really just a poor man's
>>>>> heuristics, we might just be better to really turn this heuristics
>>>>> into a dedicated cleanup warning script, then we can check for more
>>>>> indicators, such as "does it contain the word Copyright" somewhere in
>>>>> the kernel-doc comment, which tells us even more that this is not a
>>>>> kernel-doc as we would expect it.
>>>>
>>>> I really don't think we need that kind of heuristic.  The format of
>>>> kerneldoc comments is fairly rigid; it shouldn't be too hard to pick out
>>>> the /** comments that don't fit that format, right?  Am I missing
>>>> something there?
>>>>
>>>> Thanks,
>>>>
>>>> jon
>>>>
>>
>> Hi Lukas and Jon!
>> I have a question, should I clean up the files with '/**' like
>> comments in only header lines? Or as we are planning for making it
>> generic, for other lines as well?
>>
> 
> Aditya, of course, if you can detect and come across some unintended
> '/**' comments in some files, clean them in the same go (as you did
> with ecryptfs).
> 
> I am just worried that if you extend it to the fully generic case,
> that the list of cases simply explodes: showing many 1,000 cases
> across various 1,000 files that need to be cleaned up, and such
> clean-up work is just too much to get done by yourself.
> 
> The current list limited to comments in header lines seems to be a set
> of patches that you can probably get done.
> 

Sounds good, Lukas.

Thanks
Aditya
