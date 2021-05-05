Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4663747E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhEESS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:18:57 -0400
Received: from foss.arm.com ([217.140.110.172]:49968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhEESS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:18:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EBBD1FB;
        Wed,  5 May 2021 11:17:59 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27D0D3F718;
        Wed,  5 May 2021 11:17:58 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] Rework CPU capacity asymmetry detection
In-Reply-To: <1619602363-1305-1-git-send-email-beata.michalska@arm.com>
References: <1619602363-1305-1-git-send-email-beata.michalska@arm.com>
Date:   Wed, 05 May 2021 19:17:55 +0100
Message-ID: <87bl9pxcx8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/21 10:32, Beata Michalska wrote:
> v2:
>  - Fixed style issues
>  - Reworked accessing the cached topology data as suggested by Valentin
>

Other than my pedantic nitpicks:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks for tackling this!

> Beata Michalska (3):
>   sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL sched_domain flag
>   sched/topology: Rework CPU capacity asymmetry detection
>   sched/doc: Update the CPU capacity asymmetry bits
>
>  Documentation/scheduler/sched-capacity.rst |   6 +-
>  Documentation/scheduler/sched-energy.rst   |   2 +-
>  include/linux/sched/sd_flags.h             |  10 +
>  kernel/sched/topology.c                    | 327 +++++++++++++++++++++++++----
>  4 files changed, 302 insertions(+), 43 deletions(-)
>
> --
> 2.7.4
