Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088AA3A04AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhFHTx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:53:26 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55892 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234218AbhFHTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:53:25 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7IOHRKA5dz/lkGDlHemd55DYdb4zR+YMi2TD?=
 =?us-ascii?q?GXoBMCC9Ffbo9fxG/c5rtiMc5wxhPk3I9erhBED/ewK6yXcF2/h1AV7KZmCP0w?=
 =?us-ascii?q?qVxelZg7cKqAeQfxEWmNQtrZuIsJISNDQzNzJHZArBjDVQa+xQu+VvOZrGudvj?=
X-IronPort-AV: E=Sophos;i="5.83,259,1616454000"; 
   d="scan'208";a="512448444"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:51:30 +0200
Date:   Tue, 8 Jun 2021 21:51:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: find_new_ilb
Message-ID: <alpine.DEB.2.22.394.2106082138350.16734@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from the following commit:

commit 45da7a2b0af8fa29dff2e6ba8926322068350fce
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Aug 18 10:48:17 2020 +0200

    sched/fair: Exclude the current CPU from find_new_ilb()

up through Linux 5.12, I observed that often when most of the machine was
idle, there could be many (thousands) of sched_wake_idle_without_ipi
events, typically between cores 0 and 1.  I don't see this any more in
Linux v5.13-rc1.  I looked through the patches to fair.c and core.c
subsequent to v5.12, and I didn't see anything that explicitly addresses
this issue.  Before I plunge into another set of rounds of bisecting, I
wonder if anyone knows whether and how this problem was resolved?

thanks,
julia
