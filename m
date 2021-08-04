Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEC3E09F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhHDVWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhHDVWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:22:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D26C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:22:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n17so4139055lft.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJEIF1MBhfOV8x4z5f0qO8eGLWYyB7UB8BJTiU6/7O8=;
        b=Q2ftN7/c7umZq4SmFVMuZAx+rzkbimz0K+YLyZ2KSXIJIziAIdaJ1KaBVnmQ8yvqOV
         5AenidY5GXZnjRTV0HTOrGg2f1kpY0+DQKSxHE/DUDWfWjyN4nQTqvWmBPfjg8JC7sB1
         vh9PgKg1OAZxkr+gDgTtrHsxZQ8LH4aqtOPlCeSu/WOhOFetxTeqt52R8m7WeiDqM+w2
         RoSDZZyMgl2KMFT+Sa74k5ou4I8gl4yURTdk7D6kriityAGqpizx6nch2QntcLoA6f7p
         6d7xGQfm2nj12pxanrd0E59+xaOt6xQpIH7RydBRcAANUsWeaIxHCzXsTkM61EsSY9Bd
         K7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJEIF1MBhfOV8x4z5f0qO8eGLWYyB7UB8BJTiU6/7O8=;
        b=TpDuvXfbpbNMhHRrvyQBWoFS0tVRWnJ5lIXE6YLuZoKr/p/gSLG0RDOEVpYeSbx5NB
         b8vKznidv8Nz50CcICkI/lLOFjAXVArJSEvYWSY6HwSHTIoYWoABGt0uX22wDA+/YIum
         Ab+lgOZ6U7MIcElFFnNFcePPiAOkRtPLWZmvuFEF5EGiSPmehaGG+mjamIG29jvg2GUb
         ZrVmj6zYiMD5jNsRXnlMQwPreBqg0UgNZx8Rw1KQ5Et15qwoCv5zuJOwtfKGhCegoPAG
         w46kYhbTtMYwRiPdYB4yFy9kgsizGgHnExIFx1OzGaMia5DrvesZv8kQVihzZh7DnLYI
         bdlg==
X-Gm-Message-State: AOAM533ato+K7J9fvAqAQFZMTShnkzfbn98rjip4JtO0H/qMdvjCK5G4
        0/g249trQWQfaWBi0VjlTiEiegsinp+tdEWSCn34Jg==
X-Google-Smtp-Source: ABdhPJy/WQsmj7Ah+zKiTmlR/rxywqx0xCrCM7jCG3pMSJQFZyirN6Z3oXQmXjHNFmQzT8kSDupixHzxvVtqXXAP+M8=
X-Received: by 2002:a05:6512:3f16:: with SMTP id y22mr853067lfa.356.1628112147822;
 Wed, 04 Aug 2021 14:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210731175341.3458608-1-lrizzo@google.com> <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
 <20210803230725.ao3i2emejyyor36n@revolver> <CAG48ez2TEP0hsRjLACVmRppMEk6Z9aREcGL498EKhdBBXSRsoA@mail.gmail.com>
 <20210804152148.GI543798@ziepe.ca>
In-Reply-To: <20210804152148.GI543798@ziepe.ca>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 4 Aug 2021 23:22:01 +0200
Message-ID: <CAG48ez1U9OKoc3EUHLOTRvm67Bprrmznr9_49cKPU1FsjcsRKg@mail.gmail.com>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Luigi Rizzo <lrizzo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 5:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Aug 04, 2021 at 04:42:23PM +0200, Jann Horn wrote:
> > Since I haven't sent a new version of my old series for almost a year,
> > I think it'd be fine to take Luigi's patch for now, and undo it at a
> > later point when/if we want to actually use proper locking here
> > because we're worried about concurrent access to the MM.
>
> IIRC one of the major points of that work was not "proper locking" but
> to have enough locking to be complatible with lockdep so we could add
> assertions like in get_user_pages and find_vma.

That's part of it; but it's also for making the code more clearly
correct and future-proofing it. Looking at it now, I think
process_madvise() might actually already be able to race with execve()
to some degree; and if you made a change like this to the current
kernel:

diff --git a/mm/madvise.c b/mm/madvise.c
index 6d3d348b17f4..3648c198673c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1043,12 +1043,14 @@ madvise_behavior_valid(int behavior)
 static bool
 process_madvise_behavior_valid(int behavior)
 {
        switch (behavior) {
        case MADV_COLD:
        case MADV_PAGEOUT:
+       case MADV_DOFORK:
+       case MADV_DONTFORK:
                return true;
        default:
                return false;
        }
 }

it would probably introduce a memory corruption bug, because then
someone might be able to destroy the stack VMA between
setup_new_exec() and setup_arg_pages() by using process_madvise() to
trigger VMA splitting/merging in the right pattern.
