Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8525404365
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 04:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349774AbhIICCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 22:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhIICCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:02:14 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40553C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 19:01:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a22so303838iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Oy5A8PYrCuxEwNcqPutPFjqQJ1l+woiGv/ZNAsuFTUs=;
        b=KtW/t7Psm8GhVojYnQZpdTHgLbyANmRgGMhvw0gs3r7M3zVGG4VIgZaL/34q1JCYKZ
         7L5g8GsjOvXLJgOX2fbnzBVlzw7az5UDm+OJbSlsKg07QkLEijvIQ5oYUOrQ7wwCvHU5
         otYoBW1ajlhlYS9uTuXWUILCBGuIggjOPxlNzjoU+gE2TBNpFsodEMZZW1wfywRtlfst
         fj+9r+dC4O3pRt7Nuly6o42Q0t/tWYPpGbOD7czjmSkRecLchMzD2MJxhL9/EP6nReyp
         oQcAlbIM+exF7Ki5XpOOUv9XQrHcT0iAdX3+SpXVB/iJRLygft/45+cuSVdrE3hy+wXD
         pGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oy5A8PYrCuxEwNcqPutPFjqQJ1l+woiGv/ZNAsuFTUs=;
        b=EOHxrT4Kp+fY0CeiA5Ix/QzUEjYnJuYhoFLKJMMdnnZvjrLeeKBBeqZQlKm8EVxIyf
         iRAB1bjYoFAzTCUFbsYnQPMJjuyWdfev76QrHSOPGudFCY0rZ97m+n33UrHX0xnAzn6W
         b3KPtIqQkNoL/zqNnBPYmsDnDEqRgPIN1pDMFlZCKUL+DQ8dhG6ZjGuYpB7+TEqk4EHI
         Mb8n4YdKLNq6xgD1klJuDVpY4KfsENbhSTQ8GSHjxLgNnKxsck6AUhvxC2+bFV9a5SjD
         WwOzwBoUN3ozggt1uF3Jr9FD3kEvw6+IFu3/7dCaAnFwc/c7YrVa+/S45JaKQNIEPqPt
         dexg==
X-Gm-Message-State: AOAM530qP/WGvhYMsVOfvgdfvqx+1m6gBEBOCGEu9r3OO7Pc8MhS4aWq
        fFPIfN4+sXfLg0j9HdbsxhwL0g==
X-Google-Smtp-Source: ABdhPJz+3VWsj6qLUOS0nV44i7XfUESePxiXfH1wiihdYFoek28nTz7qLML/xJRaJXTdEucfVGnMFw==
X-Received: by 2002:a05:6602:2ac7:: with SMTP id m7mr528771iov.66.1631152865415;
        Wed, 08 Sep 2021 19:01:05 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t11sm202551ilf.16.2021.09.08.19.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 19:01:04 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in io_uring_register
To:     syzbot <syzbot+97fa56483f69d677969f@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000868f9305cb84d318@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9774a34b-93af-5b09-8ad0-fec289d31428@kernel.dk>
Date:   Wed, 8 Sep 2021 20:01:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000868f9305cb84d318@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 6:10 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ac08b1c68d1b Merge tag 'pci-v5.15-changes' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=177842dd300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dc596ab8008badc2
> dashboard link: https://syzkaller.appspot.com/bug?extid=97fa56483f69d677969f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Pushed out a fix for this one.

-- 
Jens Axboe

