Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1720F30D9E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBCMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:39:37 -0500
Received: from foss.arm.com ([217.140.110.172]:39168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhBCMjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:39:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7C713D5;
        Wed,  3 Feb 2021 04:38:34 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.11.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211C93F73B;
        Wed,  3 Feb 2021 04:38:31 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:38:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Seiya Wang <seiya.wang@mediatek.com>, Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v2 0/2] Add support for ARM Cortex-A78 PMU
Message-ID: <20210203123828.GF55896@C02TD0UTHF1T.local>
References: <20210203055348.4935-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203055348.4935-1-seiya.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:53:46PM +0800, Seiya Wang wrote:
> 
> Add support for ARM Cortex-A78 PMU since it will be used in
> new Mediatek SoC.
> 
> Based on v5.11-rc6
> 
> Change in v2:
> Remove change-id in commit message
> 
> Seiya Wang (2):
>   arm64: perf: add support for Cortex-A78
>   dt-bindings: arm: add Cortex-A78 binding

Both patches look good to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, I assume you'll pick this up.

Mark

> 
>  Documentation/devicetree/bindings/arm/pmu.yaml | 1 +
>  arch/arm64/kernel/perf_event.c                 | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> --
> 2.14.1
> 
