Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9EC456440
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhKRUfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:35:37 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:24454 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhKRUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637267556; x=1668803556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ku4lgLFVLydzdvx+PWnCumS5fNvHZbga0x9By5nYn2k=;
  b=uyxDnm2oNEZZapKfOwZKxwMVopwWwe1lRLAlgvhcKWYfz0mAxxlqtbOh
   yzTMm169LqjluP2sPdiLbB1IfSytd6IVLBYtTAjK4cT/4fh8FxfAwXxmv
   93rgqT6iekL8qgMG0ZbAXsJh7mptGkhbjaXVJ8E2kgroAIqOgncUrI7i1
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Nov 2021 12:32:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 12:32:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 12:32:36 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 18 Nov
 2021 12:32:35 -0800
Date:   Thu, 18 Nov 2021 15:32:33 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Alexey Gladkov <legion@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
Message-ID: <YZa4YbcOyjtD3+pL@fixkernel.com>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
 <875ysptfgi.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <875ysptfgi.fsf@email.froward.int.ebiederm.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 01:46:05PM -0600, Eric W. Biederman wrote:
> Is it possible?  Yes it is possible.  That is one place where
> a use-after-free has shown up and I expect would show up in the
> future.
> 
> That said it is hard to believe there is still a user-after-free in the
> code.  We spent the last kernel development cycle pouring through and
> correcting everything we saw until we ultimately found one very subtle
> use-after-free.
> 
> If you have a reliable reproducer that you can share, we can look into
> this and see if we can track down where the reference count is going
> bad.
> 
> It tends to take instrumenting the entire life cycle every increment and
> every decrement and then pouring through the logs to track down a
> use-after-free.  Which is not something we can really do without a
> reproducer.

The reproducer is just to run trinity by an unprivileged user on defconfig
with KASAN enabled (On linux-next, you can do "make defconfig debug.conf"
[1], but dont think other debugging options are relevent here.)

$ trinity -C 31 -N 10000000

It is always reproduced on an arm64 server here within 5-minute so far.
Some debugging progress so far. BTW, this could happen on user_shm_unlock()
path as well.

 Call trace:
  dec_rlimit_ucounts
  user_shm_unlock
  (inlined by) user_shm_unlock at mm/mlock.c:854
  shmem_lock
  shmctl_do_lock
  ksys_shmctl.constprop.0
  __arm64_sys_shmctl
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

I noticed in dec_rlimit_ucounts(), dec == 0 and type ==
UCOUNT_RLIMIT_MEMLOCK. 

[1] https://lore.kernel.org/lkml/20211115134754.7334-1-quic_qiancai@quicinc.com/
