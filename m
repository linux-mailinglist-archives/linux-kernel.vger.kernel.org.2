Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF4325B29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhBZBHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhBZBHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:07:25 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31458C061794
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:06:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id g5so12009883ejt.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hshTohekKVzxbI8Gdg4o7wDfhyGczePTc6NMf/Dm1B0=;
        b=t8Jhg/Wo4q4oMpwBzWgLwhR2qoUKb1jrUkLmUrJbhzrdFa1lvtizQEf/FQBlf4CxX5
         kfPYsVQXSwyirI34aU5APwxO2Wi1OfjPAqb9789iPnqnUGIOrQm94kKJ3NVewuGJzH5q
         70hpGID4SGwqyrlm5Jj8QwiJPPyVoKoVCjS7xmzvr5kBP9/1CxPppioQGyLBb1DMP0de
         zRvcaQY7LJMjI8lnWjKJnJJC6GIlZRX0jSI0+vuNg0KJc0YcnLVf4wBJHJ+NfKYiXyAY
         c1KFNQucGUusUaHkNrxPdz/+qJZ0quh0PvJZlao46WMYwCEm0pWdnnSou1wVaY1KI51v
         famw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hshTohekKVzxbI8Gdg4o7wDfhyGczePTc6NMf/Dm1B0=;
        b=p80SdipQAu9W1cQ6v1ZObblKk3xbDhgUmCC2vj7FLMPNWMGsbNignaUTSaLSTXXs0n
         ZfJ1Gy/h+iwMKrGDCu9ORv36h5lgEHww0a3PzcYSFn/Gu0uVXrqMkL5Ig7V4S2jKu33l
         2pRFhkvm94DWwh+e3e5UDd+zUf1ayhpwpR2k46GkNL3BI3M8TYTVEolzg5CjRQFmTGdN
         e8hbp1tRi/eQjQTDSH944BKXpgWNAmTz2P4ZWFZ+76v0muXRfWS9P4NA7GiriXKDREc+
         0duCoSuJfXHyCrkjpJ0FN16Vbz5texxwhXpyAp25ocWvh82xm5IDvZtm6ENCAG9x56gE
         bnEg==
X-Gm-Message-State: AOAM530i8boIhYzHUMmYjNo3TKy1Y8UVEG498wuPh+NkHaN3JzT+ywEm
        rRoQ3qpJdDJkta1kzKfJ7m4twKASZmloAF0bSKr6
X-Google-Smtp-Source: ABdhPJz9Ym22J+71vu28hduTtY1dbebaSSmN+CFMDHNnCACBgGb8WrLJ4GnFK7OSVWzIx5rZEe326i5FwFwvcgLs/QI=
X-Received: by 2002:a17:907:3e14:: with SMTP id hp20mr509206ejc.106.1614301616841;
 Thu, 25 Feb 2021 17:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
In-Reply-To: <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 20:06:45 -0500
Message-ID: <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 4:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> After the switch to RCU, we now have:
> 1. Start live conversion of new entries.
> 2. Convert existing entries.
> 3. RCU-assign the new policy pointer to selinux_state.
> [!!! Now actually both old and new sidtab may be referenced by
> readers, since there is no synchronization barrier previously provided
> by the write lock.]
> 4. Wait for synchronize_rcu() to return.
> 5. Now only the new sidtab is visible to readers, so the old one can
> be destroyed.
>
> So the race can happen between 3. and 5., if one thread already sees
> the new sidtab and adds a new entry there, and a second thread still
> has the reference to the old sidtab and also tires to add a new entry;
> live-converting to the new sidtab, which it doesn't expect to change
> by itself. Unfortunately I failed to realize this when reviewing the
> patch :/

It is possible I'm not fully understanding the problem and/or missing
an important detail - it is rather tricky code, and RCU can be very
hard to reason at times - but I think we may be able to solve this
with some lock fixes inside sidtab_context_to_sid().  Let me try to
explain to see if we are on the same page here ...

The problem is when we have two (or more) threads trying to
add/convert the same context into a sid; the task with new_sidtab is
looking to add a new sidtab entry, while the task with old_sidtab is
looking to convert an entry in old_sidtab into a new entry in
new_sidtab.  Boom.

Looking at the code in sidtab_context_to_sid(), when we have two
sidtabs that are currently active (old_sidtab->convert pointer is
valid) and a task with old_sidtab attempts to add a new entry to both
sidtabs it first adds it to the old sidtab then it also adds it to the
new sidtab.  I believe the problem is that in this case while the task
grabs the old_sidtab->lock, it never grabs the new_sidtab->lock which
allows it to race with tasks that already see only new_sidtab.  I
think adding code to sidtab_context_to_sid() which grabs the
new_sidtab->lock when adding entries to the new_sidtab *should* solve
the problem.

Did I miss something important? ;)

-- 
paul moore
www.paul-moore.com
