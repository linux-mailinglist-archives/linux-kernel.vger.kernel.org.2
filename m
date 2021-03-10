Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066CE334061
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhCJOad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:30:33 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34177 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhCJOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:30:23 -0500
Received: by mail-ot1-f44.google.com with SMTP id n23so10909779otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxwIQWo5TM6As6/7cnfjeLk9SNKVv9VR0qnunGreMwI=;
        b=dRiUo9EC4cxXJ+EzbfdgxejZHoaaREZHdRrQiqF+yHA4tj/ReS7Nk4544OCTpyP93g
         Lvh7ke5hlkNdkUSSOIZvpTQl9wHB4s3PLRdZGVpSy5gj011mpMgenhJPIcw53aPgDnxi
         ZQ6azI2PlcvgJgqcWnMWmtazGkzGrHXMWw98csf133jnr2tX762qQkImkGsBBEBM3Idn
         Co5T2qEwDBocv54tvziPM90bLo+NWPVwhKx4rwuf+0q1MMvHbwsEWg7XK/yVE9IC0izD
         DNnLs7QQVyngqi3Vbb2Chb1QtpQMZVyXRW8I8mRjS9LnXLPuU4Xvw4PcZL/llOq/31pI
         0OkA==
X-Gm-Message-State: AOAM531yihNZ8wiydU0QGsrbjcvLxzNwYU7Z1fAko1tR/1r/8Pk78ahI
        zkn3IyfgE8938Fa8jhcirylwa9L9P76zBpH6L9fWIewW
X-Google-Smtp-Source: ABdhPJwlDMdvDIG39uON6PqOFJiIDnmBw8t2I5/hgpNiovh5TQCLqO457KlCjelM0DBm9hOFvxCul+QU32e16vTPDfc=
X-Received: by 2002:a9d:3d34:: with SMTP id a49mr2599820otc.206.1615386623467;
 Wed, 10 Mar 2021 06:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
 <YEdTGsr6CjUirOsn@smile.fi.intel.com> <CAJZ5v0ivHnHNTFPXKSgiKYY0fKiqSWuBaLh6noqE3xQEFC2-pA@mail.gmail.com>
 <YEh3FGTExpE3IGhb@kuha.fi.intel.com> <CAJZ5v0j1GDoqYKHfts-pQtkNQYpYsvCxeradmDQMLYMVY024mw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j1GDoqYKHfts-pQtkNQYpYsvCxeradmDQMLYMVY024mw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Mar 2021 15:30:09 +0100
Message-ID: <CAJZ5v0hoM8zXjwxzzNbUKjVqmXfXZnrgryRdy8LE0E230iZWnw@mail.gmail.com>
Subject: Re: [PATCH 0/2] software node: Two fixes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 3:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 8:36 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Mar 09, 2021 at 02:51:22PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Mar 9, 2021 at 11:51 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Mon, Mar 01, 2021 at 05:30:10PM +0300, Heikki Krogerus wrote:
> > > > > Hi,
> > > > >
> > > > > The second one only affects 5.12-rc1.
> > > >
> > > > Rafael, Greg, can this be applied for v5.12-rcX?
> > >
> > > Do you have a pointer to this?
> >
> > Pointer?
>
> Never mind, I'll pick them up from the archive.

Both [1-2/2] applied as 5.12-rc material now, thanks!

However, I would appreciate CCing swnode-related material to linux-acpi.
