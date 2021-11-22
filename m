Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78FD458A98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhKVIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:38:17 -0500
Received: from foss.arm.com ([217.140.110.172]:38390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238871AbhKVIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:38:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D5936D;
        Mon, 22 Nov 2021 00:35:07 -0800 (PST)
Received: from bogus (unknown [10.57.46.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9EAB3F5A1;
        Mon, 22 Nov 2021 00:35:05 -0800 (PST)
Date:   Mon, 22 Nov 2021 08:35:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        steven.price@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/1] firmware: smccc: Fix check for ARCH_SOC_ID not
 implemented
Message-ID: <20211122083503.umkqv2t75osypsbx@bogus>
References: <1637365141-16823-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637365141-16823-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 03:39:01PM -0800, Michael Kelley wrote:
> The ARCH_FEATURES function ID is a 32-bit SMC call, which returns
> a 32-bit result per the SMCCC spec.  Current code is doing a 64-bit
> comparison against -1 (SMCCC_RET_NOT_SUPPORTED) to detect that the
> feature is unimplemented.  That check doesn't work in a Hyper-V VM,
> where the upper 32-bits are zero as allowed by the spec.
> 
> Cast the result as an 'int' so the comparison works. The change also
> makes the code consistent with other similar checks in this file.
> 
> Fixes: 821b67fa4639 ("firmware: smccc: Add ARCH_SOC_ID support")

Good catch.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Can you please re-post with my review tag keeping arm@kernel.org and
soc@kernel.org ? I don't have any other fixes at the moment, we can
ask SoC maintainers to fix this up directly.

-- 
Regards,
Sudeep
