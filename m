Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C533A1E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFIUxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:53:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhFIUxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:53:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D32C6ED1;
        Wed,  9 Jun 2021 13:51:25 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 749333F719;
        Wed,  9 Jun 2021 13:51:24 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Jonathan.Cameron@Huawei.com
Subject: Re: [RFC PATCH 02/10] firmware: arm_scmi: Add missing xfer reinit_completion
Date:   Wed,  9 Jun 2021 21:51:19 +0100
Message-Id: <162327170419.2648700.1080765933489315577.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606221232.33768-3-cristian.marussi@arm.com>
References: <20210606221232.33768-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021 23:12:22 +0100, Cristian Marussi wrote:

> Reusing timed out xfers in a loop can lead to issue if completion was not
> properly reinitialized.

Applied to sudeep.holla/linux (master), thanks!

[02/10] firmware: arm_scmi: Add missing xfer reinit_completion
        https://git.kernel.org/sudeep.holla/c/e30d91d4ff

--
Regards,
Sudeep

