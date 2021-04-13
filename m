Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA635E4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347103AbhDMRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344208AbhDMRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:07:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A8C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:07:28 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x11so18539605qkp.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xbFjXfIvD0txVY5tm9g6NqmOIIi1BOsdiGGMQiDDjA=;
        b=JJ4xHG6Ae4Sv5nf7ss2cYn3PUM5vguo9qZx/CBDrGSWVyMLbDcmDfRqL/VQ2UxbMZj
         Alcu9m3KfDgyepq2dmlmYsmlkMllLOhbSy86Negv0QJ4ShFFH1FqndK+yApoFOE1ocVx
         vs961+wLFvfhLzfwNdgDKmRrofcK6SmLmn7t7VnjsYngUs4gShHgEyMiSI28aS8GwDUx
         od19V4tePI2Euj3Ir3fj7AhkdTxrCKnwcWYw9hBkbQcG3TcnEPOO5uZAxo6tjaSBcszu
         KuzmbBoch+xGmI5aWsjXAlKsn+NRDOP9T99pYRiCIgldgNpjl8mKnpaNAdNw0dax5MH8
         DKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xbFjXfIvD0txVY5tm9g6NqmOIIi1BOsdiGGMQiDDjA=;
        b=Xda/2yyM4FAwOpJrPH5sIcnabu2hHspahzioXLxpJqfGhYxt4QtguZcxSXOb0QK14S
         GoAcTC7jtJHzygubGHEpbau9zj/lvIB1tnqQ/5NrKgZWJN+lPd8H0B5kUAtLdy5VopPh
         /iTBji5HBW+s88nb8kf2ytkiGTZCjlUnf7tX8Qx6zw9TQKoNA4rZAqdSihMlhwPMlW6Y
         qB7SWYe2NRgZfAImDSLSMxNvGaFT3OorILsG620cnATmsJVH4CpYeWF9pPC+UZm6sem+
         TPnJeqbhaHBou3nK0/OaXJevzW51bVyvFaylk+7n4jwLWRJu+aX6CNp5cDuBdsoMf8TG
         DdPA==
X-Gm-Message-State: AOAM531Oj1uwzH12OQhvtgqZx8gn9Y3OSvWJMk5a+XNWu3mSJpgWgqyk
        yXC/Tg5bVHVFU/rJkFcWYJvoAAy6CBfZTbyz8YUVHzhpA/DqkQ==
X-Google-Smtp-Source: ABdhPJwuOF7qHErGETjffMNXBYKcBSZuFsSh1OZ4GKuuO/rHKk7UPDK0vA0ExTl8e29y8wy9MLDZtc4+2boE8t+0OJo=
X-Received: by 2002:a05:620a:243:: with SMTP id q3mr14114386qkn.501.1618333647620;
 Tue, 13 Apr 2021 10:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d662d805beac5df7@google.com>
In-Reply-To: <000000000000d662d805beac5df7@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 19:07:15 +0200
Message-ID: <CACT4Y+b7sRrsyOGnnFb3T-9n9JWp2vRkA4PmP3TNFA=t0Ygf0g@mail.gmail.com>
Subject: Re: [syzbot] linux-next build error (12)
To:     syzbot <syzbot+78983c59ee6ab57e6fcb@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 2:53 PM syzbot
<syzbot+78983c59ee6ab57e6fcb@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9d49ed9c Add linux-next specific files for 20210329
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=159b39aad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b55345a2d39e7782
> dashboard link: https://syzkaller.appspot.com/bug?extid=78983c59ee6ab57e6fcb
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+78983c59ee6ab57e6fcb@syzkaller.appspotmail.com
>
> failed to run ["make" "-j" "64" "ARCH=x86_64" "bzImage"]: exit status 2

#syz fix:
bpf: tcp: Limit calling some tcp cc functions to CONFIG_DYNAMIC_FTRACE
