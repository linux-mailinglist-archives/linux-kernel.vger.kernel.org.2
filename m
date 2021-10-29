Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4FA4404AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhJ2VOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:14:41 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43712 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2VOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:14:37 -0400
Received: by mail-io1-f71.google.com with SMTP id y11-20020a056602164b00b005de32183909so7605073iow.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 14:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DZhb+VO37XCGG7f7xVXdqzAOL+vfGSVWBL7jiOZyERA=;
        b=IyH0mf0eXkCao2NhBdRmPxU5hwiC8aGusrpDgHYPtFAa8EFuUwJuH5QCA9etANk2uD
         +TcvBSLa95I8PcLzm+Sk430OoCvQKIvy8ym6dZi4/mDO78/ouf53IF/Qb8B4UpbntjsR
         nTXo9MteXB6K9MRqGfnDzYTnjLWA9BIVFrOhsDcd9WACXnIGV6i+K7aLbFZOgRo6l/Ys
         SOWI50bBTlxEXCO4BDzkOedl4zc9nQXG4Y85vo/eAxyCXUkbVMlrLxusUCGvHSfM+wve
         sTWDTx55PddKUhHK/foVez4yqD5jvcNpTzW5SrraTWOYs01GY0epaG0OiV6YRsmls8ED
         ASwA==
X-Gm-Message-State: AOAM532bPWG67JTXqiNUATbYtmiz+xNCd5XSHeQ136lX7ym8SoFB53ia
        TGIUtAwEvhv64NP4AAfNStJ8vNatos+YQStQ0htfKt/pHK6T
X-Google-Smtp-Source: ABdhPJzPFjEpTzpO7k8nLm2VnYMkJSdJGEwdkl7gMHmQZUrJy9wjQWpdZMv7G1boha9IooJCaMCR3FGsNm+zdpT5U5M1CWgLLEsh
MIME-Version: 1.0
X-Received: by 2002:a02:2b08:: with SMTP id h8mr10206922jaa.137.1635541928627;
 Fri, 29 Oct 2021 14:12:08 -0700 (PDT)
Date:   Fri, 29 Oct 2021 14:12:08 -0700
In-Reply-To: <ef1ef79b-af92-863a-c5b9-49ea231c5192@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abd1dc05cf8447ee@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in __io_free_req
From:   syzbot <syzbot+78b76ebc91042904f34e@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.dk/linux-block on commit 3ecd20a9c77c632a5afe4e134781e1629936adab: failed to run ["git" "checkout" "3ecd20a9c77c632a5afe4e134781e1629936adab"]: exit status 128
fatal: reference is not a tree: 3ecd20a9c77c632a5afe4e134781e1629936adab



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.dk/linux-block 3ecd20a9c77c632a5afe4e134781e1629936adab
dashboard link: https://syzkaller.appspot.com/bug?extid=78b76ebc91042904f34e
compiler:       

