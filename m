Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32331A957
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhBMBJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhBMBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:07:36 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115DFC061224
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:06:08 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id c17so148449ljn.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6jTxP9hlbcUR9+3iPNQ9HmsqF25QNS6zvjTzXBH5E4=;
        b=WUNxTILAYi3Kk+wVUIaUVhIr3oaiaHaDjKr023ekUsCD6VQNr+/uPlhMEL6q29t3EB
         7gNdhrTjI0bG4chV1tfJBSEWmnvTFlDxKHjMtcZld38+fszGfI/ow6zlOY5oPPFVrq11
         U9kc9/PviiJUNwLPvQe5fwcbGhKWs2MNkDWS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6jTxP9hlbcUR9+3iPNQ9HmsqF25QNS6zvjTzXBH5E4=;
        b=l0l6YnlD/e6q9WxcxBieyg7St+tOwZ0cx83ysGMynHB0nqkQZlVySCDK2sf3yaI8I4
         UPnKmO/a/7rzwo/9CBnSZq37uw1Ilp/c7T9Vj58GmULPKI2d6jbu0Zs4IJwUMDMdj3fA
         f0uh1qao1fNme04mCxrCMrNI8n7PPJCBDdfuRUDLiMnJLEAWFQ1hXKvgkOGgYcfN2cnc
         ZSDO0I9JTXHfJz83/wheYZccnzqy4cuOGF/Qg9+N11mk7cVmC+2oC727P7DIjeMwHr1w
         3/0P/8vh8SPAeJF3t8FOlObPvNwL9rbqd/VPfFUrv3d52K0Cziem6G8KnADQucjfnPNw
         V4Fg==
X-Gm-Message-State: AOAM532bG78xinzQy40ndpZ82Rb2uvgcWkfT7BkoSayNS/0J0e4ZCBQY
        0/ghWe4U/nXAL98TyVa8tKmlvLzaETQ/OQ==
X-Google-Smtp-Source: ABdhPJwcNvf+nyF56F17xgpyITE7G0/lKIjrcxkT/9o8L6aZXPJ8T0R9AL4a1b/O6mZS/o5idFKiAg==
X-Received: by 2002:a2e:589:: with SMTP id 131mr3134526ljf.336.1613178366332;
        Fri, 12 Feb 2021 17:06:06 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p23sm1896094ljh.10.2021.02.12.17.06.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 17:06:04 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id e18so1138608lja.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:06:04 -0800 (PST)
X-Received: by 2002:a2e:8049:: with SMTP id p9mr3052102ljg.411.1613178363694;
 Fri, 12 Feb 2021 17:06:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk>
 <1330751.1612974783@warthog.procyon.org.uk> <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
 <27816.1613085646@warthog.procyon.org.uk>
In-Reply-To: <27816.1613085646@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Feb 2021 17:05:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi68OpbwBm6RCodhNUyg6x8N7vi5ufjRtosQSPy_EYqLA@mail.gmail.com>
Message-ID: <CAHk-=wi68OpbwBm6RCodhNUyg6x8N7vi5ufjRtosQSPy_EYqLA@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 3:21 PM David Howells <dhowells@redhat.com> wrote:
>
> Most of the development discussion took place on IRC and waving snippets of
> code about in pastebin rather than email - the latency of email is just too
> high.  There's not a great deal I can do about that now as I haven't kept IRC
> logs.  I can do that in future if you want.

No, I really don't.

IRC is fine for discussing ideas about how to solve things.

But no, it's not a replacement for actual code review after the fact.

If you think email has too long latency for review, and can't use
public mailing lists and cc the people who are maintainers, then I
simply don't want your patches.

You need to fix your development model. This whole "I need to get
feedback from whoever still uses irc and is active RIGHT NOW" is not a
valid model. It's fine for brainstorming for possible approaches, and
getting ideas, sure.

               Linus
