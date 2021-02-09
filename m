Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22433159C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhBIWzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233675AbhBITrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:47:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0584664E85;
        Tue,  9 Feb 2021 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612900001;
        bh=Tibp+D2Q1fLAWYC0pmdwEcPTKdC9dJtIKxcQZULcsjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rse+ayemXBSfNdjdOADaJKaOySC6VHwaFAcgRgC6E7VW4kTzQhz08AQptUyzvAm85
         QUKn8ECsDODXqY+mzEcjP9BGMyivax4L1/iHNiS+pjMKam7WpgniNCJTkR0RgCvNU9
         013T0dhjSmenA7iCcHvpA/HQ0nZdPmWQe8TJN1yA=
Date:   Tue, 9 Feb 2021 11:46:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
Message-Id: <20210209114640.73a68074f635852c2ce498e6@linux-foundation.org>
In-Reply-To: <20210209062128.453814-1-nao.horiguchi@gmail.com>
References: <20210209062128.453814-1-nao.horiguchi@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Feb 2021 15:21:28 +0900 Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:

> Currently hwpoison code checks PageAnon() for thp and refuses to handle
> errors on non-anonymous thps (just for historical reason).  We now
> support non-anonymou thp like shmem one, so this patch suggests to enable
> to handle shmem thps. Fortunately, we already have can_split_huge_page()
> to check if a give thp is splittable, so this patch relies on it.

Thanks.  We're at -rc7 so I think I'll park this one for 5.12-rc1,
unless it is more urgent than I believe it to be?
