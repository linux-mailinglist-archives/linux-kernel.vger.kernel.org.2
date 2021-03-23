Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340A23460C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCWN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:59:35 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:44435 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhCWN7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:59:07 -0400
Received: by mail-il1-f198.google.com with SMTP id j18so1801303ila.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=IhKG3MYgdHkC79O+28ScN5gOw2LVA4+B7uHCcbfLc28=;
        b=YfS2LC08n3fk4aAShENxpGXlPS94TsAwgzb25UevSBDRuFMLt116kni/gSEzXCsBvE
         eViazw4dvH3ThZvR7eQhpdpG3mBpcseeHF4rzLslW9cEJoYGXD30zhAyD2e5OoV5S7yn
         IpYkb+SsoMrO7arjhby5ymrgCYecyFnHGIIYUqyBo+CZL5+OQHpeGyxt+7Y9BKbzs4w5
         TzBpvWQk/tHD4UNDm+x4X4gePgdcqGae1bMtu93lKniEdO70oMtuspsaQfKxZK6I6Bw2
         W1D8pwndQHUfrb0HqS5RKmXPTSjPv7Q0lv/o9q0SHKhhOFWOMVTgKZth+yfQTmrRsl7h
         oHtg==
X-Gm-Message-State: AOAM530MLyG9nUtiIcd52bWIFyX1D6f6rAbSRmEicGXsQzQcOtjbYP4s
        gKYBPwB/uKCyjbUCDrQqJIfsKfgHGFDyDNyiab7akiu2F0+1
X-Google-Smtp-Source: ABdhPJznONeEXXNXWc8KKHAP754N/Il2V1ODQj7xOqaRoQuL//ZMBvASsl6/iQv87QKzZzrkRCzzIVZkmvMQ88laL/n9jzENPm85
MIME-Version: 1.0
X-Received: by 2002:a02:8545:: with SMTP id g63mr4590835jai.79.1616507947073;
 Tue, 23 Mar 2021 06:59:07 -0700 (PDT)
Date:   Tue, 23 Mar 2021 06:59:07 -0700
In-Reply-To: <e339a963-8ccf-eb47-c155-640b848f29a7@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6475505be3495c0@google.com>
Subject: Re: [syzbot] WARNING in io_wq_destroy
From:   syzbot <syzbot+831debb250650baf4827@syzkaller.appspotmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.dk/linux-block wq-no-manager

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Jens Axboe
>
