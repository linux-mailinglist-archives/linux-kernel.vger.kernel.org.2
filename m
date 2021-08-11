Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4DF3E97C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhHKSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhHKSiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:38:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87F1961008;
        Wed, 11 Aug 2021 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628707107;
        bh=f+gB+BcDzrFnDYSfYVhC0Y8pYBV/xwuoPfWAsf+OLJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBvSOhxizJfBTGAMkls/WXwX+z4cCeJlgT+zUA0BzK0edpgIEL950eDk6z1G9fSeG
         4i6eguQjT6YYFQFu5eXtSyYqu8DgShEvnWruIAs+vhi8mE0Ko6T5L+nmDEjIOkj5j6
         ygsTseLGsPXKIx+PRQ02Y0UYmJIYXm3OvCNwCerS61CU8pPyIsIvDGwBt32cRPiaM7
         eM6Rq8HgdLW3KALUzXwW55dsnwXjtOFE3R8mGI2CBkUAr+pIBL4cGEDX5VegRqJYws
         8PZ9hMZPk9D8dUgwynG5MkqZ7cULjfbpZ3UJgZrbp6F/5t1PGHupTWbDCAYHvYr9Wj
         0gwXSFc+OWJ1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D492E403F2; Wed, 11 Aug 2021 15:38:23 -0300 (-03)
Date:   Wed, 11 Aug 2021 15:38:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, linuxarm@huawei.com
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
Message-ID: <YRQZH9tsyW4vLSAo@kernel.org>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
 <YQgHMt4BsDeJnE09@kernel.org>
 <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
 <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
 <YRKGo1AtfBn85sZ7@kernel.org>
 <40e85ad2-3db4-aecf-d972-7d4aa5c2278c@huawei.com>
 <YRK+X/f44UK+btRx@kernel.org>
 <b64a644a-1dfd-2e3b-319c-c53d43c96025@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64a644a-1dfd-2e3b-319c-c53d43c96025@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 11, 2021 at 08:59:24AM +0100, John Garry escreveu:
> On 10/08/2021 18:58, Arnaldo Carvalho de Melo wrote:
> > > I think that you can apply it before the series. This is a pre-existing
> > > issue that there was no dependency checking on the test events folder for
> > > rebuilding pmu-event.c .
> > Its all now in tmp.perf/core, will move to perf/core as soon as my test
> > suite finishes.
> 
> Excellent, thanks!


Passed, its in perf/core.

- Arnaldo
