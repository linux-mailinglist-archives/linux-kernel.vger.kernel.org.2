Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE59415179
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhIVUi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbhIVUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:38:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:37:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ee50so14789430edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhR4BBPrkbqBPDREiZkyVSMc0RaquplEP+Rg3q+eWXU=;
        b=BpSz+zinLVgEW81plHtbJ6/OM5mmbULUAR/9nhwvKiCPCgPkj9ce3UNEwXrXAfmUtg
         IoSV2j4WrfvaksSSyDXTFezEwDuEFXqUqGT15kxq5ZExSQAiT3+B3RDYHU+TqO4zaS8U
         JRRgZO0hhu2I/7vUNP97XzT6K+AvYjQKx/F1PmKti7JLGFKw1lGgWcdfu+XNrO/ir+HK
         0kJNzQKaoMNra1TnQZZKbcOLmlQcNEuP+1W3hLTnxGwDO8cMVZ5KRbbkFtgmV54wWrHK
         lXI87M5yS2SEcLoVR3VRWoU1HZ6BQSkIk2WnBR33hXm2I+kEhxFx/IRFZp5VILAuQODK
         D88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhR4BBPrkbqBPDREiZkyVSMc0RaquplEP+Rg3q+eWXU=;
        b=lPZfgAlcQfs8kPxCaWr2rbm2vPUDifkKufnwgFntQRvTKFiVLPakjOU5iMQfr9ofFW
         xOnnnDNmimk9De0041zP2K/+/yZxBdUehDAB0OsMsev7dKPuVWxhLHKC0ewYl+9me+DD
         aL+ihLJ2bKGhK+fkfX5Bsl5PEYGxEJUSNi9OD8fDyCXEV7g90w8QHBQduf6Tq5WopwIV
         XyrVM7/ciOK1MODLSGcy9fOGFB7jfC3Ie9LFFDoRcXJaYUmVDd6uJlKEItJ9qA819I+j
         LyXLkamuaDGDMWJ68JFeKWKES8a54Kcx8XFQXn0TMUb4qzETGzbuE/7TUwVVf0xrW8Sj
         99EA==
X-Gm-Message-State: AOAM530LMgo3Qi1YH6G6VdhYXDqnK0Bh6d6jNlX9LWwKzJ+imfkl3ZB0
        6Aq8D+YcxMEVJsLoqNDxW2YtmCDzdSj5CNhLzOo=
X-Google-Smtp-Source: ABdhPJzRiJss2T7SXUtcUDI8d5MI4G89nD5FlC4r7QitdCf2uhr8zUOOZVrZNYCcd6zLp7/8DsBTtfBofTTTIHfROGw=
X-Received: by 2002:a05:6402:14c3:: with SMTP id f3mr1494205edx.312.1632343045520;
 Wed, 22 Sep 2021 13:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054116.266126-1-shy828301@gmail.com> <20210819054116.266126-3-shy828301@gmail.com>
 <YUuGB6pJZRlE4yPb@agluck-desk2.amr.corp.intel.com> <CAHbLzkoo_EDwh3=5tJVBy+b2ixnbAw7frdDB4haCZxKry18ZLQ@mail.gmail.com>
In-Reply-To: <CAHbLzkoo_EDwh3=5tJVBy+b2ixnbAw7frdDB4haCZxKry18ZLQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 22 Sep 2021 13:37:12 -0700
Message-ID: <CAHbLzkoMM6QtOY_A2bX99t89BGm9=pdPmMJ4nVfgeH-cvDQ=8g@mail.gmail.com>
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

On Wed, Sep 22, 2021 at 12:58 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Sep 22, 2021 at 12:37 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > On Wed, Aug 18, 2021 at 10:41:16PM -0700, Yang Shi wrote:
> > > Currently just very simple message is shown for unhandlable page, e.g.
> > > non-LRU page, like:
> > > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> > >
> > > It is not very helpful for further debug, calling dump_page() could show
> > > more useful information.
> >
> > Looks like your code already caught something. An error injection
> > test may have injected into a shared library. Though I'm not sure that
> > the refcount/mapcount in the dump agrees with that diagnosis from the
> > author of this test.
>
> The messages from dump_page() are (unwind them from mce logs):
>
> [ 4817.630520] page:000000003ab9dca4 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0xcef2747
> [ 4817.646860] flags:
> 0x57ffffc0801000(reserved|hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
> [ 4818.033689] raw: 0057ffffc0801000 ffd400033bc9d1c8 ffd400033bc9d1c8
> 0000000000000000
> [ 4818.280640] raw: 0000000000000000 0000000000000000 00000001ffffffff
> 0000000000000000

Missed one line from the dump:

[ 4818.321804] page dumped because: hwpoison: unhandlable page

Anyway dump_page() is just called when unhandlable page is met.

>
> The page flags tell it is a "reserved" page and mapping is NULL. It
> doesn't seem like a user page or movable page, so hwpoision can't
> handle it so that the messages are dumped.
>
> >
> > Here's what appeared on the console:
> >
> > [ 4817.622254] mce: Uncorrected hardware memory error in user-access at cef2747000
> > [ 4817.630520] page:000000003ab9dca4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xcef2747
> > [ 4817.638651] mce: Uncorrected hardware memory error in user-access at cef2747000
> > [ 4817.646860] flags: 0x57ffffc0801000(reserved|hwpoison|node=1|zone=2|lastcpupid=0x1fffff)
> > [ 4818.025515] mce: Uncorrected hardware memory error in user-access at cef2747000
> > [ 4818.033689] raw: 0057ffffc0801000 ffd400033bc9d1c8 ffd400033bc9d1c8 0000000000000000
> > [ 4818.272435] mce: Uncorrected hardware memory error in user-access at cef2747000
> > [ 4818.280640] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> > [ 4818.280658] mce: Uncorrected hardware memory error in user-access at cef2747000
> > [ 4818.313606] mce: Uncorrected hardware memory error in user-access at cef2747000
> > [ 4818.321804] page dumped because: hwpoison: unhandlable page
> > [ 4818.564802] mce: Uncorrected hardware memory error in user-access at cef2747000
> > [ 4818.573043] Memory failure: 0xcef2747: recovery action for unknown page: Ignored
> > [ 4818.595837] Memory failure: 0xcef2747: already hardware poisoned
> > [ 4818.603245] Memory failure: 0xcef2747: Sending SIGBUS to multichase:67460 due to hardware memory corruption
> > [ 4818.614297] Memory failure: 0xcef2747: already hardware poisoned
> >
> > -Tony
