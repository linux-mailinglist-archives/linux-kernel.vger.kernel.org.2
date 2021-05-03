Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315ED371F28
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhECSHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:07:53 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:52760 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhECSHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=993; q=dns/txt; s=iport;
  t=1620065218; x=1621274818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7X2Sx/02p8jds+5OouAKIoXCEMD74/3FvpAFk7V449g=;
  b=hzQfZG2hw2tREhgBr7VhHJw5OOiliOsEXxNA/Bdr9KfIQrmyos0y3XOl
   Ozryp1VEiOVkvL9+MsN7/MhspoLzi237/WHRfzTHy/F2/NxNqyfwLvwc6
   74yVjM1FKabWzEZepExFuQ1ijNBFrcGbH8xY74EAVETAtvPW9Fkga8oKz
   k=;
X-IPAS-Result: =?us-ascii?q?A0ABAACVOpBgmIkNJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUMEAQEBAQELAYMhVgE5MYxoiVKQG4pkgXwLAQEBD?=
 =?us-ascii?q?QEBKAwEAQGBFgGCdT8DAgKBewIlNAkOAgQBAQEDAgMBAQEBAQUBAQECAQYEF?=
 =?us-ascii?q?AEBAQEBAQEBaIVQDYZFAQUyAUYQCxguPBsGgwQBgwcPqBt4gTSBAYNcQYQOg?=
 =?us-ascii?q?T4GFA+BFwGNXyccgUlChDc+gmABAgGHVgSBZYIaAoFMgSiRHI03nD6DGoEom?=
 =?us-ascii?q?3Y3EKUSLbhiAgQGBQIWgVQ4gVszGggbFYMkUBkOjjiIa4VpIQMvAjYCBgoBA?=
 =?us-ascii?q?QMJjQ8BAQ?=
IronPort-HdrOrdr: A9a23:UuRB3K4c3ftbjkInKwPXwbKBI+orLtY04lQ7vn1ZYxY9SKOlvu
 qpm+kW0gKxpTYKQXc7mc2BPq7oewK4ybde544NMbC+GDT8sGyzI414qafkyTvsGyrxn9QtsZ
 tIWa54FdH2EBxGnd/3iTPIceoI7dGb/MmT79v24GxqSWhRBp1IzwA8MQqDF10zeQ8uP+tfKL
 O5xu5q4wWtYm4WaMPTPAhnY8Hmq8fQnJzrJT4qbiRH1CC0gTml6KH3HnGjt390bxp1zbgv6m
 TDmQDij5/Cj9iA1hTe22XPhq45pPLdzLJ4aPCku4w8Nijrzj2lfp1mXKeP+Aooufi15Ewx+e
 O8xSsIDoBU927beH2zrF/L3QTtuQxek0PK+Bu/nWbpp9D/SXYBL/d5wahdchff9iMbzahB7J
 4=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,270,1613433600"; 
   d="scan'208";a="708392964"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 03 May 2021 18:06:57 +0000
Received: from zorba ([10.24.21.191])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 143I6tWd008213
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 May 2021 18:06:56 GMT
Date:   Mon, 3 May 2021 11:06:54 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] lib: early_string: allow early usage of some string
 functions
Message-ID: <20210503180654.GP3844417@zorba>
References: <20210430042217.1198052-1-danielwa@cisco.com>
 <dc26a67e-dba0-1b8c-3718-3c75415c61f1@csgroup.eu>
 <1929b3a8-f882-c930-4b99-10c6a8f127c7@csgroup.eu>
 <e355ecc9-574a-dbcb-7864-5aa4974e1971@csgroup.eu>
 <20210503180141.GO3844417@zorba>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210503180141.GO3844417@zorba>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.21.191, [10.24.21.191]
X-Outbound-Node: alln-core-4.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 11:01:41AM -0700, Daniel Walker wrote:
> On Sat, May 01, 2021 at 09:31:47AM +0200, Christophe Leroy wrote:
> > 
> > > In fact, should be like in prom_init today:
> > > 
> > > #ifdef __EARLY_STRING_ENABLED
> > >      if (dsize >= count)
> > >          return count;
> > > #else
> > >      BUG_ON(dsize >= count);
> > > #endif
> > 
> > Thinking about it once more, this BUG_ON() is overkill and should be
> > avoided, see https://www.kernel.org/doc/html/latest/process/deprecated.html
> > 
> > Therefore, something like the following would make it:
> > 
> > 	if (dsize >= count) {
> > 		WARN_ON(!__is_defined(__EARLY_STRING_ENABLED));
> > 
> > 		return count;
> > 	}
> 
> I agree, it's overkill it stop the system for this condition.
> 
> how about I do something more like this for my changes,
> 
> 
> > 	if (WARN_ON(dsize >= count && !__is_defined(__EARLY_STRING_ENABLED)))
> > 		return count;

I'll have to work on this one..

Daniel
