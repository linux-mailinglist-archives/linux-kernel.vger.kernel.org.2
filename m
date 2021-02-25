Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6B324F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhBYLs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBYLsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:48:52 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D6C061756;
        Thu, 25 Feb 2021 03:48:12 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id a7so5499176iok.12;
        Thu, 25 Feb 2021 03:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3L7usN+5cmsXeKGLPgVIQPUIqxaAXKtFSZCm0zZ0Hk=;
        b=oBf6vlDmlJBTEeO9ygLoHlDgg7UVVuSXuYc28Nfjg9q3yy/TtXuxWvEJadtVpbFh5a
         tAvKfmgZWO3/LL4wKLwoNl3XrJLB37efdjaupMxFg1k5Ml3I5OutcnzyMrO+MV/GBDNb
         IKSz5lN4anDRqaG99BrmoKRBE0xfPRdOBVuhZ+C6QxKJvbLLRCpbvG6YRvqIAhpk3Z3v
         kyIIHSwXAMFOp8pKoI5Lpz5NY2Vk/WQvtVWs8Yt1QzSdotjyPRIswtg+2z3RiOPlf1EX
         XeKwg9J41LWqHHn/f57g74uR4zXAvZxF3xI4oBcZnDGZtCa2+oQyk6Ur0X5ziG6wRKbV
         PJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3L7usN+5cmsXeKGLPgVIQPUIqxaAXKtFSZCm0zZ0Hk=;
        b=K3Mv81viEFVC1VHOoWpHaGZ4kjd0egCFhVMzAwWYKnEgQM6VdRXe/+LGm5EVhFgUuV
         jZAe02phsO7Qwl5B6nKVdk2GLzCfWq8vG/0bFX8d3d8dGwgl1xkCnNSP2swQTNRMpuEj
         6MUcVjwMq9Z6JzhzOWyhiRs5QSyZwaBdOihYfeM9H2eDvyM3z3b6BAhBYr2F7rNcUk+B
         mIFkt1mLH3ar4m171XGE3H9aN1LkzqS+phAE5WnTBCPFx6GxAMqXuD7hUMTNjU7yKkx0
         VnIDj7H3AwM8fc6CJN77ebbbsAf3whQyR8zhHRXaFK7+zsywVHtlD528WKH5Y0Oab5dL
         w+mg==
X-Gm-Message-State: AOAM5329slfm7u4cv0GPnwemUDWO3v0J6QzWfydFA6I+zx4ueEHkVICE
        hg/JKBY41wzT6VjGwCz0xaBTOcxTRmOyTmV2ShTfb6g98gKJYw==
X-Google-Smtp-Source: ABdhPJw/f34MGRY1uPbeITLqjNsfPAa1w+m4HVjyP0Iido2zkqPagHTuhMpIKQSevXUSvu1nuowj0WnT6tPoA7uB/J8=
X-Received: by 2002:a6b:b452:: with SMTP id d79mr2218002iof.183.1614253691517;
 Thu, 25 Feb 2021 03:48:11 -0800 (PST)
MIME-Version: 1.0
References: <875z2jlr2j.fsf@meer.lwn.net> <20210224133002.13503-1-yashsri421@gmail.com>
In-Reply-To: <20210224133002.13503-1-yashsri421@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 25 Feb 2021 12:48:00 +0100
Message-ID: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
Subject: Re: [RFC v2] scripts: kernel-doc: fix typedef support for
 struct/union parsing
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 2:30 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> Currently, there are 447 files in the kernel tree, which use 'typedef
> struct/union' syntax for defining some struct/union. In total, there
> are ~1290 such occurrences in the kernel tree.
>
> However, kernel-doc does not support it currently, and running
> scripts/kernel-doc -none on emits:
> "error: Cannot parse struct or union!"
>

I will help rephrasing it more precisely:

Currently, there are ~1290 occurrences in 447 files in the kernel tree
'typedef struct/union' syntax for defining some struct/union. However,
kernel-doc currently does not support that syntax. Of the ~1290
occurrences, there are four occurrences in ./include/linux/zstd.h with
typedef struct/union syntax and a preceding kernel-doc; all other
occurrences have no preceding kernel-doc.

Add support for parsing struct/union following this syntax.



I also tested it; here is my quick diff of "git ls-files | xargs
./scripts/kernel-doc -none 2>&1" before and after patch application:

< include/linux/zstd.h:154: error: Cannot parse struct or union!
< include/linux/zstd.h:171: error: Cannot parse struct or union!
< include/linux/zstd.h:181: error: Cannot parse struct or union!
18857d18853
< include/linux/zstd.h:936: error: Cannot parse struct or union!


So, again:

Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Aditya, can you please pick up my rephrasing and send out a v3.


Lukas
