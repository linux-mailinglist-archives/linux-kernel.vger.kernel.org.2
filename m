Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A343F62A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHXQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhHXQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:25:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B15C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:24:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so11842754lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/xd7Ft3z6AfgdBMUUGrTVeHJirMdGU4DzFsT8Tnm9iE=;
        b=fm0jkOLnvxsLB+LtmDIo9dIOdBzNOXNrIHyvfgv2nIkhFgAsqUfnB5CVy0KUgn5bOs
         2iAH7X/jWR3pviMYvoCtFatgFjBsIxYCHEfArD5cJLDn2cGZM/BNWe/ELxLFIssjNEwt
         jt+hvmPdlw8tjs9BIipZloh8bWcQjvQtH8KUQzyNqTkeO29zORprx6wkbfmA9eMGYOT1
         jZXWmVy+bFz37x8gOkoqSy40ppBoTNBcO0YHaVjHm1OipD2XCWhFc8L0g//S8/1qY1AG
         l2KHPzv26mfVye0pJrtlZM6I+eqe4no2FQwgtMxwXmeKuglk4hjvWExf/wi+OEDzU+Zi
         0fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xd7Ft3z6AfgdBMUUGrTVeHJirMdGU4DzFsT8Tnm9iE=;
        b=RfUU2gI5QYNCm391V+yeex978N3DOeTZ1o56Yktdz4GLhdpbSqWF005VoGwALRuIGk
         Q4HYoFsMRVTdEXnixgghacVdVVISvoz52ZJl9dVLgBDfaUUnH5mU0oy3Nfmmo3SAKh0p
         H4ZaOEO0gW3LK2V+3ivgSdJp8peAYhMSPatibOx7OD/BKutu4A6fktTPqN+e9P48pFWs
         2KpTyYi9aS9x8yZrKJ8px04fqMzrUc1FRMgN+kh+qT/0gSv6AimCeXE8xkS5B2Mu5K+N
         RhHzQvjQE2ksFXAvDycK0GkxBDsDK3lp0cysVExI/rmQH2jtKPdM2nos+8bCWifqt2qN
         BmYw==
X-Gm-Message-State: AOAM532MjINUPQtof2ZK91uNar78KkTUyexO97jyF00jG4T3wXaisgEN
        OUqq68mGSPyFD6hezR9V1Ok=
X-Google-Smtp-Source: ABdhPJyZZZV+wfrsLmGyU9/XBeGLC39SSrF3yJ5eezzfne8kc8pLLB7b7R+sPXVfEDZ31n3kyDjrMg==
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr29343846lfe.340.1629822295922;
        Tue, 24 Aug 2021 09:24:55 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id d1sm471217lfh.209.2021.08.24.09.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:24:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in
 usbctrl_vendorreq()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <2327592.S5L5zkRU50@localhost.localdomain>
 <a5bfab84-16cc-52ad-5cdb-038765bf0b36@gmail.com>
 <1730935.6n1DRfr91A@localhost.localdomain>
 <8984a400-0d1a-07cc-cff4-c0eeef81fc79@gmail.com> <YSUb1BPAGmP9wngU@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <9f4a66c8-73e3-199c-5d4e-7b6ea495a850@gmail.com>
Date:   Tue, 24 Aug 2021 19:24:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSUb1BPAGmP9wngU@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 7:18 PM, Greg Kroah-Hartman wrote:
>> It can be easily fixed. We need public fork somewhere (github,
>> git.kernel.org ...) and we should ask Greg to add remote-branch to his tree.
> 
> No, not going to happen, sorry.  I will catch up with patches when I get
> the chance and then all will be fine.  This is highly unusual that there

Ok, sorry for this idea, I am not familiar with maintaining process :(

> are loads of people all working on the same staging driver.  No idea why
> everyone jumped on this single one...
> 

My guess is
	1. It's new
	2. There is a lot work to do

> relax, there is no rush here...
> 

We don't try to rush, just discussing. Sorry to bother you :)



With regards,
Pavel Skripkin
