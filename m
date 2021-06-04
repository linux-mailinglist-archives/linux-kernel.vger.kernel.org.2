Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC139B53B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFDIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:55:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhFDIzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:55:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4A71063;
        Fri,  4 Jun 2021 01:53:37 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BD4F3F774;
        Fri,  4 Jun 2021 01:53:36 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 1/4] firmware: arm_scmi: fix deps arm-smccc-discovery deps in Kconfig
Date:   Fri,  4 Jun 2021 09:53:29 +0100
Message-Id: <162279671393.1763066.13025009312152651179.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521134055.24271-1-etienne.carriere@linaro.org>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 15:40:51 +0200, Etienne Carriere wrote:
> ARM_SCMI_PROTOCOL depends one either MAILBOX or HAVE_ARM_SMCCC_DISCOVERY,
> not MAILBOX only. This change fixes this in Kconfig file and driver
> private header file.

Applied to sudeep.holla/linux (v5.13/scmi_dt_schema), thanks!

[1/4] firmware: arm_scmi: fix deps arm-smccc-discovery deps in Kconfig
      https://git.kernel.org/sudeep.holla/c/c05b07963e

--
Regards,
Sudeep

