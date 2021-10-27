Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4743CD09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242659AbhJ0PJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:09:23 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20427 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbhJ0PJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635347217; x=1666883217;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uetMNEem1lHx4zYfnA3j/Gq8DvjWkcCBPdSH7BuWEYI=;
  b=mG7LwPvibFvwz2Y2D6u9n+WstSqmWzFsLUvyRY0JinGcslCoTCqyfpEx
   BzjklkKQei/YVk0ZTMlqmBHt9hwGSOStE2MqST5IIT6Bq0gOEMxcPQRqe
   GFib2NnrfcVAkXhfbSExAzxy3xjhFb3RFjf9MjLh4ujU/MyJstU2S6O7w
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 08:06:56 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:06:56 -0700
Received: from [10.110.114.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 27 Oct 2021
 08:06:55 -0700
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Yury Norov <yury.norov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXhOEEOSG+fgEy+t@yury-ThinkPad> <YXhVVvG9keoVWJyK@smile.fi.intel.com>
 <YXhW8K7DxadyVgx3@yury-ThinkPad> <YXhaMVTymVNzOlGT@smile.fi.intel.com>
 <031fe271-7fc3-0d95-3547-edbe0c975cbb@quicinc.com>
 <YXkfaGlmbkXXJGih@smile.fi.intel.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <4afd7242-a8f9-6d41-e1a8-e6cfbe3cea6e@quicinc.com>
Date:   Wed, 27 Oct 2021 11:06:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXkfaGlmbkXXJGih@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/21 5:44 AM, Andy Shevchenko wrote:
> Agree, but you see a problem here, W=2, for example, is high due to
> a lot of non-sense (or very little sense) noise. The warning you got
> is hidden on purpose. On top of that, the code has not been thought
> through at all, despite missed test run. This is easy to catch.
> 
> What I expect from "a stranger" who is in doubt (obviously) how this
> code works to ask and then decide how to act.
> 
> And on top of all these, we used to have UMN case which makes me
> first think of bad experiments on the community (I really haven't
> believed that this patch was sent consciously).
> 
> So, please be careful next time and better ask first before acting,
> if in doubt.

Yes, I am an idiot. My brain was short-circled for a moment to be
totally mistaken with "GENMASK() == 0" instead GENMASK_INPUT_CHECK(). I
am not sure how to avoid those short-circles again in the future though
apart from thinking about going to an office in the near future, so kids
at home would drive my less crazy. Of course, I knew the trick for
lib_test.c now which should help me in this subsystem in the future.
Thanks for your time, Andy.
