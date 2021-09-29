Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5141CA22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbhI2QcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345910AbhI2QcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:32:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51AC061769
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:30:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e15so13215861lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=dpqmTpQas2GBcy9NTLgFKk4Ern9IXCMccxCg1tz7q4s=;
        b=oXEcOolsZBbZpxLkSBI35fjHs9Op71APCDx371q/h3oYjh6pUifwpuVcxBXquaxPLT
         eHoXfuX5rz/05JXUVFAXgD6NfaJAhsHi4gv+erfHgnqqCyEduvlqmujGtVA9JiP78T8h
         EpPlbMFC2iEoi7kxVGgfl9k76fZ0MNySlRafl9qGEQNQ14nVEaL0oJx6Xv1ZGAMqvNPr
         Xd9DNF9oQvRUAaOlvrbz+CmFPPuGUNRaI1HzhPsHZUPCoG3OrAVC4G6Ld++DsSSKS7c+
         RLSiVMemdo7xWCx/AEBaTbgug89p3RQXLJk/OtjwYXYJum8PI69Euxs0VkPrROzqCBmP
         ZIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dpqmTpQas2GBcy9NTLgFKk4Ern9IXCMccxCg1tz7q4s=;
        b=VE4RS5x/utL5dWlBTU7PjO/NuycSLxG07FBdlyS5FckKrb7E1qQdGnlqogWJHJbNvz
         NNkbV+d1Qai1eRrJuNbzLlhF+oPqWPJKSfIq+vwHJaObGjAa88s1EHWveAyROXwVLq2i
         /m52LpeYVUQWx79+yhr5wUj6ZxV98DdZpyges4DP/d8yLTu4x+BeVBk+nyRczM7R1B0F
         gHqs8OE8y7Cfc7mYf3qHSRvza4FeFlV8nDQX0xdzk4rNxVRw/r6u9vk2Tbdm1/S6jOH0
         LG6Slgqjph0eeJbQ6ImWYGCbdGBvht8eLCW2MQOTWYOw4t2/sHsQek+sJV4xSu7lNSs+
         +SNw==
X-Gm-Message-State: AOAM530v3nG7jUowztux7MN1QHqpBip/uh9lyeyvdn5FHQ3IVAvfkxAZ
        /mCa56KIfTIesxAx/oxjdUQ=
X-Google-Smtp-Source: ABdhPJxhDxaP93+TmJlBLgqiuA0R+6nDmzIIcLkpG6ecqrWY2+KCQt1nXQQ4sdDfwaSz9lNOMouvFg==
X-Received: by 2002:a05:651c:289:: with SMTP id b9mr840417ljo.465.1632933019498;
        Wed, 29 Sep 2021 09:30:19 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.149])
        by smtp.gmail.com with ESMTPSA id x23sm40192lfd.136.2021.09.29.09.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 09:30:18 -0700 (PDT)
Message-ID: <79069fea-c0f4-2363-6f58-39396689f95e@gmail.com>
Date:   Wed, 29 Sep 2021 19:30:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [syzbot] memory leak in bsg_register_queue
Content-Language: en-US
To:     syzbot <syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f5edbe05cba2df23@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000f5edbe05cba2df23@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 15:01, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0319b848b155 binfmt: a.out: Fix bogus semicolon
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1776fab5300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d196bb8b1e038c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=cfe9b7cf55bb54ed4e57
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b2e115300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f2147d300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com
> 

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git 
1a0db7744e453844aa2db3f2959aea4a378025ea


With regards,
Pavel Skripkin
