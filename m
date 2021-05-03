Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055C6371F17
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhECSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:02:39 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:30479 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhECSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=921; q=dns/txt; s=iport;
  t=1620064904; x=1621274504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=11OIbKeLQbrAmtYBHBv7IUPUzo44ctCWght7Qdc/mM4=;
  b=MWs8TCqfqER+RKcP50HnhV3kmuFELomjw3RKZwij4KZ4S+QtL55F0c1B
   QpOYwpy3+is8ZJ1myhiI5RreLcwKT2IlLkxJDYeKNBd2HAib9pz1fIUPF
   X55yD3ODjMIrsolXyS5df1wrWBUYn2E4cyg4V7RwTwTFJOxRIPFPpvnRm
   A=;
X-IPAS-Result: =?us-ascii?q?A0ABAABeOZBgmIENJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUMEAQEBAQELAYMhVgE5MYxoiVGQG4pkgXwLAQEBD?=
 =?us-ascii?q?QEBKAwEAQGBFgGCdT8DAgKBewIlNAkOAgQBAQEDAgMBAQEBAQUBAQECAQYEF?=
 =?us-ascii?q?AEBAQEBAQEBaIVQDYZEAQEBAwEyAUYFCwsYLjwbBoMEAYJmIQ+oEniBNIEBg?=
 =?us-ascii?q?1xBhA6BPgYUD4EXAY1fJxyBSUKENz6CYAECAYdWBIFlghoCgUySRI03nD6DG?=
 =?us-ascii?q?oEom3Y3EKUSLbhiAgQGBQIWgVQ4gVszGggbFYMkUBkOjjiIa4VpIQMvAjYCB?=
 =?us-ascii?q?goBAQMJjQ8BAQ?=
IronPort-HdrOrdr: A9a23:yK4s+KrHpEuia7oOGiAk4nMaV5tRL9V00zAX/kB9WHVpW+aT/v
 rAoN0w0xjohDENHFwhg8mHIqmcQXXanKQFhLU5F7GkQQXgpS+UN4lk94Tv2HnNHCf5++5b28
 5bAsxDIff3CkV3itu/3RmgH78bsbu62Y2hmOu29R1QZC5wbaUI1WpEIyadVnZ7XQxXQac+fa
 DsgfZvgxqFVTApYt+gBn8DNtKzxOHjsJ79exYJC1oGxWC17A+A07LxHxiG0hp2aVomqosKym
 TLnxf04a+uqZiAqiP07XPZ7JhdhbLapOdrOcrksKQoAwSpohq0YsBbV6eaujcurKWU9E8yi9
 XXuX4bTqJOwkKUWH2pqh3w3ASl9zAi5xbZuCelqEqmh9DlTzQnDMcEv6ZlS1/y7kotu8wU6t
 Mz416k
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,270,1613433600"; 
   d="scan'208";a="686368801"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 03 May 2021 18:01:44 +0000
Received: from zorba ([10.24.21.191])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 143I1fkQ017898
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 May 2021 18:01:43 GMT
Date:   Mon, 3 May 2021 11:01:41 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib: early_string: allow early usage of some string
 functions
Message-ID: <20210503180141.GO3844417@zorba>
References: <20210430042217.1198052-1-danielwa@cisco.com>
 <dc26a67e-dba0-1b8c-3718-3c75415c61f1@csgroup.eu>
 <1929b3a8-f882-c930-4b99-10c6a8f127c7@csgroup.eu>
 <e355ecc9-574a-dbcb-7864-5aa4974e1971@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e355ecc9-574a-dbcb-7864-5aa4974e1971@csgroup.eu>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.21.191, [10.24.21.191]
X-Outbound-Node: alln-core-9.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 09:31:47AM +0200, Christophe Leroy wrote:
> 
> > In fact, should be like in prom_init today:
> > 
> > #ifdef __EARLY_STRING_ENABLED
> >      if (dsize >= count)
> >          return count;
> > #else
> >      BUG_ON(dsize >= count);
> > #endif
> 
> Thinking about it once more, this BUG_ON() is overkill and should be
> avoided, see https://www.kernel.org/doc/html/latest/process/deprecated.html
> 
> Therefore, something like the following would make it:
> 
> 	if (dsize >= count) {
> 		WARN_ON(!__is_defined(__EARLY_STRING_ENABLED));
> 
> 		return count;
> 	}

I agree, it's overkill it stop the system for this condition.

how about I do something more like this for my changes,


> 	if (WARN_ON(dsize >= count && !__is_defined(__EARLY_STRING_ENABLED)))
> 		return count;

and for generic kernel,

> 	if (WARN_ON(dsize >= count))
> 		return count;



Daniel
