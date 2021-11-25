Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4045DA41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354801AbhKYMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:46:55 -0500
Received: from foss.arm.com ([217.140.110.172]:50412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352683AbhKYMoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:44:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9F5B1042;
        Thu, 25 Nov 2021 04:41:42 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5D2E3F66F;
        Thu, 25 Nov 2021 04:41:41 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Date:   Thu, 25 Nov 2021 12:41:39 +0000
Message-Id: <163784401235.134020.969364168870540116.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028140009.23331-1-etienne.carriere@linaro.org>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 16:00:08 +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".
>
>

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
      https://git.kernel.org/sudeep.holla/c/b7d2cf7c81
[2/2] firmware: arm_scmi: Add optee transport
      https://git.kernel.org/sudeep.holla/c/5f90f189a0

Sorry for the earlier incomplete message.

--
Regards,
Sudeep

