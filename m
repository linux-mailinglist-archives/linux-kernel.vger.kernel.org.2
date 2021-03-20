Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CD342BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCTLND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhCTLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A9C06178A;
        Sat, 20 Mar 2021 03:33:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c17so10356262ilj.7;
        Sat, 20 Mar 2021 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xaGlk2i4k4xjrgxv5GCvNM+Vcz1bxTHvvKwGlfw7Mxg=;
        b=XLrdFwzHA9lCbJzFer+aRn0FKRE/KKbYX4paLFhRsCU2OWn6bg2V7Yt782lecLwIZk
         3xS9SaJa8ecMvkxrRrr96vjN/5P1nrseX36JbMKoUgG1XoQNf4yILRr08n9P4dEAfVFN
         ndy4fyuIlVjfPCPb0nTDXTp9/yZ98DMLPTEmc6Tu4u2WC4ydAlu2VyjCOKNGhhXI/W2s
         GBKYw49T0i/luT3ABpb9oQcw5F/5XFbwNiSbXBknAC+ifddjsWO/UXPe88yJBfBeVWKC
         xt53hOZwHqc6xDLuhN4pc90scHhqsAZEdskl3yoVoGdd07GWJGYzw1ntC6TizMIDIweT
         QiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xaGlk2i4k4xjrgxv5GCvNM+Vcz1bxTHvvKwGlfw7Mxg=;
        b=lnw//37UHz+DnQbZD8lQaFYQTtvUwf6wSXiRJaVBFG9/OMO5m9H5UnwT6m86sjJiPe
         q7DkEYF6xfu3C3iThF0wBdWJeRrj5SJquyg3LPkxENp53y4XzaJxgfo/7/XUevAewPbf
         Jm7ldOl0ZB2PJQWub1Z8o4EmHoZdzBf9r3ofvL3JZiutxFUlSD9lG1w8nW4ARwZxUYrT
         jLdfzJ2StO9X9e/BQXBaYKiScCfKNgmlJ978DOj0O9uS72fzirFNT2ULwtmyDabxmWcn
         rhvz2jaBFGXVemAfkntH8QAVTesl5YVyxNDk0RddiMZsRjcsdRptv7E5YbE+hHtcZm52
         hnRw==
X-Gm-Message-State: AOAM5305GlFXow+kdY5w8wp3D6irHr/ejPG3aHW0zTNsjM6qBmrNtfJu
        QQizhdZGZxN2gfaQvXzaI+3I5+SP7yPfJA==
X-Google-Smtp-Source: ABdhPJxhsvRW3v+zrvOebXyKVredO5FCmhgmS1lkDZIvenC/aYsSzP3zHXlvcArWWKvhynF18VCdNQ==
X-Received: by 2002:a63:a547:: with SMTP id r7mr15162795pgu.186.1616223211846;
        Fri, 19 Mar 2021 23:53:31 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:1ce8:18d9:6e3d:8c29? ([2405:201:600d:a089:1ce8:18d9:6e3d:8c29])
        by smtp.gmail.com with ESMTPSA id i7sm7513423pfq.184.2021.03.19.23.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 23:53:31 -0700 (PDT)
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
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
From:   Aditya <yashsri421@gmail.com>
Message-ID: <99a21e10-266e-b997-7048-c29a570afe0b@gmail.com>
Date:   Sat, 20 Mar 2021 12:23:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8fgpbpx.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/3/21 11:48 pm, Jonathan Corbet wrote:
> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
> 
>> Yeah, and as this line-counting is really just a poor man's
>> heuristics, we might just be better to really turn this heuristics
>> into a dedicated cleanup warning script, then we can check for more
>> indicators, such as "does it contain the word Copyright" somewhere in
>> the kernel-doc comment, which tells us even more that this is not a
>> kernel-doc as we would expect it.
> 
> I really don't think we need that kind of heuristic.  The format of
> kerneldoc comments is fairly rigid; it shouldn't be too hard to pick out
> the /** comments that don't fit that format, right?  Am I missing
> something there?
> 
> Thanks,
> 
> jon
> 

Thanks for the inputs Lukas and Jonathan. I shall try to come up with
something.

Thanks
Aditya
