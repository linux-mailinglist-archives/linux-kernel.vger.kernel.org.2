Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7823441B67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhKANBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhKANBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:01:08 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE7EC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 05:58:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j28so11932062ila.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0i1TUXds+hETNA9yyCDE97aWcP5kn/b/jmxNhdk+IQY=;
        b=3L0jadcQs0aH5YVGsm8khtu/wrj/UzkiB4ehQzQfhd4otl+x9riBFmmvWP246RIm4o
         zkVIdk/sCTG9306kGnchSy++HLylitGTvoQczPT8KqhHBWEwZptWZ8H5e/0AH2YDyAzI
         +lsq7cALmz9kZZOPQ3yo9Fz3dpaOqQiRptshS5gmgv7oJVRSL/wuR42Xd5dby+Isy2dl
         dhWYCK9Nj+osK1wWnJj8xXDF/HEt/Gj5TAJAWoj/pQG5eEVKvNI5ZdYcmPFsyl1FD5aQ
         T/3nnCJuzhpLjDRpCdC6q6JsAJKL9DbtMgSesXezWVAEl0LSV5NQbKSjvyk7QcOwwcm+
         1tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0i1TUXds+hETNA9yyCDE97aWcP5kn/b/jmxNhdk+IQY=;
        b=09PghWUaAjpeMXj4/QghzOXPexxNpWxEzQTUX7dtnuyS4Xh9FEHhGxwgFlG8GBBE2a
         20VdzFV+RLCkmgNiGIJb+lBPOoLaF2E9tw2rQpqm5wgxc3Z/wpqzDAg2E9AqAyReT6Kg
         bOW5ZRTCZODfyp1wW9lpa2lwRZ48tJjZCww1yIhwxq51e8DX1NwAx69BQFtWVdSmqCyQ
         z/wzFcIiBn361KmDL3TOB1M6RFtd0Eh+f3VbqT3rOES0GJQQ+ELgtf7qXB2SI+Ck9dIX
         gAaDrb0rHBf226McT9PPvbahpl2nE+1T5HBTZBU5WYXJ6VkKHsKmxFhlLPaJ8kZU5At/
         J4KA==
X-Gm-Message-State: AOAM533wJ/ruWiYTRirxwud8uhb/uOo+nXipGmSYBxJ/AvcYLBKF+3Fo
        9xW0f83ViXzeVYhSkEebkXEAHA==
X-Google-Smtp-Source: ABdhPJzLLVAhR4iCsqJaAh2d8tBpAYhUSQ1AbZIaClzoio8aRGdlDWX3ki0DGo5DLZCeGTa4OM0VaQ==
X-Received: by 2002:a05:6e02:1c87:: with SMTP id w7mr7846009ill.244.1635771514677;
        Mon, 01 Nov 2021 05:58:34 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a14sm8430155ilv.86.2021.11.01.05.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 05:58:34 -0700 (PDT)
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 __blk_mq_alloc_requests
To:     syzbot <syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000028c58805cfb9a28f@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3de46fd-2159-6843-d2da-9a7a6a46b6c9@kernel.dk>
Date:   Mon, 1 Nov 2021 06:58:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000028c58805cfb9a28f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 6:51 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    503f375baa99 Add linux-next specific files for 20211028
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14688302b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aa50dda6b6975803
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd20829ac44b92bf6ed0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1385446ab00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fc8c6ab00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com
#syz test: git://git.kernel.dk/linux-block for-next

-- 
Jens Axboe

