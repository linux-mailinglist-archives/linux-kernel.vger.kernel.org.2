Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE45E379351
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhEJQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhEJQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:03:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44437C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:02:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m9so17202967wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbmoWY4vRsWcwb5kwZUhO9zSK/gGwniadxXkrUiz8aU=;
        b=K6HVrQS1PNUwW4vcyq8Rco0zF9mhznEP99RSbGP8FjS32CScmkMnbwaNKzuokW8URj
         Lopgf309Lw6KTdz9TxmCK9oIljoRq4NWKMezZcAlg4iQsOH2wt9WhmR5z/2ezYOtlwSx
         uUQxctR7zkEE2EJSe6eUjwVxN/LP9j6IkUt/bFhBRIAKw3aj1PffEicj98ikWHx8PkRd
         TIjDbFercnoRXVEik5Gq5IDUdZpO7qZr6Qeo/ujVD/1YQvnWoerwUr0PVbpbF87h3jl0
         LfwH5t13p3Vx91X+SdhjPArCJtaldhca5HXCuWvMTl7B4ORqlBSglYLi8hHaEw+rlvZ0
         5CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbmoWY4vRsWcwb5kwZUhO9zSK/gGwniadxXkrUiz8aU=;
        b=IFxkiKP81q8fV+WGUssoBk6bjoWBOo6N8M1TAa9HLXsJoCvOJlA2QzfQd7KwRUPlmc
         jJRnB24NB5Vv46B7c5p5BoIg1W85JSS+MfKA61wkJk2wX5skzB/+ViDy64buhBv+Jl+V
         JWg5mW3qopn0hOJl+39rhpWHUxcO/B5eajsxrFO3WHW9UGdI+58eRdy9+V2sjO2IJrTf
         Y/Wn6jZ/7I8+TO1hyU3gV3aqsGo6bcI3Y/4xND3t2wzilR7uuEfMf95CVWcVg2HTjnJo
         7t99A8xrYEP51bCM55E7lVSbBaywcWw5AxL7OuZ8JVjqZP02Xvx5vVbbvfXOEqf+869G
         mw5Q==
X-Gm-Message-State: AOAM531AnXSfPwO0leQuOTzbJ6y663CfRjBh9XnWsXIZtY0fSaN/Cig1
        kp2QTavRN2WetcmrkIYvvC1+Kg==
X-Google-Smtp-Source: ABdhPJyru5lvwFS2GWijg2hAYBhcdYg0JOFYldQiZGfI9fsqX1vm+zlou4m9HqYPgnvO+mySRbNvEQ==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr30606778wrs.134.1620662565867;
        Mon, 10 May 2021 09:02:45 -0700 (PDT)
Received: from snaipe-arista.aristanetworks.com ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id c62sm9244960wme.5.2021.05.10.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:02:45 -0700 (PDT)
From:   Snaipe <snaipe@arista.com>
To:     gscrivan@redhat.com
Cc:     christian.brauner@ubuntu.com, dwalsh@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, Snaipe <snaipe@arista.com>
Subject: [RFC PATCH 0/3] new mode 'shadow' for /proc/PID/setgroups
Date:   Mon, 10 May 2021 18:02:33 +0200
Message-Id: <20210510160233.2266000-1-snaipe@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510130011.1441834-1-gscrivan@redhat.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Giuseppe Scrivano" <gscrivan@redhat.com> writes:
> This series is based on some old patches I've been playing with some
> years ago, but they were never sent to lkml as I was not sure about
> their complexity/usefulness ratio.  It was recently reported by
> another user that these patches are still useful[1] so I am submitting
> the last version and see what other folks think about this feature.

For context, the reason why these patches are useful to us is that our
use-case of user namespaces includes running executables within an
{u,g}id space controlled by the calling user, while still remaining in
the original root filesystem.

For example, we use user namespaces through one of our tools[1] as a
substitute to fakeroot in order to build software that would otherwise
need root permission to package, like sudo or ping, where setting the
setuid bit or more importantly file capabilities are necessary.

In these use-cases, still respecting the original group membership is
actually desired. Not just because of the negative-access permission
issues, but because it's possible to lose legitimate access to files
if using setgroups while holding membership of unmapped GIDs. This can
be very surprising behaviour, especially when, as an example, the caller
suddenly loses access to their current working directory after entering
a user namespace and using setgroups.

I've seen other solutions to the original problem mentioned, like
introducing a new sysctl to convey that the system does not use negative-
access permissions -- I believe these alternate solutions do not solve
my second point about losing legitimate access, while this patchset does.
I've tested an older version of these patches and they have all of the
desired properties:

    $ id
    uid=1000(snaipe) gid=1000(snaipe) groups=1000(snaipe),998(wheel)

    $ bst grep . /proc/self/uid_map /proc/self/gid_map /proc/self/setgroups
    /proc/self/uid_map:         0       1000          1
    /proc/self/uid_map:         1     100000      65536
    /proc/self/gid_map:         0       1000          1
    /proc/self/gid_map:         1     100000      65536
    /proc/self/setgroups:shadow

    $ ls -l
    total 8
    drwxr-xr-x 2 root wheel 4096 Apr 23 14:18 allowed
    drwx---r-x 2 root wheel 4096 Apr 23 14:18 denied

    $ bst sh -c 'id; ls allowed denied'
    uid=0(root) gid=0(root) groups=0(root)
    allowed:
    ls: cannot open directory 'denied': Permission denied

    $ bst --groups 1 sh -c 'id; ls allowed denied'
    uid=0(root) gid=0(root) groups=0(root),1(daemon)
    allowed:
    ls: cannot open directory 'denied': Permission denied

Ultimately, we want to make it safe to run our tool as an unprivileged user,
and while we're currently riding the status-quo of "safe-to-use-but-not-
if-you're-using-negative-permissions", having a way for us to do the right
thing -- without relying on the gotcha that a system administrator must
configure a system knob to make it safe -- is quite attractive.

[1]: https://github.com/aristanetworks/bst

-- 
Snaipe
