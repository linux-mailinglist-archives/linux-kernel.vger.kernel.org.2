Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356CA33C650
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhCOTDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:03:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhCOTDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:03:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5C0EAE3D;
        Mon, 15 Mar 2021 19:03:13 +0000 (UTC)
Date:   Mon, 15 Mar 2021 12:03:07 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] futex: Fix irq mismatch in exit_pi_state_list()
Message-ID: <20210315190307.vslsxmgtwn43crwc@offworld>
References: <20210315050224.107056-1-dave@stgolabs.net>
 <20210315050224.107056-2-dave@stgolabs.net>
 <YE9dM6PB9ZpC8AfY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YE9dM6PB9ZpC8AfY@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021, Peter Zijlstra wrote:

>Or am I reading this wrong?

No, I read it wrong. Please ignore this patch, there are rather a few
cases that do this trickery.

Thanks,
Davidlohr
