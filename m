Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D86403618
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349888AbhIHI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:27:22 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:53172 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349461AbhIHI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:27:19 -0400
Received: by mail-il1-f200.google.com with SMTP id s3-20020a056e0210c300b0022c5f147482so69258ilj.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=78IxIo20RHVjo5QvtpSB+aSKKhjTDobbC+QvMjvPAiw=;
        b=PfCQcNNi+Mcd30JxFHsigTcIqhoGw/nobmHZr2n4dxOnmIgeVMjNmwr1wFQaotG/5y
         v4yraS/44udUxIHE3itYViaj9aC59mZ0DfK1N7+C3RTEQ3Li2WYOw5tj69drDAlJj71V
         0eefz9iLAyl9lGOFBuKTanzxJ/QwUOmkXGpVubVGEf7MOiAlhloNYRk8vPhbtJ4kXlwo
         uLCiIBEL9KFvtFkYNXCHw58AsbJ36/GcDx1WWhI1ruFxNH5ulBhY4+pN8PisXAIAtxXp
         3OWTX2HGXFW/EHUWtp+Yf9JC6x2vkTbaAH6A388j6Sla8zJn1KKsPbISKzy3wwD7EEdW
         KWqA==
X-Gm-Message-State: AOAM531ZYMgTGKUQAqvRXAdyh3UeCUTBQDiJ8iFUgMflYkLNBqq4uY5e
        qDRGsynx7YgJpXwj3SykrgoM9WxUfnnVwoh1eRmv2TjayE1m
X-Google-Smtp-Source: ABdhPJylhXqTPfF2GffTlDJJAOvyXDXchsxNmGUL/aOTLpIx5wk15j5BBJzC8fejpT4lNWlkYFc8nELAx9DVV54E46MiLpKLxl2l
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1613:: with SMTP id x19mr2579191jas.77.1631089571970;
 Wed, 08 Sep 2021 01:26:11 -0700 (PDT)
Date:   Wed, 08 Sep 2021 01:26:11 -0700
In-Reply-To: <CAJfpegvVL-U3_4rhnhAU15qMAH-6WBuvmhnPMUkr_423R_2TOA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088c3ec05cb77a2c2@google.com>
Subject: Re: [syzbot] WARNING in ovl_create_real
From:   syzbot <syzbot+75eab84fd0af9e8bf66b@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+75eab84fd0af9e8bf66b@syzkaller.appspotmail.com

Tested on:

commit:         ac08b1c6 Merge tag 'pci-v5.15-changes' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec7a3d00a9dd6f1
dashboard link: https://syzkaller.appspot.com/bug?extid=75eab84fd0af9e8bf66b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a55a43300000

Note: testing is done by a robot and is best-effort only.
