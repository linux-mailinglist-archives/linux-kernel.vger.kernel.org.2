Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8B38C75D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhEUNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:02:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48464 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhEUNC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:02:28 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 510932329d31bd57; Fri, 21 May 2021 15:01:04 +0200
Received: from kreacher.localnet (89-64-82-20.dynamic.chello.pl [89.64.82.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 701CD6696D3;
        Fri, 21 May 2021 15:01:03 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        kyle.meyer@hpe.com
Cc:     Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver exists
Date:   Fri, 21 May 2021 15:01:02 +0200
Message-ID: <4656572.31r3eYUQgx@kreacher>
In-Reply-To: <20210518193455.192796-1-kyle.meyer@hpe.com>
References: <20210518193455.192796-1-kyle.meyer@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.82.20
X-CLIENT-HOSTNAME: 89-64-82-20.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedgiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedvrddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekvddrvddtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihlvgdrmhgvhigvrheshhhpvgdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 18, 2021 9:34:55 PM CEST kyle.meyer@hpe.com wrote:
> From: Kyle Meyer <kyle.meyer@hpe.com>
> 
> Revert part of commit 75c0758137c7a
> ("acpi-cpufreq: Fail initialization if driver cannot be registered").
> 
> acpi-cpufreq is mutually exclusive with intel_pstate, however,
> acpi-cpufreq is loaded multiple times during startup while intel_pstate is
> enabled. On systems using systemd the kernel triggers one uevent for each
> device as a result of systemd-udev-trigger.service. The service exists to
> retrigger all devices as uevents sent by the kernel before systemd-udevd
> is running are missed. The delay caused by systemd-udevd repeatedly loading
> the driver, getting a fail return, and unloading the driver twice per
> logical CPU has a significant impact on the startup time, and can cause
> some devices to be unavailable after reaching the root login prompt.
> 
> Load the driver once but skip initialization if a cpufreq driver exists by
> changing the return value of cpufreq_get_current_driver() from -EEXIST to
> 0.
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 7e7450453714..e79a945369d1 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -1003,7 +1003,7 @@ static int __init acpi_cpufreq_init(void)
>  
>  	/* don't keep reloading if cpufreq_driver exists */
>  	if (cpufreq_get_current_driver())
> -		return -EEXIST;
> +		return 0;
>  
>  	pr_debug("%s\n", __func__);
>  
> 

Please resend this with CCs to linux-pm@vger.kernel.org and linux-acpi@vegr.kernel.org.

Thanks!




