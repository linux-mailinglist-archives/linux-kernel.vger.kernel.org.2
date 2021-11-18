Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BA455B54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344557AbhKRMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:16:47 -0500
Received: from foss.arm.com ([217.140.110.172]:40154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344582AbhKRMPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:15:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4402F101E;
        Thu, 18 Nov 2021 04:12:43 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8803D3F766;
        Thu, 18 Nov 2021 04:12:42 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix type error assignment in voltage protocol
Date:   Thu, 18 Nov 2021 12:12:40 +0000
Message-Id: <163723752963.4014471.870903179686074290.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115154043.49284-1-cristian.marussi@arm.com>
References: <20211115154043.49284-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 15:40:42 +0000, Cristian Marussi wrote:
> Fix incorrect type assignment error reported by sparse as:
> 
> drivers/firmware/arm_scmi/voltage.c:159:42: warning: incorrect type in assignment (different base types)
> drivers/firmware/arm_scmi/voltage.c:159:42: expected restricted __le32 [usertype] level_index
> drivers/firmware/arm_scmi/voltage.c:159:42: got unsigned int [usertype] desc_index
> 
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix type error assignment in voltage protocol
      https://git.kernel.org/sudeep.holla/c/026d9835b6

--
Regards,
Sudeep
