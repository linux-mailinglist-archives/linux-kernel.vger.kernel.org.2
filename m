Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7A3FFEA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbhICLGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348487AbhICLGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:06:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41F106101A;
        Fri,  3 Sep 2021 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630667109;
        bh=ZYJJfNfDBDoEd9auwZs1I3zRjMJaKASoHmWShb2DHD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6OjZ+ui3ulw9uaS74ytWqqRvhHTsFdgUizXzu8tn3dghLK6Dq4TP7yl+lNmFaaB4
         +4w5u9+OFRLrg5pgz75abQjlmvRcpItiigCrNkTaCrZoxxVIjrxjhL3bsTwszO7zBM
         +9DnMcRekOhFqiAF8fCnkRjNJn8DrjOEcvtcaF4U1L3ol3bBPTZQtuY4qtRAYxG4jt
         W8XDYPbIS6l5r8eXnprF3lUqRHV2ltQ19H4M3E2+2Pnl9CKDn0qo6rReDQ9JWaDdDZ
         tBtWTFrHo7ugboOkBK2r8aPCYDWw2SG/ae01MDSjZUw7WZjDFVNEle7Jtgzlsu+n06
         2gy1fFp6dKxcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C59ED4007E; Fri,  3 Sep 2021 08:05:06 -0300 (-03)
Date:   Fri, 3 Sep 2021 08:05:06 -0300
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
Subject: Re: [PATCH v2 1/9] perf cs-etm: Refactor initialisation of decoder
 params.
Message-ID: <YTIBYkU281/di+vD@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-2-james.clark@arm.com>
 <ca0f3d7c-2420-fcab-0c48-57225ed15b00@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0f3d7c-2420-fcab-0c48-57225ed15b00@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 03, 2021 at 09:52:14AM +0100, Suzuki K Poulose escreveu:
> On 06/08/2021 14:41, James Clark wrote:
> > The initialisation of the decoder params is duplicated between
> > creation of the packet printer and packet decoder. Put them both
> > into one function so that future changes only need to be made in one
> > place.
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks, collected the Acked-by.

- Arnaldo
