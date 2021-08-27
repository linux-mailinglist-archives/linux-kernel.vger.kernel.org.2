Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4133FA0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 23:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhH0VLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 17:11:01 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:47424
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231570AbhH0VK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:10:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P29/WIdyCVADs/ERNOfaAc/Vr8CU8PrQ5nI5UxoMs5sY1VDTptPkRp9hwUk/Tb1QgnaLQfRXwKVyXZ1TecPHswl0IRjDwN8r9hTZ4qzAArpTEMwTLjTmWkOpaya0HpNBKwAqovqcEYMx/pnbWn5QCQYfxuE+nge/vnsqWd3AuvlwBhQTEq8Z+fGDcZhmh0ytHLBYLNcetBndgC5ozh05A/MFzWQnHJaT5xrs5Rprc09el+aCOjzFVx6tYQzd20hBlvaDF43MkxTpMV0ZY7bL/NcZV/LkOOX3a9ezbahq7V1gQRozRoVSQV2RSkkuDEZYom9RDteKYfOY4lW0xPkHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia75g/CRQk6d9zuDW6C3CfeKOWoO4Xq12hFLUL/xRSU=;
 b=ifnIqdHMKtw7SnTynT7hQIl+DusdB8zuXviIMn9lxY3a73Y8pgnwYCMaFiO3DvwCLq/bggZDbCBTxW3K7/pdTO94OW9W1U6HqPf3UACNlsnRxwZ2tsPykDFdK85idEgFLjGSFdG5sSbsy/HHoi7LxTyObWVDfIm4yfcSU93OcgQFUKDgm4oVW9oH8LaVpHhfDGGzTr+ZUm+/vg7W6dE9w1AvRRayP1VyFlncGVUyyk+NvUgzFo7ibQxds7olnoq9vrIlRpsoCE3HAuO54yfgxtU4qGD1ys5l3jDBLNu6lJ/nxFF8BJhoXDu/WO3UrqEWNQnDvOLfPQzzAAXFt1l+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia75g/CRQk6d9zuDW6C3CfeKOWoO4Xq12hFLUL/xRSU=;
 b=AiH8XcbTvRIq+CL7cCe+a4DlhuMW9qBkoF0mF5nzPT1hP1NDgOfikjosbZkZZnKgIf6WrYquDpR+TRyeBtY4IrwrPD0sZpvvOierNINX6nlY6WvXMO2TAaB3SjkAoVwGPZxSDEHZTTZivADYzBz0bOTX0waiD3HIiLoLFyOJ8+4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 21:10:08 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 21:10:08 +0000
Subject: Re: [PATCH v2 3/3] hwmon: (k10temp): Show errors failing to read
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Wei Huang <wei.huang2@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
 <20210827201527.24454-4-mario.limonciello@amd.com>
 <20210827210648.GA678755@roeck-us.net>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <90d283d0-06f6-baa5-b41b-fcd2f4b3ba99@amd.com>
Date:   Fri, 27 Aug 2021 16:10:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210827210648.GA678755@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.54.68] (165.204.77.11) by SN6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:805:66::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Fri, 27 Aug 2021 21:10:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8534520e-b75d-4061-3e5c-08d9699f0ccc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4432469B9B0EDC2FA0EC1C16E2C89@SA0PR12MB4432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5e3lkZDCjcHUy/9v3wnDDh5MgbOzos8uTIK92I8C8Iuj5l+zjEq/5ebPzZTI96LBLwgouQpIm4XrYSQjKb+X6LjpL47lKwAYaL9z1tk+YGY93AqwxAabCAKYmJ8/DVnH/L6gjp3xn5fVAqhY3q6fW2RgYX1DATlo4A3BkLBGhZXBfyYGZBeVmaNVuzppFyYsOEq+C3z9hzDal+wn2L7rgZD3V1XYBjyYDVJW578lN/1+LsNJSKknei5/qFb3qVNvdrxHPleEwUOj0McJbStfrD5jKNKxUVlH4AIAIWczQQPUy6P8Kr6xbF3ePS7sqxP5LBaLdsyq65SUb5dWTMQwa+mF35bcdqNsCtsrnTro24cjAr8/LZaGHIaWZppj+bImQ4/Ee40dCF0V9gqTpDwO5oPoX/zXZ5BndokRBJprR8H7hkg8QDsQarL/pfPspuj35nf7xzFFnRScMdkPRAINLMFFLyDbHRDTlx0e5oIQ7QWveEq8TYqZbbY0Cz/lkqRoQRkYVbe8f8eibJ0miB48scYeVY02sOo1PpSA68iEvCrtFAsLkp7IPXFoVvS/w405gAypcNTlvQT5kg04KN1yBS59FpSHVlcYxVxvsBf0WceR2qoSis807dT+nT521ysWagajT2omgKtzVMPnOV7P3HvC44Jo5e2Gv33xqVe6VMuqtoMOaMyCK5a2ECOiUrUu1C8m0UCLlg0zKXY01UdgDswnUuPIB1PqWK82NPTRrEU6wobzaEOaIxllktEzXin7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(2906002)(6916009)(186003)(86362001)(8676002)(54906003)(316002)(31686004)(5660300002)(4326008)(31696002)(16576012)(6486002)(66476007)(66946007)(66556008)(956004)(83380400001)(2616005)(478600001)(38100700002)(36756003)(53546011)(8936002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3pLaGZjZHVBVjZyNGY1SUY0UDJQYUZYelVKZHNwaFRSS2prMnNIQ0I1RVJS?=
 =?utf-8?B?R0tuVTRueUxMM3YzeUFIMzdWRm9zQzgxTnI3amIzMFMwVnVGMlNya1VRRXNV?=
 =?utf-8?B?a1g1Wk5udUw1NXRyZjdIeUNIb2h1MzBDbGdGZGtnQ09sSmZuckh5SThEckZh?=
 =?utf-8?B?ZHhNK2l2V1RPTURCdWtQeU5CYjZ2ak9tOWZqLzRlVWhuWXRzSGYxRm9Lc0hp?=
 =?utf-8?B?cUJ2UHpwU2JJL1BOdEhqMDczMUQwRHUxY1prVUNpYUFac2p6R1UwQ2lERzVv?=
 =?utf-8?B?WkdiUmFhWlMycCtZZThuVUh2bEFUNUNRRDRacTRjUHhndWF0dU9jK01yTWNW?=
 =?utf-8?B?WHlLMEJqOW4vdEt5cUZVRWJ4TmlweDZUUXM4eEJvelp0TStYNnBtbHV0bFdk?=
 =?utf-8?B?bVJRUVZLNHZPN3E0V0N6cUY0U3N1cVhpVVlWK3N3SlFJRjZnNkZkRHQxR1Zn?=
 =?utf-8?B?WmM3V3dUUkNqcVg4d2puL1R5UTAxRVV4N2JTRWtma3A4dGNUMk5oY1RheVBV?=
 =?utf-8?B?YkxCNnpuSy9qNEcwU0JzYkdkK3ZJSjk0NVF0Ymh1NDYxbDM2WjFFYmpIdE1H?=
 =?utf-8?B?TXlCMWtjYmVqeWxKaWIyUUZaZGxZaGJTQlR4VmZuWXZGWlpTMnFzdDc1aStr?=
 =?utf-8?B?aWF0WE5zUFlsbzlPRGFUSVN2cEJ1TUdsUjVlbFlEMkluYU9iNlZqNENkakg1?=
 =?utf-8?B?aEtQUENYV0FwK3o4Y2tldzAvcWU0OVdUUElPWGpKSFVsUUREdVhKQmFBN1hX?=
 =?utf-8?B?VnYrYjFFUDIzemJFdmdHTS9JVVRYSXRTMHVRS0V2TXlVS0FBTGxCNUF6UHM1?=
 =?utf-8?B?c0RYU3prWFNrdmwrVVRBbWV4VVdNY1pxZnQ5ZUdsbE85YWo1dkxhNDFPM2tu?=
 =?utf-8?B?a29Hd2cvWGZ0Q1BYOUszQjNoVTl3OTgrNlJpS29PanFoOHNGUWd3UDhnMHE4?=
 =?utf-8?B?RFVPYTRFcnJRd2JLTGNOMjBYTVZUdXZ5TW1WMnByRjBLc3Q1ejJidVk3WTdl?=
 =?utf-8?B?MS8wQldCaTg3UFlKV0xlcVR0RFpySG5sNlM1Wm9kRFlqQSt0VlRra2NuRmZC?=
 =?utf-8?B?Q3BrbjdiVUlNMnlLMlVsWnRscmN1Yy9BMmIramhxT1lmVUt4allJaUl1WWZ4?=
 =?utf-8?B?YlgzWmdBRUFCWTNhR0x6NWZyZWRoamRWcFJyM0JaU2F2VHdJWnVnSEFpTFp0?=
 =?utf-8?B?WlZPbnMzYjRWWkhaOEJrbmZYMTdWZFpsbkUyTHljNDZtSFNtQjhWd3Y1L1RK?=
 =?utf-8?B?SExra09ZbFo0dDc2WWFEK3lZdmJtRUlCWml1Vi9ERGJyNE10NmJqVmxBZjNS?=
 =?utf-8?B?SEtNclFEWGFyL2U2RktBZTB3SkY3ZitpaFhtNGRzK1JHL3k0R0tXaHg5MG4v?=
 =?utf-8?B?MWpDZkovRkV4elpRS0VmL2QvUGFiNGg2S1JIbk5Kb203MU95M3UvZk8wSGNq?=
 =?utf-8?B?NERUaXNINytoMndpN0JqMGxJb1o5OFpacXhVSWhzUlZBMDRYQnJqMUJjckYw?=
 =?utf-8?B?VmxqTDNNMThmbVh4dzN5RUMwM0x1ZlFOS2szR2QvNUdnN0RSbVdOS3BwaTBn?=
 =?utf-8?B?d1d2cCs2RlBDT1dUemRPbjQ0NWd2ZUpBMG1uYjNoUnFhQmlEMGZkKzJaRjhH?=
 =?utf-8?B?Sm9FVUlnV0ZrUXVJVitjeU12WFVHc0tjNUgydWprQjU0clp5QWdTRmN2MTVD?=
 =?utf-8?B?Q3IvQ0hGRW0vdFZyTktmT3BvMGljR1BLYy9sSTF6VUJ2Qy9XaVQ1NmFBUmln?=
 =?utf-8?Q?2ziR3bzExIU9GBaQS/1c1Uo9SSspQ0dbUh3p96H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8534520e-b75d-4061-3e5c-08d9699f0ccc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 21:10:08.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uctxn7tRlAOikAc11A/WPwqojrOpXxqlLdAz2yKPUQpuQTEORzCs7mr4bs2FLaTPcQPy0R4mIDQQ9SIeXzpAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/2021 16:06, Guenter Roeck wrote:
> On Fri, Aug 27, 2021 at 03:15:27PM -0500, Mario Limonciello wrote:
>> Enabling Yellow Carp was initially not working "properly"
>> because extra IDs were needed, but this wasn't obvious because fail values
>> from `amd_smn_read` were ignored.
>>
>> Don't discard errors from any functions providing them, instead pass up
>> to the caller.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/hwmon/k10temp.c | 87 ++++++++++++++++++++++++-----------------
>>   1 file changed, 52 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index 38bc35ac8135..2edb49d39d22 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -98,8 +98,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>>   
>>   struct k10temp_data {
>>   	struct pci_dev *pdev;
>> -	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
>> -	void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>> +	int (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
>> +	int (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>>   	int temp_offset;
>>   	u32 temp_adjust_mask;
>>   	u32 show_temp;
>> @@ -129,55 +129,65 @@ static const struct tctl_offset tctl_offset_table[] = {
>>   	{ 0x17, "AMD Ryzen Threadripper 29", 27000 }, /* 29{20,50,70,90}[W]X */
>>   };
>>   
>> -static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
>> +static int read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
>>   {
>> -	pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
>> +	return pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
>>   }
>>   
>> -static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>> +static int read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>>   {
>> -	pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
>> +	return pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
>>   }
>>   
>> -static void amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
>> +static int amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
>>   			      unsigned int base, int offset, u32 *val)
>>   {
>> +	int ret;
>> +
>>   	mutex_lock(&nb_smu_ind_mutex);
>> -	pci_bus_write_config_dword(pdev->bus, devfn,
>> -				   base, offset);
>> -	pci_bus_read_config_dword(pdev->bus, devfn,
>> -				  base + 4, val);
>> +	ret = pci_bus_write_config_dword(pdev->bus, devfn,
>> +					 base, offset);
>> +	if (ret)
>> +		goto out;
>> +	ret = pci_bus_read_config_dword(pdev->bus, devfn,
>> +					base + 4, val);
>> +out:
>>   	mutex_unlock(&nb_smu_ind_mutex);
>> +	return ret;
>>   }
>>   
>> -static void read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>> +static int read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>>   {
>> -	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>> -			  F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
>> +	return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>> +				F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
>>   }
>>   
>> -static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>> +static int read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>>   {
>> -	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>> -			  F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
>> +	return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>> +				F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
>>   }
>>   
>> -static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>> +static int read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>>   {
>> -	amd_smn_read(amd_pci_dev_to_node_id(pdev),
>> -		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
>> +	return amd_smn_read(amd_pci_dev_to_node_id(pdev),
>> +			    ZEN_REPORTED_TEMP_CTRL_BASE, regval);
>>   }
>>   
>> -static long get_raw_temp(struct k10temp_data *data)
>> +static int get_raw_temp(struct k10temp_data *data, long *val)
>>   {
>>   	u32 regval;
>> -	long temp;
>> +	int ret;
>>   
>> -	data->read_tempreg(data->pdev, &regval);
>> -	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
>> +	ret = data->read_tempreg(data->pdev, &regval);
>> +	if (ret)
>> +		return ret;
>> +	*val = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
>>   	if (regval & data->temp_adjust_mask)
>> -		temp -= 49000;
>> -	return temp;
>> +		*val -= 49000;
>> +	if (*val < 0)
>> +		return -EINVAL;
> 
> Please don't do that. More on that see below.
> 
>> +	return 0;
>>   }
>>   
>>   static const char *k10temp_temp_label[] = {
>> @@ -212,24 +222,27 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>>   {
>>   	struct k10temp_data *data = dev_get_drvdata(dev);
>>   	u32 regval;
>> +	int ret;
>>   
>>   	switch (attr) {
>>   	case hwmon_temp_input:
>>   		switch (channel) {
>>   		case 0:		/* Tctl */
>> -			*val = get_raw_temp(data);
>> -			if (*val < 0)
>> -				*val = 0;
> 
> We have to take the history into account here. A negative value
> is not an error per se, but it suggests that the chip returns wrong
> data. See commit aef17ca12719 ("hwmon: (k10temp) Only apply temperature
> offset if result is positive") for some of the background. I don't really
> want to change that into an error return just because we don't know
> what the chip is doing. Please retain the above code, either by fixing
> the values up here or in get_raw_temp().

Actually I thought what I was doing *was* making it a lot less ambiguous.

The caller getting -EINVAL from get_raw_tempt will indicate that the 
data shouldn't be trusted rather than a surely wrong "0".

> 
> Thanks,
> Guenter
> 
>> +			ret = get_raw_temp(data, val);
>> +			if (ret)
>> +				return ret;
>>   			break;
>>   		case 1:		/* Tdie */
>> -			*val = get_raw_temp(data) - data->temp_offset;
>> -			if (*val < 0)
>> -				*val = 0;
>> +			ret = get_raw_temp(data, val) - data->temp_offset;
>> +			if (ret)
>> +				return ret;
>>   			break;
>>   		case 2 ... 9:		/* Tccd{1-8} */
>> -			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
>> +			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
>>   				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
>>   						  &regval);
>> +			if (ret)
>> +				return ret;
>>   			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
>>   			break;
>>   		default:
>> @@ -240,11 +253,15 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>>   		*val = 70 * 1000;
>>   		break;
>>   	case hwmon_temp_crit:
>> -		data->read_htcreg(data->pdev, &regval);
>> +		ret = data->read_htcreg(data->pdev, &regval);
>> +		if (ret)
>> +			return ret;
>>   		*val = ((regval >> 16) & 0x7f) * 500 + 52000;
>>   		break;
>>   	case hwmon_temp_crit_hyst:
>> -		data->read_htcreg(data->pdev, &regval);
>> +		ret = data->read_htcreg(data->pdev, &regval);
>> +		if (ret)
>> +			return ret;
>>   		*val = (((regval >> 16) & 0x7f)
>>   			- ((regval >> 24) & 0xf)) * 500 + 52000;
>>   		break;

