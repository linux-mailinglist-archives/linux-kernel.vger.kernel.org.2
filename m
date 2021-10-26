Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6066643B582
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhJZP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:28:43 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:48616 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhJZP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635261977; x=1666797977;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4AYJm7qd1hQYTfs/Z6RrpgJUNElL105ABdcefBVrSaA=;
  b=ulfshrPD7KTLNpDywjV0Np1z08mPPkHg6W9qYf3qb3UUcqWN2Pp8phOv
   hrDl6LFaxZt5+Rl/Mv3HY7YrpLaj9/S7yOL9p55gs4y2TW1d3lyPJ1FRf
   aXgp5CsDpaktD8AcKR3ucMwVCJwsmPXhaHlwm6W9c0uYwnGlmRaHTvmen
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 08:26:17 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 08:26:16 -0700
Received: from [10.110.83.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 26 Oct 2021
 08:26:15 -0700
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXgafyMzK+o9FYkN@smile.fi.intel.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <adcdf79d-e50c-2fb0-e105-67b384189999@quicinc.com>
Date:   Tue, 26 Oct 2021 11:26:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXgafyMzK+o9FYkN@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/21 11:10 AM, Andy Shevchenko wrote:
> On Tue, Oct 26, 2021 at 10:41:08AM -0400, Qian Cai wrote:
>> Since "size" is an "unsigned int", the rvalue "size - 1" will still be
>> "unsigned int" according to the C standard (3.2.1.5 Usual arithmetic
>> conversions). Therefore, GENMASK(size - 1, 0) will always return 0UL.
> 
> Huh?!
> 
> Have you run test_bitmap et al., btw?

Not yet. I'll setup a VM to run it soon.
