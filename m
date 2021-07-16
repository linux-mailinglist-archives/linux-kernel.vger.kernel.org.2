Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF93CBA79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGPQWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:22:11 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54243 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhGPQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:22:03 -0400
Received: by mail-il1-f198.google.com with SMTP id j6-20020a926e060000b02901f2f7ba704aso5623068ilc.20
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=v+hIPKfq8b1qkJLuVkwXm4/bmuwjWY8bFn96h7dTncU=;
        b=h/UZlvz3NzdtKPsvgGqef9YxGPf2QrBKpA7t+BfqbPiIUXaF1sqvWEjfFE1ONQ/eho
         XdHntuduT78tnfuaIlvALT9s2ibDSbAzr3GLx5IHTMQQ1qKXuV43Hj9X/ZlXUFEklFm/
         0cn+x5lSqRJaRvfsROlUtbvep0y5bZh2enf8IdC6pRoKK/HtzU6Dl5H9GkApKwuOqx+a
         lbqm6oRX1YFvMJ2gs5FOmpvbA2CFvQyacjT4ZXSWS7WW9nRb/hA56I7GIczLwN/c0eqZ
         E133pT3Ceaf+v4qGE06E/bOEBvXLpYcbcsJBLgZPE5EBWgGMVgq/TriB3HeVcTMI7svT
         pwWQ==
X-Gm-Message-State: AOAM531UA9wiat6VFaCpWY04FICIPmZkvVP8CLpW/rBenEykMuyViZQL
        hoYuPoIprJ0HsTeyXWSdtH0CkpkM95mNRHoLC4K+ggp3suO2
X-Google-Smtp-Source: ABdhPJylTEqDxWuIsTvrtSmKuLkDyG2tSWKvCuHjV/dWGy3InHB0iO0BWwgPa5j0Q7PlNyd9PlBPrMcsSSfvcJw1tVZehhAjKAUg
MIME-Version: 1.0
X-Received: by 2002:a92:dc4f:: with SMTP id x15mr7064318ilq.64.1626452348840;
 Fri, 16 Jul 2021 09:19:08 -0700 (PDT)
Date:   Fri, 16 Jul 2021 09:19:08 -0700
In-Reply-To: <20210716165526.20e3c1a9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f348105c73ff207@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in profile_init
From:   syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com

Tested on:

commit:         d936eb23 Revert "Makefile: Enable -Wimplicit-fallthrou..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d53336580099d6
dashboard link: https://syzkaller.appspot.com/bug?extid=e68c89a9510c159d9684
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16750fe2300000

Note: testing is done by a robot and is best-effort only.
