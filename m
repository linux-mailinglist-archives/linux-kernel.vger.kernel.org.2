Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084C3377B39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 06:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEJE2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 00:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhEJE17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 00:27:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E07A66100C;
        Mon, 10 May 2021 04:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620620815;
        bh=odosyeUkF8IMRHT7IXOdmt7HbqZ5eRV7yGJJrHVHxf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pda+AWAtFXjbJG05uulfL5FQb+jKO7zJKI9I3eFJJzpDSnyc0JBmDjGSma8dynEba
         o9ZzpAwECdcUAu/1kz1ARy7WD2l55Gm43c65pNn/ibW7npCqF7rxGWiaO5i5D2HHVD
         m7cawHclZSAxIELdYA04S+HPymhkSQZDFsWoHk8E=
Date:   Sun, 9 May 2021 21:26:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v3 1/2] mm/debug_vm_pgtable: Move
 {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE
Message-Id: <20210509212654.e215ff71042b62704965ae01@linux-foundation.org>
In-Reply-To: <20210419071820.750217-1-liushixin2@huawei.com>
References: <20210419071820.750217-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 15:18:19 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge are not dependent
> on THP. Hence move {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE.

What is the actual effect of this?  Better test coverage?  Smaller
kernel?  Larger kernel?

(I'm too lazy to figure this out and it should have been in the
changelog anyway ;))
