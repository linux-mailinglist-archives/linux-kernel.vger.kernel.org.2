Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A75329EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445938AbhCBDC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbhCAURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:17:14 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EC3C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 12:16:34 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x62so5170608oix.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CpiE1pBrxa73ZoavNQfgfeEm27dty1Q76LBnbbf260Y=;
        b=HeZobEdHhxUthkkeiQ+zZFdYT0M1eBhINCAyAp+kaPBBn6NWOkA4YCfwK4HlNJ4iO+
         y7kN2zEX9XByXD8cu0e3agyI1yx43wWMPa4zRq8RFygp2bxl7LENZKDcXqHphOL+lCkc
         QHP8WGdorrbiHzk6I3IS3qczMfznL23MF7Brb1N8Iabvuw1Dekh5ig3tq8tI0ui5OaOx
         JEaHPRUFLYaXLWBuVzCQeWftCHO3ssfEf+U6LcircvndN1y+qz1PEuitxjCuSYFtHYkc
         uLrCoq4vXlEPHKSixRFS6wEXydJbO8UB1gR3PUkiObLUOx+99bUV5BoHJj+/wA+UYFF3
         BO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CpiE1pBrxa73ZoavNQfgfeEm27dty1Q76LBnbbf260Y=;
        b=o6R+cfbpu5aL3WiHWVd5KrEXO3SDHvBQDMRQiafbCxyYQMWUgPfJ9v83Z6d7iCaU9m
         f05KNg0HBhLhNaMQCbRp3b4FziXGa3TnXBxB8/Li5+aEf7N0+vH5/667ENdySbAjeUZE
         xSuzKEOKo0ifaDfHVmB0VM1aeq674DlPT/n4jkT6lu+LU1xpcXkoWVe66vTYLro9lfA4
         8Ga0sjKA6bnHYW4x26FDhI6lUabym4ErEjymJVrUDqWkRgPj2NQLwHgZ1A9hVlPG0QFf
         ucwSuWi00V6yLYCMFWWo5f1ZilvDOOMRncDjP2MD3Ow3ynjAT104RCFsATEh/Gw+fd15
         XDqg==
X-Gm-Message-State: AOAM533h0AVPdrjN5TwZOY6hddgbSucpNmsd2XlKC0PW6JZ8UVUFeP1Z
        9nbTHKHn/0pk1eoaxFGYoqvDHg==
X-Google-Smtp-Source: ABdhPJyX7Z9XnpFyNuqpfqkjPIdufx/u4bzd7dwJJIfVixRVYr5mvebT1DMOwhkGk2hOtFa5zMskoQ==
X-Received: by 2002:a05:6808:24d:: with SMTP id m13mr532829oie.165.1614629791975;
        Mon, 01 Mar 2021 12:16:31 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t13sm4039319otp.42.2021.03.01.12.16.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 12:16:31 -0800 (PST)
Date:   Mon, 1 Mar 2021 12:16:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Zhao <yuzhao@google.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and
 PG_unevictable
In-Reply-To: <YD1HgmERg3/LuApe@google.com>
Message-ID: <alpine.LSU.2.11.2103011215260.4616@eggly.anvils>
References: <20210224084807.2179942-1-yuzhao@google.com> <20210226091718.2927291-1-yuzhao@google.com> <20210226091718.2927291-4-yuzhao@google.com> <20210226121314.GB2723601@casper.infradead.org> <20210301115007.mgw5vthgjoibnjf4@box>
 <YD1HgmERg3/LuApe@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021, Yu Zhao wrote:
> On Mon, Mar 01, 2021 at 02:50:07PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Feb 26, 2021 at 12:13:14PM +0000, Matthew Wilcox wrote:
> > > On Fri, Feb 26, 2021 at 02:17:18AM -0700, Yu Zhao wrote:
> > > > All places but one test, set or clear PG_active and PG_unevictable on
> > > > small or head pages. Use compound_head() explicitly for that singleton
> > > > so the rest can rid of redundant compound_head().
> > > 
> > > How do you know it's only one place?  I really wish you'd work with me
> > > on folios.  They make the compiler prove that it's not a tail page.
> > 
> > +1 to this.
> > 
> > The problem with compound_head() is systemic and ad-hoc solution to few
> > page flags will only complicate the picture.
> 
> Well, I call it an incremental improvement, and how exactly does it
> complicate the picture?
> 
> I see your point: you prefer a complete replacement. But my point is
> not about the preference; it's about presenting an option: I'm not
> saying we have to go with this series; I'm saying if you don't want
> to wait, here is something quick but not perfect.

+1 to this.

Hugh
