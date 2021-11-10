Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A439544C11E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhKJMWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:22:11 -0500
Received: from foss.arm.com ([217.140.110.172]:45718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhKJMWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:22:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33E2F101E;
        Wed, 10 Nov 2021 04:19:22 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67AC23F718;
        Wed, 10 Nov 2021 04:19:21 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marco Elver <elver@google.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] sched: Provide Kconfig support for default dynamic preempt mode
In-Reply-To: <YYuvzzZPuIZPe2iU@elver.google.com>
References: <20210914103134.11309-1-frederic@kernel.org> <YYuvzzZPuIZPe2iU@elver.google.com>
Date:   Wed, 10 Nov 2021 12:19:18 +0000
Message-ID: <87ee7orynt.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 12:41, Marco Elver wrote:
> Is there some way to avoid introducing *_BEHAVIOUR and keep the old
> user-settable config options?
>
> That would make the transition more seamless and avoid this predictable
> issue when 5.16 is released.
>

We're looking at it, but Kconfig be hard :-)

http://lore.kernel.org/r/20211105104035.3112162-1-valentin.schneider@arm.com
http://lore.kernel.org/r/20211109151057.3489223-1-valentin.schneider@arm.com

> Thanks,
> -- Marco
