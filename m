Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A09348362
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhCXVFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:05:23 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50145 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbhCXVFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:05:04 -0400
Received: by mail-il1-f198.google.com with SMTP id k10so2610277ilv.16
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mROZGZumZQMQOnoXlCDQGKmXabY17Zv1cEv6eXCZ7B0=;
        b=S2pLyhA/NEj9BGO1YslGLSxw6pIPqv3/9e+bqSm1U74sopRxPzW/JHSlECHqWBe7JY
         DtOSekUaN/xCoE54cJUVyGMk6m7B+02ojvFhprgsbd84sBVBwa3dkkslzqUkJuCBNduH
         VqibRSJKh8xV8QJHoGwCCoKSjTQWFvIa0hxPRu/T6EhI1+cH4sURe6ESUJ9U9YOrZTi9
         kCw4VhhX6Qn4IF+xgSNMQ43ivY0WAV3Cb1A+ItjbcyTA0sKfNDLN9moAAZBve/xU07JA
         ro8l+aQjI31UAeYOSyHsRuAPWe8p6IYAg3q7SkSeADfSD1INB7Ov56tZx+6TWglqRwx3
         7agw==
X-Gm-Message-State: AOAM530Zbu7yybT8EMqcicSksnWuzV+16zO3ENdKfIrSsP5WRDtRlW8S
        +wDXpYjWnxV3N72aQGdTJZoPmzHUq/aiR+mu226SzpsV2Ei+
X-Google-Smtp-Source: ABdhPJxSQCYWCzJpObAUcnvHHXPhUoZV/3wVmPom/l/7dIKev7tSKi/BGuOV4CxSH82tmIoAzqZDTyCoOH8IYSWW3GGqEgqhMaRl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218f:: with SMTP id s15mr4724845jaj.58.1616619904161;
 Wed, 24 Mar 2021 14:05:04 -0700 (PDT)
Date:   Wed, 24 Mar 2021 14:05:04 -0700
In-Reply-To: <34e31fabb228da3cca292e6496dfa8a79c25c7d8.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fdd8305be4ea7a9@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in vhci_hub_control (2)
From:   syzbot <syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, musamaanjum@gmail.com, shuah@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com

Tested on:

commit:         84196390 Merge tag 'selinux-pr-20210322' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b6433fa3370faed
dashboard link: https://syzkaller.appspot.com/bug?extid=3dea30b047f41084de66
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1702d621d00000

Note: testing is done by a robot and is best-effort only.
