Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136C33B3703
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhFXTca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:32:30 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40956 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:32:29 -0400
Received: by mail-io1-f69.google.com with SMTP id l15-20020a5e820f0000b02904bd1794d00eso5259823iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 12:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4GffdjDqZnowU56j73n2EpB/mSqgSUg9fkkvywwXGWo=;
        b=fd2iMoyOVosYkc38NYTks+l5qF0QXEoiHy7uMydaYLUfM39ij02T//4R6DPuvulgQG
         CCti2WhNQLuRBXFS/w920/fZdzl32UPTZ71BZV0F+HrSDtWuHlZ6U2S2xtdmdIdLjcMr
         bBI4+0dT/eYkk2gPamnIAStvEl2LVp3TcLZdnrAwCiiolZUAMMYvNtLHckZsVcggUqIz
         7exOJoVctDkoEubi49qzuiSdX6pk7jWvEf3LAvYhCKdj8ZHrMK/BYfOkYhFUjNvWTEK5
         1qLybTXCqJDucB1ta1/+ZQRkh+UbeEqya8B6MIiMs7cPRzR7C8GOY+WI5z67iz9m41/k
         WE9Q==
X-Gm-Message-State: AOAM531PU1sS6HwkHfyrwxUBxJ3oCCPiPgf3GoAqF1QZmQ/Ct/RLLb7y
        n2ethsXwPJNNpEhn/TeWbUCZMXAhctzec6Ryo2Zypch4nNWT
X-Google-Smtp-Source: ABdhPJwWipLKwHeSiEufevAh3Nge4R6oY7mbwMwSHc2nPMIq4fjeo4QYOzfYGF9eEJI+PQWT0zYAo5nLYRQmNybNfIK1K6Hqgu7I
MIME-Version: 1.0
X-Received: by 2002:a5d:8986:: with SMTP id m6mr5370913iol.87.1624563009800;
 Thu, 24 Jun 2021 12:30:09 -0700 (PDT)
Date:   Thu, 24 Jun 2021 12:30:09 -0700
In-Reply-To: <20210624221244.3529b808@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d4e9805c5880db1@google.com>
Subject: Re: [syzbot] memory leak in xfrm_user_rcv_msg
From:   syzbot <syzbot+fb347cf82c73a90efcca@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fb347cf82c73a90efcca@syzkaller.appspotmail.com

Tested on:

commit:         4a09d388 Merge tag 'mmc-v5.13-rc6' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=be86be9dadf57eea
dashboard link: https://syzkaller.appspot.com/bug?extid=fb347cf82c73a90efcca
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c17dbfd00000

Note: testing is done by a robot and is best-effort only.
