Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B320307FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhA1Ujd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhA1Uj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:39:29 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39652C061786
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:38:12 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id h11so3715203vsa.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KPgt9hBeVcEo5Nho0Ik1gkLx7dER9AD9O3f4dkEfDM=;
        b=LCM7oE/eDXhBiFGmQ+Q7GUkb33VZwMTOs6c+QMmmtTshjoGqrJch7qKjp3VgVrjLGo
         0DGsKGDL+zECFRWW9m76RiQ+77fnJjO9wvDhlugmouvNCUj/jpz0PzDOHDUnQJYgTNsN
         8fMlfmaw0EuBzGRkL6Ta+ZNUJKnBJBofqcJyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KPgt9hBeVcEo5Nho0Ik1gkLx7dER9AD9O3f4dkEfDM=;
        b=tim5zLpA45L+FKe44z//8cc89lM9P30L3BtPMr3NLO+TsORRFhw9H+NRs5KNmJmnDz
         uOtSXX3y7VosrHCPWSqaff0CioLOAnAlHrSDRp6zIj6qA1fv7VDZTkmKryjyJn9FnOn7
         ViR/gtjJ8ItFP+lsI5yuKrrhEZDQcnmjDpCR8c+IhTSMwH8OYRKl9BAO1buXGW1cHi0b
         5VOIDgfC4yGWgNY2MP3E/pxP6XTzCgz9DfY9/mjLw4bGUQ2r4isQZy+/YxTPfveqw8HG
         o4kxZKokvQYMloh5hSLdIzl9aajfwer5kZfzqCaNK4yTiAH3Tee2KAlVkHd/EnYP68zt
         vCwQ==
X-Gm-Message-State: AOAM530J/PRvTCwwKLQSwy7cGP0hCHLWwM6k+pGVCi8ekqC573IkwZnI
        an074XKD4XVQTZcs2nZqFXSOtFsOzL2DNfLHVTLcyg==
X-Google-Smtp-Source: ABdhPJzX/gZhVjy5xbZXs4+sI7wH7G5vQ7HSsfArwt+AUTKX6c8cJkmXmX6BOemJlLH0uq/Hd1IX4Q3wYAZvMD4Uwqo=
X-Received: by 2002:a67:c992:: with SMTP id y18mr896831vsk.7.1611866291533;
 Thu, 28 Jan 2021 12:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-3-mszeredi@redhat.com>
 <8735yw8k7a.fsf@x220.int.ebiederm.org> <20210128165852.GA20974@mail.hallyn.com>
 <87o8h8x1a6.fsf@x220.int.ebiederm.org>
In-Reply-To: <87o8h8x1a6.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Jan 2021 21:38:00 +0100
Message-ID: <CAJfpegv8e5+xn2X8-QrNnu0QJbe=CoK-DWNOdTV9EdrHrJvtEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 9:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:

> <aside>
> From our previous discussions I would also argue it would be good
> if there was a bypass that skipped all conversions if the reader
> and the filesystem are in the same user namespace.
> </aside>

That's however just an optimization (AFAICS) that only makes sense if
it helps a read world workload.   I'm not convinced that that's the
case.

Thanks,
Miklos
