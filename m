Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2450B453965
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhKPSa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:30:59 -0500
Received: from foss.arm.com ([217.140.110.172]:48352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239466AbhKPSa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:30:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52DB6D;
        Tue, 16 Nov 2021 10:28:01 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364AD3F70D;
        Tue, 16 Nov 2021 10:28:01 -0800 (PST)
Date:   Tue, 16 Nov 2021 18:27:58 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/scmi: fix base agent discover response
Message-ID: <20211116182758.GB56473@e120937-lin>
References: <20211116173255.19936-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116173255.19936-1-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 06:32:55PM +0100, Vincent Guittot wrote:
> According to scmi specification, the response of the discover agent request
> is made of:
> - int32 status
> - uint32 agent_id
> - uint8 name[16]
> 
> but the current implementation doesn't take into account the agent_id field
> and only allocates a rx buffer of SCMI_MAX_STR_SIZE length
> 

Hi Vincent,

> Allocate the correct length for rx buffer and copy the name from the
> correct offset in the response.
> 
> While no error were returned until v5.15, v5.16-rc1 fails with virtio_scmi
> transport channel:
> 
> [    1.093253] arm-scmi firmware:scmi0: SCMI Notifications - Core Enabled.
> [    1.114776] arm-scmi firmware:scmi0: SCMI Protocol v2.0 'Linaro:PMWG' Firmware version 0x2090000
> [    1.117544] scmi-virtio virtio0: tx:used len 28 is larger than in buflen 24
> 

Good catch...I was (still) not testing BASE_DISCOVER_AGENT in my virtio setup
given it's optional....

Once implemented the command I could reproduce and test you fix.

[    1.239629] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    1.266401] arm-scmi firmware:scmi: SCMI Protocol v2.0 'EMU-SCMI-VM:userland' Firmware version 0xdeadbeef
[    1.280360] arm-scmi firmware:scmi: Found 3 protocol(s) 3 agent(s)
[    1.286304] arm-scmi firmware:scmi: Agent 0: AGENT_00
[    1.294115] arm-scmi firmware:scmi: Agent 1: AGENT_01
[    1.301062] arm-scmi firmware:scmi: Agent 2: AGENT_02

LGTM.

Maybe it's worth also a Fixes...

The earlier where this was introduced seems:

Fixes: b6f20ff8bd94 ("firmware: arm_scmi: add common infrastructure and support for base protocol")

and then it was carried on (:D) after heavily refactoring in:

Fixes: 8d3581c2526f ("firmware: arm_scmi: Port base protocol to new interface")

FWIW,

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

