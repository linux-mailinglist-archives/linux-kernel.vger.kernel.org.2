Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD344110C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhITIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhITIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:16:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE05C061762
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:15:24 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so3691684otx.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21r3SlBBRDN7c0GadObCkHwMNcefKesbIlR1sAlPsLQ=;
        b=SQWorY7ZsfFtuloE/lG1ja9FAvI18dl+3bl39aMZLpZxDz27fU31wFPgbMvWVtOdh/
         jH5lPNVNUsKGROWbTpJVqcFsltAcTwYq6aD3Qr+5PAA7SeVT1zKKDMSLqv7v81XUiv42
         tLQKsYubNAudAduG3VA2BvmY5PzrTUH32YWZwuT/we2r/LH7pP++EwPC4RvZPzD5CBWU
         zTEXxcBJcgaf4n199H6aPWL/uU67ZsIRMgZaPcf/PHYjRcVI5MVqZIKnhwPKag68NCqD
         koCbJjQKlGy7LSty428a/2+jF10JJS8pdJV/zHpNGg+z9pTFoUePAAxc/broobCeL+ga
         pNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21r3SlBBRDN7c0GadObCkHwMNcefKesbIlR1sAlPsLQ=;
        b=6Su3zNujLRDCgFvsKMU2P8obB9GNWH4ElOop70fdUOTAuwVPIu6OY2jQEW+Z/aqmap
         ObowYfA1MfD7C0zfFJsRUc+6TjgznPHtdUeqv/KS5u7KZfzYpoBbonFSHbm4whcFZZsX
         A0AVSzYSidmyOS8sdK4/JIsI3hNH6XZqWcGMdMn+Tae3GExRct8oeGQFPOUj0MfFlA5/
         4mBQ1SR52p9wZ69kf81020IIlZ3jy/vYPRQE4jIKZGJkXhYFMyA/0p2qNtNJkgbGxEQs
         GAECLRKJUb3OCiUDcsDipgqPmDmEo+ZBZkK01Mb1Z80PiV+ucFXOAkjwXVeMSIhu2JbP
         jnBA==
X-Gm-Message-State: AOAM532AJjunql5HGpsn5CggvS+JIloVMKYkJFF7S3FtlYMGccPsiH70
        k/8CDHfmlJpJ20UlUIfw1sfsIvI0QBihYSAxAr94HA==
X-Google-Smtp-Source: ABdhPJzEDVSSzCivHfiy0IzQdQlADqrjIknyU8CHTYUeZMc4g90+xJaP6rpoqArVDCE1Y9MpCoy2Dueb/K4l59izd04=
X-Received: by 2002:a9d:2f28:: with SMTP id h37mr10592929otb.196.1632125723220;
 Mon, 20 Sep 2021 01:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <0ddad8d7-03c2-4432-64a4-b717bbc90fb4@gmail.com> <000000000000526fb105cc1d3f5b@google.com>
In-Reply-To: <000000000000526fb105cc1d3f5b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Sep 2021 10:15:12 +0200
Message-ID: <CACT4Y+bdXWBBXc9PfpU09d=zAGvKmMVuq=etQJ3b5WLgRwjGHg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __percpu_ref_exit (2)
To:     syzbot <syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com>
Cc:     asml.silence@gmail.com, axboe@kernel.dk, coreteam@netfilter.org,
        davem@davemloft.net, dsahern@kernel.org, fw@strlen.de,
        hdanton@sina.com, io-uring@vger.kernel.org, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sept 2021 at 16:01, syzbot
<syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-and-tested-by: syzbot+d6218cb2fae0b2411e9d@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         5318e5b9 io_uring: quiesce files reg
> git tree:       https://github.com/isilence/linux.git syz_test_quiesce_files
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7d9f99709463d21
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6218cb2fae0b2411e9d
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Note: testing is done by a robot and is best-effort only.

OK, since it's not failing, I assume we can say:

#syz fix: io_uring: fix link timeout refs

(and it's better to close it with a wrong fix, then to keep it open
forever anyway)
