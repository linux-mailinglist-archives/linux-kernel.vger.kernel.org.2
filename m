Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9A31F286
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBRWuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:50:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:35419 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhBRWuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:50:10 -0500
IronPort-SDR: PXxltUC+nCXRkRD1ZCphu12L69b3/n52ZTBck7gMEGcnktVhzESg30ztCmseTu1xpneGEwEceH
 faW212by7VvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="180159390"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="180159390"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 14:48:49 -0800
IronPort-SDR: 3BbPWGw4358jO5fcFIuyRFXScJbK8dak/QttUQN57kkvj4q5/TFgX+DSB1kIA+Gfcj+TSIDEP+
 AEXLQJWBYdbA==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="367709276"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 14:48:49 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id E694F6365;
        Thu, 18 Feb 2021 14:48:48 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:48:48 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <Divya.Bharathi@Dell.com>,
        Alexander Naumann <alexandernaumann@gmx.de>
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: correct an initialization
 failure
Message-ID: <20210218224848.GB134379@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210218191723.20030-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218191723.20030-1-mario.limonciello@dell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 01:17:23PM -0600, Mario Limonciello wrote:
> On Dell systems that don't support this interface the module is
> mistakingly returning error code "0", when it should be returning
> -ENODEV.  Correct a logic error to guarantee the correct return code.
> 
> Cc: Divya Bharathi <Divya_Bharathi@Dell.com>
> Reported-by: Alexander Naumann <alexandernaumann@gmx.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c     | 4 +++-
>  drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c | 4 +++-
>  drivers/platform/x86/dell-wmi-sysman/sysman.c                 | 4 ++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> index f95d8ddace5a..8d59f81f9db4 100644
> --- a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> +++ b/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
> @@ -175,7 +175,9 @@ static struct wmi_driver bios_attr_set_interface_driver = {
>  
>  int init_bios_attr_set_interface(void)
>  {
> -	return wmi_driver_register(&bios_attr_set_interface_driver);
> +	int ret = wmi_driver_register(&bios_attr_set_interface_driver);
I have to ask if the propper fix should be in wmi_driver_register
> +
> +	return wmi_priv.bios_attr_wdev ? ret : -ENODEV;
Also, is there any point to call wmi_driver_register if returning -ENODEV?
i.e. should the call to driver register be wrapped in a test for
bios_atter_wdev?


>  }
>  
>  void exit_bios_attr_set_interface(void)
> diff --git a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> index 5780b4d94759..bf449dc5ff47 100644
> --- a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> +++ b/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
> @@ -142,7 +142,9 @@ static struct wmi_driver bios_attr_pass_interface_driver = {
>  
>  int init_bios_attr_pass_interface(void)
>  {
> -	return wmi_driver_register(&bios_attr_pass_interface_driver);
> +	int ret = wmi_driver_register(&bios_attr_pass_interface_driver);
> +
> +	return wmi_priv.password_attr_wdev ? ret : -ENODEV;
same comments as above only for password_atter_wdev.

--mark

>  }
>  
>  void exit_bios_attr_pass_interface(void)
> diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> index cb81010ba1a2..d9ad0e83b66f 100644
> --- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> @@ -513,13 +513,13 @@ static int __init sysman_init(void)
>  	}
>  
>  	ret = init_bios_attr_set_interface();
> -	if (ret || !wmi_priv.bios_attr_wdev) {
> +	if (ret) {
>  		pr_debug("failed to initialize set interface\n");
>  		goto fail_set_interface;
>  	}
>  
>  	ret = init_bios_attr_pass_interface();
> -	if (ret || !wmi_priv.password_attr_wdev) {
> +	if (ret) {
>  		pr_debug("failed to initialize pass interface\n");
>  		goto fail_pass_interface;
>  	}
> -- 
> 2.25.1
> 
