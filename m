Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6343CD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbhJ0PUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:20:03 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:16854 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhJ0PUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635347857; x=1666883857;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EB+uKYDyfMVWPXxIP3rU1BgAPz0x6oZw2Oj6xwGMrMc=;
  b=y9948G41SWHhK4bj3PMLfREYwyqjzHRX6LrpIX8fUFd7Pw2mgLBcgXOm
   9nvTs7pjuH6SmxnPM+bqtty1UTPgdXebzkE0vWNl62A1FutlHEU8CcNPb
   2kit4OFhMd0Y4YO75ws9VaG+Ext8UGc/koOYNoboYZAW/9ddM23in0gvt
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 08:17:37 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:17:36 -0700
Received: from [10.110.114.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 27 Oct 2021
 08:17:35 -0700
Subject: Re: [PATCH] KVM: arm64: Remove unused TRNG_NO_ENTROPY
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
References: <20211026210913.57006-1-quic_qiancai@quicinc.com>
 <3fac8ddb626205286f79adde96ea527b@kernel.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <4a1a720a-3818-b4de-d549-939473c63fda@quicinc.com>
Date:   Wed, 27 Oct 2021 11:17:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3fac8ddb626205286f79adde96ea527b@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/21 3:46 AM, Marc Zyngier wrote:
> That's an architectural definition that doesn't cause any problem.
> If anything, that's documentation.
> 
> We have *tons* of other definitions with no user all over the
> arm64 code. They save the exact same purpose.

Understood. Thanks for the quick feedback, guys!
