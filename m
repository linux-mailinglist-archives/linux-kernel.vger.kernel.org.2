Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072EB40DC24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhIPOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:02:35 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55954 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbhIPOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:02:32 -0400
Received: by mail-io1-f71.google.com with SMTP id o128-20020a6bbe86000000b005bd06eaeca6so11435880iof.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 07:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Rg5swG7vfZFIYVXMyonVSaWtcmV6xu8pi1vuSVxxgRg=;
        b=VG/BOhMBkfDTgqzPyto1hiSMGvpz+RK1ytY5vXoQ/BiLrAnAds14mX5Kd0n39ylxa6
         ExIh3TGDrimBABWrNXd3O7fhofwOR9aAKEzefD0MPhrLD+0zmGCr4VO5Brey2D0vqIYm
         +eN6YtlX17rjRPH5Q+nZGHhDxdcO8nZXsjDtyVUfhNGp73GMynF/BoDfsDVE0JC2s9jU
         q96PNcmxjAWbi7NoapnMKFwfAO0cWQY5IgiMetUHEn2QvMZIV8Y0kUYHqFUnbtn+1ORw
         z9iE3pZLjdX03pSxmZ1KVibPTO8uk0LEkKKuMuhaFq6OG4QC6eEk1FPDN9PqCV5hE1WN
         26yA==
X-Gm-Message-State: AOAM533JTNrurZQLItvOn61XDc4BTIZcceBcxGKdlmi9Xt0uaoExSHGq
        IKRIOv5z9p9eY+TSmABKnGM2q5TUhXV/rWgaCrfvVNtM96kV
X-Google-Smtp-Source: ABdhPJx1AQvYzhvk1chHxJ+OOacYbh2ToZzXsMDGRXSfvADJvc2UVKTiq8ZYqzGqE/bXmABIleNk1xHuK0ut39hBC0JzqvljvTE9
MIME-Version: 1.0
X-Received: by 2002:a92:cb87:: with SMTP id z7mr4244017ilo.315.1631800872036;
 Thu, 16 Sep 2021 07:01:12 -0700 (PDT)
Date:   Thu, 16 Sep 2021 07:01:12 -0700
In-Reply-To: <0ddad8d7-03c2-4432-64a4-b717bbc90fb4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000526fb105cc1d3f5b@google.com>
Subject: Re: [syzbot] WARNING in __percpu_ref_exit (2)
From:   syzbot <syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, coreteam@netfilter.org,
        davem@davemloft.net, dsahern@kernel.org, dvyukov@google.com,
        fw@strlen.de, hdanton@sina.com, io-uring@vger.kernel.org,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com

Tested on:

commit:         5318e5b9 io_uring: quiesce files reg
git tree:       https://github.com/isilence/linux.git syz_test_quiesce_files
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7d9f99709463d21
dashboard link: https://syzkaller.appspot.com/bug?extid=d6218cb2fae0b2411e9d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
