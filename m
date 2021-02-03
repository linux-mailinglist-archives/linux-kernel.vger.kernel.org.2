Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E630E223
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhBCSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:13:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:38176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhBCSMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:12:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5FF8B15B;
        Wed,  3 Feb 2021 18:12:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 82A5C1E14C4; Wed,  3 Feb 2021 19:12:13 +0100 (CET)
Date:   Wed, 3 Feb 2021 19:12:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     bingjingc <bingjingc@synology.com>, kuba@kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] parser: Fix kernel-doc markups
Message-ID: <20210203181213.GB20183@quack2.suse.cz>
References: <20210129050037.10722-1-bingjingc@synology.com>
 <f5cd0b56-de00-bc4f-d4c6-9108d7cab780@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5cd0b56-de00-bc4f-d4c6-9108d7cab780@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-01-21 22:39:46, Randy Dunlap wrote:
> On 1/28/21 9:00 PM, bingjingc wrote:
> > From: BingJing Chang <bingjingc@synology.com>
> > 
> > Fix existing issues at the kernel-doc markups
> > 
> > Signed-off-by: BingJing Chang <bingjingc@synology.com>
> > ---
> >  lib/parser.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> thanks for the kernel-doc patch.

Thanks for the patch and review. Since this is somewhat related to the
match_uint() fixes, I've just picked up this patch to my tree as well since
I don't think we have a designated lib/parser.c maintainer...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
