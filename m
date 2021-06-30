Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F393B802D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhF3JmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233541AbhF3JmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:42:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 558F461CBB;
        Wed, 30 Jun 2021 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625045995;
        bh=eKmTaNZqk1yOZWp2QfqKyvhfO8SsAkQgz2XvJkWB1DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjqF8QiltFiCZ+ubNHOObGXDJ/aAqlll4/v+riAiBy2Wh+aGmE2PWf4zngtQUxwXH
         OXIEAMKevHE6G/PuEzGzQHVp8+k9uAPmDXGqWBsN18RWdjrCCrWKwr8LIUskeGtprA
         q8+6fDEe9ZO+t4CdgSEszS5X4WdlPW7mXm8A+Ejo=
Date:   Wed, 30 Jun 2021 11:39:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH V3 2/6] perf/x86/intel/uncore: Add alias PMU name
Message-ID: <YNw76ZUUUG+qUyP2@kroah.com>
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
 <1624990443-168533-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624990443-168533-3-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:13:59AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
> server supports the discovery mechanism. Without the platform-specific
> support, an uncore PMU is named by a type ID plus a box ID, e.g.,
> uncore_type_0_0, because the real name of the uncore PMU cannot be
> retrieved from the discovery table. With the platform-specific support
> later, perf has the mapping information from a type ID to a specific
> uncore unit. Just like the previous platforms, the uncore PMU is named
> by the real PMU name, e.g., uncore_cha_0. The user scripts which work
> well with the old numeric name may not work anymore.
> 
> Add a new attribute "alias" to indicate the old numeric name. The
> following userspace perf tool patch will handle both names. The user
> scripts should work properly with the updated perf tool.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: gregkh@linuxfoundation.org
> ---
>  arch/x86/events/intel/uncore.c       | 19 +++++++++++++------
>  arch/x86/events/intel/uncore.h       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 28 +++++++++++++++++++++++++++-
>  3 files changed, 41 insertions(+), 7 deletions(-)

No Documentation/ABI/ update for your new sysfs file?

:(
