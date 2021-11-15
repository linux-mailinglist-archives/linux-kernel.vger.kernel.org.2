Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F856450586
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhKONfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:35:04 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:62803 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231695AbhKONcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636982996; x=1668518996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSASduQVtPzP/emfrd+RzN5Fm3/Hk+6ZPxPAcA4/Lgw=;
  b=V5CoaLnyxgth6EXxFVbP00TQ/E0MdvGlUgNcfXW/gswKCyZw9msm7RTx
   bPki0qdCtAK8YS0x0EFcma98Ih8sM69YtaYjl8ewSrpKzaGPxu1885Bb8
   7lnMau6EuIYqOMAerIyiUYkKPfx4RkeP1Yj4ZgAtIn6ZqtulmqLqQh0C4
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Nov 2021 05:29:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 05:29:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 05:29:49 -0800
Received: from qian-HP-Z2-SFF-G5-Workstation (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 15 Nov 2021 05:29:48 -0800
Date:   Mon, 15 Nov 2021 08:29:46 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        "Valentin Schneider" <valentin.schneider@arm.com>
Subject: Re: KASAN + CPU soft-hotplug = stack-out-of-bounds at
 cpuinfo_store_cpu
Message-ID: <YZJgyve+tQ/+8NDC@qian-HP-Z2-SFF-G5-Workstation>
References: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation>
 <YY9WKU/cnQI4xqNE@qian-HP-Z2-SFF-G5-Workstation>
 <CACT4Y+bj7JU=5Db=bAafjNKJcezeczzDCTwpKvhhC8kESc5+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+bj7JU=5Db=bAafjNKJcezeczzDCTwpKvhhC8kESc5+kQ@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 07:49:39AM +0100, Dmitry Vyukov wrote:
> This may be just a bad format string.
> But I don't see kernel/printk/printk.c:2264 doing any printk on
> next-20211110. What's up with line numbers?

Yeah, it is usual that the line number could be off by a few lines
with that .config. It is still in my TODO to dig into the bottom of it
though.
