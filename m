Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2A5339423
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhCLRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:00:24 -0500
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:36338
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231789AbhCLQ7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgUcIwi5It5Kf7jsRxLmkj8XorWLy5GILpDsODFiwS/U9P1IPb8rQWFXYxkpIb190mNN/OzjNDnVhPIHb0xG6lVMAsrbVJO4G6AME6jvNr70EA80DkB/h706OhL3Wmd2dB+bK4IqbbFu/F5xMeoAJ46YJHWm6v6mVrYhIsVuyWuADTRXveazzoXqjMq2gSZIPwLBgiaRrQa1QrDedDUm2LExijeKX0/pDqeoUEnJZrDYVxZ0YlZkXNGKaMg7ErUlIc18pMqAT+k9KJwfmWnHpjGytSND7YIHv2cYCkyn2Ra5By6mdG+utau4p9PgG5P3081DLg1sgQTDw5USsHr4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRMCZQ/5W+V/ZE4rWgRPXScex3edLaDksjQrBpqCBHg=;
 b=n5mbW5NKBseC5uV8tEsKNeqrSqggIuJifvhsXNCuOmWZZVn2F1n4fKwtaI5TOacnDgoEKVRhOD16WRxBdZoRmlS7c28W+jstnB8SJ3GxkdRwGxy3zGhoLaTtjBw8VzOs10Uuz5M0G9zrLzPxcWsgpl+fBtAQ+jtoyJSVVXEavPXq5VzE7ziXwyNhLrOj/IYvUs/5OSeQOkutVCdhKIDNjm7SKxTphrobjEfOZXriviKM3JKV66YKLXzR/L7GLK58mXssbMUlf5GBmGoKlySi93rj9GGh2pfH9HGo7WyJ55P37xedo/0Nbj/txd51OteibtK/844KcxXFwZBDAD7F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRMCZQ/5W+V/ZE4rWgRPXScex3edLaDksjQrBpqCBHg=;
 b=S8xUgdMu4Fcbwy820SEmTx/pczgBLI5hMRf5WGqg3C234fVL/gQu8EPP5kt29/8+CZ4VnkiXN4GB34mRTwJgmVOdQ1KY5T5nUMWuhD4ma+dFBgNUHK9jTfJ0SVGPQL+uNmcxC8n5I39JAp9gX89/l1fdWUYxtmTnLy/yNFXERgnqzJb0B+uOAyWEvioIqE8vURFkb1paK69zKYIl+Ro6WBbzpK0RnTU14SYssMJXiX6HTPI/hmX0RY5QOK2ZWfixy7Mf5nD0PX1sQ3+bipM0TCLYZd33LMoLiqNtqs/UGO8jih6GGQxc4QaGZnL2X89+LFQCrYFjQdzjWMGjVm/BBQ==
Received: from MWHPR1601CA0002.namprd16.prod.outlook.com
 (2603:10b6:300:da::12) by DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 16:59:50 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::cb) by MWHPR1601CA0002.outlook.office365.com
 (2603:10b6:300:da::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Fri, 12 Mar 2021 16:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 16:59:49 +0000
Received: from [10.26.49.11] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Mar
 2021 16:59:47 +0000
Subject: Re: [PATCH v1 2/3] driver core: Update device link status properly
 for device_bind_driver()
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Michael Walle <michael@walle.cc>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-3-saravanak@google.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b0171cd5-0145-eecd-5849-a4867704a0d9@nvidia.com>
Date:   Fri, 12 Mar 2021 16:59:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302211133.2244281-3-saravanak@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b22a405-f3e8-4e47-1d39-08d8e5783f97
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4123CE16EFC2746326E0BAA8D96F9@DM6PR12MB4123.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sa/QNBODloz/DMlcPHEEtA/8TFzcqPjwy8u6nXumljWJMK9HhG8oRYHZHusMSwnn4PzC9U9PlyxCFxJFIGQtKQOKFJz7RjzBIL7RuRkfG5jBFrB+cbOO4qtsd1b8e3VD9cTo4k0GzprSdzhgocAdVW6/JwWQJzaGcIY4vXP9OeRoOcuxAtQWBW6jdarIQxr8elfWirPBfGDL6UeFDJ7geMqj9Gl4S52x5NCbbGzGhPXvza1avczS4h5rnjazP0K5lK4CD96YROeLx4hxF8EMh+A8bTgJQWOBb1c5ezJPHWlsRbJGSc1BiLIoEz01IXA6ZjBX0nzNQ50CE/2H0qpA6B5SCrxetrs/XXNP53J+PRA9H0JdhPZvyycpe6jQSvZjqELC/CLYslC8IIsAuH8WcYnoROfJCGNgbfIelta8wBibUH7O05xANm0QeZuXGv4IT35mYsvYfconcKQly6NQyi9w9UdZ6WynUWJ5PIO7GS/z0pYmbN6O7SLkSKNIVuabcrNSP1p/V4q1TcXOdZRLq4LfTFxvqQBfjqI2RV614nvagDs+eIK5cjEcLOatCMRyodL9aaGbQQJBbhc5Tr6OAS422Hl3VebvQaZt55Haz6beCyhy+GPcZeeMqlgcpRGF6n9SbIgm0a3e8miSSJiF03RQvyI2a97R4FZ2g96KZiRj3e3VfOicKqXbV1+ZFx9XH1a7JS5RifYqCB0ojMHJovBm9gzGAoPVsO5gnyH/RLLDqVnn9KiLfwFcroQgfj0D+cjIfX57CCmsxWDXIfZZ+0ZEaqMwyAuiH+CJDOWzMX0=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(36840700001)(46966006)(16576012)(8936002)(26005)(336012)(426003)(8676002)(31696002)(110136005)(5660300002)(316002)(36906005)(54906003)(4326008)(15650500001)(2906002)(16526019)(186003)(31686004)(2616005)(966005)(36756003)(356005)(70586007)(478600001)(86362001)(47076005)(34020700004)(83380400001)(53546011)(82740400003)(7636003)(82310400003)(70206006)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 16:59:49.8009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b22a405-f3e8-4e47-1d39-08d8e5783f97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/03/2021 21:11, Saravana Kannan wrote:
> Device link status was not getting updated correctly when
> device_bind_driver() is called on a device. This causes a warning[1].
> Fix this by updating device links that can be updated and dropping
> device links that can't be updated to a sensible state.
> 
> [1] - https://lore.kernel.org/lkml/56f7d032-ba5a-a8c7-23de-2969d98c527e@nvidia.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/base.h |  1 +
>  drivers/base/core.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/base/dd.c   |  4 +++-
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 52b3d7b75c27..1b44ed588f66 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -185,6 +185,7 @@ extern int device_links_read_lock(void);
>  extern void device_links_read_unlock(int idx);
>  extern int device_links_read_lock_held(void);
>  extern int device_links_check_suppliers(struct device *dev);
> +extern void device_links_force_bind(struct device *dev);
>  extern void device_links_driver_bound(struct device *dev);
>  extern void device_links_driver_cleanup(struct device *dev);
>  extern void device_links_no_driver(struct device *dev);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f29839382f81..45c75cc96fdc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1153,6 +1153,41 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(waiting_for_supplier);
>  
> +/**
> + * device_links_force_bind - Prepares device to be force bound
> + * @dev: Consumer device.
> + *
> + * device_bind_driver() force binds a device to a driver without calling any
> + * driver probe functions. So the consumer really isn't going to wait for any
> + * supplier before it's bound to the driver. We still want the device link
> + * states to be sensible when this happens.
> + *
> + * In preparation for device_bind_driver(), this function goes through each
> + * supplier device links and checks if the supplier is bound. If it is, then
> + * the device link status is set to CONSUMER_PROBE. Otherwise, the device link
> + * is dropped. Links without the DL_FLAG_MANAGED flag set are ignored.
> + */
> +void device_links_force_bind(struct device *dev)
> +{
> +	struct device_link *link, *ln;
> +
> +	device_links_write_lock();
> +
> +	list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node) {
> +		if (!(link->flags & DL_FLAG_MANAGED))
> +			continue;
> +
> +		if (link->status != DL_STATE_AVAILABLE) {
> +			device_link_drop_managed(link);
> +			continue;
> +		}
> +		WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
> +	}
> +	dev->links.status = DL_DEV_PROBING;
> +
> +	device_links_write_unlock();
> +}
> +
>  /**
>   * device_links_driver_bound - Update device links after probing its driver.
>   * @dev: Device to update the links for.
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f18963f42e21..eb201c6d5a6a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -460,8 +460,10 @@ int device_bind_driver(struct device *dev)
>  	int ret;
>  
>  	ret = driver_sysfs_add(dev);
> -	if (!ret)
> +	if (!ret) {
> +		device_links_force_bind(dev);
>  		driver_bound(dev);
> +	}
>  	else if (dev->bus)
>  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> 

Thanks, this fixes the problem I had observed.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
