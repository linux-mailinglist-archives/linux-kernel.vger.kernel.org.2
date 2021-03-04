Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78832CE70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbhCDI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:28:14 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:51779 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhCDI1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:27:50 -0500
Received: by mail-il1-f200.google.com with SMTP id y11so19883335ilc.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 00:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6Z9uhMMGUlxMK9WR9njyeuEFP6BA8lotMFqvBRev/Ds=;
        b=eXJVisd4nUGHf1U5Q9IdZ26S2kGSjY++sfBMvpEUNY90fPtdNpl2w3Qcg/KgImbVUh
         +8qawgRfpHf25MNiMsFDf6mcIbfhQBIW+Eh8IAln0kDBXD6j6CMupOGgXu3aTEwSslLc
         2V8WOffnbn9t2L77N7gJ5gtz+bsizHVlBpc1UieNsmC8IHogMz0XGSi6h9bnSHDJeJuA
         BPfENdaP4FOtolOE5kh+t/TJzTm4LcSWqBlMWN86uGhQaxev2K1DRsuDnxZLdFYhIip9
         bfqNYgoDDSBhbxinlIwLnAQ2u4jEXvxLbnlwnNF+zAqdXG+qtEGBROk4hZ6MoRCEgWHA
         sdIg==
X-Gm-Message-State: AOAM530tVreLH7j+GIX39zrET3Bhz8qKwfREcXR5Rj1lpTTZe0CLQdaG
        Ko/WjQNLbLourO8Rg10zdoHe0vZbVhoWU8aRwVNXl+skOpMK
X-Google-Smtp-Source: ABdhPJwsIfXz6QM1K0WwnCEY1jn+iyk7Wg9ebm+n6fHKt4lFAt/z88NBe2s+PUYaxC9bnn3OGmJtWB1tIGvARGYbrHlRisIdqm86
MIME-Version: 1.0
X-Received: by 2002:a5e:c00a:: with SMTP id u10mr2646759iol.165.1614846430408;
 Thu, 04 Mar 2021 00:27:10 -0800 (PST)
Date:   Thu, 04 Mar 2021 00:27:10 -0800
In-Reply-To: <8494c673-180e-e0b9-4db7-04aed2aee791@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9f38005bcb1bbec@google.com>
Subject: Re: memory leak in io_submit_sqes (2)
From:   syzbot <syzbot+91b4b56ead187d35c9d3@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+91b4b56ead187d35c9d3@syzkaller.appspotmail.com

Tested on:

commit:         e64db150 io-wq: ensure all pending work is canceled on exit
git tree:       git://git.kernel.dk/linux-block leak
kernel config:  https://syzkaller.appspot.com/x/.config?x=c43bda1f1543d72b
dashboard link: https://syzkaller.appspot.com/bug?extid=91b4b56ead187d35c9d3
compiler:       

Note: testing is done by a robot and is best-effort only.
