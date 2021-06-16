Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3303AA2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFPSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhFPSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:10:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D774C613DA;
        Wed, 16 Jun 2021 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623866895;
        bh=xeQF3lt1IwcjtNTtkNbhGzWG1wVuWmJHINFemNC2ghQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmKRg38mAI81TW3NiCVzZb3r0/oR8HSjz833VQxeU/63DtP7Nfq2F/XDEeigvrhPn
         iMdg5G7pW11EOE7t8/yg4cxwoKCURT6VBI7cUddyPKXXZFILCPmgDO5jSp3ASyB+8G
         vFs+DmYKxoaiwdfdoAP/7WYHX5pYB5D4fbdAgvQn1ScZsbNtuLbRfECvJ1IlnUrKHS
         TY8lCKlovZIxr8NFFd1H7ZsiMAGwWXXn/QKeKZ3m/ghbheMdnkHFRkNiZdqr4nQ0Rx
         m+dZbDBQQXjQ6bUYFy2ICEFqXbrXyxphHPZq2wqyD/8gXrUTsqomQdBzUeSLnw8/qO
         WSLFemCgvQN9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 416C440B1A; Wed, 16 Jun 2021 15:08:12 -0300 (-03)
Date:   Wed, 16 Jun 2021 15:08:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf annotate: Add itrace options support
Message-ID: <YMo+DNR5czzEu8iP@kernel.org>
References: <20210615091704.259202-1-yangjihong1@huawei.com>
 <1e2f6d0e-e171-e0be-4f33-02722b0c50d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2f6d0e-e171-e0be-4f33-02722b0c50d9@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 15, 2021 at 01:27:25PM +0300, Adrian Hunter escreveu:
> On 15/06/21 12:17 pm, Yang Jihong wrote:
> > The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
> > "annotate". As a result, perf annotate does not support parsing itrace data.

<SNIP> 

> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

