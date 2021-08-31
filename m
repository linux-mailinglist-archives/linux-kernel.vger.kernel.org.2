Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6523FCC79
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhHaRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhHaRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:44:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193B4C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:43:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b4so378611lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnd65774JO8YYmZVOhCC16tnqq32B7o8SgIDuZJ5NNY=;
        b=Xz7mg9NXLim+9Vg9JD5Jw6XT5OV9xbyVxCx9yHvWMsYpvK1sLGgOT6Vdn6dA5zxaf9
         xr+O6z59ZBDsfmnS+iVFCQt/C9bOlQyS/6C3phRAhM8PSgMDhbBjCrj9e9kZQx1Y5SHc
         ErjpSlzPY38B0e9mc65A7J3UWaM010BxzOQIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnd65774JO8YYmZVOhCC16tnqq32B7o8SgIDuZJ5NNY=;
        b=SwcK4SwxILjh7ulNFwhMY9nb8WpoVTsABIbuVy3LTtFtzODugJvT20iwQ0W5O8WoYE
         oHR7lp1e90XZq88gUJ9XsYEg2cvL3FJDvr2Bk8+cLp2Ij1T9raUzJ0ZQ2T6Ih4vU+Tf1
         7boDP5uIN4eCHCOzh5Dbfdmtkw/VAQ4z7KuAm2rQEQ8f8f6c51PxbrtH1yozcezZW92i
         9QYpz/5MPAVDXQG8Cqjn8OFiJCbGn/MSRkr6YkK6sZo2v1okQoJt5ZCYZDPljFAg7JCg
         L774IB3yH+tnwreMD+OzIf2myh4YMrMUFigyV2Vfb20HP7MsHzY9HcB0DZCuR56XoCkA
         xzyw==
X-Gm-Message-State: AOAM530Zbm2cGxJqvtylCQoIk3GsyuRapv/TqqNpAbPqten/t7lISHce
        yGjT8d60eoUeY7KqJhLWqQA9fplr127CbEIUL/c=
X-Google-Smtp-Source: ABdhPJxR8an+e4O47HWwbXJRY2JGcm+gF8VWMQf2Z8+u3B3d6VihB/o+2oEM6Urv8S+kYJZxHHjvog==
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr15943633lfu.280.1630431826142;
        Tue, 31 Aug 2021 10:43:46 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id e19sm2252963ljj.28.2021.08.31.10.43.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:43:45 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m28so470770lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:43:45 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr21985146lfp.41.1630431825288;
 Tue, 31 Aug 2021 10:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvVdBoUW-0BfsxiRAE6X30cqhBtNDvG7pwKdQwsu+wXfg@mail.gmail.com>
 <CAHk-=wiNvB_j3VZYJ1yZqq+9JjgWCO1MUmRsjTKBwQ+x=kB5tg@mail.gmail.com> <CAH2r5mtTLUQa2U=MGHOVk_FsPZg6owMsw+RoTudWxGuoQej41g@mail.gmail.com>
In-Reply-To: <CAH2r5mtTLUQa2U=MGHOVk_FsPZg6owMsw+RoTudWxGuoQej41g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Aug 2021 10:43:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxmDks6CS41PCy_BZG70pjAhcPBV_7ga8kSJySvvDezQ@mail.gmail.com>
Message-ID: <CAHk-=wjxmDks6CS41PCy_BZG70pjAhcPBV_7ga8kSJySvvDezQ@mail.gmail.com>
Subject: Re: [GIT PULL] cifs/smb3 client fixes
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 10:09 AM Steve French <smfrench@gmail.com> wrote:
>
>   So if you are ok with renaming the client dir and module
> name - we can gradually stop using the word/name "cifs" except for the
> parts of code which really are needed to access the (unfortunately
> hundreds of millions of) very old devices which require SMB1 ("CIFS").

I'm ok with directory renames, git handles it all well enough that the
pain should be fairly minimal.

I'd ask for that to be done during a fairly calm cycle, though, when
there isn't a lot pending, so that any rename conflicts will be
minimized.

> We could even build two versions of the module "smb3.ko" which does not
> include support for the less secure legacy dialects and "cifs.ko" which does
> include it.   Is there a precedent for something similar.

I'm not sure there is precedent for that, but that's not a huge issue per se.

Whether it's actually worth it having two separate modules, I don't know.

That said, I'm not entirely enamoured with the name "smb" as a module
(or directory) name, to put it lightly.

Part of it is that it can mean "system management bus" too, although
in the kernel we happily universally (?) use "smbus" for that.

But a big part of it is exactly the history of random different names,
which means that I'd like any new name to be more explicit than a TLA
that has been mis-used for so long.

So yes, we have "fs/nfs/", but I'd rather _not_ have "fs/smb/".

They may superficially look entirely equivalent - but one of them has
had a consistent name that is unambiguous and has no horrible naming
history. The other has not.

> Do you have any objections to me renaming the client's source
> directory to "fs/smb3" (or fs/smb) and fs/smb3_common ...?

So no objections to the rename per se, but can we please use a more
specific name that is *not* tainted by history?

I'll throw out two suggestions, but they are just that: (a) "smbfs" or
(b) "smb-client".

I think "smbfs" has the nice property of making it clear that this is
just the filesystem part of the smb protocols - that otherwise cover a
lot of other things too (at least historically printers, although I
have no idea how true that is any more).

And "smb-client" as a name is in no way great, but at least it's not
just a TLA, and from a naming standpoint it would match the
"smb-common" thing (although I guess you used an underscore, not a
dash).

Again - those are just two random suggestions, and I'm not married to
either of them, I just really don't like just that "smb" because of
all the historical naming baggage.

So if we rename, we should rename it to something new and slightly
more specific than what we used to have.

I'd rather have a module called "smbfs.ko" (or "smb-fs.ko" or
"smb-client.ko" etc) than "smb.ko".

And no, I wouldn't want it to be called "smb3" either. Because it
clearly does cifs/smb1 and smb2 too (even if people would obviously
like to deprecate at least the older parts).

Hmm? Is there some unambiguous name that is in use by the smb
community and would work?

                 Linus
