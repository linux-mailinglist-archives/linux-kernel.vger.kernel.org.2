Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F363C88CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhGNQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:41:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhGNQlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:41:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25239D6E;
        Wed, 14 Jul 2021 09:38:26 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B3083F7D8;
        Wed, 14 Jul 2021 09:38:25 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Avoid padding in sensor message structure
Date:   Wed, 14 Jul 2021 17:38:21 +0100
Message-Id: <162628065273.2615991.7447656949078196138.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628170042.34105-1-cristian.marussi@arm.com>
References: <20210628170042.34105-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 18:00:42 +0100, Cristian Marussi wrote:
> Structure scmi_resp_sensor_reading_complete is meant to represent an SCMI
> asynchronous reading complete message: representing the readings field with
> a 64bit type forces padding and breaks reads in scmi_sensor_reading_get.
> 
> Split it in two adjacent 32bit readings_low/high subfields to avoid padding
> or the need to make it packed.

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Avoid padding in sensor message structure
      https://git.kernel.org/sudeep.holla/c/187a002b07

--
Regards,
Sudeep

