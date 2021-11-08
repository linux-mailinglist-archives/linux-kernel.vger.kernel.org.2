Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE630449F00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 00:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbhKHXa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 18:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbhKHXa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:30:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A22C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hXlfPXoraJxvMlmnLjJ9FDLqsSLbWHE4ov9uAQpzlyQ=; b=XXJUAGCdeAroytP5eC/+J99V/7
        3OSN0yMihx5SkdJuhea2EInMOGfRp8dbZYPU2avu/U5JH8sXKKpyxVS58r6MAhj6pM1kHCEN8Ghzo
        PZs+zlv6NxBHm8ShQcYRACbxrXYiApdvZawPoeCFkc26UJxGePd6y5CkSxDbw1bUwKfa4Jf574uOp
        nXD8+OINPK+yQimz78+ezFKfZTz9Jt9jwu88d5aQ4mTV+AODhW7Am+plvr8GOyaNN5PCcu93HrlJb
        FFjP5MBhKfYaDNyTRrl1eegx1En6+t0+VUbYaVPp/AZYIuKZdevlmUOgEdJv1rL2DqjhqEdFkqQ9F
        ClW8pLdQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkE3A-00Haag-AZ; Mon, 08 Nov 2021 23:27:40 +0000
Date:   Mon, 8 Nov 2021 15:27:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Modules updates for v5.16-rc1
Message-ID: <YYmybK73+NGQdsQw@bombadil.infradead.org>
References: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
 <CAHk-=wjQyGhKCM+F8vRS6SSesXk1rZEP4QxdTjvr8DXmC-e1Lg@mail.gmail.com>
 <YYlK2QKpmb+ipalA@bombadil.infradead.org>
 <CAHk-=whvQ0JxYDB2BWx4r3Ym-MM1U5G_OY0E=31UVqbwz2_-Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvQ0JxYDB2BWx4r3Ym-MM1U5G_OY0E=31UVqbwz2_-Dw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 09:07:58AM -0800, Linus Torvalds wrote:
> So if your 'origin' remote branch is the one that tracks upstream, the
> command line should be something like
> 
>    git request-pull origin/master git://git.kernel.org/....
> 
> please give that a try (but don't update your origin tree before you
> do, since I've just pulled things, and then you'll get the same
> "nothing to pull").

Yes, I see the diff stat now thanks! Will be sure to make it smoother on
the next rounds.

  Luis
