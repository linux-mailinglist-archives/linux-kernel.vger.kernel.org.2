Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09813F4ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhHWQ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhHWQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:59:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18029C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:58:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i28so39289463lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98PHTWq7ky4uIAhtxpYGbR+A+DrEV4QAqPeio6dZ76c=;
        b=XYZgeUhUnJcXD4fVkA+dF4XVXeqfUj+huK6g+OxtSkKhEM5JL/fWZ3SpGPJMJ7MbM/
         VZQsdqy/SaE+gChury1wlKIgbV40Thmnbjc4otuiITwu3beKN6i/Lu7sNBI5YV5KUuOa
         ZFTHG7omc6VajNPz+K7hNjB8Bgm0WhNsQG0Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98PHTWq7ky4uIAhtxpYGbR+A+DrEV4QAqPeio6dZ76c=;
        b=ACpLyBu5VtPl8/WpNSE2rTrJrkMMkNN81wY+cuYES/jri9fN/202M+JXssGTOq95ga
         bUg6FZl4rSvhTWzXF1hJ+lVoHV3famIWr4IjnKYLXLIZ/NzuL4WEavqCucx6vSOxRzK5
         4Nht9UOBAVHZATa61HA2wcd4oa/w2MFrj8nsuTGpf/1DlHcwH4h6n4yzP82mS5CHacgj
         AWW079vCj9z0OyxljMCiQU3mFsh+VNGRfHhKqHU+lvV3YOlt0+v6FC0EzptsNywRCRh9
         L8golHl88bxEaYF8/6/G0loNAZdIAL0enN+DdVE9RoBc1j4Ga2g01Pllxw5jkU5yJs1j
         XHhg==
X-Gm-Message-State: AOAM53281OFxY6unp24m7bTF2iAin/CaSOG2+dKDv5b19v+Wwu1n5TCE
        Re+zB1wQXtmc312t51UsZEG99QrtvctmwgBU/7o=
X-Google-Smtp-Source: ABdhPJyEaDbJ/yJbNOFObZt8zxEGpn6EyCG2vQjeYhpG7cy+3FXxv194xUKzdRAFqkSReFJwOErotg==
X-Received: by 2002:ac2:5fc1:: with SMTP id q1mr25311988lfg.92.1629737897751;
        Mon, 23 Aug 2021 09:58:17 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c23sm1497805lff.194.2021.08.23.09.58.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 09:58:17 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id x27so39253555lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:58:17 -0700 (PDT)
X-Received: by 2002:a19:500e:: with SMTP id e14mr24746968lfb.487.1629737896948;
 Mon, 23 Aug 2021 09:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <4e3e0d40-df4a-94f8-7c2d-85010b0873c4@web.de> <20210819133128.45ef4353@coco.lan>
 <c56ec571-2278-95e9-2028-990e03159c3f@web.de> <20210822194709.4b9d33d4@coco.lan>
 <be6ac929-2443-ff55-3e11-6a86d6472e0e@web.de>
In-Reply-To: <be6ac929-2443-ff55-3e11-6a86d6472e0e@web.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Aug 2021 09:58:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSadWPfzQ_hOqbjq6c_xwJs8GLHTyznhXRvDF5Yrs4FA@mail.gmail.com>
Message-ID: <CAHk-=wjSadWPfzQ_hOqbjq6c_xwJs8GLHTyznhXRvDF5Yrs4FA@mail.gmail.com>
Subject: Re: [Regression 5.14] media: dvb userspace api
To:     Soeren Moch <smoch@web.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 7:59 AM Soeren Moch <smoch@web.de> wrote:
>
> Linus,
>
> Is what I described directly above the new linux maintenance policy?  Or
> is linux media a private kingdom where the community should keep away?
> Is this a place where the subsystem maintainer is on a mission to
> destroy everything instead of maintaining and improving it? Please tell
> me what I understood wrong here.

So technically, the regression policy for the kernel is purely about
the ABI - the _binary_ interface. That seems to not have broken - old
programs continue to work.

We very much try to discourage user space applications from using the
kernel header files directly - even projects like glibc etc are
supposed to _copy_ them, not include the kernel headers.

Exactly because re-organization and changes to the kernel tree
shouldn't be something that then causes random problems elsewhere that
are so hard to test - and synchronize - from the kernel standpoint (or
from the standpoint of the other end).

That clearly doesn't seem to be the case in this situation. Which is
annoying as heck.

Mauro: there clearly _are_ users of those header files, and even
apparently that one old driver out there. And those headers were in
the 'uapi' directory, so while it is annoying how user space programs
used them this way, I think it's also not entirely unreasonable.

I have reverted the header file move. But I would also heartily
recommend that whatever user program includes those headers (VDR -
anything else?) should take snapshots of these specific kernel
headers.

I'm not convinced that it makes sense to move the av7110 driver back
from staging - it may continue to work, but it _is_ old and there is
no maintenance - and I would certainly suggest that any other
out-of-tree driver that uses these old interfaces that nothing else
implements shouldn't do so, considering that nothing else implements
them.

So the only thing I did was move the header files back, and mark that
move to be backported to 5.13 stable.

           Linus
