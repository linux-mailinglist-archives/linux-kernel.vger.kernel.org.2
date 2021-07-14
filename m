Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA73C88E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbhGNQt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:49:27 -0400
Received: from foss.arm.com ([217.140.110.172]:37028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhGNQt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:49:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F1E6D6E;
        Wed, 14 Jul 2021 09:46:34 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A14D03F774;
        Wed, 14 Jul 2021 09:46:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vasyl.Vavrychuk@opensynergy.com, f.fainelli@gmail.com,
        jean-philippe@linaro.org, Jonathan.Cameron@Huawei.com,
        james.quinlan@broadcom.com, igor.skalkin@opensynergy.com,
        alex.bennee@linaro.org, Andriy.Tryshnivskyy@opensynergy.com,
        peter.hilber@opensynergy.com, etienne.carriere@linaro.org,
        mikhail.golubev@opensynergy.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, anton.yakovlev@opensynergy.com
Subject: Re: [PATCH v6 02/17] firmware: arm_scmi: Fix max pending messages boundary check
Date:   Wed, 14 Jul 2021 17:46:19 +0100
Message-Id: <162628092795.2616376.4238960316270820768.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712141833.6628-3-cristian.marussi@arm.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 15:18:16 +0100, Cristian Marussi wrote:
> SCMI message headers carry a sequence number and such field is sized to
> allow for MSG_TOKEN_MAX distinct numbers; moreover zero is not really an
> acceptable maximum number of pending in-flight messages.
>
> Fix accordignly the checks performed on the value exported by transports
>in scmi_desc.max_msg.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[02/17] firmware: arm_scmi: Fix max pending messages boundary check
        https://git.kernel.org/sudeep.holla/c/bdb8742dc6

--
Regards,
Sudeep

