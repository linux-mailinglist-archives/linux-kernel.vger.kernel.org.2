Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20636D558
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbhD1KEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:04:04 -0400
Received: from foss.arm.com ([217.140.110.172]:38700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238428AbhD1KEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:04:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6061FB;
        Wed, 28 Apr 2021 03:03:17 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B9E23F70D;
        Wed, 28 Apr 2021 03:03:16 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scpi: prevent ternary sign expansion bug
Date:   Wed, 28 Apr 2021 11:03:06 +0100
Message-Id: <161960405992.396847.5531876675862211477.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YIE7pdqV/h10tEAK@mwanda>
References: <YIE7pdqV/h10tEAK@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 12:02:29 +0300, Dan Carpenter wrote:
> How type promotion works in ternary expressions is a bit tricky.
> The problem is that scpi_clk_get_val() returns longs, "ret" is a int
> which holds a negative error code, and le32_to_cpu() is an unsigned int.
> We want the negative error code to be cast to a negative long.  But
> because le32_to_cpu() is an u32 then "ret" is type promoted to u32 and
> becomes a high positive and then it is promoted to long and it is still
> a high positive value.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scpi: prevent ternary sign expansion bug
      https://git.kernel.org/sudeep.holla/c/d9cd78edb2

--
Regards,
Sudeep

