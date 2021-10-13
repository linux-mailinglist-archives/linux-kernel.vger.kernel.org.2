Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3290542C7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhJMRei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:34:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230232AbhJMRef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:34:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85CDE1063;
        Wed, 13 Oct 2021 10:32:31 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B44BF3F694;
        Wed, 13 Oct 2021 10:32:27 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:32:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 0/5] arm64 userspace counter support
Message-ID: <20211013173224.GD5400@C02TD0UTHF1T.local>
References: <20210914204800.3945732-1-robh@kernel.org>
 <CAL_JsqJBDTt_SfaqRkr6jKoCnBg=acn=p+6rY32k=FyMWS16ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJBDTt_SfaqRkr6jKoCnBg=acn=p+6rY32k=FyMWS16ug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Sep 27, 2021 at 03:46:15PM -0500, Rob Herring wrote:
> On Tue, Sep 14, 2021 at 3:48 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Another version of arm64 userspace counter access support.
> 
> Any chance someone can review this... Ideally before the end of the
> cycle this time so there's time for me to respin if needed.

Sorry for the long delay on this.

I've given some comments on patches 1-3 (which are trivial, and I think
we can fix up when applying if necessary), and I've started
reviewing/testing patch 4; I'll try to follow up with more comments
tomorrow.

Thanks,
Mark.
