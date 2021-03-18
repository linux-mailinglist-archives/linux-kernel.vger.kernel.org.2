Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764AA3403D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCRKtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:49:08 -0400
Received: from foss.arm.com ([217.140.110.172]:36886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhCRKsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:48:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A4131B;
        Thu, 18 Mar 2021 03:48:39 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92DFD3F792;
        Thu, 18 Mar 2021 03:48:38 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64\@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        debian-ia64 <debian-ia64@lists.debian.org>
Subject: Re: [PATCH 0/1] sched/topology: NUMA distance deduplication
In-Reply-To: <f096ecf6-e18a-d824-2db8-91f021db2132@physik.fu-berlin.de>
References: <255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de> <8735wtr2ro.mognet@arm.com> <cf4d7277-54a0-8bc7-60fb-9b2f6befb511@physik.fu-berlin.de> <87zgz1pmx4.mognet@arm.com> <87wnu5pkib.mognet@arm.com> <132937a8-0514-5a62-2897-569187e355a7@physik.fu-berlin.de> <f096ecf6-e18a-d824-2db8-91f021db2132@physik.fu-berlin.de>
Date:   Thu, 18 Mar 2021 10:48:33 +0000
Message-ID: <87tup8pwji.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/21 11:28, John Paul Adrian Glaubitz wrote:
> Hello!
>
> On 3/18/21 12:26 AM, John Paul Adrian Glaubitz wrote:
>>> b) do anything?
>> 
>> It fixes the problem for me.
>
> Here are the kernel messages with your patch applied:
>

Thanks for testing! I'll turn that into a proper patch and send it out.
