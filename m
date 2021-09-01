Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A53FE2A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbhIAS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:57:42 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50768 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243607AbhIAS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:57:20 -0400
Received: by mail-io1-f70.google.com with SMTP id b202-20020a6bb2d3000000b005b7fb465c4aso151446iof.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=BRYCKM+nxgazLvQShkHFc3x7TJQDmFoQrg4gb1LVEIc=;
        b=hNFrK2NhW8GhM3ENPZpURGXgP2EDYmTKisGTmwoS5h2Vx9+T7B6WOvI+pJKmV0aJa7
         NJvndatmpA1lrruuuyUuny4l8Iq8zdlEZNkXhOT/HcXp4MW6jjGjx0a05eMnRe4kQMgV
         IUXMwd52+KL+EoJD9d2k72JfHkvrQ48BhL4GnDZmjyDK0HLMqC3o5aofl0JsB6UCVvyS
         1fEMZL22+YTbh3JkWxf4izpzL///oH5b3njaO4zFuaaIWLqfq0nPH7rvMktFFhUvOElp
         31J/rGabxGWc7SYeqMRIAa2+As6DCaJLSMh4F7dbBt0XGYUi2u/8FSFG6TBzMe6Eyqrz
         HxYQ==
X-Gm-Message-State: AOAM532sBy9j+XB1ntU/ELda2jrQk3z6X2JtH7/ixSxXDhyOSTYDjpFv
        3wOLBjTYUWqqhRhSMq96VaBkZfGGT0Rit2VE99yI+3ggFP+2
X-Google-Smtp-Source: ABdhPJwad03f8v2Lfev3U5fW80KvsNT3Z1PqVPwR06oKqGJRZh4TBdZM47GPSqbQMiEFcJYYEHGp5qZsoLx/oez3+adGnRkZjcnY
MIME-Version: 1.0
X-Received: by 2002:a92:7305:: with SMTP id o5mr682775ilc.70.1630522582863;
 Wed, 01 Sep 2021 11:56:22 -0700 (PDT)
Date:   Wed, 01 Sep 2021 11:56:22 -0700
In-Reply-To: <52d33ff4-5ddc-0103-9312-f75b7e7cb5b6@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059938905caf39fce@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in xfrm_get_default
From:   syzbot <syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     antony.antony@secunet.com, christian.langrock@secunet.com,
        davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 8/30/21 23:19, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    eaf2aaec0be4 Merge tag 'wireless-drivers-next-2021-08-29' ..
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1219326d300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f9d4c9ff8c5ae7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b2be9dd8ca6f6c73ee2d
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6e3a9300000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10de8a6d300000
>> 
>> The issue was bisected to:
>> 
>> commit 2d151d39073aff498358543801fca0f670fea981
>> Author: Steffen Klassert <steffen.klassert@secunet.com>
>> Date:   Sun Jul 18 07:11:06 2021 +0000
>> 
>>      xfrm: Add possibility to set the default to block if we have no policy
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114523fe300000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=134523fe300000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=154523fe300000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com
>> Fixes: 2d151d39073a ("xfrm: Add possibility to set the default to block if we have no policy")
>> 
>> netlink: 172 bytes leftover after parsing attributes in process `syz-executor354'.
>> ================================================================================
>> UBSAN: shift-out-of-bounds in net/xfrm/xfrm_user.c:2010:49
>> shift exponent 224 is too large for 32-bit type 'int'
>
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

want 2 args (repo, branch), got 3

>
>
>
>
> With regards,
> Pavel Skripkin
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/52d33ff4-5ddc-0103-9312-f75b7e7cb5b6%40gmail.com.
