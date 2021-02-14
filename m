Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4426031B25B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBNT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBNT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:59:00 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D57C061756
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:58:20 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u4so5369519ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bi9/tKLqRB7XYTeD4JTt31R6u9zSQtiGRVhGjjfzfY=;
        b=fv4gYMv1+2fbiPpwBeB0jGFCIA9aDAvFWgbDxFzpMUm1MKTndG1UKhmEYtV0Ph/GHW
         gjW8DZp2ry1tCTVHqfAdewsjXWWJ9WFVPwcaeBVwhFrumV44VTB/6PF2+QJQGm4eQYjp
         XAfkCXf4NQjAdS9ubtbtVcoW8zRpOWxNxbadE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bi9/tKLqRB7XYTeD4JTt31R6u9zSQtiGRVhGjjfzfY=;
        b=iQ9tj2m8qBJIohnEFtbXSEtKKkTkr/dqg+dp9EZZV//hO8bD9xqa3ouiwc9VIHRvY/
         HE+DfXm+AJ9YYx4GWGt8s9OZTYkV6avtXCzt0SwPSByOaOOpI9Mwg+1pWvnNCFCwWbBt
         W/qO8W+DMwjE2GVCrvjqnWLpTkJxfpiQvFc/Ii/5HVCvHH4iUMwZngw0Vi9UHHVl/ufH
         JZuIxeT/Uo4YaQVzGJ8mEMNxuGhzuPwlA3f1RScF7gY+1571XDI2PEPqyAuqkzsrdV53
         wk2sLhHJSqTIKyZikgoD5tTM2UWdfZgYP0UmbVOvdfVmrVX9EXS0OS+AGC7jPMGSkUTw
         858Q==
X-Gm-Message-State: AOAM533ATH0jurkg299SgbxFezBSgkdKoIUojOc+4O7oNctpnEOGOZs7
        2iYXBFtL3EzV321mVM4zvaI6LzHljdGGvg==
X-Google-Smtp-Source: ABdhPJzmuvL4mLjGLVrPTbRmtNYJHRRDO6lwtzrnvSwv7zxx+/+CBIglJ8bKEWXXn6EC/XLZ8CsVlA==
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr7615850ljp.318.1613332697244;
        Sun, 14 Feb 2021 11:58:17 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d19sm3370551ljj.51.2021.02.14.11.58.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 11:58:13 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id k22so4720868ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:58:13 -0800 (PST)
X-Received: by 2002:a2e:3910:: with SMTP id g16mr3229377lja.61.1613332693197;
 Sun, 14 Feb 2021 11:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20210214171328.GA5314@duo.ucw.cz>
In-Reply-To: <20210214171328.GA5314@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 11:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCp5n3sB_hDmOLSPiJcwJm9RErBHN_6ABhRWyVEkY4Xw@mail.gmail.com>
Message-ID: <CAHk-=wgCp5n3sB_hDmOLSPiJcwJm9RErBHN_6ABhRWyVEkY4Xw@mail.gmail.com>
Subject: Re: [GIT PULL 5.11-rc8] LED fix
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 9:13 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Unfortunately, for some reason request-pull is not willing to
> cooperate, so I'm just doing this manually.

The reason request-pull doesn't cooperate is actually spelled out explicitly:

> pavel@duo:/data/l/linux-leds$ git request-pull master git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ 92bf22614b21a2706f4993b278017e437f7785b3 > /tmp/delme for-rc8-5.11
> warn: No match for commit 92bf22614b21a2706f4993b278017e437f7785b3 found at git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/
> warn: Are you sure you pushed '92bf22614b21a2706f4993b278017e437f7785b3' there?

Commit 92bf22614b21 is my rc7 commit. And it's not in your tree (which
is based on rc1).

Why are you giving raw commit ID's to git request-pull? Particularly
ones that aren't even in your upstream tree? Git figures things out on
its own, why do you point to the rc7 commit that has nothing to do
with what you're pushing?

And yes, that commit exists on kernel.org through my tree, but it's
not reachable from any tips in yours (because your work was based on
earlier state - which is as it should be).

              Linus
