Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7896344D01B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhKKCpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 21:45:23 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:57084 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbhKKCpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 21:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636598553; x=1668134553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JnqA0szHrg+XzXO/n7kiXmy9+xkd6HrrIyTgwhsyuVk=;
  b=Lxd2OAUazcLwH5guOgFSCPr8s206AqUZBx4ZIarQApzq/S4mxay+itp+
   Aq7JXhIDLMUmXSPkyqMiyW/AuDlu8pNjKWnF82eB4BJez1LmWxBZEkdgr
   cXhB6aKd7nHDgCSUqjybfYnVHh5+UDTdnQ63I0dyUuXv0/xAwiBv+KzRs
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 10 Nov 2021 18:42:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 18:42:32 -0800
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 18:42:29 -0800
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <peterz@infradead.org>
CC:     <boqun.feng@gmail.com>, <hdanton@sina.com>,
        <linux-kernel@vger.kernel.org>, <longman@redhat.com>,
        <mazhenhua@xiaomi.com>, <mingo@redhat.com>, <will@kernel.org>,
        <quic_aiquny@quicinc.com>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already set
Date:   Thu, 11 Nov 2021 10:42:10 +0800
Message-ID: <20211111024210.11775-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110213854.GE174703@worktop.programming.kicks-ass.net>
References: <20211110213854.GE174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: quic_aiquny@quicinc.com

There is an important information that when the issue reported, the first waiter can be changed. This is via other hook changes which can not always add to the tail of the waitlist which is not the same of the current upstream code.

The current original Xiaomi's issue when we checked the log, we can find out that the scenario is that write waiter set the sem->count with RWSEM_FLAG_HANDOFF bit and then another reader champ in and got the first waiter.
So When the reader go through rwsem_down_read_slowpath if it have RWSEM_FLAG_HANDOFF bit set, it will clear the RWSEM_FLAG_HANDOFF bit.

So it left the wstate of the local variable as WRITER_HANDOFF, but the reader thought it was a Reader Handoff and cleared it.
While the writer only checkes the wstate local variable of WRITER_HANDOFF, and do the add(-RWSEM_FLAG_HANDOFF) action. If it do a addnot(RWSEM_FLAG_HANDOFF), then the writer will not make the sem->count underflow.

The current scenario looked like this:
--------------------------------
	wstate = WRITER_HANDOFF;
	raw_spin_lock_irq(&sem->wait_lock);
	if (rwsem_try_write_lock(sem, wstate))
	raw_spin_unlock_irq(&sem->wait_lock);
	   :
	   if (signal_pending_state(state, current))       //other *important* reader rwsem_down_read_slowpath add to the first of the waitlist, and clear the RWSEM_FLAG_HANDOFF
	     goto out_nolock
	     out_nolock:
	     add(-RWSEM_FLAG_HANDOFF, sem->count)                     // make the count to be negative.
--------------------------------

So if we do a andnot it will be much more safer, and working in this scenario:
--------------------------------
	wstate = WRITER_HANDOFF;
	raw_spin_lock_irq(&sem->wait_lock);
	if (rwsem_try_write_lock(sem, wstate))
	raw_spin_unlock_irq(&sem->wait_lock);
	   :
	   if (signal_pending_state(state, current))       //other *important* reader rwsem_down_read_slowpath add to the first of the waitlist, and clear the RWSEM_FLAG_HANDOFF
	     goto out_nolock
	     out_nolock:
	     addnot(RWSEM_FLAG_HANDOFF, sem->count)                // make the count unchanged.
--------------------------------


So if we do a andnot it will be much more safer, and working in the not killed normal senario:
--------------------------------
	wstate = WRITER_HANDOFF;
	raw_spin_lock_irq(&sem->wait_lock);
	if (rwsem_try_write_lock(sem, wstate))
	raw_spin_unlock_irq(&sem->wait_lock);
	   :
	   if (signal_pending_state(state, current))       //other *important* reader rwsem_down_read_slowpath add to the first of the waitlist, and clear the RWSEM_FLAG_HANDOFF
		if (wstate == WRITER_HANDOFF)
			trylock_again:
			raw_spin_lock_irq(&sem->wait_lock);
			if (rwsem_try_write_lock(sem, wstate))		//writer will set the RWSEM_FLAG_HANDOFF flag again.
	raw_spin_unlock_irq(&sem->wait_lock);
--------------------------------



Thx and BRs,
Aiqun Yu (Maria)


