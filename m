Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE22455291
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 03:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242489AbhKRCXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 21:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbhKRCXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 21:23:06 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02FCC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 18:20:06 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y16so5989739ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nEboIJi6Qr0nnqtwMzUfbJQpRLVgbACz3hjpilD94rI=;
        b=Rgkp2jGw8gBb38o9uu/tQF5ixm86rr7B1cROb5nakXQV+W6wLPTX9ud/SHND1/ECm4
         D6rl3BXYuIvQNJp1vcH6ZH8QFWdA+ksURZVFp05IxScv3ZvzubAVhO29Q1L4sl613CLQ
         0JNDgewyqdH1oEK21rN91T+R1XDRtJCc84e2YiHN6l+FQLgSpT6A/mkfmURO6JEz91oA
         UQtDM0aeL7d3r8/vhycCjIjHBfJRGsD3yYKamUtjRPjM96qK3ug1j7Fd8Gt5yPugw7b1
         IZi4KrvkTxcNtE8blfISU3fk9wnrIbpxe9vqcqcrMncNZu6KMu0pNKf7POt6RkbEWSc8
         ihqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nEboIJi6Qr0nnqtwMzUfbJQpRLVgbACz3hjpilD94rI=;
        b=q69ZAUj2a7svsHwUwUcIMqGM7kDZOJusgbRXgtjWA+/Doe12BE5SbDhACeMrhRdmgV
         7tkDNErmMN2ZP+SNwn0hYDVPIPHycgw4SKh1e8TIPu0preynAv2dDfeuPZ79h1YIp0Ma
         bYE+yiVunZ0dVJWzPa9tP6CDJiAb1BdKKRAt+5kPVziN7I7XsyMeJ6I//imB/sV4URbg
         HNOVMC1mBL8NRwZgHcNa3WKIFwrJIHoRM46b2iKa1qyAHRfKw5/P97uMJ/2HZsSHXtby
         8m/kVCpry9bEU8gjvBCFdz1W17fp9TJ+q/bybghB3y9079NWuXJbqsl5jBLNu6yuic7x
         zOng==
X-Gm-Message-State: AOAM533roI8RTgb96uG6AS5gKoYCHv9Z2Z23xqiifPLeqkrRjgx7it5n
        WWwGW5krzGFF63cLQf75WRAFDq+dAdceH34EakpOfXa/
X-Google-Smtp-Source: ABdhPJztqjOsmfn1ypZiZk8a9IQq8tiDbNZvnAs81c2j9SG8MaJ+ICx1tHuzO+3/kPgJVrDEYxrfX9We4tY2qr331mk=
X-Received: by 2002:a6b:b4cc:: with SMTP id d195mr14575028iof.0.1637202005901;
 Wed, 17 Nov 2021 18:20:05 -0800 (PST)
MIME-Version: 1.0
From:   Jidong Xiao <jidong.xiao@gmail.com>
Date:   Wed, 17 Nov 2021 19:19:54 -0700
Message-ID: <CAG4AFWb8XmmWra5qYBE8XxgxMYDqMMg8zzOXkHE03rGd_MBsCQ@mail.gmail.com>
Subject: how and when to create the "." and ".." entry in Linux file systems?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to learn how to implement a very simple file system in a
Linux system. I started with registering the file system, allocating
and initializing the superblock, and allocating the root inode of this
file system. Now after mount, I can "cd" into my file system root
directory - the directory where this file system is mounted.

Now my next goal is, in the root directory, if I run "ls -a", I should
see "." and "..". I think this behavior should be common among all
file systems,  thus in my file system code, I likely don't need to do
anything fancy, but maybe just call some VFS function? If so, call
which function? Are these two entries (. and ..) supposed to be
created when the file system is mounted or later - like not created
until I run "ls -a"?

Thank you.

-Jidong
