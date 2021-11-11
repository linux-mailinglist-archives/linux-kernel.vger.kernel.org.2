Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEEC44D652
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhKKMJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:09:40 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:58933 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhKKMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636632409; x=1668168409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pEhHx4xmdkRDKSCeTsMlzkrnFkjav4JeEBzcJ5Zp1ZQ=;
  b=gSb/zPOPxyDj0jQ8pP0+zGXfmlqdHu8nba05uH5eUJMmngTYdS2EZn8Q
   BAJtMhje6L35B6SOAX6aAeLxyZ+9+pgWY7jxux+JGjJSGFqTrmnrvfB+t
   jJRXfl/ya/vEODP5nQDh8xqpHFn+5ly6coMO4KBxDRWwqb10RFOrMG6WH
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Nov 2021 04:06:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 04:06:45 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 11 Nov 2021 04:06:44 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 11 Nov 2021 04:06:40 -0800
Date:   Thu, 11 Nov 2021 17:36:36 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Chen <peter.chen@nxp.com>,
        Jack Pham <jackp@codeaurora.org>,
        Dean Anderson <dean@sensoray.com>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] usb: gadget: f_fs: Use stream_open() for endpoint files
Message-ID: <20211111120636.GA11612@hu-pkondeti-hyd.qualcomm.com>
References: <1636629117-2206-1-git-send-email-quic_pkondeti@quicinc.com>
 <YY0Asjnm/Ce6FpS8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YY0Asjnm/Ce6FpS8@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Nov 11, 2021 at 12:38:26PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 11, 2021 at 04:41:55PM +0530, Pavankumar Kondeti wrote:
> > Function fs endpoint files does not have the notion of file position.
> > So switch to stream like functionality. This allows concurrent threads
> > to be blocked in the ffs read/write operations which use ffs_mutex_lock().
> > The ffs mutex lock deploys interruptible wait. Otherwise, threads are
> > blocking for the mutex lock in __fdget_pos(). For whatever reason, ff the
> > host does not send/receive data for longer time, hung task warnings
> > are observed.
> > 
> > Change-Id: I602fa56fb5ed4c8c46e19df68c3335c4b12cae81
> 
> Always run scripts/checkpatch.pl on your patches so you do not get
> grumpy maintainers asking you to run scripts/checkpatch.pl on them...
> 
Thanks for taking a look at the patch. My bad, I have applied the patch
from a recent android tree and carry forwarded this tag. I will fix it.

Thanks,
Pavan
