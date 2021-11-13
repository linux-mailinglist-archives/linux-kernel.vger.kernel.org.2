Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1378944F1BD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 07:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhKMGKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 01:10:34 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:49139 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhKMGKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 01:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636783661; x=1668319661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pp8JfTGNCrtvO19aZcBYoe2ILjUc/Tzny+fyjlfwUzE=;
  b=P1uCqc0lp4K8+oy18Ts/C+Hks/c9LPCEsYOL736STP+oeuH/GTKIP8wH
   HLs2VOXJJMGBQP20unMOacA5M9fJVo1qhiQi6gFvI8ceEcOsShBvE6Stq
   opbrRaL9cxLwBSUZSUqdWw7lFyIfnPJf6w88Q8CXBzcSbQBqo5rdbyj89
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Nov 2021 22:07:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 22:07:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 12 Nov 2021 22:07:40 -0800
Received: from qian-HP-Z2-SFF-G5-Workstation (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 12 Nov 2021 22:07:39 -0800
Date:   Sat, 13 Nov 2021 01:07:37 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: KASAN + CPU soft-hotplug = stack-out-of-bounds at
 cpuinfo_store_cpu
Message-ID: <YY9WKU/cnQI4xqNE@qian-HP-Z2-SFF-G5-Workstation>
References: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:50:19PM -0500, Qian Cai wrote:
> FYI, running CPU soft-hotplug with KASAN on arm64 defconfig will
> always trigger a stack-out-of-bounds below.

Actually, KASAN is not enough to trigger. It needs some addition
debugging options to reproduce. I'll narrow it down later. Anyway,
this one will reproduce.

http://lsbug.org/tmp/config-bad-14rc1.txt
