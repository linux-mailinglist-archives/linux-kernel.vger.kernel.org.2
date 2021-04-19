Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA563639BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbhDSD1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbhDSD03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:26:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115DC06174A;
        Sun, 18 Apr 2021 20:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wF5Ti3p6ukxFBbnOErN0GEWkYJORujrGl5v+prvaUz0=; b=dYIGAGcYlNbN2NQppzgNkikKhg
        PnPCMz45ytddxiSTkgLS7zacFZxpmcMQC3jAp+uN4QTTlXXGK2aUbuvkAgjfWG1ASsMxc/2mnVU7j
        pUvoft2tkI1gm6TtpVV16Ard9CweevBNvpMYqIleos42dDFi23wYZ8gslx4fyK2oBC9sQOzqgFosX
        STUB7UudxPMxRJ8yVnRb6yJaSDOhjeoZPr3i/M8tLPIXryTVaj42PgmXRyGB3P5Wk1Ug30gRFuMe9
        1MrYPpYOb1lEUzD+XC8/sKDgdrYNKFS+ij1sfSfn/uS+u//uHP3U4PSg+SSV05Ek5y6ejifOQXDTI
        y/SwOkcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYKXB-00D9dR-5t; Mon, 19 Apr 2021 03:25:18 +0000
Date:   Mon, 19 Apr 2021 04:25:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Neil Brown <neilb@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        vegard.nossum@oracle.com, Al Viro <viro@zeniv.linux.org.uk>,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
Message-ID: <20210419032513.GW2531743@casper.infradead.org>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
 <20210316054727.25655-2-foxhlchen@gmail.com>
 <20210419021730.GV2531743@casper.infradead.org>
 <CAC2o3D+kq+U9vSp_9DNM3UGA=UGhS84Y+mwm=9S6eMPpf2-ogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2o3D+kq+U9vSp_9DNM3UGA=UGhS84Y+mwm=9S6eMPpf2-ogQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 10:33:00AM +0800, Fox Chen wrote:
> On Mon, Apr 19, 2021 at 10:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Mar 16, 2021 at 01:47:16PM +0800, Fox Chen wrote:
> > > -In the absence of symbolic links, ``walk_component()`` creates a new
> > > +As the last step of ``walk_component()``, ``step_into()`` will be called either
> >
> > You can drop ``..`` from around function named which are followed with
> > ().  d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
> > marks them up automatically.
> >
> 
> Got it, thanks for letting me know. But I will still use them in this
> patch series to keep consistency with the remaining parts of the
> document.

Well, you weren't.  For example:

+As the last step of ``walk_component()``, ``step_into()`` will be called either
+directly from walk_component() or from handle_dots().  It calls
+``handle_mount()``, to check and handle mount points, in which a new

Neither of the functions on the second line were using ``.
