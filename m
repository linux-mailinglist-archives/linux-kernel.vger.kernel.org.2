Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455513987DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhFBLUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:20:18 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:36619 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFBLUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:20:16 -0400
Received: by mail-il1-f197.google.com with SMTP id s5-20020a056e021a05b02901e07d489107so1298330ild.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=fUuOkxrIdoQmAb56CsmjGA6rmm8IFaIzsgB206kzii4=;
        b=RS7Rs+4KGR2j0DGe/CRvyspDCpDN2z+bDm9jL3nR59MwP/S5Da2ozlge+Ejkzf3UaF
         UkV1CsnXZa1Wuwv5DkoR5zt9EK+r4NcMyMqkYsqg1AtPbUmb4aYi6NU4NRdigx3Au/Ij
         I0Dr0B83z4KlVDhwaYzV60lUzS8G0Cr4DE4dqNzpFJsH2NwTKMxAk5mPYB8JTGxXzmpV
         OyIKRMcGYRJuf+GfGGWGIOYNK+zJ3LlfLu2Vz/qCAISG6SYYZed/tFGww7XCKFKFcvPx
         gG90n89ufQKiUaja/VmMCI8QhvUyPjsVsqm8qHDO3rlC4QWmsRiJ9pPXIpAaQlsUbfVC
         HlEA==
X-Gm-Message-State: AOAM532UUBPydsfEocEKKojI2tQm0OFdj9GWOWdA/PpLmQmDIN6CUnb6
        qroAjjz0jZL7ph/6bPl83246vDJ5dwCbBFZw9FcG2kCxOPyz
X-Google-Smtp-Source: ABdhPJz7V5+svtllpxH9nzf4ovxVaVuS5+ylKIbKxC0l1D+WwRHYpJWQy/Nm9+9mMbCvDsJopVTIjAVhfqs6ZSYfC97n2tcnqNcJ
MIME-Version: 1.0
X-Received: by 2002:a92:c5ad:: with SMTP id r13mr14881585ilt.238.1622632713370;
 Wed, 02 Jun 2021 04:18:33 -0700 (PDT)
Date:   Wed, 02 Jun 2021 04:18:33 -0700
In-Reply-To: <YLdo77SkmGLgPUBi@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b451b05c3c69e4d@google.com>
Subject: Re: [syzbot] WARNING in idr_get_next
From:   syzbot <syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     anmol.karan123@gmail.com, bjorn.andersson@linaro.org,
        coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org,
        ebiggers@google.com, ebiggers@kernel.org, eric.dumazet@gmail.com,
        fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        necip@google.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz fixed qrtr: Convert qrtr_ports from IDR to XArray

unknown command "fixed"

>
> On Wed, Jun 02, 2021 at 03:30:06AM -0700, syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>> 
>> commit 43016d02cf6e46edfc4696452251d34bba0c0435
>> Author: Florian Westphal <fw@strlen.de>
>> Date:   Mon May 3 11:51:15 2021 +0000
>
> Your bisect went astray.
