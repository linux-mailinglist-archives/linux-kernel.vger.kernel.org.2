Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5863E3F29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 07:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhHIFBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 01:01:23 -0400
Received: from foss.arm.com ([217.140.110.172]:52802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232786AbhHIFBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 01:01:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D1311042;
        Sun,  8 Aug 2021 22:01:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2737F3F718;
        Sun,  8 Aug 2021 22:01:01 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        cristian.marussi@arm.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, adharmap@codeaurora.org,
        avajid@codeaurora.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Free mailbox channels if probe fails
Date:   Mon,  9 Aug 2021 06:00:57 +0100
Message-Id: <162848516052.232525.343233021782950735.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1628111999-21595-1-git-send-email-rishabhb@codeaurora.org>
References: <1628111999-21595-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 14:19:59 -0700, Rishabh Bhatnagar wrote:
> Mailbox channels for the base protocol are setup during probe.
> There can be a scenario where probe fails to acquire the base
> protocol due to a timeout leading to cleaning up of all device
> managed memory including the scmi_mailbox structure setup during
> mailbox_chan_setup function.
> [   12.735104]arm-scmi soc:qcom,scmi: timed out in resp(caller: version_get+0x84/0x140)
> [   12.735224]arm-scmi soc:qcom,scmi: unable to communicate with SCMI
> [   12.735947]arm-scmi: probe of soc:qcom,scmi failed with error -110
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Free mailbox channels if probe fails
      https://git.kernel.org/sudeep.holla/c/1e7cbfaa66

--
Regards,
Sudeep

