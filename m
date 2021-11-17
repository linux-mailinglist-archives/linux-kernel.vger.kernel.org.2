Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F7455138
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhKQXmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:42:24 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:50329 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241649AbhKQXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637192363; x=1668728363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKVIiBfJluAKZ303CpRtgb9+T2vg6QFbNX0lyDOUQUQ=;
  b=GFzo6YIRVGqe2UoYCRz5EbF+J3ppThq4dpX0FvQRa6sU3Pwlg6VcpBK9
   ZuVD7yMe2vAldjpMpYg0L5k3KtsQdwUXGt5O5SFbLSvSNDaCmytIzl7D3
   etDCAa4XD/9eXOs6ySzb4zgnVx70Vy+La0GbZ5u2wPovz0i504MXO1DrR
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Nov 2021 15:39:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 15:39:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 17 Nov 2021 15:39:22 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 17 Nov
 2021 15:39:21 -0800
Date:   Wed, 17 Nov 2021 18:39:19 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <dvyukov@google.com>, <peterz@infradead.org>,
        <valentin.schneider@arm.com>, <will@kernel.org>,
        <woodylin@google.com>
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
Message-ID: <YZWSpz75zMms133n@fixkernel.com>
References: <20211115113310.35693-1-mark.rutland@arm.com>
 <YZPc7MLxwmd47YYw@qian-HP-Z2-SFF-G5-Workstation>
 <20211117115234.GB41542@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211117115234.GB41542@C02TD0UTHF1T.local>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:52:34AM +0000, Mark Rutland wrote:
> > Thanks for fixing this quickly, Mark. Triggering an user-after-free in
> > user namespace but don't think it is related. I'll investigate that
> > first since it is blocking the rest of regression testing.
> 
> Cool; are you happy to provide a Tested-by tag for this patch? :)

Sure, the testing is running good so far.

Tested-by: Qian Cai <quic_qiancai@quicinc.com>

