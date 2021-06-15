Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E83A8CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFOXuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOXuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:50:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D8F161369;
        Tue, 15 Jun 2021 23:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623800898;
        bh=MU+QgBNSQeAjAwvNJgbwfAcrLw//Mv1kPExB4e8vCXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q8ADG2ZIioieYx3NSlF5YDr8udzfRscNEhba5uzHy7LSg1cPwM8N945yJ+Wxr0dtd
         8fV16UuhlsOzrMAqwr7h1oACCbfGvRddETpDuM9H+DwDfoMFtqr2sZiWUCk1fhISq6
         GBOMPKVCvUFKlXp2cHQj+GJdtqrH+CNR57OmbIL8=
Date:   Tue, 15 Jun 2021 16:48:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=) 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm/hwpoison: do not lock page again when
 me_huge_page() successfully recovers
Message-Id: <20210615164818.24d5c07c95ece3fcf82e7805@linux-foundation.org>
In-Reply-To: <20210615035846.GA1807446@hori.linux.bs1.fc.nec.co.jp>
References: <20210609072029.74645-1-nao.horiguchi@gmail.com>
        <20210610165059.6618498250f60674c1bb9c03@linux-foundation.org>
        <20210611002329.GA1201351@hori.linux.bs1.fc.nec.co.jp>
        <20210614193528.c2cc50d92eb76c4bea1b40e8@linux-foundation.org>
        <20210615035846.GA1807446@hori.linux.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 03:58:47 +0000 HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> > Should Tony's patchset also be targeted to -stable?  If so then OK.
> 
> Yes, that's fine. And I think that the first two patches
> (mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races.pathc and
> mmhwpoison-return-ehwpoison-to-denote-that-the-page-has-already-been-poisoned.patch)
> can be marked to stable, but 3/3 (mmhwpoison-send-sigbus-with-error-virutal-address.patch)
> may not because it's a little too large and not the main part of the fixes.

OK, thanks, I queued

mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races.patch
mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races-fix.patch
mmhwpoison-return-ehwpoison-to-denote-that-the-page-has-already-been-poisoned.patch
#
mm-hwpoison-do-not-lock-page-again-when-me_huge_page-successfully-recovers.patch

for 5.13 with cc:stable and

mmhwpoison-send-sigbus-with-error-virutal-address.patch
mmhwpoison-send-sigbus-with-error-virutal-address-fix.patch

for 5.14.
