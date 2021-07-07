Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294FF3BE9DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhGGOk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231737AbhGGOk5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:40:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BFE061C37;
        Wed,  7 Jul 2021 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625668697;
        bh=bc//SalR1DAUqRMVWUKuA62hc8+6u1K0EeWAU3GsaNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lv+hSg4FvB4bomMPwm4/aLLhkwPnDqxixcwreJ5KiGiOrmbE+6ka7YjqfCF6wzsWr
         8AE8ZOhWmCqDRDEj/8ja+IVK21sBCBELH40fOJF9jDbHbbLusLw1APA+Rl0qH8+eQQ
         iK6xDa/MGqdPHjFQvLrZirsaK4VecWWTVfJorjcH3SILQtmF1fuwcfBFC//+m7xaHt
         vf01iuF/qejLFmOOoP12Uwft1wu8hEFk5RwoLR0LmnxoQGSILHOmBBH5OJWMc6dmUT
         ZOrlaTXgasc3Piigs9m75KLgZeZ6WKGqjxF7lMAGxv/qIhOqYp4pIsbaPGUh94kk8R
         YUJpZs47v5BMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0471C40B1A; Wed,  7 Jul 2021 11:38:14 -0300 (-03)
Date:   Wed, 7 Jul 2021 11:38:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf stat: Disable NMI watchdog message on hybrid
Message-ID: <YOW8VmUS88D41RoL@kernel.org>
References: <20210610034557.29766-1-yao.jin@linux.intel.com>
 <d7d01f73-0253-fe4d-c98a-ae000e289e09@linux.intel.com>
 <YOS052YU7108zIjx@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOS052YU7108zIjx@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 06, 2021 at 09:54:15PM +0200, Jiri Olsa escreveu:
> On Tue, Jul 06, 2021 at 10:19:47AM +0800, Jin, Yao wrote:
> > > v3:
> > >   - Use evlist__has_hybrid() to check there is at least one hybrid
> > >     event in evlist.

> > > v2:
> > >   - If the group was mixed with hybrid event and non-hybrid event,
> > >     the NMI watchdog message was still reported. V2 adds checking
> > >     for hybrid event mixed group.

> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

