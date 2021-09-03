Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528C93FFEE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349242AbhICLUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349206AbhICLTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:19:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3B9861056;
        Fri,  3 Sep 2021 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630667928;
        bh=srUw3/8a9bDyIO1KrzQ9s3Vpff74UdYRjHWRZ0pzbmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAr4+/eCBv+FBmPAU8ZcH04uejkm12w4p1f86r9ApaNA6sjBSn2FOK6SeYMcyzILa
         x4YrLTx0m0B2CDnqOrC35IybMuHCapZiWIMM04J5GbxigG/OUWWQQeVsW/JyoBzVoS
         tQXzWVJnHq+GRXj1JOZamJVuuTChXOl8BCrJeU9pNgeawRo/CSmisj2dVUr4Qy1+uB
         R33QkSYmZ9fTTq07+J8Q+6RbMeYaa893spL94Aq4rzOgzLhSta1qB0mvx5SxpncmYi
         F/k4TvWiHoUsdhIanqWIm5gL3eO1mV1wOJaxb13I8maYJ9uFHvOJyFbAF9dOoP9MSS
         qh3EDCUL501Eg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B9F24007E; Fri,  3 Sep 2021 08:18:46 -0300 (-03)
Date:   Fri, 3 Sep 2021 08:18:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] perf cs-etm: Print the decoder name
Message-ID: <YTIElk3Zv3VNJU+q@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-9-james.clark@arm.com>
 <de23e803-3840-501e-87a8-39eed7ba434b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de23e803-3840-501e-87a8-39eed7ba434b@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 03, 2021 at 10:17:25AM +0100, Suzuki K Poulose escreveu:
> On 06/08/2021 14:41, James Clark wrote:
> > Use the real name of the decoder instead of hard-coding "ETM" to avoid
> > confusion when the trace is ETE. This also now distinguishes between
> > ETMv3 and ETMv4.
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks, collected the Reviewed-by.

- Arnaldo
