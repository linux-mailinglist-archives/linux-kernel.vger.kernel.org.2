Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D47B415AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbhIWJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:18:29 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:59075 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbhIWJSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632388614; x=1663924614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YMHGIu+GVfd3HsD86oGGNWfnyx0KoPQ7Y7puOM+D3M=;
  b=LwzIM5wlbKT0Ir9dYXOORb9dwUTFF9z2qzM9ZX/s4oNq1rhD6eKjL9gC
   fi/54csOojutV/vGfWeWBSTYCY1/Hla4UBhDKWYt7Dp6U+CQhr3yjsmae
   zHS0uxxGfyLDaCwTeM4pglDxL3EWi31ih2vvTeUVlp9d+RRO3kz3mllr7
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Sep 2021 02:16:54 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 02:16:53 -0700
Received: from taozha-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 23 Sep 2021 02:16:49 -0700
Date:   Thu, 23 Sep 2021 17:16:46 +0800
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: Re: [PATCH v2 0/2] Add Coresight support for RB5 board
Message-ID: <20210923091627.GA7576@taozha-gv.ap.qualcomm.com>
References: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
 <07bba970-2315-4284-cd3e-d69a3028a406@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <07bba970-2315-4284-cd3e-d69a3028a406@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:31:34PM +0100, Suzuki K Poulose wrote:
> Hi Tao
> 
> On 13/09/2021 07:40, Tao Zhang wrote:
> >This series adds Coresight support for SM8250 Soc on RB5 board.
> >It is composed of two elements.
> >a) Add ETM PID for Kryo-5XX.
> >b) Add coresight support to DTS for RB5.
> >
> >This series applies to coresight/next
> >https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >
> 
> Please could you mention what has changed since the previous version
> in the cover letter ?
> 
> Kind regards
> Suzuki
>
The version 2 of the series add more comments "Cortex-A77" for ETM pid.
Do I need to rewrite the cover letter and then resubmit it for review?
> >Tao Zhang (2):
> >   coresight: etm4x: Add ETM PID for Kryo-5XX
> >   arm64: dts: qcom: sm8250: Add Coresight support
> >
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 442 +++++++++++++++++-
> >  .../coresight/coresight-etm4x-core.c          |   1 +
> >  2 files changed, 439 insertions(+), 4 deletions(-)
> >
> 
