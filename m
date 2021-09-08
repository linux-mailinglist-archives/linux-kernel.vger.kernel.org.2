Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D652403C65
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbhIHPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235940AbhIHPTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:19:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ED4560F6C;
        Wed,  8 Sep 2021 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631114316;
        bh=QYYCrb5xUdDBqMUZgOy0J9e3LMwjGDvCfYmNV5Vqq1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZN8zXn3QFbidhhCFiQ/x6qjt630vQckN7G45WnmaBd2xpKQrIDUZ8g8eTfBsFfZYr
         hqOwlLzOOt7wOe1Pr1M8ZQ6svb6imREHq0sRN/MO7dhscORhqh3oJ5Q7L8IJmYE0ha
         3UvAgG1mu90ni7m5Jbl4iWqeuJWHsFctSeMDEp/a/OiCe9j3uTwXQUZItuD2WS6t23
         z2z9j58Pu2AM5aRg6eF9AWxxSR/uqqRpayJOADQy2Z44Q6EyfHTwj0qflPBXrH1/gq
         nxiCIVjBkbm792Ksso0Md6Ersi5CbnC8xeV9KSa7vUgeMLamqx5ceNP6DCn/5duy+Q
         ljGycoH/U2fNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA2D34038F; Wed,  8 Sep 2021 12:18:30 -0300 (-03)
Date:   Wed, 8 Sep 2021 12:18:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dlfilter: Add dlfilter-show-cycles
Message-ID: <YTjURgpxXEFGMn2Y@kernel.org>
References: <20210906160850.22716-1-adrian.hunter@intel.com>
 <7bee95a7-fa31-a801-8068-80c63ba6ccfe@linux.intel.com>
 <b8b1d870-9db2-4b0f-7138-c139e1ef878b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b1d870-9db2-4b0f-7138-c139e1ef878b@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 07, 2021 at 10:06:03AM +0300, Adrian Hunter escreveu:
> On 7/09/21 5:54 am, Andi Kleen wrote:
> > On 9/6/2021 9:08 AM, Adrian Hunter wrote:
> >> Add a new dlfilter to show cycles.

> >> Cycle counts are accumulated per CPU (or per thread if CPU is not recorded)
> >> from IPC information, and printed together with the change since the last
> >> print, at the start of each line.

> > Thanks! An example how to use it would be nice 
 
> I started looking at making an example and noticed that this approach
> does not work very well because the IPC cycle count only increases when
> the IPC is output which (for CYC accurate mode) is only happens when a
> CYC packet is output that corresponds to the current sample.  Seems like
> this needs a re-think, sorry.

Ok, will wait then. And this shows part of the value of this, checking
if it works as expected :-)

- Arnaldo
