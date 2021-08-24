Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7AC3F622F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhHXQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhHXQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:05:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:04:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i9so46568131lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5yA2CDTAPJHf5fMUYfdv8CmMkwrZZbXBrgJecnrlodI=;
        b=V/xhUZcTeN8rM/UlFvXxlZZK0bpJLcsxR1zJxhM/5URenoaSDLUNcyb4hA/LMsI911
         pVHHrn0ZwH9n3SU2htHgFy5oMZpbh2ntWoQzTQ7XwmikQzs9Ws9jCxPkP8CZgNnGTy1+
         c6elqs0XmcboSJqKvuonHd0Dokq0xx0ajCb4LGm2QwNv83p8WhPHHIU8QICHtplgKUqn
         eHJy3Fl70m4Rp4AOe3+8Vdj+Ddy672xeOzOamx3bpyyT+AAwwJ2to7O902F6oTSkakYu
         +5F1oTsYguThK3471D52jn7EnJZSqpx+iiVnT7WQh/Lf9J5z96HFGwOGBy5wFjCWevF5
         8F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yA2CDTAPJHf5fMUYfdv8CmMkwrZZbXBrgJecnrlodI=;
        b=bx3VtosJY2TMg1Bfn61EPz0oXB58WqkzXtlWk2mtrT11oVMWbVfqMZkKFn8GNw6Cq/
         BGSBX8qWdjG7NHMHf74aph0MCJa3g2hWOJuEtzUSMYo4lVN6ukybfai4qOVz6ju3743B
         kOkVzGxeqNorMT6CAT+fRCTo2hlbNXbTxx1+gg1MUdb/D1NlijPT2r88TPvviZxeuOJ9
         mf4XfpdqMgLHLZW/jViC5s097Hv4lGUy0OtpO2CLZ0HF6q+uEobRzMMbk4PWKT9deJ7G
         JOUVOvZ7dy3AIUOgY1HSoMKaacPkcmDiEtauT6ipcjWOJPEiquCOaSCnEM2i8LmleI39
         uUOA==
X-Gm-Message-State: AOAM533BoHcdOHNOp43F0Tu+c6qb1f8F/wl6Q6HQ+RIOdXfbaxB0sjFK
        v4MWYVdBVDtm4stSb8lAh24=
X-Google-Smtp-Source: ABdhPJz8LJoNnF3UdJTjfa8tB1RxNU770RdVtrZASUytHz2lEv/vNOHF3eYbgDQ0vMg5ReGLRoF4mA==
X-Received: by 2002:a05:6512:3d12:: with SMTP id d18mr29706484lfv.542.1629821072531;
        Tue, 24 Aug 2021 09:04:32 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id a6sm1965431lfs.160.2021.08.24.09.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:04:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <2327592.S5L5zkRU50@localhost.localdomain>
 <a5bfab84-16cc-52ad-5cdb-038765bf0b36@gmail.com>
 <1730935.6n1DRfr91A@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <8984a400-0d1a-07cc-cff4-c0eeef81fc79@gmail.com>
Date:   Tue, 24 Aug 2021 19:04:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1730935.6n1DRfr91A@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 6:59 PM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 5:43:26 PM CEST Pavel Skripkin wrote:
>> On 8/24/21 6:39 PM, Fabio M. De Francesco wrote:
>> > Oh, I know where it comes from... :)
>> > 
>> > It's a patch of mine that is in the queue, waiting to be reviewed and applied.
>> > Please see: https://lore.kernel.org/lkml/20210819221241.31987-1-fmdefrancesco@gmail.com/
>> > 
>> oh.... there are _a lot_ of pending changes :)
>> 
>> I guess, we need smth like public-mirror with already reviewed and 
>> working changes
> 
> It's becoming a serious problem. A lot of times I see people who is asked to
> rebase and resend, not because they forget to fetch the current tree, instead
> because the tree changes as soon as Greg start to apply the first patches in the
> queue and the other patches at the end of the queue cannot be applied.
> 
> Anyway,I understand that Greg cannot apply a patch at a time soon after
> submission but in the while the queue grows larger and larger.
> 


It can be easily fixed. We need public fork somewhere (github, 
git.kernel.org ...) and we should ask Greg to add remote-branch to his 
tree.

Then one of the maintainers/reviewers should accept patches to this fork 
+ send pull requests every week (I guess).


I can help with picking up and testing after I receive my device and set 
up qemu environment for testing :)




With regards,
Pavel Skripkin
