Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E23A1373
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhFILwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:52:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhFILwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:52:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lqwil-0006hA-UX; Wed, 09 Jun 2021 11:50:08 +0000
To:     "Hans de Goede <hdegoede"@redhat.com,
        Mark Gross <mgross@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Colin Ian King <colin.king@canonical.com>
Cc:     platform-driver-x86@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Computation of return value being discarded in get_cpu_power() in
 drivers/platform/x86/intel_ips.c
Message-ID: <548dd463-3942-00a1-85c3-232897dea1a3@canonical.com>
Date:   Wed, 9 Jun 2021 12:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was reviewing some old unassigned variable warnings from static
analysis by Coverity and found an issue introduced with the following
commit:

commit aa7ffc01d254c91a36bf854d57a14049c6134c72
Author: Jesse Barnes <jbarnes@virtuousgeek.org>
Date:   Fri May 14 15:41:14 2010 -0700

    x86 platform driver: intelligent power sharing driver

The analysis is as follows:

drivers/platform/x86/intel_ips.c

 871 static u32 get_cpu_power(struct ips_driver *ips, u32 *last, int period)
 872 {
 873        u32 val;
 874        u32 ret;
 875
 876        /*
 877         * CEC is in joules/65535.  Take difference over time to
 878         * get watts.
 879         */
 880        val = thm_readl(THM_CEC);
 881
 882        /* period is in ms and we want mW */
 883        ret = (((val - *last) * 1000) / period);

Unused value (UNUSED_VALUE)
assigned_value:  Assigning value from ret * 1000U / 65535U to ret here,
but that stored value is not used.

 884        ret = (ret * 1000) / 65535;
 885        *last = val;
 886
 887        return 0;
 888 }

I'm really not sure why ret is being calculated on lines 883,884 and not
being used. Should that be *last = ret on line 885? Looks suspect anyhow.

Colin


