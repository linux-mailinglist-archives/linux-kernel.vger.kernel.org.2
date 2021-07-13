Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0FA3C6F24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhGMLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:09:57 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:44766 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbhGMLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:09:55 -0400
Received: by mail-il1-f197.google.com with SMTP id s12-20020a056e02216cb02901f9cee02769so7574325ilv.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 04:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AvMyKnTkwsxUrtP3XQjHPh5T2O88RDnNqnIxyYnIxDM=;
        b=m/zILuj5YVByDNV7n/yqOgzKFVTVKsxVkAA348OcOjSrkUDmr0nUsY+2GlpEVMgbgH
         FC1AS7CuNC9CFgkLV9DhJRA6NWI+D6V1S+0L+ddAxmSuo15Io/86+65IcX9U3LrR+/Z7
         lLzskLpgud+n/TFfvq1uQ0iDKtdLcC+Fw/f9tJV2BX5RKtuI2a0wL09SZYToqGBDg13I
         Wc7gE5LsTH1wQQ/aw4R+KifiCWR/jZfQojfw6odMqOp4l/vE5QbyoVBVtCWaVYEv8O+6
         d+wWosoMoXBlGL0w/VfKja8/VLNKrA2Dt9ZqY9exDnlZedHcFBgbyKYKhSM5vcdPMY/Q
         W6PA==
X-Gm-Message-State: AOAM532BZhoPxteDZqijfttydUHvFDVY72FJ8ClI5NyATE3X6946XLz4
        4V+FlYDUnupjkauWZeY4yLmozwR8oMMmDybxSDsQM4BwmnAa
X-Google-Smtp-Source: ABdhPJx/vetpoAeNKu+h2uUTRnfq90XIA1URsPj0f0m4j4mGg0p/BueIwuoYv8LVvOh5gGrqGwU9K0+iMrMbIOe/OTEglU2TUt1K
MIME-Version: 1.0
X-Received: by 2002:a92:c0c3:: with SMTP id t3mr2483044ilf.80.1626174425449;
 Tue, 13 Jul 2021 04:07:05 -0700 (PDT)
Date:   Tue, 13 Jul 2021 04:07:05 -0700
In-Reply-To: <20210713115546.34c99ea8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8c8e605c6ff3cff@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in r871xu_dev_remove
From:   syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        paskripkin@gmail.com, rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/staging/rtl8712/hal_init.c:46:3: error: implicit declaration of function 'shedule'; did you mean 'schedule'? [-Werror=implicit-function-declaration]


Tested on:

commit:         8f0df15b Add linux-next specific files for 20210713
git tree:       linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=5872a520e0ce0a7c7230
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a2c06c300000

