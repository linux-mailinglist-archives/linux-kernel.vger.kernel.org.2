Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8203B310AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBEMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhBEMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:13:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177F0C06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L6mpUyb2tsXriUaxnJYzuNaLbxNc4mxLma6rOnf0vj0=; b=H+Q6G+KEvacqdLRfvY8ucy9m+u
        OZ/RyKqspgovjVJ1UxlwgrYXnNZDtIYry6P53zz7Vsmhul70qm6DztS61LmTO8Kj+KxXDTJi7YaV9
        0FKo8kzRDDSMQqFSTpJuHnLOA2+QydDl89CRhQjrWWSoDrTVnjom2YtEcE95xQnMQQb6+ZkNOIRUW
        Lrg5uxjcihQKehxU3gyiLYzENN9dwBT4UF4VuoxEDZVMuSgwDSaKE2t1vuxFoLu5vB61bfsHrX6aB
        Dpvzi191o88+C9kzm7LnRIERZQ68DhM7Jgn/7YZI/sw2zkcQB4O7QiCKNuXhGlJ6qojzDb/W4yUSH
        /8atktZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7zyD-002GeT-Ku; Fri, 05 Feb 2021 12:12:17 +0000
Date:   Fri, 5 Feb 2021 12:12:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <20210205121217.GH308988@casper.infradead.org>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <20210205025526.GG308988@casper.infradead.org>
 <YBzWCl0MVNWntyUZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBzWCl0MVNWntyUZ@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:22:18PM -0800, Minchan Kim wrote:
> > > +	for (i = 0; i < cma_area_count; i++) {
> > > +		cma = &cma_areas[i];
> > > +		stat = kzalloc(sizeof(*stat), GFP_KERNEL);
> > > +		if (!stat)
> > > +			goto out;
> > 
> > How many cma areas are there going to be?  do we really want to allocate
> > their stat individually?
> 
> I am not sure what could be in the end but at least, I have
> 5+ candidates (but could be shrink or extend) and yes,
> want to keep track them individually.

I meant, wouldn't it be better to:

	cma_stats = kzalloc(array_size(sizeof(*stat), cma_area_count),
				GFP_KERNEL);

