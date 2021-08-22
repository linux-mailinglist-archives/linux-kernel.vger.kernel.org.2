Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA43F3EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhHVIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 04:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 04:32:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB5C061575;
        Sun, 22 Aug 2021 01:31:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b9so4015461plx.2;
        Sun, 22 Aug 2021 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APvVQF1z6WQa9rlK96FDBdWRJewiu2JOsywqsMpZgNs=;
        b=sRAh3FVCbY2swrn+sqq//F/sNMrBV40CVbFYovk2M4K/xYSQBCszVB3BZGXU2rCP9Y
         /6/wOe7PUqMHr1gJWHL/PzctBanbs4IPaafr//Wv18138zQk5HLWYwwl7fF3uIhfZEq/
         ZzRltYHfPgzhWOOMapcueqmDkQ/FO1v4fF4ZlAIejvLAjJwv8t3mV42FSPIW4OBxCopD
         BWwyNjXQG1KodRXjh5u6UezFwZhyuPK0LY8bJTST4e0t4k1dLhBTrwCKmRKjJhQbhfQ5
         85Cd6HznAgPURfS5lC7CQX7XvfRQxDVeFQ/KwD4lxRyIw8CVcNqityp1NAwgEcMJ02j9
         pN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APvVQF1z6WQa9rlK96FDBdWRJewiu2JOsywqsMpZgNs=;
        b=t8B2lK3bqK+ba/NYOtK+LTbZMaw3JPkwUff6QrNBehRFlRtBkTXGnwVBZ91liOq3Rr
         KqK9fBOjJk2PBy6idMRCtnhbKD8UrTpZlor/9Fw+FmBg79jJp6rXIJzeCLqfWhaUqmAU
         Oxq3O1LQFvErwO8q7AnInuq5XaSuuccuOK7eHUfq6y0sW7AdD+nblGNsI37GFSP0BmAO
         3eMi5DQ7G3UxuJhjidVzLynaXJqD715vX7BbGFal2qFcCPntFEteTnGxG2tLFeHfBUhh
         g8NnoJNhtAi7yYGuw6UKMdTuhYcOmhyMjhuSmddt71M80RSJJNxD1csE1k7Rp3Jyr2Pt
         C/0A==
X-Gm-Message-State: AOAM5311jTidZohrvwxQOGpQ3aBDtjCkwwFgayvX6673YbxJl1RyhMwo
        odWIuqZ6oONRQNPjlivvrXeRi+bRaWLiv1D5Nhk=
X-Google-Smtp-Source: ABdhPJwSFmnSX6sXHzoIVdPMKv8nPOQWXu5gIglXllmhU94Jg+e4guxACgEmiQaql+ycOaOJemHVccJH5Fm0oSg78+Y=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr23513063plg.0.1629621103647; Sun, 22
 Aug 2021 01:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <6abd83d11f1daa3094f82e92843e8279f302e349.camel@perches.com>
In-Reply-To: <6abd83d11f1daa3094f82e92843e8279f302e349.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Aug 2021 11:31:07 +0300
Message-ID: <CAHp75Vdh2CP9n0FrU+6nkmzVWKoKD6RN-RGv7Z+UD_KUoFXPfw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf and docs: Add X to %ph for upper case output
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 6:00 AM Joe Perches <joe@perches.com> wrote:
>
> Uppercase hex output of small char arrays is moderately frequently used.
> Add a mechanism to support the %*ph output as uppercase using 'X'.

Besides the fact of existing hex_asc_upper_*(), what ABI (!) uses
this? If none, I dunno we need this.
And show at least a few users where we gain something after conversion.

-- 
With Best Regards,
Andy Shevchenko
