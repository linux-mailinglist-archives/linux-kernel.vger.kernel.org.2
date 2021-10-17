Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62F430C89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 00:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbhJQWF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 18:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344737AbhJQWFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 18:05:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2258CC061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 15:03:43 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d11so12879148ilc.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a++EeukHLheQaAyV9/MPOEWxfhGKeLO2fJxeA799MI4=;
        b=jwJaAxsXFjwSP9UUxCP1mNsBL/gJb9sYYNvz5Ea+bTYp7ChX2i3tdiv+CqnhYjXXXS
         tTwP6yqC+DoROopr4qAtgTtuFRt8ghWv+YKvOTF3fkMKncljBicmVC6vktwaGO3URorI
         rLAgl/Kl7yTtdmDVd22SJBNc80ZcAjuErGh9rez1oFFB6KeW++7qbFH0z2X2H/4yU4Oh
         01ZgR98FaruE/K0o5j0EYO0NRjPC/sGl0OLimCpA1EjEuYPxKWK8dhfIZYzJEt1f/Ca4
         dbtcpd2QF1lg3ESVEG3+vr5C0qaHpEh/h4s16qkICJZt6UcWv3EhDJJctkNk9Qb9SWKj
         UEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a++EeukHLheQaAyV9/MPOEWxfhGKeLO2fJxeA799MI4=;
        b=HZHDHi7hocmSYuhd5HlBqvdwtYyQCpCMcogTlDKBNu0jKS5nLdml3HXHMb1a9tb7IB
         ckBXI8dQJ0IzRv3gdVpTVH0sVvCekPuQXguwdnSij8zIqhjYjwUp/YqhhzIZsgJA5D2N
         W6vq2f4RrYyFm2XyeVtHfzdZn/K6I/+GqD1J/OY9cX6GeLYb3yMFEMAI2Mint6dqUCLS
         68D+Y56EKfEjyO+odYfSsS+2zT5JQTim4xdZ0lbW5xG9EB2VJnnADPWtYzKYHtCr5cfb
         8AKPcLO75r+E/4qbmjsrfFQQUHJQKE6GxK/cXuFD+ZsWdVigdnqT3ZVKADGVsIDrtVrr
         FfKQ==
X-Gm-Message-State: AOAM530UZEQoIfh3w+JFu3OROWSuL1D8UrFs0nleRHgX6GYqoekd7fVu
        o6zD+EPqhR/ZW56GboGLdKTXFQ==
X-Google-Smtp-Source: ABdhPJwHjzRFKzWFufectUTBvQGlekfLU+TiHjM9a01CoVk+ADLcYFEtLHi2xTK9v13yo1I2StXLSg==
X-Received: by 2002:a05:6e02:1d1e:: with SMTP id i30mr12174005ila.248.1634508222329;
        Sun, 17 Oct 2021 15:03:42 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i15sm6080256ilb.30.2021.10.17.15.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 15:03:40 -0700 (PDT)
Subject: Re: [syzbot] general protection fault in hctx_lock
To:     syzbot <syzbot+005b78d4c45263d656dd@syzkaller.appspotmail.com>,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000c7c18505ce93467e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23531d29-9d96-6744-bab9-797e65379037@kernel.dk>
Date:   Sun, 17 Oct 2021 16:03:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000c7c18505ce93467e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/21 3:40 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7c832d2f9b95 Add linux-next specific files for 20211015
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e9df10b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
> dashboard link: https://syzkaller.appspot.com/bug?extid=005b78d4c45263d656dd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1154f80cb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1750eeecb00000
> 
> The issue was bisected to:
> 
> commit f328476e373a7ce4b4d16c48fe85571044e025f5
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Oct 12 10:40:45 2021 +0000
> 
>     blk-mq: cleanup blk_mq_submit_bio

It's a potential use-after-free using rq->mq_hctx after inserting a flush.
I'll fold in a fix, as I'm shuffling things around anyway.

-- 
Jens Axboe

