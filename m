Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B266943313B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhJSInM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Oct 2021 04:43:12 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48041 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhJSInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:43:11 -0400
Received: by mail-io1-f69.google.com with SMTP id s18-20020a5d9a12000000b005ddc91c47f4so12786318iol.14
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=zmoEaV0HwzX7oDzswsR/tmadU98uVZ2rFKJ//gLFLec=;
        b=b/XmdvQ5Zc4Im/zmUsTBTNimlRXXpx1iNdfJ6qSbcdtyvMecgxjlbwuDjU3BuaDflY
         q56fZQf6WEQXhTTDFdpPS7fHq+MSvrqb7718ijri4pPN0DS/OXG+K1u0wY5nf1d23H1t
         TAgCkqajOLq2SfTQ4HXUx+yqgxeUCi4jqDb3mdZXUaTPmjn6byCnTb6TRMD+KYgARpS7
         2B9v4Ib6ZUajuQ5+o2jExCH7xf7SUiFA5cfNykojsMhTL21yWxNdWsiOqvHEQ78y6Asp
         UQ8MvVV4IsjuxXANElCps95VrVjgCjWSQKMt+xGKE9stupzZP9zdESpTyA0DXMQ5Zijr
         DpnA==
X-Gm-Message-State: AOAM533MZPftbt2uDiedmyMX4KllR6ZABJgy61cLoYd3j/OyK3Ie9zUX
        9k4lFiQoZ2Vbw4kWyxxNBy0sGrHp5D3DUX5ItdtUcSFrE1Qt
X-Google-Smtp-Source: ABdhPJxJiLZQoMLgnK+lCq76ABC1JNwHSYsXZXueokW1agP8zOU7LSqZ97CvfFHXuqHaxTg1WOfjiIcvzD54dN5k2KPtbvRdgz23
MIME-Version: 1.0
X-Received: by 2002:a02:cac6:: with SMTP id f6mr3136897jap.81.1634632858981;
 Tue, 19 Oct 2021 01:40:58 -0700 (PDT)
Date:   Tue, 19 Oct 2021 01:40:58 -0700
In-Reply-To: <649fd15d-4e23-f283-3a58-f294d59305c7@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5d81305ceb09ead@google.com>
Subject: Re: [syzbot] divide error in genelink_tx_fixup
From:   syzbot <syzbot+a6ec4dd9d38cb9261a77@syzkaller.appspotmail.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 18.10.21 20:55, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    660a92a59b9e usb: xhci: Enable runtime-pm by default on AM..
>> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1506ccf0b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5016916cdc0a4a84
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a6ec4dd9d38cb9261a77
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11308734b00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f56f68b00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+a6ec4dd9d38cb9261a77@syzkaller.appspotmail.com
>
> #syz test   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git c03fb16bafdf

unknown command "test\u00a0\u00a0"

>
>
>
>
>
>
>
