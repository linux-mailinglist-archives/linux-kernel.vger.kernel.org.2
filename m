Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8916436CB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhD0ScX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhD0ScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:32:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7FFC061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:31:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h36so41010487lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZr+uThAt0ciiksb5ytQDUkfPwWrBd07uVSgmxyj1eE=;
        b=gXB/ev241A+ABixVHuF9uRXX2mdp46DZLus2UrKHidpghpb8UTG1oK9rLlZSG14lu2
         oyJS2lcfpHAvsJ/yLkCwJ206dAagh8K5AtMj9DZ2VaOEmTqTjgd/6PzhpBp/fJYskUja
         4roVrTYHPkKU2t6wth7V8TjlUfD6U7WLpwahk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZr+uThAt0ciiksb5ytQDUkfPwWrBd07uVSgmxyj1eE=;
        b=N01cO+Mh/WYsSNtnm0tyzx4WokOBAAD3kHeMBMHq8iqmmcbIo0knT9eJtab5OngNYG
         bfyAyLlGAAK2hEFfuwuDs1Br7x4F9CAJXYwDUaCuuPoqwjYfDd0tZbl834DjzlWj4sf4
         R/+ry5DesMOS+NRu4aZKofwgLCQJcoWK1QfJtmClp+s/LnJyNaTfa/PXh69p2ysZKczB
         pTO7TAlFSnrnwqERMgyIh99KmXRj7orJ9AYQ4cxOG3SnjFbY6K2NuXCPjrwVIsh0OmKs
         URR9KqUkzOYYwwyOn/4SxtOL9BR0yywUNNQrWaY2k1PXrFy7ko95f0eJh85m+yvqpj4Z
         nplw==
X-Gm-Message-State: AOAM530ZqgMp1XrAJITr0GtogtEHpk9IEJBxV6MR6K9kPampDYQL5jT4
        EoNjw5rqGBl40srkhndvYarZOJvtdzbeYG+W
X-Google-Smtp-Source: ABdhPJwjk26eeJKpPiFTuQHLKZd0WcgB70PswtkJW8Pj31IGqdyJqjbGzauK204FbvhNbhQEzMjgZw==
X-Received: by 2002:a19:c7c5:: with SMTP id x188mr5322699lff.313.1619548295520;
        Tue, 27 Apr 2021 11:31:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id j18sm597021ljc.132.2021.04.27.11.31.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 11:31:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s9so11399389ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:31:34 -0700 (PDT)
X-Received: by 2002:a2e:880f:: with SMTP id x15mr15839732ljh.507.1619548294774;
 Tue, 27 Apr 2021 11:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <YIdByy4WJcXTN7Wy@zeniv-ca.linux.org.uk>
In-Reply-To: <YIdByy4WJcXTN7Wy@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 11:31:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNdEKs-LoF9DKYW8k5Eg2rPjqqWf047TxAY3+v4W=iRQ@mail.gmail.com>
Message-ID: <CAHk-=whNdEKs-LoF9DKYW8k5Eg2rPjqqWf047TxAY3+v4W=iRQ@mail.gmail.com>
Subject: Re: [git pull] fileattr series from Miklos
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 3:42 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The branch is straight from Miklos' tree (it's #fileattr_v6 there),
> sat merged into vfs.git #for-next for a while.  Not sure what's the normal
> way to do pull requests in situations like that - do you prefer a reference
> to my tree (as below) or to mszeredi/vfs.git?

This is fine. The only downside here is that there was no signed tag,
which I would have preferred - either from you or from Milkos.

We've had this a couple of times before, and I've started trying to
"document" it with a "Pull X from Y via Z" thing. See for example

   git show 836d7f0572ca 70cd33d34c60

which is a similar kind of thing where Borislav just forwarded Ard's
work (and it has happened in the past a couple of times without those
kinds of notices).

Btw, unrelated to that, this pull request got a conflict with

  64708539cd23 ("btrfs: use btrfs_inode_lock/btrfs_inode_unlock inode
lock helpers")

which I think I sorted out correctly (the "inode_lock()" is now done
by the VFS layer for the fileattr things, and the btrfs use of
"btrfs_inode_lock/btrfs_inode_unlock" ended up being undone). But just
to be safe I'm cc'ing the btrfs people involved. Please double-check
that I didn't screw something up.

(Note: it doesn't show up as a conflict in the merge itself, because
each piece was a straight "take the case from one side or the other",
and in this case "take it from the fileattr" side meant that the
inode_[un]lock -> btrfs_inode_[un]lock conversion for the fileattr
cases just went away).

                 Linus
