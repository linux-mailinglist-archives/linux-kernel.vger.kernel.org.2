Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4393087CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhA2K0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 05:26:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35726 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhA2KZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 05:25:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10T8Hd7t059383;
        Fri, 29 Jan 2021 02:17:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611908259;
        bh=I9PkR8FW728GQCsm4YJ9ZUBoOdip6+dqZ/a/vkZDoUc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pWy7EV3ovEIHmshk8CT2egZtnYdI39J+b0/+0Kd+Kw/5PnwZGJZtqC/ajIfr0MFfN
         XLSejXunhoFJPtU6AkDqg85p76eOy8V8Z76ytq3wPRye0pT4pwUZDo69+yq5J/aHM1
         QpniWQiQNz8Nh9B7yxmCYOIwX14olUf/FuTn+U8U=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10T8Hdlr114200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jan 2021 02:17:39 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 29
 Jan 2021 02:17:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 29 Jan 2021 02:17:38 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10T8HaOc099863;
        Fri, 29 Jan 2021 02:17:36 -0600
Subject: Re: [PATCH] PCI: endpoint: Select configfs dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210125113445.2341590-1-arnd@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <98b28941-68b6-5bf9-7a23-874c6ecd0918@ti.com>
Date:   Fri, 29 Jan 2021 13:47:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125113445.2341590-1-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Lorenzo,

On 25/01/21 5:04 pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added pci-epf-ntb driver uses configfs, which
> causes a link failure when that is disabled at compile-time:
> 
> arm-linux-gnueabi-ld: drivers/pci/endpoint/functions/pci-epf-ntb.o: in function `epf_ntb_add_cfs':
> pci-epf-ntb.c:(.text+0x954): undefined reference to `config_group_init_type_name'
> 
> Add a 'select' statement to Kconfig to ensure it's always there,
> which is the common way to enable it for other configfs users.
> 
> Fixes: 7dc64244f9e9 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Since I'm sending a new revision of NTB driver, I'll squash this patch
with the driver patch and add Arnd's sign off.

Thank You,
Kishon

> ---
>  drivers/pci/endpoint/functions/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 24bfb2af65a1..5d35fcd613ef 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -16,6 +16,7 @@ config PCI_EPF_TEST
>  config PCI_EPF_NTB
>  	tristate "PCI Endpoint NTB driver"
>  	depends on PCI_ENDPOINT
> +	select CONFIGFS_FS
>  	help
>  	  Select this configuration option to enable the NTB driver
>  	  for PCI Endpoint. NTB driver implements NTB controller
> 
