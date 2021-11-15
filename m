Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C640452354
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379594AbhKPBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243612AbhKOTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:12:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B6C061208
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6W1hMfmQMQGGpTs8Ri8cJaoE7Bep5eQ/Q+sFKM2FP1g=; b=347vnEWPfrFaMguc9y8BgC6Hgo
        OGRHVF1aN4p61i1lGoMawGE0+ajnBMQWySZkmE0Z0b4L2CSD196V0/oHt8XFXJg8BSgwGPNe7gKZf
        TxP0WvfHCXEPK7GruOsLW+HCX8+Fo6KkiLQbh1INpdqeccaHr+INFaUibPYMnIxlDOytHSdkbGCy3
        d8Esp1gRToD1kK5weskAlQHIEmOhM5UFX8eOOTwIHesOYTDR6ef4/TW7aRft3X5T+vqzfcO5G/bEy
        pvR9L53qeXVDbk+Vfma6tkAQMm7FmDHmbOXQcp+Yjk5QFwCxvgAeqdtS2UNpYwVaLv+/0oLlkHQ4Z
        WQTSAfHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmgJB-00GcWr-NC; Mon, 15 Nov 2021 18:02:21 +0000
Date:   Mon, 15 Nov 2021 10:02:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: is arch/h8300 dead, was Re: linux-next: stats (Was: Linux 5.16-rc1)
Message-ID: <YZKgrSNXR87q2HSD@infradead.org>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115141718.0ce3947d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115141718.0ce3947d@canb.auug.org.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 02:17:18PM +1100, Stephen Rothwell wrote:
> There are also 424 commits in next-20211101 that didn't make it into
> v5.16-rc1.
> 
> Top ten first word of commit summary:
> 
>      53 bluetooth
>      37 tools
>      23 rcu
>      21 drm
>      18 arm
>      17 iio
>      13 soc
>      10 h8300

At least two of the h8300 ones also were in linux-next for the previous
merge window and didn't make it (my set_fs removal patches).  What is
the maintainer status of h8300 when nothing gets sent on to Linus?
