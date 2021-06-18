Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD93AC925
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhFRKvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:51:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48747 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhFRKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:51:15 -0400
Received: by mail-il1-f198.google.com with SMTP id t5-20020a922c050000b02901edcb27f61eso5681973ile.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HrK3zoZ7mBoYxTNh9K06ogvFxCCPaWcCp7U6uUfuszg=;
        b=pD39e1JFuACP/569WFgaS2uTn1hylfLFDefIaqVg2pQyqFIXEBYLHFEUvdcgMw80k2
         pRIPnq2IHFDffnvALhDEzFrw3OSlHm4kRdEDfe1PVrB4/hUZWYdDqFaw1AzhycOI0JET
         kmpziXw/Ql89NuvXYVifMAQYu5bma0d1pCkYcF50Y7a+cpAYPVZmCKBSD8Dw7gX3/ybU
         ZNHLOzYq9/0+VmGiE9ry2uz38po9ZjvmLUTk68FsWNC4i1pI4L8bTbxpwZC14t/vR3LC
         dQzCpbPTB3iLzi4V7z+heR535s422z+3tPhBoxUc9AQjxQBMvSNdh3OuD5t77mZkaKR+
         k8xQ==
X-Gm-Message-State: AOAM533H/YlqS+9SisGRE+dds0yPIm6rNou6oy25/jYFvAV1x8lOJT0s
        aR2BYXkME3kUWFl5dJYSSqXLBdoTMw3qEMZbuYfNpb7FkCg3
X-Google-Smtp-Source: ABdhPJzCs/4OA4IQ6EdpX5w7LDi1TyMBN9jVHynWWJ1IIwL1ilVww+diOFD/9gDfLlvjM0MAPMOEjUjnAUdQpIPV/79GfMvNceNj
MIME-Version: 1.0
X-Received: by 2002:a05:6602:38d:: with SMTP id f13mr7558181iov.109.1624013345667;
 Fri, 18 Jun 2021 03:49:05 -0700 (PDT)
Date:   Fri, 18 Jun 2021 03:49:05 -0700
In-Reply-To: <20210618133112.596c60d8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000943f6e05c50812c3@google.com>
Subject: Re: [syzbot] divide error in ath9k_htc_swba
From:   syzbot <syzbot+90d241d7661ca2493f0b@syzkaller.appspotmail.com>
To:     ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+90d241d7661ca2493f0b@syzkaller.appspotmail.com

Tested on:

commit:         fd0aa1a4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a4fe6d9e0a3e71f
dashboard link: https://syzkaller.appspot.com/bug?extid=90d241d7661ca2493f0b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f9aff0300000

Note: testing is done by a robot and is best-effort only.
