Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF9343CD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242684AbhJ0PQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:16:25 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:17797 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbhJ0PQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635347637; x=1666883637;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ai+eDdXkfnWg+d1nZS2x7qtRIy6LUrKbeHhn2zVblMw=;
  b=juVB5ZYuI3wL3GooWWEusv1zYqI902NFTlT2/RTwgDV1Qs64YA04LPAO
   pFIOeF5f0gC6dYgnxViv98HazRLNgtjCaHPikjvXvsUW1mVeWyvhUm/Md
   v/rij2tSS2ou2Y6Mcc09/OU1e47v+aiBWNMH8kS1XuAbPu4MN7raQPy6Q
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 08:13:57 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:13:56 -0700
Received: from [10.110.114.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 27 Oct 2021
 08:13:55 -0700
Subject: Re: [PATCH] KVM: arm64: Avoid shadowing a previous local
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
References: <20211027024212.64842-1-quic_qiancai@quicinc.com>
 <da6be00d39c37ad26bfad9e75e814cb1@kernel.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <247f9c62-3031-24d4-eb58-be6a4d5a364e@quicinc.com>
Date:   Wed, 27 Oct 2021 11:13:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <da6be00d39c37ad26bfad9e75e814cb1@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/21 3:34 AM, Marc Zyngier wrote:
> I don't think this makes much sense. This is bound to eventually clash
> with another variable, and you're back to square one.

Yes, perhaps. We don't have a namespace feature in C. Thanks for taking
a look, Marc.
