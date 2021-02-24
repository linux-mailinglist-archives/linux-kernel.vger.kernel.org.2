Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691C3234B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhBXAok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhBXAET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 19:04:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A755C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 16:02:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id p2so412993edm.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 16:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teqVJhK4LXz4OZBg8usuG8VfNJnNMz+dTljcctkaNG4=;
        b=KdGZTmGsRPg0mfraFXSTSp/gtdGU7k4ammQ9upVnBXq/Xqb+ZsRIvIaqmyV3pVxo7C
         Y040vHQJmflrbsQ+9fRB7vQCenEwcGCHPxhTc+dwKFX2p3us0JRO27Zg62jUNVMeHIG9
         q1/fIVOksrqcUPr6yZH+k2Vfnjsyu0a4riSCBSB8y+ioY7q34yxUUTrq4N6GhQwKQWNu
         17d+2hkaQcEs5OfPaKnzKhA4I4Q9UJzA8VofTtNkrZG9GHTsVwnoJlnHz/zEIgRKrmmo
         bSg/NOsYK2XzYQFCIZIbQ1GGVNC3b8Ld1Y8O01y5OynRX0jDGH7IYowztBOl+KMxSQFJ
         RSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teqVJhK4LXz4OZBg8usuG8VfNJnNMz+dTljcctkaNG4=;
        b=Y83+F3GfR1zNvKZ5jbIK3Rb/hMnU+Zec/T3EJETJC6XZTi0rjW9a/QWH2yDzwIOWSi
         69Yz2Ee86QRPu4/ZhDLeFT5NAl3SKlVwPryDJmWpxps7LF0DlxYI3iwoM1dlwJKXd4Ul
         VBBjjqSRI60OCT5wDoRuqXDOG2iHYyovpf/s3icwW+nbwvlPi/p5dhqU2M6kD0CIwd1n
         zBEZuKmCvJNH8TQekr/Hsc7atwD73ZPy3zVavgptjnIegeNJkNmL1hXwqJTZt1jl9ckd
         Xu6Yvbddmcehut26bnJK3e67vDE//qJRojD++siku+kbr+v5WYD531c04IH//cx9jT2F
         iGqg==
X-Gm-Message-State: AOAM530RCtN+ANorXQp5fq4y6b0k6YcC5kEDeyfjwuiRr1JN55zJNM9c
        POm7EwFZ6vCnH0yWO9vAakwnREHCoR4OjnDVvbzX
X-Google-Smtp-Source: ABdhPJziRNGyofDZux2ELTzG6efQZEMJidRWFdAhC84nYkh3iZBsqcyVm8N/r7ln1ulYlW2a+bnT67lUDe8MhFeDwFs=
X-Received: by 2002:a05:6402:22e9:: with SMTP id dn9mr21996487edb.269.1614124956065;
 Tue, 23 Feb 2021 16:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia> <20210223223652.GD6000@sequoia>
In-Reply-To: <20210223223652.GD6000@sequoia>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Feb 2021 19:02:25 -0500
Message-ID: <CAHC9VhRkP-ZuzWPvLbpCOiM2H-x-_FyDrKvy5fZ7TL9etwVJCA@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 5:36 PM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> On 2021-02-23 15:50:56, Tyler Hicks wrote:
> > On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > > I'm seeing a race during policy load while the "regular" sidtab
> > > conversion is happening and a live conversion starts to take place in
> > > sidtab_context_to_sid().
> > >
> > > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > > then another policy gets loaded ~2-3s into boot. That second policy load
> > > is what hits the race condition situation because the sidtab is only
> > > partially populated and there's a decent amount of filesystem operations
> > > happening, at the same time, which are triggering live conversions.
>
> Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
> change here:
>
>  https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/
>
> I'll put these changes through a validation run (the only place that I
> can seem to reproduce this crash) and see how it looks.

Thanks, please let us know what you find out.

-- 
paul moore
www.paul-moore.com
