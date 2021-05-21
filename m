Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE338CE34
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhEUTdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236901AbhEUTdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:33:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8B8F60FE7;
        Fri, 21 May 2021 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621625499;
        bh=3vCpW8xLXbUSD5frK0Eu7sWnc7qIC9I7pcYAKP07bg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMrLG5PROURLFYbK7RzyZfYbGb75ubxs8HhTXBcjvDvKvYHBArre7/IEDPTVSuDBJ
         wDHOwILtoHETm0DIXBr+ZlZMcT/PURbvpD9SSpUxu4+7Ur2Ms7R9P1apt58bayTXpy
         M+VyXb6xJyF0R2tk1PMmtS9paMBhDRZ0zEId8ZR6L+UoCF/2IBR5euNl2AWiavmw2q
         RTZvv6kKNdGb3JxrvWg9QkisSm6/SMGaJ8QU6p4QcoBbDpt3lSvf6oTRvf1Rq4U1fE
         VfTBb2+T3dqLfMb/ABCXNG7rEEUuetlsG0WwlOpzmgqM4z7tucKJUqmVDICaP33nYw
         vwfTnY9Pd4PvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6B614011C; Fri, 21 May 2021 16:31:36 -0300 (-03)
Date:   Fri, 21 May 2021 16:31:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf scripts python: exported-sql-viewer.py: Minor
 fixes
Message-ID: <YKgKmMQ90gH3196S@kernel.org>
References: <20210521092053.25683-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521092053.25683-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 21, 2021 at 12:20:50PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are 3 minor fixes for stable.
> 

Thanks, applied.

- Arnaldo

 
> Adrian Hunter (3):
>       perf scripts python: exported-sql-viewer.py: Fix copy to clipboard from Top Calls by elapsed Time report
>       perf scripts python: exported-sql-viewer.py: Fix Array TypeError
>       perf scripts python: exported-sql-viewer.py: Fix warning display
> 
>  tools/perf/scripts/python/exported-sql-viewer.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
