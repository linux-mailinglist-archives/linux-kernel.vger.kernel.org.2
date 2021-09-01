Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D63FE392
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbhIAUQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:16:17 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40738 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhIAUQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:16:16 -0400
Received: by mail-il1-f200.google.com with SMTP id f13-20020a056e02168d00b002244a6aa233so301079ila.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EWh7AfEBQS0YoU0ozxM6YG0zLIfPh1jKCDo2dTRpkEg=;
        b=ryJJ2CPdTgGJZ3HvE19tfcqqFowi8ZotExKg+J65KlEDjSVHgnlluIBL6YhBfElfiE
         8c8yPSlNChcqnDPgolEvY0sDYWBajdNbZ32sf5kmuhxWGUbtkM752xso/SJCvzZkIreC
         VD1RB96KsRxIV3gO8QF3gJdNv/wgSiNK4w8Ow0VZzUCIhv8VGbrr7pAlK8hzEtFiWe7R
         a/CKH5JXeO+3DaLZH/A5+BiUcsjd9W/fx2ZSzJfkeNWmDga8uJKld5DjyXREUkcXtxGC
         cF6U0H0JnzjoHTwgoD/RjcFqW54mKgUHvobB3aCAj7yUHw3vP0P3aRMISsPG3QAz3keJ
         Ll7Q==
X-Gm-Message-State: AOAM532faMPZnXog58vVJ7eKRvu20MTzNFzvn/dZgTn4oGRsm5xQma6J
        7SURkEnNBcZC27bhCr6Qug/shJ1esUXW02OFQYL23pTBYj/B
X-Google-Smtp-Source: ABdhPJwOUbXzdVuZamlU8JUgZs2HfIvAlCoqH12e74cXJ2LTAYqEbCSZM1HArKzLR9OZLN9gND0th90s0Dlew3QZhebdaxqmULp4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d11:: with SMTP id q17mr1179827jaj.63.1630527314101;
 Wed, 01 Sep 2021 13:15:14 -0700 (PDT)
Date:   Wed, 01 Sep 2021 13:15:14 -0700
In-Reply-To: <ba030947-6463-9a0f-7ce1-cd712ef9c1aa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a8dc805caf4b92e@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in xfrm_get_default
From:   syzbot <syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com>
To:     antony.antony@secunet.com, christian.langrock@secunet.com,
        davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

arch/x86/kernel/setup.c:916:6: error: implicit declaration of function 'acpi_mps_check' [-Werror=implicit-function-declaration]
arch/x86/kernel/setup.c:1110:2: error: implicit declaration of function 'acpi_table_upgrade' [-Werror=implicit-function-declaration]
arch/x86/kernel/setup.c:1112:2: error: implicit declaration of function 'acpi_boot_table_init' [-Werror=implicit-function-declaration]
arch/x86/kernel/setup.c:1120:2: error: implicit declaration of function 'early_acpi_boot_init'; did you mean 'early_cpu_init'? [-Werror=implicit-function-declaration]
arch/x86/kernel/setup.c:1162:2: error: implicit declaration of function 'acpi_boot_init' [-Werror=implicit-function-declaration]


Tested on:

commit:         9e9fb765 Merge tag 'net-next-5.15' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=b2be9dd8ca6f6c73ee2d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a2a34d300000

