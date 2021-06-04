Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6852139B542
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhFDI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:56:41 -0400
Received: from foss.arm.com ([217.140.110.172]:33036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhFDI4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:56:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980291063;
        Fri,  4 Jun 2021 01:54:54 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32FE43F774;
        Fri,  4 Jun 2021 01:54:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Jonathan.Cameron@Huawei.com,
        souvik.chakravarty@arm.com
Subject: Re: (subset) [PATCH v2 0/5] Review/Extend SCMI Transport Core layer
Date:   Fri,  4 Jun 2021 09:54:50 +0100
Message-Id: <162279684371.1763354.4697663546315752509.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601102421.26581-1-cristian.marussi@arm.com>
References: <20210601102421.26581-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 11:24:16 +0100, Cristian Marussi wrote:
> this short series is meant to review and extend a couple of SCMI transport
> core layer mechanisms in order to ease the interaction with more complex
> SCMI transport driver like the upcoming virtio-scmi and optee-scmi.
> 
> The commits in this series have not and *should not* have any impact or
> require any change in the currently existing SCMI transports.
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/5] firmware: arm_scmi: reset_rx_to_maxsz during async commands
      https://git.kernel.org/sudeep.holla/c/0cb7af474e

--
Regards,
Sudeep

