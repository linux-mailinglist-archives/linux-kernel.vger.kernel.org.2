Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0263A74E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFODSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhFODSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:18:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3D4161403;
        Tue, 15 Jun 2021 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623719558;
        bh=wXpDWAhWzwm6rYJOKAWqIhMA0w55huKKrzBAUYBys2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YMN+ev+O//2iInS48NBgC+9MdSpgmI/zI9YddpMX7rlSorCsZlS8oRLmeGFxkeZRL
         7cOaQlBW+AMD5tpW+1mBEiusP6ira2zvKqWb+uvTAfjLgxgHa7b2e2YEcXVO/QQ5Sb
         HT71Gk5HYyjdjeeUgSFfxa2Vvf743PdsEPgGfN64=
Date:   Mon, 14 Jun 2021 18:12:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        chenhuang5@huawei.com, bodeddub@amazon.com, corbet@lwn.net,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] Split huge PMD mapping of vmemmap pages
Message-Id: <20210614181237.5513724624dde3ac930b75d8@linux-foundation.org>
In-Reply-To: <20210612094555.71344-1-songmuchun@bytedance.com>
References: <20210612094555.71344-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 17:45:52 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> In order to reduce the difficulty of code review in series[1]. We disable
> huge PMD mapping of vmemmap pages when that feature is enabled. In this
> series, we do not disable huge PMD mapping of vmemmap pages anymore. We
> will split huge PMD mapping when needed. When HugeTLB pages are freed from
> the pool we do not attempt coalasce and move back to a PMD mapping because
> it is much more complex.
> 
> [1] https://lore.kernel.org/linux-doc/20210510030027.56044-1-songmuchun@bytedance.com/

[1] had a nice [0/n] description but the v2 series lost that.  I could
copy/paste the v1 changelogging but I am unsure that it has been
maintained appropriately for the v2 series.

I think I'll pass on this v2 pending additional review input.  Please reinstate
the [0/n] overview if/when resending?

