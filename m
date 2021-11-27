Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F446006E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhK0RQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 12:16:28 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:33763 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhK0RO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:14:27 -0500
Received: by mail-il1-f199.google.com with SMTP id w1-20020a056e021a6100b0029f42663adcso17568717ilv.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=K+yxiNRvoRZS9pRMwE6nb/0gBHDc0Ghntu/MPpY6soc=;
        b=wDZnWIDt6rCveFnNtBlQN7edwht6nDir06rqG4JKdfS4p7PVitOL69wObK2zCe6Qil
         0+fNmrhyMHQy6F3cHqI4rgt8UvuFTvoO/k0ZqZWucIc7pJHbdxX22beEyUN2TAqoaWB+
         bRhK1zy1n563VE0bP2qw0t7xBwL4i2zWj9hgsTdXsF6EDUaYyAkUn2O51pKYaY7mYga9
         CI54/XvFxw9FtNNGZ+FPmEOEkqOdNXS+LohT6wxRa9FTCYYuffqiyD3WMOT6CjTBm4hT
         IHyooaPxPG8IIAdbBQt5Hf9DavbXZrD51CYHQwuvj+NHTKzhO33iF4Byz7m/dJRhz1g7
         KplQ==
X-Gm-Message-State: AOAM533ju0u4T7Kf23Q6MPqOfW6XHDX/WGiCxwUJbXFZECV9LrOH250l
        AjJru3HhYWt7J3Atc7ekTovJo8K75Jp80xnnCSKv4OQ7Ft+1
X-Google-Smtp-Source: ABdhPJxN9Miw3DqoHDLxUvrACmzL4ogERn4NVrpIgHCvzKvRM+ZyHHT1Pr+qY94keK/uOJQGLs4hNy1ZU9EM9VemVO9Q28CuOl5v
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:: with SMTP id s11mr15014619ilv.228.1638033072609;
 Sat, 27 Nov 2021 09:11:12 -0800 (PST)
Date:   Sat, 27 Nov 2021 09:11:12 -0800
In-Reply-To: <0000000000003544c405c8a3026a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c5f7705d1c84b93@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in newstat
From:   syzbot <syzbot+84ef57449019b1be878d@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        rajatasthana4@gmail.com, sean@mess.org, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 476db72e521983ecb847e4013b263072bb1110fc
Author: Rajat Asthana <rajatasthana4@gmail.com>
Date:   Wed Aug 18 20:31:10 2021 +0000

    media: mceusb: return without resubmitting URB in case of -EPROTO error.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c58e09b00000
start commit:   7e96bf476270 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
dashboard link: https://syzkaller.appspot.com/bug?extid=84ef57449019b1be878d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f2aac9d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15470c66300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: mceusb: return without resubmitting URB in case of -EPROTO error.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
