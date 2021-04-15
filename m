Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF8A3611BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhDOSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:10:10 -0400
Received: from foss.arm.com ([217.140.110.172]:52012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234064AbhDOSKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:10:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FAA712FC;
        Thu, 15 Apr 2021 11:09:45 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885863FA45;
        Thu, 15 Apr 2021 11:09:43 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>, linux@armlinux.org.uk,
        sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, a.p.zijlstra@chello.nl,
        dietmar.eggemann@arm.com, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm: topology: parse the topology from the dt
In-Reply-To: <20210414122326.5255-2-ruifeng.zhang0110@gmail.com>
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com> <20210414122326.5255-2-ruifeng.zhang0110@gmail.com>
Date:   Thu, 15 Apr 2021 19:09:41 +0100
Message-ID: <871rbbmnbu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/21 20:23, Ruifeng Zhang wrote:
> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>
> The arm topology still parse from the MPIDR, but it is incomplete.  When
> the armv8.2 or above cpu runs kernel in EL1 with aarch32 mode, it will
> parse out the wrong topology.
>

Per my other email, isn't the problem that MPIDR can't be trusted to
properly represent the topology, and thus a new method of describing the
topology (cpu-map) has to be used?
