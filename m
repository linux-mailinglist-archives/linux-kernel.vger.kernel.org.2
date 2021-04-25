Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C705936A7D0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 16:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhDYOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 10:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhDYOhF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 10:37:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77EA961139;
        Sun, 25 Apr 2021 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619361385;
        bh=UY9BJe/nlhOqZtYlihUHyQPmWLEmuahDikfpKyPXCPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwTMK0ZsPSWJ87LHeBlo51H6dC3Uvy8uFWx63Zziny1U2v8qMQv7d3qnapKlwwrOs
         ZSHlatLHMsuHitutvnmWS0JN3OOzifpezkVATOx/Lg6a/gNNhm3Nh+teVfga9xhxED
         ZGUaq+/8Ib/X+UpFa38uFvlhdeTj1dQurZueFqP3Jvv67mgHyhjRFHoM4+tw2QxeqA
         DhkyueX9gSQggUTSgVkFDm8c+wRboRaDet2TxPGXYtHGyOnqDttx27yGRZ9mL4PpcO
         WT4/DrzGtB9pV74mml/GewIvjpBwhk/1cQraePbQqq/D77qk/x6IOEQNqKHxAe0h6g
         SdGWnFjBADfbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1FE8E40647; Sun, 25 Apr 2021 11:36:23 -0300 (-03)
Date:   Sun, 25 Apr 2021 11:36:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf vendor events: Add missing model numbers
Message-ID: <YIV+Zq82GedZSyA3@kernel.org>
References: <20210329070903.8894-1-yao.jin@linux.intel.com>
 <67f05194-0eb4-becd-c8bb-7dc944ac6ca8@linux.intel.com>
 <20210425010950.GQ1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425010950.GQ1401198@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Apr 24, 2021 at 06:09:50PM -0700, Andi Kleen escreveu:
> On Fri, Apr 23, 2021 at 10:58:02AM +0800, Jin, Yao wrote:
> > Hi Andi, Arnaldo, Jiri,
> > 
> > Can this patch be accepted?
> 
> Looks good to me.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

