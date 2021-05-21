Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD5C38C8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhEUOE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhEUOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:04:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E6BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:03:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x8so21191021wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UoyqHaleZ/HFc6OQ6KjZU11ia4r7rg8JChlt0tQ6+mg=;
        b=BJGrsJGpeh5I/S47Z0uWOZDKwjvrKqPYSPGE/OZ8eTPqeIBqKROQqDaTpHJp90ic+v
         8Wf9tbcLfEL0SMQilFVquAGy4NBnM6tVaVlLhKh8+DSyqEWcc6Auu9e0jOZu/V23gavW
         yqDvnBSkhFEEBVRSGFOqGOXM+FQuy9e9C1YSJ8vqdieaerTPRsSF4AK3u8lAH+M9CuLH
         qlSmOroEXkTl2im8E/DCEcP/+h1tNnULM4KFn65NRySKRzxCMBJvHFVGQLkaWj6ap7/k
         ohYl1zJ01y99Yp8g/EjDsXg5274tizqVwIDVECJL5M8KIBUKnqat5bHDoiWVuP5SHgcH
         JTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UoyqHaleZ/HFc6OQ6KjZU11ia4r7rg8JChlt0tQ6+mg=;
        b=iZ566hsxPO1MU6tGeDKO2Ttq1ftvpGAvbDDLybJmhY3WxI8wWEYAQxY+n7Zep+kUbn
         vbb2r+x9h/GQeT4jh7cDBCWVH5ZomC2nzLyj4iJ40TMq2SaupTUV0tQ1CJJ7jGUw6BhS
         En1xXObUz/1BtMkkX2cNqTqtrEuwVdnSuFpTUfDoNH5K6dYxaXyw+8dL+Pw2bArFzQm6
         75na3cARdW9SIe8STzJVhyxSOLHZv/NsqwF4uUfmi5lx418C0ubOEjYCkuys6EyPXnHo
         20zt5BggO3DIkhyXvP/EsQvXQP5obhD2FWdJav47WyzsO/wTkMRaeYFu8bNVUlt1eP0W
         Jh1w==
X-Gm-Message-State: AOAM530uCuf6agSnWTf5QEPdXdbEFUttO0cF1Z9p4oxI1gsq4gmehgzh
        vBfpkB9BHcTveQeZhvNjb06RWaNHnkygQ6SHB4A=
X-Google-Smtp-Source: ABdhPJwfOpUTxsj1ejd+Yicuss9jPZTxqvoXrHVbTANTP8/3HBxYPyKeFeLiuHEOAyxBqmctlGuOSg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr9630626wrt.220.1621605813231;
        Fri, 21 May 2021 07:03:33 -0700 (PDT)
Received: from snaipe-arista.aristanetworks.com ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id r2sm2369042wrv.39.2021.05.21.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 07:03:32 -0700 (PDT)
From:   Snaipe <snaipe@arista.com>
To:     christian.brauner@ubuntu.com
Cc:     dwalsh@redhat.com, ebiederm@xmission.com, gscrivan@redhat.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        Snaipe <snaipe@arista.com>
Subject: Re: [RFC PATCH 1/3] setgroups: new mode 'shadow' for /proc/PID/setgroups
Date:   Fri, 21 May 2021 16:03:22 +0200
Message-Id: <20210521140322.3745998-1-snaipe@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517143321.en2jy2gaxrhdhvub@wittgenstein>
References: <20210517143321.en2jy2gaxrhdhvub@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:
> On Mon, May 17, 2021 at 03:30:16PM +0200, Giuseppe Scrivano wrote:
> > "Serge E. Hallyn" <serge@hallyn.com> writes:
> > > If userns u1 unshares u2 with shadow set, then when u2 unshares
> > > u3, should u3 get the same shadowed set that u2 has, or should it
> > > get all of u2's groups as u3's initial shadow set?
> > 
> > good question.  Thinking more of it, I think a reasonable interface is
> > to expect a child userns to inherit the same shadow groups as its parent
> > userns.  If "shadow" is written again to the /proc/PID/setgroups file
> > then it grows shadow groups set to include the ones the userns had at
> > creation time (which includes the parent shadow groups).  What do you
> > think of it?  I'll play more with this idea and see if it works.
> 
> So when I initially looked at that proposal I was neither "yay" or "nay"
> since it seemed useful to people and it looked somewhat straightforward
> to implement.
> 
> But I do have concerns now after seeing this. The whole
> /proc/<pid>/setgroups API is terrible in the first place and causes even
> more special-casing in container runtimes then there already is. But it
> fixes a security issue so ok we'll live with it.
> 
> But I'm not happy about extending its format to include more options. I
> really don't want the precedent of adding magic keywords into this file.
> 
> Which brings me to my second concern. I think starting to magically
> inherit group ids isn't a great idea. It's got a lot of potential for
> confusion.

To be fair, we already magically inherit group ids -- that's what not calling
setgroups after entering the userns and setting up the {u,g}id maps does.
The new shadow mode does not really cause inheritance, but it does provide
a way for userspace programs to keep these unmapped groups around after
a setgroups, which is currently impossible, and quite sad for the reasons
I outlined in my other email[1].

> The point Serge here made makes this pretty obvious imho. I don't think
> introducing the complexities of magic group inheritance is something we
> should do.
> 
> Alternative proposal, can we solve this in userspace instead?
> 
> As has been pointed out there is a solution to this problem already
> which is to explicitly map those groups through, i.e. punch holes for
> the groups to be inherited.

I don't think it really addresses the problem. If you explicitly map these
groups through, then it's still trivial for userspace programs to simply
drop them after the gid map is written. It just solves the problem of
having control over your additional groups in the userns, which, it turns
out, is already configurable by the system administrator via /etc/subgid:

    host$ id
    uid=1000(snaipe) gid=1000(snaipe) groupes=1000(snaipe),998(wheel)

    host$ cat /etc/subgid
    user:1000000:1100000
    user:998:1

    host$ unshare -fU --map-user=0 sh
    ns# echo $$
    3720498

    host$ newgidmap 3725680 0 1000 1 1 1000000 1100000 1100001 998 1

    ns# id
    uid=0(root) gid=0(root) groupes=0(root),65534(nobody),1100001

This is only fine if we're not interested in supporting both negative-
access permission bits and ACLs. It also means application writers and
system administrators cannot force unprivileged users to stay in their
groups even after giving them control of their own user namespace.

[1]: https://lore.kernel.org/lkml/20210510160233.2266000-1-snaipe@arista.com/

-- 
Snaipe
