Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE338F403
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhEXUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:01:46 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44731 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhEXUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:01:43 -0400
Received: by mail-io1-f70.google.com with SMTP id z25-20020a05660200d9b02903de90ff885fso28570170ioe.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UxdQh88rvBJTStyCsXUz5phO00MIhSQveuUIqhOKQ3E=;
        b=fKXeqUQa6Aq91hll1vdKBSb87BFzJ/cPxqXtDaE4FoVuQTNdXaPtrGKn2ClqTivFE+
         1T5tJKbbnVQYQKnW75JNOEO4HVahf3m2bNiJC+CDGGke9T2FPniNJ4HMaOZQ6GAEb6Sc
         gOAgkYEzxP8r0y2XmGrtQ+FfsnJHwfxFbfSM+JC/MLxXfJvmW7iY+YmlihlnhFhPXseS
         2mrcRnCKApbnk0nvzby4YCVpZvdWDNLKJs7yD6453AwItMh9qmj7maM0M3usbkMSWewA
         t/5fUhc95XHXkwFRun1WaogjbqvGjauLt6OTb/mXg4ku0KHdekLatwaHaEW55ppXv1sN
         sW1w==
X-Gm-Message-State: AOAM531O5jimPhyr0x10EKCozgaoSqP54+qnceH9MRWGqhVGxtMXM62Q
        C+iamfUwkLLVubQ/dQMSTPxJVW20fp/l+8+6EXxkAVlCsFz4
X-Google-Smtp-Source: ABdhPJxBi9ip3XWcomrql0oioeeL8xRGVpJK0qKKtYMWiP0u+HE6DkjDMrYcciPvJA3Bp7ydRzWdBAtUfomYqbdUm+Mmr4rBOuba
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14cd:: with SMTP id b13mr8633555iow.163.1621886413024;
 Mon, 24 May 2021 13:00:13 -0700 (PDT)
Date:   Mon, 24 May 2021 13:00:13 -0700
In-Reply-To: <20210524224449.544eab2f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083b7cf05c318db2c@google.com>
Subject: Re: [syzbot] memory leak in smsc75xx_bind
From:   syzbot <syzbot+b558506ba8165425fee2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, steve.glendinning@shawell.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b558506ba8165425fee2@syzkaller.appspotmail.com

Tested on:

commit:         1434a312 Merge branch 'for-5.13-fixes' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb6cff3094efa258
dashboard link: https://syzkaller.appspot.com/bug?extid=b558506ba8165425fee2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dfdf1dd00000

Note: testing is done by a robot and is best-effort only.
