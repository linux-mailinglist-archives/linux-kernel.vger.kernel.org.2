Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C124383DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhJWNtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 09:49:33 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38490 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJWNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 09:49:31 -0400
Received: by mail-io1-f70.google.com with SMTP id m7-20020a6b7b47000000b005dc506c5e04so5351681iop.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 06:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=6th7FRqhRNbP1CsZO8PDsX9c9NXk641vpSEu8kddIEc=;
        b=4nL0890t1CtQn37DSKOUnY45uCSbbsFlRjCl3Ccb3ztaqX+JQRYm91Hnf11nz2LpcS
         6WfxTq2awdlYQUOJN9WWMhSnWof1LxjIX+dbHG3FwRGE0V06RThriygbbsAknd4gwH9P
         m+nIzaRUvfSMkYxj9wYMEGUihhUnujtjAxKBdtOObkSqG+X2vHIALZa9xCP/oNam2Uvj
         51q/Ra0i6dAMVTHCWBQiKRIiMFXlKzpXnDkP5M0XSdZH2vkbIOKaEwbQtCeTfYxrFr/D
         W7avs2CXU1Tg7dJH3TcdD5fowgaVtcZcqwFG+GfxNZZq0GRaHmQVfedMi61+Iy6leUBX
         ajYw==
X-Gm-Message-State: AOAM530g3ndKu22YkpfWCzp41SHe/sajNazSfmbsbb5L1/QMjrSBAR3t
        rmFTzVMqWfM3P3NnMBS+w9SI/m4dvVhWQrQMRI++4WzXyAWc
X-Google-Smtp-Source: ABdhPJwAolsosnFjYFye6ykTTlSg+G8dCRpSMML37WZ0RiyiCqDL7LK8qN5nC7KJw8ivcRihrhIAZ3bdcRjrkSsGiMhMDK+WW64x
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de2:: with SMTP id m2mr3623066ilj.134.1634996832673;
 Sat, 23 Oct 2021 06:47:12 -0700 (PDT)
Date:   Sat, 23 Oct 2021 06:47:12 -0700
In-Reply-To: <4202176.J8ZBFPDcmx@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006baa3205cf055dd1@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in
 hci_uart_tty_receive (3)
From:   syzbot <syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     fmdefrancesco@gmail.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Saturday, October 23, 2021 1:54:24 AM CEST syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    519d81956ee2 Linux 5.15-rc6
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16787178b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1f7f46d98a0da80e
>> dashboard link: https://syzkaller.appspot.com/bug?
> extid=f2725165900304ec97b6
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils 
> for Debian) 2.35.2
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the 
> commit:
>> Reported-by: syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com
>> 
>> INFO: trying to register non-static key.
>> The code is fine but needs lockdep annotation, or maybe
>> you didn't initialize this object before use?
>> turning off the locking correctness validator.
>
> Let's try the solution attached.
>
> Fabio
>
> #syz test

This crash does not have a reproducer. I cannot test it.

> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
