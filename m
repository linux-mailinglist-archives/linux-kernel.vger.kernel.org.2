Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C762389262
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354461AbhESPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhESPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:20:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D977C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:18:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w12so8079490edx.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+/4m4rfJ/qusBu6xKLeqSfoq/WhFXeBjZFbets1dms=;
        b=L1dTZ/cejTl+mgSkbTA6g3xoBK1uVV3OJBQYenHp/RsDHmtHbJH61VtRY/tS2t9i2v
         6rG/tuZPjwK1A36hZ+ZFrO02elZzCn0m6ck3ZEXouML3ey2StNCu3+0X7DXjif36uQGj
         1D0bU8X/8Sx9Y+dqTtv51adgzo5SWy1LVnKIN2qg6D6Tc/OTHkw3sQQiyOLnPp+hWGMc
         CH2HLX/oWClPhnOEH0OiBAtPOukmLfjLyQIR2fApxy0sqctGF0OUvNi3xBcJX4lAXdIG
         OB3zli27dx9nzBvlk936qedg9Y//j1IiyOMJWaCzkvGJplG6k3DLinY5tU5hP8CldXVc
         b/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+/4m4rfJ/qusBu6xKLeqSfoq/WhFXeBjZFbets1dms=;
        b=qEDlLgycx3tMZ5zWQxzcnLqvRu6eYx7sTd4WaPIWizgJ9QjgYs3DkHO9QHEvbPy1BF
         KIUXcGLn0DPck7W29cAQGoKOh4xCt0j+WzUjd2Yqver/xXsSCJUOL0gLZQoGuqsngC2U
         N7Xr1Ud3PzixL4sA9FqKLl6k8zKOedv8WICSQFKoj2TShTJP0i+/OENJnDEfOXWa44lX
         a75DCbM6R0F2M5CQqV9G+93IVb3oLBWraYFWzfFIu8U6FWln+NWETpJoFVnwCl8zuNPh
         OCvC7eHizK4Uu0yy0LiIyLu9h7h7NdXUu8JHDA80ings+rCyuvHju4mLTTX8yux/m9g9
         K2BQ==
X-Gm-Message-State: AOAM531WPZ1h4qSpXJ5MqfCYayfkVnevjnECPER4HhJcbva3V5+5+Wen
        xo4cEXKk3k7vcb9rm+op7guVuUyU1YJD42hljFDi
X-Google-Smtp-Source: ABdhPJweTp1Zx0DSC45lRP2AIkDyyygfjOr7HW1yUjrFHA4wGjuIWy4HGyTLZRX5S/SFeMSmMrf9Vm79x2hCKHCyc3E=
X-Received: by 2002:aa7:c349:: with SMTP id j9mr15031390edr.135.1621437526510;
 Wed, 19 May 2021 08:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210519113058.1979817-1-memxor@gmail.com>
In-Reply-To: <20210519113058.1979817-1-memxor@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 May 2021 11:18:35 -0400
Message-ID: <CAHC9VhS=PDxx=MzZnGGNLwo-o5Og-HGZe84=+BBtBCZgaGSn4A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Create io_uring fd with ephemeral inode
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     io-uring@vger.kernel.org, Pavel Emelyanov <xemul@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 7:37 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This set converts io_uring to use secure anon_inodes (with a newly allocated
> non-S_PRIVATE inode) for each individual instance. In addition to allowing LSM
> modules to enforce policy using the inode context, it also enables
> checkpoint/restore usecases by allowing mapping the VMA to the open fd in a
> task. Offset is already available to determine rings mapped per region, so this
> was the only missing piece in establishing region <-> io_uring instance mapping.
>
> LSM tie up has been left out of this set for now.

This brings to light something I have been trying to resolve for a
little while now, but I have been finding it difficult to find the
necessary time due to competing priorities at work and in my personal
time.  While the patches in this patchset are a necessary dependency,
there are other issues which remain unresolved but which are now
public (although the problems were not buried very far in the first
place).  Further complicating things on my end is that the system with
my current work-in-progress patchset was taken offline two days ago
and my office is under renovations :/

Give me a day or two to get the patches off that system and I'll post
them here and we can start the process of kicking around solutions
that work for everyone.

-- 
paul moore
www.paul-moore.com
