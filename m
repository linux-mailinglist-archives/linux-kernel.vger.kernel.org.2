Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C22441B91
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhKANSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:18:45 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:33431 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKANSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:18:44 -0400
Received: by mail-il1-f200.google.com with SMTP id m7-20020a056e021c2700b00259bf1e38b1so10127962ilh.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 06:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gt2XnhzY8fDS+SgeNfM/Uab1dWqIkAJn0jd2H/ERAws=;
        b=qpqyjkacK/LljxXBKQ3mJ5PfBuQsvcmPOiwLK2tCKkQqcjamtxhkRsnSC32Q7LGqsr
         hlzMZFZqp9zeyiteLOyMrwaY3+3Lov5hvrXKXV3go+06ApxpxsbKZ5nT+ra7sfzN+BuJ
         SRNqmYHZ0iv6GjqC0ax/mIbzv74pFbeXFbqX+DTjFSg6JconANUPHGAkCrUXAzZBgyBH
         uc1rCQqbw63ra7w5a0/NAHUzm7yXKHPcvrP3yyx+YMC/jQ1YLU4wOxKBazK4GB+KMQSb
         rBCTPujO+YtxSVis8vDgfWXM5OS7aCjooWtiXnHd7cAd8zQqBdeU4zenqEHd2efJrAyM
         xieA==
X-Gm-Message-State: AOAM532BIeB7SW29jdKHL75Cwv9YdrJDmvcyqIzliWPLibYcfPAsXLnu
        9d46faE+CRONcH2Pt2U734KyEt4lbatg/XMD9N/S8m7yVf1E
X-Google-Smtp-Source: ABdhPJygvpMoysiFZMBOQUyz3LUgeuSlsCMSsz+vxGrqQK4ulKv05XNBG1CFhA4ZkcGq4EQP7/OZF4WQgXd+fDJsPHikb/WL5tKV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:: with SMTP id m10mr6772343ilh.192.1635772570980;
 Mon, 01 Nov 2021 06:16:10 -0700 (PDT)
Date:   Mon, 01 Nov 2021 06:16:10 -0700
In-Reply-To: <f3de46fd-2159-6843-d2da-9a7a6a46b6c9@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006d69c05cfb9fb2c@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __blk_mq_alloc_requests
From:   syzbot <syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com

Tested on:

commit:         d1c2a961 Merge branch 'for-5.16/block' into for-next
git tree:       git://git.kernel.dk/linux-block for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bfca9240a79435af
dashboard link: https://syzkaller.appspot.com/bug?extid=cd20829ac44b92bf6ed0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
