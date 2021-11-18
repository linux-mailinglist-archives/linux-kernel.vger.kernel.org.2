Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62892455B53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbhKRMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:16:35 -0500
Received: from foss.arm.com ([217.140.110.172]:40134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344563AbhKRMPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:15:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18164ED1;
        Thu, 18 Nov 2021 04:12:00 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DC4F3F766;
        Thu, 18 Nov 2021 04:11:59 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix type error in sensor protocol
Date:   Thu, 18 Nov 2021 12:11:57 +0000
Message-Id: <163723745398.4014385.11846182754201289624.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115154043.49284-2-cristian.marussi@arm.com>
References: <20211115154043.49284-1-cristian.marussi@arm.com> <20211115154043.49284-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 15:40:43 +0000, Cristian Marussi wrote:
> Fix incorrect type error reported by sparse as:
> 
> drivers/firmware/arm_scmi/sensors.c:640:28: warning: incorrect type in argument 1 (different base types)
> drivers/firmware/arm_scmi/sensors.c:640:28: expected unsigned int [usertype] val
> drivers/firmware/arm_scmi/sensors.c:640:28: got restricted __le32 [usertype]
> 
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix type error in sensor protocol
      https://git.kernel.org/sudeep.holla/c/bd074e5039

--
Regards,
Sudeep

