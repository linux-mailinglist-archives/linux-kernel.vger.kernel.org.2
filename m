Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B483A32E24B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 07:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCEGhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 01:37:06 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:54821 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCEGhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 01:37:05 -0500
Received: by mail-io1-f71.google.com with SMTP id n15so1064363ioh.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 22:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9eaCYfkOQuJEVGK3vD++ucoro9m1dub/WdBbvxw09lQ=;
        b=AICvJmgPPvzrarwSkGzRjt4UBU++7y93vEczIv40HoSdFXY2t3JefNro52Sh5sORKN
         RQ/AXsCpQSooTCyQdJQsf7Jf8yZKnXj0JNSLIW5a+Vc6f45K//eMXZDSd5WS3cAkVSpY
         wVW2ylpJxpUSMozcDH3vAUAFj3ZOES3QqJSTPolNN7qRjRBlobGQzEwHuSwC2bxff94Y
         FDHIJ/biP6a254DlHHVXuxB4daImOacwbi+r47W6Jzd/qczAQnngrVGSFPjw6WYWl46d
         OZl0lg9+xCV7Uq476iDtTj6CpTHwZKyh/lIzY8X1ECBQEjl3pfNsi3Y1pp+lM6pklBWG
         JfuQ==
X-Gm-Message-State: AOAM530ma0Y4BUqjlGnugUYS131w6XATXhHvAVaTFW7o0sGNXH5Dn+qW
        QOP21A5xyMs6hrB1gIT8mC8BS+RaSewV4J7ilCY+qjnfl8LD
X-Google-Smtp-Source: ABdhPJxi5FMb8Gtqz+q8eOcjlJ7eTcYMgt8xt0JDLdD5lcTHbZxuE/yqpKlOFPKmyN37WeK74E03P96+WJLIcvMieDoGzNTvO9hX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e5:: with SMTP id q5mr7133793ilv.131.1614926224754;
 Thu, 04 Mar 2021 22:37:04 -0800 (PST)
Date:   Thu, 04 Mar 2021 22:37:04 -0800
In-Reply-To: <0000000000009b387305bc00fda6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f70f8f05bcc44f14@google.com>
Subject: Re: WARNING in ieee802154_get_llsec_params
From:   syzbot <syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b60673c4c418bef7550d02faf53c34fbfeb366bf
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Mar 3 05:05:15 2020 +0000

    nl802154: add missing attribute validation for dev_type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100b11b0d00000
start commit:   f5427c24 Add linux-next specific files for 20210304
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=120b11b0d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=140b11b0d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7876f68bf0bea99
dashboard link: https://syzkaller.appspot.com/bug?extid=cde43a581a8e5f317bc2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124c7b46d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1276f5b0d00000

Reported-by: syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com
Fixes: b60673c4c418 ("nl802154: add missing attribute validation for dev_type")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
