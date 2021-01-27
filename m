Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39B53051BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhA0FKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbhA0E2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:28:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E093C061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=6kzl6YnNBd1itbEFlkG5btC0KdTc69/v16B5E3djeZY=; b=d+HKxHN3mx0C6s6jdBdQNGk0k3
        qlmdtYOhfv5vDZWrJHAADoraPaPk3cWmc0l7n9uVgABzwax2rGUzBOS380jaei7RsWb93mPx179MF
        vKMGswF9usPLXs2jous69bmVSTMZHixR5eBWpwd5fo327PuqcX492sHiZtq5NhvkEM+xvcwXMjWh5
        q181vuKifl5MeSbAvJNnTWqwXQSi9WCysEBo1iTPxpF6DDujXSjwFJVPYJUqGP2+HVB9+GQJgGdvA
        BFqO3cFM94RbJygYiF8pKUp5G9IVBqbDKxuBZ21Oi94o1qqdrCzPUGKxaDSymSaNWuxTWfioy6xpi
        OMPs0M7Q==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4cPS-0001pQ-Nt; Wed, 27 Jan 2021 04:26:27 +0000
Subject: Re: [PATCH v3 34/34] misc: HDDL device management for IA host
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-35-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f3b1ac5f-e418-2f05-44a8-c8350fdefe49@infradead.org>
Date:   Tue, 26 Jan 2021 20:26:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210126054036.61587-35-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:40 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/hddl_device/Kconfig b/drivers/misc/hddl_device/Kconfig
> index e1ae81fdf177..7f9a6a685275 100644
> --- a/drivers/misc/hddl_device/Kconfig
> +++ b/drivers/misc/hddl_device/Kconfig
> @@ -12,3 +12,15 @@ config HDDL_DEVICE_CLIENT
>  	  the device connect/disconnect programming sequence.
>  	  Say Y if using a processor that includes the Intel VPU such as
>  	  Keem Bay.  If unsure, say N.
> +
> +config HDDL_DEVICE_SERVER
> +	tristate "Support for hddl device server"
> +	depends on XLINK_CORE && !HDDL_DEVICE_CLIENT
> +	help
> +	  This option enables HDDL device server module.
> +
> +	  This driver is used for sharing time sync data to local host and
> +	  retrives the sensors available on the platform. This also handles

	  retrieves

> +	  the device connect/disconnect programming sequence.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
