Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF2E334023
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhCJORK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:17:10 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42006 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCJOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:16:55 -0500
Received: by mail-ot1-f54.google.com with SMTP id e45so16479146ote.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bY3wLSS1oA1+qVvAVNW7XYojaEkqfwDO2iAubNUUC9c=;
        b=d32eIITmMgZGmCfGQMKY2aoUUv/hs5X6ZEM9yUa9zrb/eW+sk3CColDJ9SJ5sXW8/P
         Q17gnxKVeXL+aX2PceRzex3eQJ/sfEDw7DFEbqvxCW03RO0sIKNUx+R2RuqA450EIjuG
         lFY8H8dIVzjkH3EOXxuu9W1u6NJqzeOvN9tg2JxmOiwbQnSr9w3DYWzU820TwGF8gynL
         jhd2IcWU7wic2f5BRs3kHxIDLTXwI11nc3yqjSNVTOk+iOTXLgyTuffob7TZFJlF6nLG
         /ZLRpQuafdOXpILu5bGFSeBtOJf1B/7tdht/2g3Au8znAWucgcVnV50/AytoJc2LUAEM
         2ZZw==
X-Gm-Message-State: AOAM531AlwLB22um0QD2f6JuhdFkwSewpbHkrKirPWWKaxVx4H0vKRW9
        L9WiIuUFPXFmaPNk6HLpLl0g6eeyJ9NH5+SihJg=
X-Google-Smtp-Source: ABdhPJyeZnmfmf5LmD4f6mzR7jTmCpnPei5+MuuIPw4cC9uo9oeVD8XFPTBhNhHKDzdN+r68OWXwhI0GJUmVjqf6RiE=
X-Received: by 2002:a9d:3422:: with SMTP id v31mr2725578otb.260.1615385814808;
 Wed, 10 Mar 2021 06:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
 <YEdTGsr6CjUirOsn@smile.fi.intel.com> <CAJZ5v0ivHnHNTFPXKSgiKYY0fKiqSWuBaLh6noqE3xQEFC2-pA@mail.gmail.com>
 <YEh3FGTExpE3IGhb@kuha.fi.intel.com>
In-Reply-To: <YEh3FGTExpE3IGhb@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Mar 2021 15:16:41 +0100
Message-ID: <CAJZ5v0j1GDoqYKHfts-pQtkNQYpYsvCxeradmDQMLYMVY024mw@mail.gmail.com>
Subject: Re: [PATCH 0/2] software node: Two fixes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 8:36 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Mar 09, 2021 at 02:51:22PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 9, 2021 at 11:51 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Mar 01, 2021 at 05:30:10PM +0300, Heikki Krogerus wrote:
> > > > Hi,
> > > >
> > > > The second one only affects 5.12-rc1.
> > >
> > > Rafael, Greg, can this be applied for v5.12-rcX?
> >
> > Do you have a pointer to this?
>
> Pointer?

Never mind, I'll pick them up from the archive.
