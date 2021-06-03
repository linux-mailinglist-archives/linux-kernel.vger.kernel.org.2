Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0567039A3A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhFCOuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:50:00 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:16010 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:49:59 -0400
Date:   Thu, 03 Jun 2021 14:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1622731693;
        bh=SoE1BjkhHMmw5ZLkSwNONJBeXYAJkMmLHBte1ttyC3k=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=QSt9SIK6hEM/+73dJMTc6lhBe/YxU0lLQEKaOC/XC5zCeij0l4WXnVBH6fXB5cgD9
         f9Eb7hUIjqK6S8FB78+wotYa7WdNLDRKghn5xo1PYbaIEPVQrvsls8xZrV9vCTokOF
         hAS5pP6wIbA34pQEU/usJJ86ddKFyUiXco5m2IVYpmJdobwU4RcpZH7zowc7xZjzlK
         AYfOv2s5KCCxlOhkoBGUUIy/PkAEgz51n0rpR8s2FNFpBgpx7tc2WA9U9CqnJOWlAd
         DpSapI05/TeWMDesi3LsLvlx6KMfd/NJmA9VwvXfV0tfkdkHe2hR92GjXCRRT/I/HH
         /e441Z2V6SePw==
To:     Matthew Wilcox <willy@infradead.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Lin, Ming" <minggr@gmail.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: Sealed memfd & no-fault mmap
Message-ID: <yK5pBcI8tfOfgvVkLrLRMaAdSrt7uL8Ppc05GLMMl8JEfBVsY7f-ksJME4RsNJUvOif2u_r_dBh_PwXyPwYl4Ug2tiMiMxVJb7ESHKNS6w4=@emersion.fr>
In-Reply-To: <YLjf1Hmrkfwc5xUW@casper.infradead.org>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr> <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com> <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com> <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com> <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com> <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com> <alpine.LSU.2.11.2105291315330.25425@eggly.anvils> <d9rpd_hm_ereswX76EqjEGkqfjFFSi-N_yj8b1pj4MZMFy-fpiicN_XrHl13sXqkkgzAJqZEy1roQsVklWEhY38-olslcbO34GB0YcjHks8=@emersion.fr> <YLjf1Hmrkfwc5xUW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 3rd, 2021 at 3:57 PM, Matthew Wilcox <willy@infradead.org=
> wrote:

> How about this:
>
>  - The client sets up a 1KiB shm file and sends it to the compositor.
>  - The client expands the file to 5KiB
>  - The compositor sees the new data up to 4KiB but zeroes past the 4KiB
>    mark.
>
> Does that still make userspace happy?

As long as the new data in the expanded region is visible after a remapping=
 the
file with the new size, it should be fine. It doesn't matter that it's not
visible without a munmap+mmap cycle.
