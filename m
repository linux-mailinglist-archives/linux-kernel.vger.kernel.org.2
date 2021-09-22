Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C504150D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhIVT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIVT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:59:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:58:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg28so14570780edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9tn2XqkVDCc0LmLHPQVQ22W8Z0S8fgFGrJaQw+LTrg=;
        b=YPqYaNllBuBpVhxOsD/1DjT3Dw7a6R1Cvgsp8SRxwiAVlSrNsYW5DwxxXBjLkHKa/F
         DQMAalVQsbcaY0Q6F6vWue6+MUvzqpzbv40FdUkUvjZMuJrD7HNUUVElpwuTTub46fLM
         ox5b2goZKY4ZMoNuzdp8rZOj+EAN81FxgHPCGnn0hrY9x1qFjzYDTdjBlkVLHjvWsruq
         S44gAiwGoikk3Djc+6eIl8/tIUbmEA3/ZABH4E/aIw2nd9mjOGz7W1dF/dAAowcKGXPk
         hMEWspXgrB4DSi5kEDbQnlnBQZmXYRzbcImVYdv4tIjykG0wBq+6EWvtMvvdITi9VdOB
         Rnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9tn2XqkVDCc0LmLHPQVQ22W8Z0S8fgFGrJaQw+LTrg=;
        b=z5aBaqRT36xhWEF5pwkM45wxZ7Eo8UKNwIr7AUzpj4GQok5nBfaXTVeAVoN8rZ3/0R
         rni671h/XYwvAylWpV0CMWQhdY8spW2r8NFSVkRUfk6yv+AcvETbn0Q0fHENCFRz1Oym
         bOfNQHG8LR321qcB+DNvP79PORomAWxUgf9tZ0jUe6RzBq4AdrS1ZhwtAeWnYJCIhQiH
         +EuLt1U7TSJDYUYmGSU1y5XeQai6IIBXs+FGN/UfwCHw+t4fpKPZkfoeB7i4c9VfKM/u
         o1SEH6tFKpUremS4YAkL/WH4V3Ym84z8we0tbUT+1OxATLlKG3RWed/R+Ak7h3jRJ1sS
         AoYg==
X-Gm-Message-State: AOAM530qsmlQuJ8m/GNLEqYW2KpuF9nl+04Wk89NM3eilhH8tRfAXq4l
        44sra9XeyZ+A65kdpuOqhhWtcYR0TBWdN99+lkQ=
X-Google-Smtp-Source: ABdhPJw6CdlXaI9gWMZaGrg6AAs3Rv82/sncd7Qr8bFMQG/IN39fQBrXlR0bQtAjUZTOapsq4jfAAdu96aFFDMzvkz0=
X-Received: by 2002:a05:6402:16d2:: with SMTP id r18mr1235107edx.363.1632340700277;
 Wed, 22 Sep 2021 12:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054116.266126-1-shy828301@gmail.com> <20210819054116.266126-3-shy828301@gmail.com>
 <YUuGB6pJZRlE4yPb@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <YUuGB6pJZRlE4yPb@agluck-desk2.amr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 22 Sep 2021 12:58:08 -0700
Message-ID: <CAHbLzkoo_EDwh3=5tJVBy+b2ixnbAw7frdDB4haCZxKry18ZLQ@mail.gmail.com>
Subject: Re: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        tdmackey@twitter.com, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:37 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Wed, Aug 18, 2021 at 10:41:16PM -0700, Yang Shi wrote:
> > Currently just very simple message is shown for unhandlable page, e.g.
> > non-LRU page, like:
> > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> >
> > It is not very helpful for further debug, calling dump_page() could show
> > more useful information.
>
> Looks like your code already caught something. An error injection
> test may have injected into a shared library. Though I'm not sure that
> the refcount/mapcount in the dump agrees with that diagnosis from the
> author of this test.

The messages from dump_page() are (unwind them from mce logs):

[ 4817.630520] page:000000003ab9dca4 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0xcef2747
[ 4817.646860] flags:
0x57ffffc0801000(reserved|hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
[ 4818.033689] raw: 0057ffffc0801000 ffd400033bc9d1c8 ffd400033bc9d1c8
0000000000000000
[ 4818.280640] raw: 0000000000000000 0000000000000000 00000001ffffffff
0000000000000000

The page flags tell it is a "reserved" page and mapping is NULL. It
doesn't seem like a user page or movable page, so hwpoision can't
handle it so that the messages are dumped.

>
> Here's what appeared on the console:
>
> [ 4817.622254] mce: Uncorrected hardware memory error in user-access at cef2747000
> [ 4817.630520] page:000000003ab9dca4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xcef2747
> [ 4817.638651] mce: Uncorrected hardware memory error in user-access at cef2747000
> [ 4817.646860] flags: 0x57ffffc0801000(reserved|hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
> [ 4818.025515] mce: Uncorrected hardware memory error in user-access at cef2747000
> [ 4818.033689] raw: 0057ffffc0801000 ffd400033bc9d1c8 ffd400033bc9d1c8 0000000000000000
> [ 4818.272435] mce: Uncorrected hardware memory error in user-access at cef2747000
> [ 4818.280640] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [ 4818.280658] mce: Uncorrected hardware memory error in user-access at cef2747000
> [ 4818.313606] mce: Uncorrected hardware memory error in user-access at cef2747000
> [ 4818.321804] page dumped because: hwpoison: unhandlable page
> [ 4818.564802] mce: Uncorrected hardware memory error in user-access at cef2747000
> [ 4818.573043] Memory failure: 0xcef2747: recovery action for unknown page: Ignored
> [ 4818.595837] Memory failure: 0xcef2747: already hardware poisoned
> [ 4818.603245] Memory failure: 0xcef2747: Sending SIGBUS to multichase:67460 due to hardware memory corruption
> [ 4818.614297] Memory failure: 0xcef2747: already hardware poisoned
>
> -Tony
