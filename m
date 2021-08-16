Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2093EDEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhHPVBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:01:43 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46876 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbhHPVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:01:42 -0400
Received: by mail-io1-f71.google.com with SMTP id s6-20020a5ec646000000b005b7f88ffdd3so1770631ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QdxFVZxxVpsbxj2o+V3LRFIQHQQnZrQkJLl5OL4ggRM=;
        b=SrrUqYVlLM7dY/Ck58/YBlSMM+HGjiCpQYbv2/eGL0ob3kQbp1Llo9yOioswEIm8Rd
         kuQ9rAnmYZLrDAZPNlNHS2q6z2W0rHmsuGYBUS+CebOyDySXGvKdazmP5mwXo3ad5/p9
         +PV8VsvCuHONSVU6uQqBV9JZLkSkgPUKwqe8+82zx2wNSxv5Sdd9/ge4M6KSY19XB+T4
         OvQLDXroQneiRNd55TEs69Z415I/wTZRBhxAmQjRGIXbUpR+ADlBEnTN+5qzwKtU8xkt
         pVtepv+bV9AFzBYUy5PCRYEH7tE7s+GI3h+yv/UPXwpk4n4FN5Fk8/S3s5z6+EeMyRyu
         4VvA==
X-Gm-Message-State: AOAM530pvHoigw0yv562P6WggFAKxuc+zag839gkCmk1mc7svn80STzQ
        +VBss34XNb8KjY0VYy/axOZ21sspZ+1kymf6TAwtkakGDotg
X-Google-Smtp-Source: ABdhPJwbLG6x/Nim7U+ZAhIBCiDjR+IfP2PInnWonRdz7ac8GlsIVYJT2H3mkthaKYjCFEL1injmoeKZyfkmc6VcPTKerPKls3PN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:33a2:: with SMTP id h34mr513258jav.43.1629147669921;
 Mon, 16 Aug 2021 14:01:09 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:01:09 -0700
In-Reply-To: <568c354b-6e4b-d15a-613e-3389c99a93a1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027061b05c9b38026@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_req_sync
From:   syzbot <syzbot+be2baed593ea56c6a84c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/hci_core.c:1346:18: error: 'HCI_MAX_TIMEOUT' undeclared (first use in this function); did you mean 'HCI_CMD_TIMEOUT'?


Tested on:

commit:         a2824f19 Merge tag 'mtd/fixes-for-5.14-rc7' of git://g..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=be2baed593ea56c6a84c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145874a6300000

