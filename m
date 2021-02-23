Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A7322CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhBWOqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:46:16 -0500
Received: from foss.arm.com ([217.140.110.172]:53718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhBWOqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:46:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE181FB;
        Tue, 23 Feb 2021 06:45:28 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE3AB3F73B;
        Tue, 23 Feb 2021 06:45:26 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
To:     vincent.donnefort@arm.com, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <66a16cf1-ffc5-2a40-7e04-900cc0e2ee2c@arm.com>
Date:   Tue, 23 Feb 2021 15:44:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222095401.37158-1-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2021 10:54, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>

[...]

> Also, replace sub_positive with lsub_positive which saves one explicit
> load-store.

IMHO, in case you're going to fix this now in compute_energy(), this
optimization could still be done. Maybe in an extra patch?
cpu_util_without() is using lsub_positive() to remove task util from cpu
util as well.

[...]
