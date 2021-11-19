Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FCA456FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhKSNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:35:35 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:8422 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhKSNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637328753; x=1668864753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FmJCvY2dnIaeEmmJNY1LbW8p5/hq7Az1d2ZeyeSBMKk=;
  b=D08IL0vDeBs2eMAJ9JJhUWeruR1qW2L9KAen3gucfpSkQoiE8xM1Zhc6
   wZ48fXRNhrBC+2vNn43EI79y0aw0+lRVt5L+QcTzwEyI/5v1g6+ATSzgz
   Lj5hUwos++C0IguATWhkcpFdiKYnXt9KIN9edh1CJM5Mvr4JkfXlz2eFC
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2021 05:32:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:32:32 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 05:32:32 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 19 Nov
 2021 05:32:30 -0800
Date:   Fri, 19 Nov 2021 08:32:26 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Alexey Gladkov <legion@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
Message-ID: <YZenam0jzQIlyIew@fixkernel.com>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
 <875ysptfgi.fsf@email.froward.int.ebiederm.org>
 <YZa4YbcOyjtD3+pL@fixkernel.com>
 <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:57:17PM -0600, Eric W. Biederman wrote:
> Does this only happen on a single architecture?  If so I wonder if
> perhaps some of the architectures atomic primitives are implemented
> improperly.

No, I just don't have another arch to test this on, and I see no reason
that it won't be reproduced on x86. If arm64 atomic primitives are
problematic, it will likely blow up elsewhere which is not the case from
our daily CI regression testing running for many years.
