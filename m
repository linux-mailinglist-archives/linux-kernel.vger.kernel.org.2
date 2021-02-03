Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B868730DE64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhBCPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234549AbhBCPhN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3308464DF6;
        Wed,  3 Feb 2021 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612366592;
        bh=G8HiIlIOtnUi7ov/aeZ2j8ezEwCl5j40erKG29Mr8M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGpCorwVuW893pfuqQgRoJSX2xc4a/6vDBOvTGBp4ZC6ZH7paH3CqwEID31oCxG9Q
         +yfMoylsuWzn/fPo3iwBJABXdIM7oUMszENn92bsIxCH37E449qQfSYb8vYi45dlH+
         4oQ4Jx4Gw340lqkduLigOhzhedXkOR0zvclb9TMK9hFZmUyhakLuzzMLrL1sezaypb
         pO7CfB1GMVbN47DKD0DCZPPlR3F9PQtLWJ+VamG1QSE/xX9HASfcDAOjpxkwMNDTnh
         FB5TxldX7ZTs/1B6CQS3OdK9ywLmbm+MfjQ+Rw7Mw0af2NSeOKvkC5CkTffkkmRfRQ
         CeHE2myCQA7Xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E64E40513; Wed,  3 Feb 2021 12:36:29 -0300 (-03)
Date:   Wed, 3 Feb 2021 12:36:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf metricgroup: Fix segmentation fault for metrics
 with no pmu event
Message-ID: <20210203153629.GD854763@kernel.org>
References: <20210202022424.10787-1-yao.jin@linux.intel.com>
 <77af7dc5-eac4-4591-cba7-8937c94a058f@huawei.com>
 <c73fff2c-8525-f496-66da-2cb4a8ccbf94@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c73fff2c-8525-f496-66da-2cb4a8ccbf94@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 03, 2021 at 08:46:52AM +0800, Jin, Yao escreveu:
> On 2/2/2021 4:15 PM, John Garry wrote:
> > On 02/02/2021 02:24, Jin Yao wrote:
> > > It causes the segmentation fault. Now check the pmu_name before strcmp.

> > > Fixes: c2337d67199a("perf metricgroup: Fix metrics using aliases covering multiple PMUs")
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

> > This should be fixed in v5.11-rc6 - please check it.

> > 9c880c24cb0d perf metricgroup: Fix for metrics containing duration_time
 
> Oh, I see, your patch is in Arnaldo's perf/urgent branch. Sorry about that,
> I just tested Arnaldo's perf/core branch. :(

As soon as I finish processing patches today and get perf/core thru the
usual set of tests, it'll all be in perf/core.

- Arnaldo
