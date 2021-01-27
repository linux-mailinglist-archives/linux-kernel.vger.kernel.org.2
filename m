Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB53051C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhA0FMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbhA0EfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:35:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E56C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FyigkRlRE4pmsaGXCKtC6757GGw4ameez6fOL+IxA1E=; b=qovdVIOzFkicxoxJoclBex/ie0
        eDDxgh8okUbfPSG7hjHNOhBi+zahrZUNbYBnxdWqBTJF96K0y3z97vf+ooOFDAmcp/khEpjnDuDcM
        P9pUOW4/sKGnYLNig/d9MX1NxJqjBlig3H2VJsgv4b9x+UjAMQmASrZ2Z5BXyxBsnRiO5hDSs7dB7
        pr87laL0UwERKbS0HaBMlUXbpbmhXPuU77D1czbrQ5dtO+OZAKmbmhMaO4+qLb3paGPnG7VpB0dsW
        2hOHkEq49WQbTkSzWHjwb8y+le3KdXiTtXtqyGyvis5L9uPBHv0uZfrGzSKcZEvni56PjPpJw/3g3
        chJfap2Q==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4cX1-0002Rd-CF; Wed, 27 Jan 2021 04:34:15 +0000
Subject: Re: [PATCH v3 33/34] misc: Hddl device management for local host
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-34-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b6062fe9-3936-cf1e-bc7c-365f6f03a680@infradead.org>
Date:   Tue, 26 Jan 2021 20:34:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210126054036.61587-34-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:40 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/hddl_device/Kconfig b/drivers/misc/hddl_device/Kconfig
> new file mode 100644
> index 000000000000..e1ae81fdf177
> --- /dev/null
> +++ b/drivers/misc/hddl_device/Kconfig
> @@ -0,0 +1,14 @@
> +# Copyright (C) 2020 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config HDDL_DEVICE_CLIENT
> +	tristate "Support for hddl device client"

s/hddl/HDDL/

> +	depends on XLINK_CORE && INTEL_TSENS_LOCAL_HOST
> +	help
> +	  This option enables HDDL device client module.
> +
> +	  This driver is used for sharing time sync data to local host and
> +	  retrives the sensors available on the platform. This also handles

	  retrieves

> +	  the device connect/disconnect programming sequence.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
