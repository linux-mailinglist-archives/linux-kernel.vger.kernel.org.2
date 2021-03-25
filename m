Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA06349A96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCYTlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhCYTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:41:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D047C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:41:00 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id 19so3140246ilj.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=clN4iC9HkbcVp9or8nd11n5BRZo9b6ciBBEd3z5M6R8=;
        b=tgJ/7YkwWoFgQk92tCce4LujIppTQLnjaZkN+uY0/Q1T8omSmLXq7wYifp4Qke8aTV
         bdSXwFuA4x3K6yT1lGhEXdpstuJQMjY9pBnOYDzEyBzgv3yq41JKzvR9QHXYNDS9/F/B
         ZAQgZKTUzShKmVCL6ti6NoTrET+cPhevxdWKL52m9P/FyW8MmgxoSIpXhYUFkYaxFYBY
         /Tye0mE4XjxZB7+pvVXrh4HQqpF0QVWY6kTpf5jtxG/An+I7SmVr81Nux6+heVy/HRHo
         nlGMTNL9xLvoa5az5nPa1jv3uXsnnbMC62JYGRCMRqeP0Kgo9fOMwcaMow8P4LHPdzSo
         Q/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=clN4iC9HkbcVp9or8nd11n5BRZo9b6ciBBEd3z5M6R8=;
        b=k7V6SoF4nzAKAGmmEBGmePNvLEAtHo+EiYMPFHH2wWVXk0JZYeJ+SnwYx90BSdVvnA
         DqU6wpIpUlCKN4XmcpHuhpbH4kxA7kkSDo34ZkMGIa2rFcCi2O0FNfSQcrvOGvuKYwGw
         ncT1al1uh2eFMjyj4UvaPqy6GJjCSY+QnotbkkyRoh4qUH5D0R/jBoIIVm6dgTBlrtVq
         lEi9Dcn7qObjd4bNRXcXOQlq+C7B7oGCIuNYMI0K6SOyrjGyaAL7dMbDta56ZQnoLbXH
         vkTLMI1bauggDVdcP7NMrlDDjxug4Z5IGArnqu1Cz+HCw8jETvfAYMQhbWZZXdo/umR+
         WZ5g==
X-Gm-Message-State: AOAM531BovQih5L6HigS+eck/YIchAvqLBEyWFjxtRCogX+NYNb7Y3Yd
        zr7yIYUxOyJFCDbL5k1MxirUuA==
X-Google-Smtp-Source: ABdhPJyeTALlRoxzUZfjQ8pHYLrJiXspny/Ug6SHgAMjSsEVt8ygPJ5ZlveW8VDNUrc37UGdXZMPQQ==
X-Received: by 2002:a05:6e02:1069:: with SMTP id q9mr8138332ilj.97.1616701259682;
        Thu, 25 Mar 2021 12:40:59 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v17sm3074402ios.46.2021.03.25.12.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 12:40:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
References: <20210325164343.807498-1-axboe@kernel.dk>
 <m1ft0j3u5k.fsf@fess.ebiederm.org>
 <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97c7c790-35ab-9dbd-78d7-f299f150b3ea@kernel.dk>
Date:   Thu, 25 Mar 2021 13:40:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 1:38 PM, Linus Torvalds wrote:
> On Thu, Mar 25, 2021 at 12:34 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> A quick skim shows that these threads are not showing up anywhere in
>> proc which appears to be a problem, as it hides them from top.
>>
>> Sysadmins need the ability to dig into a system and find out where all
>> their cpu usage or io's have gone when there is a problem.  I general I
>> think this argues that these threads should show up as threads of the
>> process so I am not even certain this is the right fix to deal with gdb.
> 
> Yeah, I do think that hiding them is the wrong model, because it also
> hides them from "ps" etc, which is very wrong.

Totally agree.

> I don't know what the gdb logic is, but maybe there's some other
> option that makes gdb not react to them?

Guess it's time to dig out the gdb source... I'll take a look.

-- 
Jens Axboe

