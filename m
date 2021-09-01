Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251BE3FD1E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbhIADmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:42:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51975 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbhIADmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:42:06 -0400
Received: by mail-io1-f70.google.com with SMTP id i11-20020a056602134b00b005be82e3028bso768077iov.18
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 20:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0beOg+MnIe4h9OCbsLE4S8EBVJhiyel3Re+mX7gXaLg=;
        b=sDTAJJuR2IZ4ecPhefU2DSLIarpCZYSU8KWgEQZHfWWNoC6kLVHhwZqiYXOJ/0a7wX
         ixWazHPK5WIu8Xu9HaXX4pUVHEv2cBa+2qKHR4TZpQgqilycaiReUZ/l+4ZhpjiQozsO
         Xnjw4hzkWDEZGNLALxISm8gM4X+/cQPQg/Rr1IRBWDzlLAVhtRtdnN+KhOZht2vNsdn7
         iYzfuiuKeGU/citIxhyBZ74IepXmkKXc5D2aa8aTCMkBUcVRMkNWVQ1RHJMNy7BJqFP6
         vOKc9zVkY2PN7X+iH1rz189lKMvkm0AC7bCC4kbnETfJHTgeT/HlH2BR2ujNm8wgs1VK
         KpfQ==
X-Gm-Message-State: AOAM532+rW6E+5G1eZM63vV29CP324s4Bi9viIWdffGGDtiAoMafEVdh
        Sq+ATNyBVNl/utRRK8lXO5B0Buj3dYcjnq2Bl/t3DG85+A68
X-Google-Smtp-Source: ABdhPJwcRouK3MNpdsLyB3uITFnuOZQgmH7wdDL4dTob9ukhwMaq/IdUSJeoLsAgHDjQ4rNwFn2tcWAEE1TaClmauJO65kieMAfb
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26cb:: with SMTP id g11mr25688183ioo.110.1630467670108;
 Tue, 31 Aug 2021 20:41:10 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:41:10 -0700
In-Reply-To: <20210901030636.2336-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b732105cae6d6f1@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in qrtr_node_lookup
From:   syzbot <syzbot+c613e88b3093ebf3686e@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, dan.carpenter@oracle.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

arch/x86/kernel/setup.c:916:6: error: implicit declaration of function 'acpi_mps_check' [-Werror,-Wimplicit-function-declaration]
arch/x86/kernel/setup.c:1110:2: error: implicit declaration of function 'acpi_table_upgrade' [-Werror,-Wimplicit-function-declaration]
arch/x86/kernel/setup.c:1112:2: error: implicit declaration of function 'acpi_boot_table_init' [-Werror,-Wimplicit-function-declaration]
arch/x86/kernel/setup.c:1120:2: error: implicit declaration of function 'early_acpi_boot_init' [-Werror,-Wimplicit-function-declaration]
arch/x86/kernel/setup.c:1162:2: error: implicit declaration of function 'acpi_boot_init' [-Werror,-Wimplicit-function-declaration]


Tested on:

commit:         9e9fb765 Merge tag 'net-next-5.15' of git://git.kernel..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=c613e88b3093ebf3686e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1413e2f5300000

