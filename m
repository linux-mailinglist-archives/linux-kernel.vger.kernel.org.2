Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF93347691
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhCXKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhCXKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:53:22 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D58C0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:53:22 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e13so11074075vsl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93ckUpQ97JYDAlaqK6dyZt+DFJZfWSRfcVZ5qbI+eMs=;
        b=nBQRzUz1L8n0WYXo6rlGUMY9Mm18aCHJlptS5Iy6CieByW+eO6W70qPKT2dnXSzAcJ
         u04q2T6A+cFbLFbyliKk6ZKUwKz/97/wkcZvqO5LXK7Qit3pRImHkZaYtmNREZ2R4FfL
         oitayKU/3ji0FdtEcViOClcmQsLTSjaF5OFqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93ckUpQ97JYDAlaqK6dyZt+DFJZfWSRfcVZ5qbI+eMs=;
        b=rQxT5OYmrdiHSrNzrj801GhgdiuiJfmZ9nibyyeq9DLWgds9z8ndeb80pZ5mEJbHKa
         JI0yaKkiep3l7T3K7CDRM/yM6lXW7rPE6FCdYiORXr1U3WAsL2MFuxnRPeL0a3IOVAV9
         dzbxxaXt4ycEdPLKn2MVIDbkG8iRlAF5JQ5eKVp9bnZhU4ey1123faXt+JRdxNkMZxpX
         1xISlW5o1S0PaZnZUeQGgwmwJrvUQoxb5tm5q033pIBZ+VSIGcbAsMozeq6IYXjSii/e
         pjlVdKpVuNOMG5qke0us7uq7r3N2bRsy5gqnYmf7cE+r0vySTqBSxkV8deME79mm6WDw
         7uvA==
X-Gm-Message-State: AOAM532imfuRUCPsQG1CSRoiyaz8RqhU+TWn0TkyhZhrtkRqO7R5eiRa
        PBtQKbke/a040ULFXxwPN64yLR5CkC/uFr+ipV5zZJKB9uuuQYQq
X-Google-Smtp-Source: ABdhPJxVq1Tf+GVyRJH4m2hw35vIV9V5TlOJe6DrMCKCc+eMVTNFYbiGpTo3oJSe939tVnzJcZsK3TaSPdIOxPlkrJ4=
X-Received: by 2002:a67:ffc1:: with SMTP id w1mr1150387vsq.47.1616583201278;
 Wed, 24 Mar 2021 03:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003f5e4805bd53a5c5@google.com>
In-Reply-To: <0000000000003f5e4805bd53a5c5@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 11:53:10 +0100
Message-ID: <CAJfpegutVjhx=d9N=q=vNdR+W2uJCryrmxvKAJwz4PgWP0va1w@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in walk_component (2)
To:     syzbot <syzbot+c6aadfbde93979999512@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: fuse: fix live lock in fuse_iget()
