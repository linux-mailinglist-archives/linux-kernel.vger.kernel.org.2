Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EEF43BAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhJZTgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:36:21 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:60164 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbhJZTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635276831; x=1666812831;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=luxtlj1Y6uRTaP9b8yBJzpsSMZuh+ycQHMse587VUzI=;
  b=x0p5veDmyCiyJ7wNkf12HSR8Mrw8QvifljngrS728VjPnXgKiV8hLM5F
   3QiRDewqC2qi5IXujj1PaGMF4f+ajmUmcSIGKgafqu09nSgY0ra6TmEP5
   8f1limBl3hfG8wMTvRBpy57kpTYkFE/MMP3Y2P74UubBEg6cx2flcRYDN
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 12:33:50 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 12:33:50 -0700
Received: from [10.110.83.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 26 Oct 2021
 12:33:49 -0700
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXhOEEOSG+fgEy+t@yury-ThinkPad> <YXhVVvG9keoVWJyK@smile.fi.intel.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <397751ea-536b-af3c-752d-c4b1045e6e56@quicinc.com>
Date:   Tue, 26 Oct 2021 15:33:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXhVVvG9keoVWJyK@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/21 3:21 PM, Andy Shevchenko wrote:
> Can you explain to me how it is supposed to work?
> 
> For example,
> 
>     x = 0xaa55;
>     size = 5;
> 
>     printf("%lu\n", find_first_bit(&x, size));
> 
> In the resulting code we will always have 5 as the result,
> but is it correct one?

Sorry, my bad. GENMASK(size - 1, 0) would just become __GENMASK(size -
1, 0) instead of 0. Let me revisit it and run some tests first.
