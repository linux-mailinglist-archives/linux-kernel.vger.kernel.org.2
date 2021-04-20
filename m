Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028C0365C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhDTPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:43:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:57988 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232303AbhDTPn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:43:26 -0400
IronPort-SDR: Kn2+hmN/QxvdemEnS9tzdf4AVHsDXJa/bth/UddiioPz3mq6oKSTQYb/l/+G3TZX6NZdyqVPGk
 thtoCPFivqUA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="182660869"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="182660869"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:42:54 -0700
IronPort-SDR: unoWFt/RJnmiNcieQXJzY2Un2GpMb8M25Wd5f9DCUQMOSqY73zRfHS7OsDFcKoXfh2MUxDnl0O
 psuXPIu7ydRg==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="523853448"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:42:54 -0700
Date:   Tue, 20 Apr 2021 08:42:53 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
Cc:     nao.horiguchi@gmail.com, akpm@linux-foundation.org, bp@alien8.de,
        david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        luto@kernel.org, naoya.horiguchi@nec.com, osalvador@suse.de,
        yaoaili@kingsoft.com
Subject: Re: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Message-ID: <20210420154253.GA577572@agluck-desk2.amr.corp.intel.com>
References: <CAPcxDJ6OAd=qdfxoTQ4cp5vQ6_+phWqX8gJfec48XyAZybBpsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcxDJ6OAd=qdfxoTQ4cp5vQ6_+phWqX8gJfec48XyAZybBpsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 06:49:15PM -0700, Jue Wang wrote:
> On Tue, 13 Apr 2021 07:43:20 +0900, Naoya Horiguchi wrote:
> ...
> > + * This function is intended to handle "Action Required" MCEs on already
> > + * hardware poisoned pages. They could happen, for example, when
> > + * memory_failure() failed to unmap the error page at the first call, or
> > + * when multiple Action Optional MCE events races on different CPUs with
> > + * Local MCE enabled.
> 
> +Tony Luck
> 
> Hey Tony, I thought SRAO MCEs are broadcasted to all cores in the system
> as they come without an execution context, is it correct?
> 
> If Yes, Naoya, I think we might want to remove the comments about the
> "multiple Action Optional MCE racing" part.

Jue,

Correct. SRAO machine checks are broadcast.  But rather than remove the
second part, just replace with "multiple local machine checks on different
CPUs".

-Tony
