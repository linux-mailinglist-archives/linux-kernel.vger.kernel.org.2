Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EBC3D83F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhG0X2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:28:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57303 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhG0X2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:28:07 -0400
Received: by mail-io1-f72.google.com with SMTP id k24-20020a6bef180000b02904a03acf5d82so355835ioh.23
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=o+xohfaKx0eRBXKeZWoG/RFdPcbzbopGddR2do92Akw=;
        b=tjrFntRHPLkp79oej2E/hKH1CutW3tFENg7hlFyCg7xhvxKLQNVopewhzL4haGAFyR
         /spteJBMgK/cWvgw47oDtRL8yfmlALPOgaF9FbzDY0RIENVf8CGT2vZbOdxKVZKmxA9a
         47In2vJN1BCpBXgSyFCKuIknKAj/EyWwQIL9LXRP35Vm1g4z3sqb2g5PmqFA1oRKSYyy
         4Erbtq9KjDR0+utPWISHizq74dNJw+LPvSUvrT68SwzyeAXr6QHKJfkTm6dQIqaiMTa3
         zOifvDU5tI1ZeJw/Icn+UAbv2TLQGk+y+O9cbFKJV0pFF9J6Gndk9r+nnrSRA0kzvuiL
         Sv0Q==
X-Gm-Message-State: AOAM531ezCIRtPqWMGxKHPpyCqZtYxRoPP6Ua0kY29x559xN1el5zBjE
        klJSUtGjyhwjAmlbM4pe8wewvYW9U/lV25f0Hk67LtVzY1Zy
X-Google-Smtp-Source: ABdhPJymsLUnghnpljxzoV3XPtlT7OCAGWIsKe3mEd2UVlAKDQBBXJBylRL1TGFTIMq7BFjxAs1v2Maaoa9ch7uR9CkMjdnG7peU
MIME-Version: 1.0
X-Received: by 2002:a92:c04f:: with SMTP id o15mr2041189ilf.156.1627428486474;
 Tue, 27 Jul 2021 16:28:06 -0700 (PDT)
Date:   Tue, 27 Jul 2021 16:28:06 -0700
In-Reply-To: <20210727174318.53806d27@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5736905c82338ac@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in xfrm_set_default
From:   syzbot <syzbot+9cd5837a045bbee5b810@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/xfrm/xfrm_user.c:1977:2: error: expected ';' before 'net'


Tested on:

commit:         42d0b5f5 Add linux-next specific files for 20210727
git tree:       linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=9cd5837a045bbee5b810
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147b8d0a300000

