Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B720A45E779
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 06:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358219AbhKZFj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 00:39:26 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19808 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344016AbhKZFhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637904853; x=1669440853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ezOHgYaF5ocrjdNaIhBrXDMQCvdxCutXFPf/Cjp9RgA=;
  b=QAhRdC+jIV9/qz3+7kVLYSVzEsJO9zbZ21bxHX0NGVx9kIEAvwAnTDcl
   ds9SPoBL3vyjyIB4D396j+e4o/t+82LISFPFAEfqkR09hFFDYUlIPffjt
   iM0VURwXC7l4oNewWksXH19CAdnS/k05H1pW6QGwzPl3QJ2cqJcOyz77W
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Nov 2021 21:34:12 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:34:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 21:34:12 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 21:34:08 -0800
Date:   Fri, 26 Nov 2021 00:34:04 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Alexey Gladkov <legion@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
Message-ID: <YaBxzDGyWxU/836N@fixkernel.com>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
 <875ysptfgi.fsf@email.froward.int.ebiederm.org>
 <YZa4YbcOyjtD3+pL@fixkernel.com>
 <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
 <YZ6zXEZf9qHLFyIp@fixkernel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YZ6zXEZf9qHLFyIp@fixkernel.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:49:19PM -0500, Qian Cai wrote:
> Hmm, I don't know if that or it is just this platfrom is lucky to trigger
> the race condition quickly, but I can't reproduce it on x86 so far. I am
> Cc'ing a few arm64 people to see if they have spot anything I might be
> missing. The original bug report is here:
> 
> https://lore.kernel.org/lkml/YZV7Z+yXbsx9p3JN@fixkernel.com/

Okay, I am finally able to reproduce this on x86_64 with the latest
mainline as well by setting CONFIG_USER_NS and KASAN on the top of
defconfig (I did not realize it did not select CONFIG_USER_NS in the first
place). Anyway, it still took less than 5-minute by running:

$ trinity -C 48
