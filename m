Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA83B8021
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhF3JjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234012AbhF3JjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:39:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C21FA61CA3;
        Wed, 30 Jun 2021 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625045804;
        bh=Mvz3NNDZPlASsecrIdP9TJRVXEIjzIe3pPHfTBxri4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmtmWhdgiNh9AVfiGtUyhMoQOVkS5mOqrfGKUe3Muj73mCLsZc7YSMCRHVobjoVax
         a4TiDqdFwYSTGvITH5Y8Ie6NF9K6c3UK8RbL48cSJCVhomBQOKB5clv2KGosxpuJeA
         7VGdHrn33Iy1VofBYesV3BzNDj9oEBHKoeGRzgMc=
Date:   Wed, 30 Jun 2021 11:36:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH V3 1/6] perf/x86/intel/uncore: Add Sapphire Rapids server
 support
Message-ID: <YNw7KorfwK/OcrTw@kroah.com>
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
 <1624990443-168533-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624990443-168533-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:13:58AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Intel Sapphire Rapids supports a discovery mechanism, that allows an
> uncore driver to discover the different components ("boxes") of the
> chip.
> 
> All the generic information of the uncore boxes should be retrieved from
> the discovery tables. This has been enabled with the commit edae1f06c2cd
> ("perf/x86/intel/uncore: Parse uncore discovery tables"). Add
> use_discovery to indicate the case. The uncore driver doesn't need to
> hard code the generic information for each uncore box.
> 
> But we still need to enable various functionality that cannot be
> directly discovered. This is done here.
>  - Add a meaningful name for each uncore block.
>  - Add CHA filter support.
>  - The layout of the control registers for each uncore block is a little
>    bit different from the generic one. Set the platform specific format
>    and ops. Expose the common ops which can be reused.
>  - Add a fixed counter for IMC
> 
> All the undiscovered platform-specific features are hard code in the
> spr_uncores[]. Add uncore_type_customized_copy(), instead of the memcpy,
> to only overwrite these features.
> 
> Only the uncore blocks which are inculded in the discovery tables are
> enabled here. Other uncore blocks, e.g., free-running counters, will be
> supported in the following patch.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---

Why is there no other intel.com review on this before sending it out?

thanks,

greg k-h
