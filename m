Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B876131653B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBJL3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhBJLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:21:37 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377A6C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:20:52 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z32so1193335qtd.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxVB4iO6uxZ6jTOSjL9nz0r+OMPii+vsyZlFeWUuLVg=;
        b=AEvU/+ulxg7NUf+jXZXy2icwOikMsi7RVzvL/HkxmQ6/Y440YoTrnQvexP9+wYSeIe
         mrNncZ7SjVBIn8vvx0yZO/st6MMTNavzcI6tD8zDNaZJ/Bnb3cHb68MC8l9yCERrQNUD
         yN2PAE2pqTWiMCWQghJvV/ZQzn+vPPNd1P6rYzTwUXR10K+mxlami9Shc0yEMB3lx5Ea
         TpjctiNDxRomyyrGmHOtGYo9qrQ55w+CEPUhyzoHvNk38x3N/QvuSgaLdnNOXtnVI+Na
         ty5red/7byBxMmCenDMBJrFQINGiQYG8PYGH3jaF9Dq9w+9sq2/zxHA3ZIgM6N2ONaFx
         /KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxVB4iO6uxZ6jTOSjL9nz0r+OMPii+vsyZlFeWUuLVg=;
        b=WNmZalecXeVJ28cIt+qvJWyaYcuWUwXQ45QdsMLo62vxr/Kc89BdZM6j5laAAfMqpz
         PWEllRcwMh10TkpfxsQ0rqrF5BSwuKI3Dc42binETs7mHLRNCWRIy424xQizqyu8xhaI
         jXC1QbzNyJtKfqRAlUIchiifciCQMrxue+rEAxpalo6H0Wc2sQwd3871u5XouxLhBgic
         631Z1xVX7e9T8n76wj+/Vx1r5JhBBjMQKyHpZ1F/Av0GQweB1rK3lVAzvbhIK6HsmihU
         CSJoRgVDMUiuxirLV62akrgwLHI8ffrQV+dtBBhrhjgC5F/yaLsmkgLDTzqTiyc07qg/
         qcCA==
X-Gm-Message-State: AOAM533x8wiU0R/YcBsU32OsTjjnq5bvaOEqVpl6VtcrKpq8YrLo86A/
        Iu021U4zGj6GbZ1/5iK0+aH34t7FEmJUeO5u3CmQIfeJ4nw=
X-Google-Smtp-Source: ABdhPJw+i4kmFEs6RYULTIxGMsfWXlLRa/DxwCtnbbZusf/Zjh7JLz5kSfxSOe1Ehb93/wrDjxPPUQ7ivxcWtnHEDZc=
X-Received: by 2002:ac8:66c9:: with SMTP id m9mr2141416qtp.43.1612956051156;
 Wed, 10 Feb 2021 03:20:51 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003178bf05ba7f9e84@google.com>
In-Reply-To: <0000000000003178bf05ba7f9e84@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Feb 2021 12:20:39 +0100
Message-ID: <CACT4Y+Z07_phGvwo+aK1nM4XmmSfHRDBtVotwgGBLY6aZDDKXw@mail.gmail.com>
Subject: Re: upstream test error: BUG: got no fallback coverage:
To:     syzbot <syzbot+e6ca682acbbf21043787@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's pretend this did not happen (since it happened only once)

#syz invalid

On Thu, Feb 4, 2021 at 10:49 AM syzbot
<syzbot+e6ca682acbbf21043787@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6642d600 Merge tag '5.11-rc5-smb3' of git://git.samba.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14de59e8d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f75d66d6d359ef2f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e6ca682acbbf21043787
> userspace arch: arm64
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e6ca682acbbf21043787@syzkaller.appspotmail.com
>
> 1970/01/01 00:02:05 connecting to host at 10.0.2.10:40353
> 1970/01/01 00:02:05 checking machine...
> 1970/01/01 00:02:05 checking revisions...
> ps_root_recvmsgcb: failed to send message to pid 4476: Connection refused
> 1970/01/01 00:02:05 testing simple program...
> 1970/01/01 00:02:08 BUG: got no fallback coverage:
> loop exited with status 11
> ps_root_recvmsgcb: failed to send message to pid 4508: Connection refused
> ps_root_recvmsgcb: failed to send message to pid 4544: Connection refused
> ps_root_recvmsgcb: failed to send message to pid 4543: Connection refused
> ps_bpf_start_bpf: bpf_open: Invalid argument
> ps_root_recvmsg: Invalid argument
> ps_bpf_start_bpf: bpf_open: Invalid argument
> ps_root_recvmsg: Invalid argument
> ps_bpf_start_bpf: bpf_open: Invalid argument
> ps_root_recvmsg: Invalid argument
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000003178bf05ba7f9e84%40google.com.
