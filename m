Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ADA3379FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCKQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:49:53 -0500
Received: from mx1.riseup.net ([198.252.153.129]:53122 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhCKQtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:49:21 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DxFKF0NRKzDxxF;
        Thu, 11 Mar 2021 08:49:21 -0800 (PST)
X-Riseup-User-ID: 4679470A95FF91EABF51198E5B78047C0E3FD6BB6DE13DC0EF9CA8910FCE32BE
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4DxFKD4zCrz5vNM;
        Thu, 11 Mar 2021 08:49:20 -0800 (PST)
Subject: Re: [PATCH] ptrace: Allow other threads to access tracee
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210310205908.23447-1-jnewsome@torproject.org>
 <20210311152123.GC15552@redhat.com>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <f82d5f3a-63f7-2f3f-0e34-aa53ade15bfc@torproject.org>
Date:   Thu, 11 Mar 2021 10:49:19 -0600
MIME-Version: 1.0
In-Reply-To: <20210311152123.GC15552@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 09:21, Oleg Nesterov wrote:
> Cough... it is not that simple.
Yes, I was afraid of that :)
> Just suppose that 2 threads call ptrace(tracee) at the same time. Say, the 1st
> thread does PTRACE_CONT while the 2nd thread tries to change the registers.

Is it acceptable for the new register-values to be lost, or even
corrupted, in this case? From my perspective it is, if the tracer failed
to synchronize itself, but maybe there's an overarching philosophy that
syscalls should be "atomic"?

I suppose even if the corruption of the register-values-themselves is
acceptable, some synchronization may be needed to avoid the possibility
of corrupting the kernel's data structures?

Is it "just" a matter of adding some locking? Would a relatively coarse
lock on the target task over the duration of the ptrace call (which I
believe is always non-blocking?) be acceptable, or would we need finer
grained locking in places where we actually touch the target task? And
do you have a feel for whether you'd be inclined to accept such a patch
once that (or whatever actually is needed) is added?

Thanks!

-Jim

