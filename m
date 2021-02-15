Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DE31C248
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBOTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBOTNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:13:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E941CC061574;
        Mon, 15 Feb 2021 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ahBtQ8EQ5jE1I8cSnduD9btkwOgYPHWG4aIuM6PsRWw=; b=fmH7G8QhdVJz+kKx8cQOk4tWIz
        s0ic5Sbo5HA4TEQYNiYJxGtnyLhz1lJfFVc945yY6GQAb9XKNeViIzg8PYNImzKJKpfDkyEo+Qnu5
        o0rUtGu0Wh8TAFZK52W4SLPxAkUaqqmkhkd//wnZNx9ONsgroBfz/m/6lh3Xf/f5SuLKrfkUJBIxQ
        s7qubCBT6YWdQLo/qUrzcjodk0R4WjOdkw/AHbS7BPwsVHCjoBlsu4LsxSJHBoU3O14I4rYgcMEGU
        5u+jb9upjdLpEqyE+Jckwvz2U6qoLeyB2kXd8DcIGbdQNZ6xvngW36ElFHapmwAb1p/P526I115B1
        pmURke2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBjIP-00FxIn-8m; Mon, 15 Feb 2021 19:12:33 +0000
Date:   Mon, 15 Feb 2021 19:12:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>, linux-doc@vger.kernel.org,
        lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
Message-ID: <20210215191233.GF2858050@casper.infradead.org>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
 <20210213131513.51386-3-dwaipayanray1@gmail.com>
 <20210214121501.GC2858050@casper.infradead.org>
 <2162334bdf4d635f1414ffef52378c0f423366a7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2162334bdf4d635f1414ffef52378c0f423366a7.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 10:11:03AM -0800, Joe Perches wrote:
> On Sun, 2021-02-14 at 12:15 +0000, Matthew Wilcox wrote:
> > On Sat, Feb 13, 2021 at 06:45:12PM +0530, Dwaipayan Ray wrote:
> > > +Checkpatch (scripts/checkpatch.pl) is a perl script which checks for trivial style
> > 
> > It's quite amusing that this patch contains lines > 80 columns.
> 
> Then you could amuse yourself further by looking at the existing
> line lengths of .rst files.

There are good reasons for rst lines to be longer than 80 columns,
but there weren't any in this case.
