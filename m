Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2332B3D90B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhG1Ocf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhG1Ocd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:32:33 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF473C061764
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:32:31 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id o8so1551170vss.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJo0PHoVbiVKIGpz4WbEXWXkHC4bfOhyP6K61KoB2LM=;
        b=S395aemGWoIdwNFYBBqyRA8mmCGQwttnLueWYxgibXsl/9W9ctYNpsyNsdJ7suhCFl
         iH9a/7h92eGx82xC6tg4Zs2lOEIeZg85gZbNLH47hCl1haxCJBTa2gL3dD8ezJOaoPpD
         CCY+Bl6InYozLIUDPOSDUU/WkLEF6OyWS4WCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJo0PHoVbiVKIGpz4WbEXWXkHC4bfOhyP6K61KoB2LM=;
        b=YmnQvqOq+cnrT/XP2lCW4jzNID+2KvP654NfMQc+Ubn8kvoH3AKgm80Q2p22WA0MaX
         nWV4XlrVgschHawjCDN+hifoMhLubTRSnZzvZa9D2gO1cvK4WqiIxCi6enZB3N4GwF73
         jn6zZDXgG4jLgbostWgx4fzwTGqM3sYP05PqylP/XjNtHJDJ89NneKeUGJfvZDdpRoyx
         d9Jz4ZmmO7IustbbOOXvaoJj4PAZmb5Hsrr5xR8W8Djl7JbJPSGTiCBQaNVIz2nEdQfp
         Lp+oE1b7LJPmGBd1Oks273JETmd8z+efjE7Njr/9pc1oC/ZOeqEb+8w3bqD2X54K1M0M
         ouAQ==
X-Gm-Message-State: AOAM530Tuh9g3hCS4FbfsBENyHVArV84usIP+E8gekswVsEszZqScdUk
        wQP8OiQJRBmDQ+VwJclY+ogEcGl39JUACqsKRwWX6OiaQ3I=
X-Google-Smtp-Source: ABdhPJykaCzneBxaJdJtv56s3tLVJvYpO/nycTzEPfmIqI1jhBvMvWYg6rp0W6fqxmetTLMPXxBObPZmifwXmXznxhM=
X-Received: by 2002:a05:6102:2ca:: with SMTP id h10mr22658074vsh.7.1627482751123;
 Wed, 28 Jul 2021 07:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052a12105c82facde@google.com>
In-Reply-To: <00000000000052a12105c82facde@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 28 Jul 2021 16:32:20 +0200
Message-ID: <CAJfpeguXWAJRyRn=8tLRq41kqjuSnX9VNqNT_V2+jhuttC0nEw@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in iter_file_splice_write (2)
To:     syzbot <syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
overlayfs-next
