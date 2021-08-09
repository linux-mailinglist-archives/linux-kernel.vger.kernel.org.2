Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E033E3F32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 07:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhHIFHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 01:07:38 -0400
Received: from foss.arm.com ([217.140.110.172]:52890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhHIFHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 01:07:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7699131B;
        Sun,  8 Aug 2021 21:57:56 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EB983F718;
        Sun,  8 Aug 2021 21:57:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        anton.yakovlev@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com, souvik.chakravarty@arm.com,
        Jonathan.Cameron@Huawei.com, peter.hilber@opensynergy.com,
        james.quinlan@broadcom.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, jean-philippe@linaro.org,
        Vasyl.Vavrychuk@opensynergy.com, igor.skalkin@opensynergy.com,
        mikhail.golubev@opensynergy.com, f.fainelli@gmail.com,
        alex.bennee@linaro.org
Subject: Re: [PATCH v7 00/15] Introduce SCMI transport based on VirtIO
Date:   Mon,  9 Aug 2021 05:57:36 +0100
Message-Id: <162848483974.232214.9506203742448269364.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803131024.40280-1-cristian.marussi@arm.com>
References: <20210803131024.40280-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 14:10:09 +0100, Cristian Marussi wrote:
> While reworking this series starting from the work done up to V3 by
> OpenSynergy, I am keeping the original autorship and list distribution
> unchanged.
> 
> The main aim of this rework, as said, is to simplify where possible the
> SCMI VirtIO support added in V3 by adding at first some new general
> mechanisms in the SCMI Transport layer.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[01/15] firmware: arm_scmi: Add support for type handling in common functions
        https://git.kernel.org/sudeep.holla/c/63b282f172
[02/15] firmware: arm_scmi: Remove scmi_dump_header_dbg() helper
        https://git.kernel.org/sudeep.holla/c/3669032514
[03/15] firmware: arm_scmi: Add optional transport_init/exit support
        https://git.kernel.org/sudeep.holla/c/ceac257db0
[04/15] firmware: arm_scmi: Introduce monotonically increasing tokens
        https://git.kernel.org/sudeep.holla/c/9ca5a1838e
[05/15] firmware: arm_scmi: Handle concurrent and out-of-order messages
        https://git.kernel.org/sudeep.holla/c/ed7c04c1fe
[06/15] firmware: arm_scmi: Make .clear_channel optional
        https://git.kernel.org/sudeep.holla/c/e9b21c9618
[07/15] firmware: arm_scmi: Make polling mode optional
        https://git.kernel.org/sudeep.holla/c/2930abcffd
[08/15] firmware: arm_scmi: Make SCMI transports configurable
        https://git.kernel.org/sudeep.holla/c/e8419c24ba
[09/15] firmware: arm_scmi: Make shmem support optional for transports
        https://git.kernel.org/sudeep.holla/c/a7b1138b92
[10/15] firmware: arm_scmi: Add method to override max message number
        https://git.kernel.org/sudeep.holla/c/c92c3e382e
[11/15] firmware: arm_scmi: Add message passing abstractions for transports
        https://git.kernel.org/sudeep.holla/c/f301bba0ca
[12/15] firmware: arm_scmi: Add optional link_supplier() transport op
        https://git.kernel.org/sudeep.holla/c/7885281260
[13/15] dt-bindings: arm: Add virtio transport for SCMI
        https://git.kernel.org/sudeep.holla/c/60625667c4
[14/15] firmware: arm_scmi: Add priv parameter to scmi_rx_callback
        https://git.kernel.org/sudeep.holla/c/13fba878cc
[15/15] firmware: arm_scmi: Add virtio transport
        https://git.kernel.org/sudeep.holla/c/46abe13b5e

--

Regards,
Sudeep

