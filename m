Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11DF3E9DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhHLFTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:19:36 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39926 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhHLFTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:19:35 -0400
Received: by mail-io1-f71.google.com with SMTP id u22-20020a5d9f560000b02905058dc6c376so2834988iot.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vAYClqij0nGxn6pQX2zV5X7oi626A4U9/u4hsAbCSsk=;
        b=VLMJ3poMjnbDngLhUW0Tsw8umMd+TCK0UuTlcx/DDmuPTpE4aPHF79SQ1pG/93virf
         qTHUktCLkmO0y8NDV1AmTNDIalOJq1LpagOROvUpsLsM1FPtG9b3xC+riY1Ax1d4EAzF
         08n8JAuSUDCxrAGGWPYILB2TcHLo3XRwtjwOW+dEB+vNlHMvpa5KqIAcwfrFRSEWpKXn
         2E3Sh8dB/uq0PvkPj+pQFpcejAujX5oBsuocvdQ1XaddgtuMZOShlWD4MZWR4c+9ZFPH
         2cIP8n1cdzPKhHE51K6EgXgBWQcy/RC7fLwBimltpzZ67Qz4ST4zSfw2DW4hOUt6+Goy
         3CQw==
X-Gm-Message-State: AOAM530gH/Z3irLzDsxJw9I14xVlzQghpVChLk7y0O0upnT3pbv7istA
        2sFjakCzLYodKdN8V7FlXMtZAtrwZTtyE1QTUmEYIu/D8tkj
X-Google-Smtp-Source: ABdhPJwKnImalox7HdHKi7x9YHaW3z1Q/MyGYUO2gKpwVxsARpknotR0UEuiqgT7eCH1tXhs/b0QjX8Urm5c+ETchZAr4asAvYIr
MIME-Version: 1.0
X-Received: by 2002:a92:b308:: with SMTP id p8mr1541359ilh.296.1628745550454;
 Wed, 11 Aug 2021 22:19:10 -0700 (PDT)
Date:   Wed, 11 Aug 2021 22:19:10 -0700
In-Reply-To: <20210812045047.2548-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6e6b305c955dff5@google.com>
Subject: Re: [syzbot] memory leak in packet_sendmsg
From:   syzbot <syzbot+989efe781c74de1ddb54@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        phind.uet@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/core/dev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         761c6d7e Merge tag 'arc-5.14-rc6' of git://git.kernel...
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=989efe781c74de1ddb54
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147a5779300000

