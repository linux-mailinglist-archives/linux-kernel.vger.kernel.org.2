Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86A143E114
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJ1Ml6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:41:58 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25026 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhJ1Ml4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635424770; x=1666960770;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9dxaZhDdceU2P32yTix/f3IgWkejut4T2juuaJpJqIc=;
  b=ooWUStld3tKju0kjLZdR55ZBtVL/VbIrMNjRqNOanBbVAAftXk8J6pvP
   WwSW7TjbI2WBEgIMIIEYexOkZNpjKytOnVMo5j/2QEEtTCKNSpPGia+ji
   uLnMwV3M+zUdUW5AXP//H2QrvtozBQqAOke+ipZZCKQn9vhzyXi7So5vx
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Oct 2021 05:39:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 05:39:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 28 Oct 2021 05:39:29 -0700
Received: from [10.110.38.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Thu, 28 Oct 2021
 05:39:28 -0700
Subject: Re: Arm64 defconfig-debug
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <4aee8e37-b1f0-bd1c-9bf8-842c6cdc557e@quicinc.com>
 <20211028074949.GB23476@willie-the-truck>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <fb956b2b-cf34-1f20-633b-0d686d381478@quicinc.com>
Date:   Thu, 28 Oct 2021 08:39:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028074949.GB23476@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/21 3:49 AM, Will Deacon wrote:
> I'm not in favour of adding a whole new debug-flavoured defconfig for arm64,
> but you might be able to add some reduced config file containing just the
> options you're interested in to kernel/configs/. That said, I'm not sure the
> existing files under there are well-maintained at all. The Android ones,
> especially, looks like they should just be removed.

Thanks for the pointer, Will. I'll dig into that direction then.
