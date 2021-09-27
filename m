Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B035B418DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhI0CoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:44:21 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15931 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhI0CoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632710559; x=1664246559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E1AFGF4nfgrKj7RD1dTjHsUvB6bZLlY48hV6MFJLlLM=;
  b=LJkJ74NiWWYCtvofgosCTYS29EL8U6BpLKXp9O9Jdk10WFgJT8igxJCB
   MwTDqMOnF8m4OEvIhF8w6zjQ66O7iIK+c0nSFCeD/y+eQ3LnAx5z9De9G
   eUeKxaFKOUrHp5+AG8Yep89XSQGa5MobNEhWaWjrB6lozBoCh19TdEtGW
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Sep 2021 19:42:39 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 19:42:38 -0700
Received: from taozha-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Sun, 26 Sep 2021 19:42:35 -0700
Date:   Mon, 27 Sep 2021 10:42:31 +0800
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
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Add Coresight support
Message-ID: <20210927024231.GA11883@taozha-gv.ap.qualcomm.com>
References: <1632477981-13632-1-git-send-email-quic_taozha@quicinc.com>
 <1632477981-13632-3-git-send-email-quic_taozha@quicinc.com>
 <e76b54b2-3d78-8d11-dbcc-a990bf52252b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e76b54b2-3d78-8d11-dbcc-a990bf52252b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:11:00PM +0100, Suzuki K Poulose wrote:
> Hi Tao
> 
> On 24/09/2021 11:06, Tao Zhang wrote:
> >Add the basic coresight components found on Qualcomm SM8250 Soc. The
> >basic coresight components include ETF, ETMs,STM and the related
> >funnels.
> >
> >Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> PS: This patch must go via the Qcom DT maintainers. I would
> recommend sending this to the following people, so that it
> can be queued.
> 
> $ scripts/get_maintainer.pl arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> 
> Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM
> SUPPORT)
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS)
> linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
> TREE BINDINGS)
> linux-kernel@vger.kernel.org (open list)
> 
> Kind regards
> Suzuki
Hi Suzuki,

Sure, I will add these maintainers and resubmit the patch for review
separately. Thanks for your review.

Best,
Tao
