Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADD0377940
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhEIXaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhEIXaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:30:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7560D613AB;
        Sun,  9 May 2021 23:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620602958;
        bh=lVloXOMnxsml3PxRicfGS9YjP6h73lgxDYsSMX6Qzic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=joU0kN9HXZ7LfK+RTyam7DDekZ7T8EKQC/mubKm28PlRu5g1uuuINcGOT/W0ektA1
         bR8j4M89hDqCbqMHWaNuj/0++PmiEnMj6WMvUCjS1GV7L4TePeChHPdK2ktg10chCS
         H9yKN87B3gt1IjNpWQgYtDlQv38e6gNauPQtt/Dk=
Date:   Sun, 9 May 2021 16:29:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Wang Qing <wangqing@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2,RESEND 1/4] kernel: watchdog: Modify the explanation
 related to watchdog thread
Message-Id: <20210509162917.3a50fef3858f7708a84d1a91@linux-foundation.org>
In-Reply-To: <YIp8e6ftzUdgX4Yv@alley>
References: <1619687073-24686-2-git-send-email-wangqing@vivo.com>
        <YIp8e6ftzUdgX4Yv@alley>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 11:29:31 +0200 Petr Mladek <pmladek@suse.com> wrote:

> On Thu 2021-04-29 17:04:25, Wang Qing wrote:
> > The watchdog thread has been replaced by cpu_stop_work, modify the 
> > explanation related.
> > 
> > Signed-off-by: Wang Qing <wangqing@vivo.com>
> 
> You should have added my Reviewed-by when resending the patchset.
> Anyway, for all four patches:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Andrew, would you take it via -mm tree?

Sure.  I dropped "[2/4] doc: watchdog: Delete the explanation about
"watchdog/%u"" because someone already did that.

