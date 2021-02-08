Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A273313340
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhBHN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhBHN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:27:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE3C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:26:16 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q131so9695696pfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbNVw0blb9h/d3DKBZ+tlSkBAWgYcu2EY7pdWUJ8R8Q=;
        b=T6sTlCGO/g6U+NOiCA464UwO8ijdPpSZOpM7NiQenIPVB/GRtx9cFMWEMqz3XlMs7F
         mAUl5mKvD/FaJdvGtRnjXl69DDch3WyyedTDMuearxyE6hkPEgOOtED9ny+5OIUKTcTp
         97otTPVSVanhbCSS1a20tpxKrWz5BqtmRuDvLrw0NySU8yKD8jQantfzMq5ubqyoGu9a
         4pFjdi8SMg+MGRGv8xB1zfea/+z8GBcGOGzgkTYs2kO7Q6G3u05fDM4jsesnTzy8sBV2
         DDLTiXncgxMXL4xIGOTwY/NLC3WoBUbSKggRtCtkf97VEKqNAP/NJifd50iC6bDcUrw/
         jOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbNVw0blb9h/d3DKBZ+tlSkBAWgYcu2EY7pdWUJ8R8Q=;
        b=ooJVT5DKVHSHfXHXUCK/7IONhSKJLh1eyMApTkM1peaH7huHd2oGVoDuXDUQ42D00/
         NHz9SYFjnaTZEzHvU677Ad3cAsZL6y3z8A1J1RLcOYWELWd1Aov0ldh+LZDHjcqsDxum
         4UvX3t2j7rKSw2bDKV1cz0+CupbSmE+DCtvsgBAq+HHP8JfQ+zM9nmzLPZPnj22dZgu4
         x6LW7bfIkfGEYtvaWUjEttlXg0XdnNZ3t05nPpcad/kPNzxtykIkDhGtappwgq1ENg3W
         udXcoCwqf9l71+ZuKwid1n9JgYwflXbyJmhNTApxqvsd2Iddr3zhKFrME0DSSmmZqUw2
         LN4A==
X-Gm-Message-State: AOAM530GOFxPSldF4dXIBmh6Aa5A4w26a+Gx0lgFkbbUju42aUfnuT1Q
        hcwxMcoXnH3vcrSmMd8m7dDpDZnZmYNPvOG+et0=
X-Google-Smtp-Source: ABdhPJxqxCH5zvob7KqNKqfR+QHy3lJpm4iKMFfVqycVnGwgz6TQZ5yJJaMxf2zbqBncTC24DmLKtH8KP3yahtFAehc=
X-Received: by 2002:a63:4f1e:: with SMTP id d30mr16764697pgb.203.1612790776109;
 Mon, 08 Feb 2021 05:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20210208101439.55474-1-laoar.shao@gmail.com> <20210208122009.GN308988@casper.infradead.org>
In-Reply-To: <20210208122009.GN308988@casper.infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Feb 2021 15:25:59 +0200
Message-ID: <CAHp75VfQzsx0dtmK9is8Y2WezV2gk7pqDqXZPfEVay722pWFfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] mm, vsprintf: introduce new format to dump full
 information of page flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        david@redhat.com, vbabka@suse.cz, Christoph Lameter <cl@linux.com>,
        linmiaohe@huawei.com, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 2:37 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 08, 2021 at 06:14:36PM +0800, Yafang Shao wrote:
> > To avoid breaking some tools which parsing pGp via debugfs or affecting
> > the printf buffer, other new formats are introduced, so the user can choose
> > what and in which order they want, suggested by Andy. These new introduced
> > format as follows,
> >     pGpb: print other information first and then the names of page flags
> >     pGpl: print the names of page flags first and then the other info
>
> This is overengineering things.  We already print in little-endian order,
> and the other information should be tacked onto the end.  Just extend
> %pGp.  Andy's suggestion to add another flag was a bad one.

Fair enough, I can admit this because I don't know the mm specifics.
However, my initial point was about the long message which might be
cut into pieces during Oops or whatever and the user will get the
first parts only.  Depends on what you consider as a higher priority
to print the order might be different. Initial patch suggested to
print the new fields first.

-- 
With Best Regards,
Andy Shevchenko
