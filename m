Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A15452E23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhKPJlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:41:18 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36591 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhKPJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:41:12 -0500
Received: by mail-il1-f197.google.com with SMTP id i9-20020a056e0212c900b0026ee2c287baso12384642ilm.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lD9ITBQAqmHKmaR4JcitwLZbpe4xJzo8NE6DXicvXsc=;
        b=gaACTt6ow89y/LzJJIqJwzmEbyCIySztoqaxMbRjeH+sHmd7b9cosej0/xdTnjUMyp
         4uYF3lBaw/5M4BATJmgOrYbPL73vtRm49DyYRH8l/+N+chE/j3ziztc78cy5UHNpXQv2
         tukc1cPVaptDa+Tg7CW1M5P/VBjNUTn64MlCAbPdXmqR28R3lk1kQtecNKNcKIMDQO18
         wdYo31yNVYbj6UDJsvWptaC6mqQrlF0yxaIpZIij2mdUnLsefS7XZktY8PsbJ3KddSr1
         6M6Uv4mFDAgHGvaeluj/5oLuZJyDKVDrStuRxo2jBnqo3BY3yVIw4Ku9KDQLeTecbsah
         wPNg==
X-Gm-Message-State: AOAM533E/g9njXrtc2cV9HFvpDUkGemzn2ePVdkTcWpgYX7TJytO7Ptq
        ENrJnADFgEW924Nf9o9fLIk8OSbWSvodwIHom6JgslIrtsNU
X-Google-Smtp-Source: ABdhPJy5NRG18dEiiqCnNnGYbRkLksczU+d0MiLdllFOIAkk6SPoaxtqxXkkumYuAKk9Y1lRiAm0V87RNvJI5wRNbr59HKF/8KTw
MIME-Version: 1.0
X-Received: by 2002:a92:cf4b:: with SMTP id c11mr2999306ilr.88.1637055493438;
 Tue, 16 Nov 2021 01:38:13 -0800 (PST)
Date:   Tue, 16 Nov 2021 01:38:13 -0800
In-Reply-To: <3786254.cann4MMnV1@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a01bf05d0e4af91@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
From:   syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
To:     elver@google.com, fmdefrancesco@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com

Tested on:

commit:         8ab77458 Merge tag 'trace-v5.16-5' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2db820d271ec6d2
dashboard link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149be83eb00000

Note: testing is done by a robot and is best-effort only.
