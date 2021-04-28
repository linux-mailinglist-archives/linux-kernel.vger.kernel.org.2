Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40B236D248
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhD1GhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:37:24 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41538 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhD1Ggz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:36:55 -0400
Received: by mail-io1-f71.google.com with SMTP id e18-20020a5d92520000b02903c332995d1eso21308889iol.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Evc5bVwxwemryzvGzpgDZhtuvWcPA3UvDTqhrxcKzWY=;
        b=Yt7T5pTzUvflr0tEGdztosFB0c9YY0uNPnDNJtEYNGd9rNSZYsZ83eqvkoykKiJiM6
         ZcFdqJh27q7P1z6McXbPqurvJprV5E41K4LKnNhnLKEhUZzeE0Ou6j7A1MNUxapm3XtO
         vcQNHGKMmWTu7naxDJEFCcKnmncI0GQWHCN/d1B5NY/V+adxIGvaPGR1ame2y/aA3iv3
         8AIAdjVYSfUuudAjE44KUwcTlTVrrUCgxDqYiQPQ/c0umbk3BARWX19UumRcB35v2jgE
         Qte7cc3j6rIuEuTDY0ehG+r+PGsaIyK2JvJmLckqZ2V19JZ15Kt5XMWHjcHLcfq0hHF2
         pKXQ==
X-Gm-Message-State: AOAM531/Dwqb3fZEsJBh/Y5f5vuJCn/hsOX7oVR/+Vgg5d6KKmp1c4JH
        GA//D9iRcpSVMy3gnlm+/e+3EB1qEDWfZTo9BVZvrbu50mT5
X-Google-Smtp-Source: ABdhPJzJ9o/2K/Iwil0D0KZ4LzyhjGgnGbzsZ02qlcomO6jJoyngCwt3sCUb8/TPKgfNWTguq0sfEzO3AFLDKsXfSJIq0vyTEP3G
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc3:: with SMTP id x3mr21450057ilv.47.1619591769638;
 Tue, 27 Apr 2021 23:36:09 -0700 (PDT)
Date:   Tue, 27 Apr 2021 23:36:09 -0700
In-Reply-To: <e3617587-7ff1-720c-00ab-434608705652@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c4f1e05c102989f@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem16_serial_out
From:   syzbot <syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com>
To:     caleb@connolly.tech, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        peter@hurleysoftware.com, syzkaller-bugs@googlegroups.com,
        syzkaller-lts-bugs@googlegroups.com, vegard.nossum@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://repo/address.git/commit-hash: failed to run ["git" "fetch" "--force" "b7cf8f2fbfc36c709a08e0b9c77990e491473738" "commit-hash"]: exit status 128
fatal: unable to look up repo (port 9418) (Name or service not known)



Tested on:

commit:         [unknown 
git tree:       git://repo/address.git commit-hash
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7f1a69dfe24c6b3aeb
compiler:       

