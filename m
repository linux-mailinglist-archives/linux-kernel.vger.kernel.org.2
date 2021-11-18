Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5778B455B41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbhKRMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:12:57 -0500
Received: from foss.arm.com ([217.140.110.172]:40092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344467AbhKRMMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:12:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7637E1FB;
        Thu, 18 Nov 2021 04:09:49 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A008E3F766;
        Thu, 18 Nov 2021 04:09:48 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cristian.marussi@arm.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] arm/scmi: fix base agent discover response
Date:   Thu, 18 Nov 2021 12:09:43 +0000
Message-Id: <163723734736.4014156.4454501057354855876.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117081856.9932-1-vincent.guittot@linaro.org>
References: <20211117081856.9932-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 09:18:56 +0100, Vincent Guittot wrote:
> According to scmi specification, the response of the discover agent request
> is made of:
> - int32 status
> - uint32 agent_id
> - uint8 name[16]
> 
> but the current implementation doesn't take into account the agent_id field
> and only allocates a rx buffer of SCMI_MAX_STR_SIZE length
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] arm/scmi: fix base agent discover response
      https://git.kernel.org/sudeep.holla/c/d1cbd9e0f7

--
Regards,
Sudeep

