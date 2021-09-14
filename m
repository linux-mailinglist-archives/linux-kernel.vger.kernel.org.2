Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53C40A3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhINCwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238027AbhINCwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:52:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D553610F9;
        Tue, 14 Sep 2021 02:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631587874;
        bh=LeDc9FUxhAd0agUr9PtL7mkbqZCgFRCvEmk8CtR8Q4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TGzKjT7KXFYDYcrhzD4EC4aUuppevUry1Jh7j5KXsu1iGyF5tjgn+ZA3RCHjhUuMb
         K3fvvKrezbjTx6VQ1cjuDnJLtUvcaRetj25+X3gC2OCX7W4rvdtQK0lzvHux1N8HC4
         r52AhA/vzD2c4AqF34+Ee/1knF6e3/845+0kzCn0=
Date:   Mon, 13 Sep 2021 19:51:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
Message-Id: <20210913195113.b13142630a5401e8abacc13e@linux-foundation.org>
In-Reply-To: <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
        <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
        <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
        <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
        <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 14:59:42 +0200 Michal Hocko <mhocko@suse.com> wrote:

> I do realize that the stable tree is in a hoarding mode for quite some
> years but my general approach has been (in line with the documentation)
> to mark and backport only fixes that really do matter.

Me2.  There has to be some risk-vs-reward test to be passed...
