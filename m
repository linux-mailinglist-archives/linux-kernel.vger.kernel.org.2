Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3613D34FB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhCaIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:23:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhCaIWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:22:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F918D6E;
        Wed, 31 Mar 2021 01:22:48 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C4AA3F792;
        Wed, 31 Mar 2021 01:22:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, etienne.carriere@linaro.org,
        souvik.chakravarty@arm.com, vincent.guittot@linaro.org,
        Jonathan.Cameron@Huawei.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, thara.gopinath@linaro.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH v7 00/38] SCMI vendor protocols and modularization
Date:   Wed, 31 Mar 2021 09:22:41 +0100
Message-Id: <161717882079.1834611.15637274566917063721.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 12:48:25 +0000, Cristian Marussi wrote:
> The current SCMI implementation does not provide an interface to easily
> develop and include a custom vendor protocol implementation as prescribed
> by the SCMI standard, also because, there is not currently any custom
> protocol in the upstream to justify the development of a custom interface
> and its maintenance.
> 
> Moreover the current interface exposes protocol operations to the SCMI
> driver users attaching per-protocol operations directly to the handle
> structure, which, in this way, tends to grow indefinitely for each new
> protocol addition.
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[01/38] firmware: arm_scmi: review protocol registration interface
        https://git.kernel.org/sudeep.holla/c/48dc16e2e5
[02/38] firmware: arm_scmi: introduce protocol handle definitions
        https://git.kernel.org/sudeep.holla/c/d7b6cc563a
[03/38] firmware: arm_scmi: introduce devres get/put protocols operations
        https://git.kernel.org/sudeep.holla/c/23934efe37
[04/38] firmware: arm_scmi: make notifications aware of protocols users
        https://git.kernel.org/sudeep.holla/c/3dd2c81475
[05/38] firmware: arm_scmi: introduce new devres notification ops
        https://git.kernel.org/sudeep.holla/c/5ad3d1cf7d
[06/38] firmware: arm_scmi: refactor events registration
        https://git.kernel.org/sudeep.holla/c/533c7095b1
[07/38] firmware: arm_scmi: convert events registration to protocol handles
        https://git.kernel.org/sudeep.holla/c/b9f7fd907c
[08/38] firmware: arm_scmi: add new protocol handle core xfer ops
        https://git.kernel.org/sudeep.holla/c/a4a20b0975
[09/38] firmware: arm_scmi: add helper to access revision area memory
        https://git.kernel.org/sudeep.holla/c/3d5d6e84ea
[10/38] firmware: arm_scmi: port Base protocol to new interface
        https://git.kernel.org/sudeep.holla/c/8d3581c252
[11/38] firmware: arm_scmi: port Perf protocol to new protocols interface
        https://git.kernel.org/sudeep.holla/c/1fec5e6b52
[12/38] cpufreq: scmi: port driver to the new scmi_perf_proto_ops interface
        https://git.kernel.org/sudeep.holla/c/eb1d35c6e3
[13/38] firmware: arm_scmi: remove legacy scmi_perf_ops protocol interface
        https://git.kernel.org/sudeep.holla/c/f58315a49c
[14/38] firmware: arm_scmi: port Power protocol to new protocols interface
        https://git.kernel.org/sudeep.holla/c/9bc8069c85
[15/38] firmware: arm_scmi: port GenPD driver to the new scmi_power_proto_ops interface
        https://git.kernel.org/sudeep.holla/c/26f19496a9
[16/38] firmware: arm_scmi: remove legacy scmi_power_ops protocol interface
        https://git.kernel.org/sudeep.holla/c/0f84576a62
[17/38] firmware: arm_scmi: port Clock protocol to new protocols interface
        https://git.kernel.org/sudeep.holla/c/887281c751
[18/38] clk: scmi: port driver to the new scmi_clk_proto_ops interface
        https://git.kernel.org/sudeep.holla/c/beb076bb18
[19/38] firmware: arm_scmi: remove legacy scmi_clk_ops protocol interface
        https://git.kernel.org/sudeep.holla/c/137e68659e
[20/38] firmware: arm_scmi: port Reset protocol to new protocols interface
        https://git.kernel.org/sudeep.holla/c/7e02934422
[21/38] reset: reset-scmi: port driver to the new scmi_reset_proto_ops interface
        https://git.kernel.org/sudeep.holla/c/35cc263062
[22/38] firmware: arm_scmi: remove legacy scmi_reset_ops protocol interface
        https://git.kernel.org/sudeep.holla/c/497ef0cbc6
[23/38] firmware: arm_scmi: port Sensor protocol to new protocols interface
        https://git.kernel.org/sudeep.holla/c/9694a7f623
[24/38] hwmon: (scmi) port driver to the new scmi_sensor_proto_ops interface
        https://git.kernel.org/sudeep.holla/c/987bae41e9
[25/38] iio/scmi: port driver to the new scmi_sensor_proto_ops interface
        https://git.kernel.org/sudeep.holla/c/25cbdd4609
[26/38] firmware: arm_scmi: remove legacy scmi_sensor_ops protocol interface
        https://git.kernel.org/sudeep.holla/c/f3690d9729
[27/38] firmware: arm_scmi: port SystemPower protocol to new protocols interface
        https://git.kernel.org/sudeep.holla/c/b46d852718
[28/38] firmware: arm_scmi: port Voltage protocol to new protocols interface
        https://git.kernel.org/sudeep.holla/c/fe4894d968
[29/38] regulator: scmi: port driver to the new scmi_voltage_proto_ops interface
        https://git.kernel.org/sudeep.holla/c/59046d157d
[30/38] firmware: arm_scmi: remove legacy scmi_voltage_ops protocol interface
        https://git.kernel.org/sudeep.holla/c/c3ed5e953e
[31/38] firmware: arm_scmi: make references to handle const
        https://git.kernel.org/sudeep.holla/c/f0e73cee26
[32/38] firmware: arm_scmi: cleanup legacy protocol init code
        https://git.kernel.org/sudeep.holla/c/51fe1b154e
[33/38] firmware: arm_scmi: cleanup unused core xfer wrappers
        https://git.kernel.org/sudeep.holla/c/9162afa2ae
[34/38] firmware: arm_scmi: cleanup events registration transient code
        https://git.kernel.org/sudeep.holla/c/3cb8c95f4b
[35/38] firmware: arm_scmi: make notify_priv really private
        https://git.kernel.org/sudeep.holla/c/a02d7c93c1
[36/38] firmware: arm_scmi: rename non devres notify_ops
        https://git.kernel.org/sudeep.holla/c/aa1fd3e4cb
[37/38] firmware: arm_scmi: add protocol modularization support
        https://git.kernel.org/sudeep.holla/c/f5800e0bf6
[38/38] firmware: arm_scmi: add dynamic scmi devices creation
        https://git.kernel.org/sudeep.holla/c/d4f9dddd21

--
Regards,
Sudeep

