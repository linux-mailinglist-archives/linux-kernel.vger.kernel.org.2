Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0E43BB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbhJZT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:56:54 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39338 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhJZT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635278069; x=1666814069;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BboTroa5pUL8duR0dglftEbE722Hf+2SVWjxPOC7N+o=;
  b=QetXSxb7dlhNXSJp4k7zFxgjf2mxwxT+wO3dg97BgYjtSJqlZoJk2rqE
   sne1X5fB3G6PdpGKhFFdSUy6MRTCbCIagV6HKeYscyRDzkK1Kq1820tuy
   T1igcL62JKeYHU/7uDqcmcLhe3mLbTyL4JUEMEchLbkTLi4pp/c8upOwG
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 12:54:29 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 12:54:28 -0700
Received: from [10.110.83.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 26 Oct 2021
 12:54:28 -0700
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXhOEEOSG+fgEy+t@yury-ThinkPad> <YXhVVvG9keoVWJyK@smile.fi.intel.com>
 <YXhW8K7DxadyVgx3@yury-ThinkPad> <YXhaMVTymVNzOlGT@smile.fi.intel.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <031fe271-7fc3-0d95-3547-edbe0c975cbb@quicinc.com>
Date:   Tue, 26 Oct 2021 15:54:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXhaMVTymVNzOlGT@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/21 3:42 PM, Andy Shevchenko wrote:
> Now, I have checked that email appearance in the upstream:
> 
> $ git log --oneline --author="quic_qiancai@quicinc.com"
> 95cadae320be fortify: strlen: Avoid shadowing previous locals
> 94560f6156fe Revert "arm pl011 serial: support multi-irq request"
> 
> While first one perhaps okay, although it also refers to W=2,
> I have now doubts if the "Revert" was really thought through
> and not just yet another UMN-like experiment.
> 
> Greg, what do you think is the best course of actions here?

Perhaps, a little sympathy towards a stranger might get us a better
community. Feel free to audit my previous works.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Qian+Cai




