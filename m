Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0DE332BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhCIQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:18:31 -0500
Received: from mx1.riseup.net ([198.252.153.129]:43378 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231283AbhCIQSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:18:20 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Dw0kN2jtnzDq9Y;
        Tue,  9 Mar 2021 08:18:20 -0800 (PST)
X-Riseup-User-ID: B3B763BB19D1706ED9FB4E7D01A5E306F0BD0569ED4B8C90687CA45D32DC6042
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Dw0kM4zN0z1xmR;
        Tue,  9 Mar 2021 08:18:19 -0800 (PST)
Subject: Re: patch: do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <b8591e67-1248-6c29-847e-d97e04b58210@torproject.org>
 <20210309085641.GB25222@redhat.com>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <383ff3ab-ef13-1c6e-7794-ecfffc6044d4@torproject.org>
Date:   Tue, 9 Mar 2021 10:18:18 -0600
MIME-Version: 1.0
In-Reply-To: <20210309085641.GB25222@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick review!

On 3/9/21 02:56, Oleg Nesterov wrote:
> I'd suggest to put this PIDTYPE_PID code into the new function.

Done

> No, you don't need rcu lock, tasklist_lock is sufficient

Done

> This is wrong, you forgot to drop tasklist_lock.

Done

>> +		real_parent = !target->real_parent ? target->parent :
>> +						     target->real_parent;
> 
> Hmm, I don't understand the line above... perhaps it connects to the
> question below.

I'd mistakenly thought `real_parent` was NULL if the target wasn't being
traced (or was being traced by the real parent). It looks like indeed
this should always be set, though.

> Afaics, parent/real_parent can't be NULL if pid_task() succeeds.

Done

> Please redo and send V2 ;)

Sent with subject "[PATCH v2] do_wait: make PIDTYPE_PID case O(1)
instead of O(n)"
