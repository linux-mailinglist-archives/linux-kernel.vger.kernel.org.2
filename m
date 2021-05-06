Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8240C3759B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhEFRwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbhEFRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:52:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EABC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 10:51:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o16so8190498ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tz9CyNHlTYlgYPLN7fAWYM+2mWJStrWfSD9j5wuxyg4=;
        b=ebP3CT9ifwaFJPDmHk5AT9swfP7XAAdoLic3YkHtLW2P2D6QLx0RlbCgSO6qKDDD/c
         sG6cTaSoc0VGes0VQkcQxTt0D3a+CVjnpDqxW224K77CheDjpbWK2OTM7pNU+cFDmbp/
         51fCFed8e6C5mMXhHuPiEJ1o17bu+Vshii/n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tz9CyNHlTYlgYPLN7fAWYM+2mWJStrWfSD9j5wuxyg4=;
        b=aqrvYngd345IcW0/2ER+aFErsxSA3nra6o0jvU819kiK7YCOpOHbdng9zdBxSSG1gO
         +E8YXIy7OE/gi3S7dJtkN8kd/inTpeDXPl5uU/g/hXNFBg1xXxPndACM5CtLYgdUDS2M
         pgt+F6YiC2m1B68xAdSe/oqqiRHTIysgPRAxudJuioAqfW9rXPhEtSrbjleotpoBZD8a
         2v7Z2pvgSKZ6QK4gS1ujo9Md+g0Vussa4TYNsazsiGQz3QP0l2Cd119XDkJf0s7HGoha
         3GtroZlbBNUT8RCXYIguO4VqshtH0X1WvjHoKABYvaIausLsOlzL25q94xTBi1aF4Wmi
         X6aw==
X-Gm-Message-State: AOAM530a1+8Sg/ykXemvUKeeVlkgeVR9bMpl56OATouKat1qnrEbEhrf
        a4pEmtmJfFEGMCPtzlxT8GToCHNf6LNFVky8x3M=
X-Google-Smtp-Source: ABdhPJwLKJYfx767ATU7OSlfrEtaDYESFZa5/HAlZ7SsB3tB0eyXEnJkgcdC2FZyUpw8s3nZlTA3Kw==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr4556513ljh.150.1620323510257;
        Thu, 06 May 2021 10:51:50 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z9sm1109057lji.139.2021.05.06.10.51.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 10:51:49 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id b7so8174905ljr.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 10:51:49 -0700 (PDT)
X-Received: by 2002:a05:651c:333:: with SMTP id b19mr4360748ljp.61.1620323509360;
 Thu, 06 May 2021 10:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210506143312.22281-1-idryomov@gmail.com>
In-Reply-To: <20210506143312.22281-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 May 2021 10:51:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjQgUYrMD_tTm5M1BqeN5Z7h_z5EkU65RXAnEevsTDLA@mail.gmail.com>
Message-ID: <CAHk-=wgjQgUYrMD_tTm5M1BqeN5Z7h_z5EkU65RXAnEevsTDLA@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 5.13-rc1
To:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 7:33 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> There is a merge conflict in fs/ceph/dir.c because Jeff's inode
> type handling patch went through the vfs tree together with Al's
> inode_wrong_type() helper.  for-linus-merged has the resolution.

Actually, the linux-next resolution looks wrong - or at least
unnecessary - to me.

The conversion to d_splice_alias() means that the IS_ERR() test is now
pointless, because d_splice_alias() handles an error-pointer natively,
and just returns the error back with ERR_CAST().

So the proper resolution seems to be to just drop the IS_ERR().

Adding Jeff and Al just as a heads-up.

           Linus
