Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223BF3C6ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 08:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhGMHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhGMHBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53A44611C1;
        Tue, 13 Jul 2021 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626159494;
        bh=YIzTpPvbZhVoGC3bxzG2v0sAhNqampjezhulmE9OipI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZLGhACFs1NcIlQ+RdH2zIl6NgUMW9BgGuv692B+iBV1+zAiMXUNgVxpTQiyCcxpX
         iu2mwx4FkHOAHRpun2ROrKtct9l4ejfz7h4KgRDtJ2NZeiOnoAvp2/4NMIIyZarJCQ
         dRX85s9xIvk4u0HDqcG48vtwo7QPrKrjTjbK92vg=
Date:   Tue, 13 Jul 2021 08:58:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pandith.n@intel.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, furong.zhou@intel.com,
        mgross@linux.intel.com, mallikarjunappa.sangannavar@intel.com,
        andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
Message-ID: <YO05g5JiOcF/bFza@kroah.com>
References: <20210713065347.21554-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713065347.21554-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 12:23:47PM +0530, pandith.n@intel.com wrote:
> --- /dev/null
> +++ b/drivers/misc/noc/Kconfig
> @@ -0,0 +1,16 @@
> +# Copyright (C) 2019 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +
> +config NOC_DSS
> +	tristate "Enable DSS NOC probing"

Please be more descriptive of what exactly this is, it does not make
sense to anyone who does not know what DSS or NOC means.

> +	depends on ARCH_KEEMBAY
> +	default y

You only use 'y' if the machine can not boot without the option.
Otherwise it is left alone.

And what about CONFIG_TEST ability to test build this code?  Without
that, you will get almost no one every building this code to see if
anything breaks over time.

thanks,

greg k-h
