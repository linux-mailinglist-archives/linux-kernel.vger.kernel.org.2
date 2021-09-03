Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92273FFF56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349314AbhICLnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:43:08 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41561 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348247AbhICLnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:43:07 -0400
Received: by mail-il1-f199.google.com with SMTP id l4-20020a92d8c40000b02902242b6ea4b3so3324734ilo.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 04:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e+HyKsU19yRq9dTTGzaiihO1RDbY/pEio/YxB+y4wlQ=;
        b=LUSdGUqHq/O7fGcY1ZhFPMwWnnIXBoxi3d2W5Xw/B+ugAfADsJJG9uj01rri5JozjL
         hoe4orDnuSDippLbrHJAbRuH3b2H6RQtABz1wIzmFrHgAa0yyWq90OTDtlDpHWri+ja9
         ervXb6WofVKThX92LGWIuj1gTCREOfIHpva8+yENIrpsZCqjS02VLerqAqNtpsy6rR1e
         +GPm+DnOc9RPyHbMQ7iqri7QCebtTz+4+SL+kEN9OTw/ySgCMu40AtGBQ32atBmaZIWC
         grvu1fBPQUqG74lYcx8X5Pb6vCZ2WJhn4uxDUXYN7J5AiICUF6tggFRKQ3V2L3t7vXfJ
         LC3A==
X-Gm-Message-State: AOAM532Brat1GNR4KnvSLRLWrIZHvwfR50nV+QYACqHCRqdAI23l7E8Z
        35vVWMqY78npdHG2PH5mUHIqpWG8G+SCwouACrtMS1+ywOuu
X-Google-Smtp-Source: ABdhPJyVGKWtZ/XNFnPfV1DJyHrVWvrUw1gcWV/6Ek254iAr3SZHr33nQjI3GFtlrzCzJ1/87getEFBZvKiyVflC5YPCMch6/ZSX
MIME-Version: 1.0
X-Received: by 2002:a02:93aa:: with SMTP id z39mr2241987jah.29.1630669327150;
 Fri, 03 Sep 2021 04:42:07 -0700 (PDT)
Date:   Fri, 03 Sep 2021 04:42:07 -0700
In-Reply-To: <10b89a9f-443c-98d1-ca01-add5f6dd3355@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdb19d05cb15c938@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in add_del_if
From:   syzbot <syzbot+24b98616278c31afc800@syzkaller.appspotmail.com>
To:     bridge@lists.linux-foundation.org, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+24b98616278c31afc800@syzkaller.appspotmail.com

Tested on:

commit:         d15040a3 Merge branch 'bridge-ioctl-fixes'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0c23f8230e048
dashboard link: https://syzkaller.appspot.com/bug?extid=24b98616278c31afc800
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Note: testing is done by a robot and is best-effort only.
