Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE78319CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhBLKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:30:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51404 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhBLKaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:30:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CASehl132870;
        Fri, 12 Feb 2021 10:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XE/qa1Rfdkq0KbXCA0HdVUpgze8l2RX7qnHAMkjhO/c=;
 b=qXBPqUYd8G6d+kdHZAFwD+M+6ojn+79w58E+yGAPGED5Aa53O6Zfd7am3es5gSIfbx9G
 xeufapro2oAji3n+Ew1FHuJrJN075KvbV9jwe96vocURQJbZxhblp5sVN29U9DSsrYkT
 jI1mKHWSoetCYY9PuXRI5NbX8GbFaosXQlIa/LDlhVQPWqkPZYpT+MOpGVGEpYteSgsg
 TXIsI9/87JH60gvp1cJveTepOx1XnPdIh3Ne+6bn3vyHteqCj0KPz3w/NFFevQsYFYpm
 f5DMifsE3OYOdIZ0rC5sFJKDNtwBQCOU+AW5vcjbFzvWN1WGJTjw+4uuSSiVdGAWAfXq IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36mv9dvx25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:29:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CATagG104712;
        Fri, 12 Feb 2021 10:29:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 36j515ase9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 10:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btF/8CpWy9OoN9caMbhVAzzJ9EIRqUAZj5p6ZIzO2MIA+gzagwF9hBYA7fiKQNLPXlZtAD9ZBSdS5JE+QwCNHjfm0CFSNo+zqJD9QN3FETn2UhbMbNklr1ULtHlnBX0P3+dDFdEI7tskFZdJrAf13MdU9KxtiXw3NswRs7/0udoJt3OOanjyTZ27iPr8oonffS7Q8wzQ62n/PGeLoYKJU4HNHuKrlgXZKRZ2w5BaZl7JOZx8bTzmRB5yo6rpkfeiLTFvecA+4KFnlTy9t101q6B1Jht8FiFDl/UJFaceY9P9Ogbh76AkP7FoP4D/AWaRriyXSiEUdFjIk2cER4kS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE/qa1Rfdkq0KbXCA0HdVUpgze8l2RX7qnHAMkjhO/c=;
 b=a0M78rTd4Eo1LauJlWmIRGEfzH8sdnn/v7cTDYNLNf+4lD24SlNShiyd/rxwAogXTAjPVI9asp4WMjujPiaNkzWcurKslATQ5zJ55vzgzrc469LlxhW5BSztNujJiwXe8q1fJv2H9Y4xhbxBYoB0cU+m7chOhKuaMe09x3m05Ivp8XYMywapfjW3+CuvU08LCE51BJUBPuOxpsp/Ld9gFoHmmJT++Oc5z4DyGX3yu2EeIjDgJxWnePgDJEzGPrzTrXmOjdNMMCrHyCQASbBsKdAdWEq8mUskdp6wzM+U8mBehFQRuLqdg6EswMk2J7hOpq/YpcJ5JywtlieA/MV62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE/qa1Rfdkq0KbXCA0HdVUpgze8l2RX7qnHAMkjhO/c=;
 b=P1md1lKSbZcI+BEOWGAD5RHOyHhdTtU4X+z09uyKhS2hxK/fgDzoP76K1bMl7vJaL8fUAr+M/+0cADtX8EGlS3TVSyMGTGB6lCBxO0iBbbi96whj7hA4UC2JGyeGCo1DBpdXavI52RxNmNqozlya2RDb2WlvILg1l9GSL1dDQHs=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1518.namprd10.prod.outlook.com
 (2603:10b6:300:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 10:29:56 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::f48a:d4cb:d74c:48ba%6]) with mapi id 15.20.3742.015; Fri, 12 Feb 2021
 10:29:56 +0000
Subject: Re: [PATCH v2 1/3] misc/pvpanic: split-up generic and platform
 dependent code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
 <1613121426-15585-2-git-send-email-mihai.carabas@oracle.com>
 <YCZVvxxHI8mMEwTC@kroah.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <a37c9549-14e1-6a80-7163-3a56414ff3f7@oracle.com>
Date:   Fri, 12 Feb 2021 12:29:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <YCZVvxxHI8mMEwTC@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
X-Originating-IP: [141.85.241.41]
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.0.254] (141.85.241.41) by LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:192::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Fri, 12 Feb 2021 10:29:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30771697-4c27-4179-f477-08d8cf412443
X-MS-TrafficTypeDiagnostic: MWHPR10MB1518:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1518F066699A2AE0CFE3B6A9888B9@MWHPR10MB1518.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1pAmjHQP7HbiwL5g50/BgHX26vdMR+j6Dt9vi6isyYNSek7zUMi+xsJTYrHYKL3naMax44NIbXzBjJ5b0TNa7sqS52ryy2PoKdtjdqV+ROKQsk21jhxcC6hit+tFmfU9AVsoEOsNBqPgQczBgw+a0o7l/oHhj15XA19Z3s72IIPjhKzhU8LtJBq6io4UpSKXYo3X32CwuivEtVgvtnJMMMfutY3wUSPOW4Dp5tnNqoXL69GpzefJGo9TPErkzJi+TG0wmH07m2B2IA4RNTp83yLE88RiONCwuA8RVdMKeFu4HuHxi7r8IL/8B2jqp7n09vTVhrGEQnu8bLUrRyqbiBe1oz+a7WatvWMlOgrDPBiUBzSoXrNzssmqJM6gxbQkmt0g7xK/ii9kXSmO0PyJqZOKhOcD7Z+iBeN/H4Q/y52SM+LCx45ys3nTj4SULd0bxFWnw7TJV3TglaNtqTQK1fR6Z69I9f5WJ/jRM5xDTxd0W04ivYFkRYR5XwabmIj3BPsSUMuAcqjQwg4tOt11MLIR3ynk7T0RTDTQy6kJTl8rLZCjc/Ijmm83QUUOVf8Yoq4p6zIjml/rZXkkVWrOe8q0scWLHgs0w27T9JzqoPQxxGluHcB/MDq7cuZmfoZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(6916009)(5660300002)(956004)(16526019)(26005)(316002)(186003)(16576012)(4326008)(2616005)(44832011)(83380400001)(8936002)(86362001)(31686004)(2906002)(8676002)(31696002)(36756003)(66946007)(6666004)(66556008)(6486002)(66476007)(478600001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MnRDd0dVVEFPMCs0TXdKZHlCeENkbFd3cFprTDJQcmMzR1JtK281Yktjd2cv?=
 =?utf-8?B?alJHQ3FZOUdJZkh6OVZXakV4ekVjYmRTRVhVWGhlYW1qUmEvWkdHcGNIQkVE?=
 =?utf-8?B?eTlLQnZJbE16K05QUFMzbDZ5VFB5dWc3M2k1UjFGeENiY0Y1OEdPd3dKZ29x?=
 =?utf-8?B?RloyZmZpWWpPUnhNREZ4SG0yMHpkK3pEeURxOVVkOTM1VWp3V0ZGWjFxVkxv?=
 =?utf-8?B?OUZ3N0FBNSszSWVMc2FOaXBDcVp5bmVrcVArOWMwZWVpSWdqZlNpUlBWM0VI?=
 =?utf-8?B?T3VVWC9qOFBmUmlYVTlCZkxuQ01rRS9nVFlHR3F5aDE4V0prZGxVamhySkV6?=
 =?utf-8?B?UkdCSjJpa2g4NjYyYTRkRHFjQldMU21Ib3BQOU5FbmdxUzAvVE5DSVpKYzI4?=
 =?utf-8?B?Tnl6YXNuNUJtMFgxVDdGa29yNUxaaXVQOC9rVE9rb0Excy9hL1NZa21WMjYx?=
 =?utf-8?B?bzZPU0twTE1jc3NncGNQU0JnMlpqNzNZdVlGSDJma3ZZQUxZaWpmNk1IZHpZ?=
 =?utf-8?B?OENyenNLTGdaQTA5RUEybFpOWkxjY21ndTFVOTNJUHRnS3JiNjlPT2tBTDZO?=
 =?utf-8?B?TU9xRXd3ak9VQnZJRkFGeFQ3RFpJU0ozNmozbHMvQVRJT1FYT3RHK1V5MlZC?=
 =?utf-8?B?M3Npa3F4OFRBSmFvMGwwUHdycGgzMWkvNnlJY0d0WmpoYTVkbWhQN1lDWDNh?=
 =?utf-8?B?aGNhN09lc3hHcERHYm91cHRDOTRSSmtxMndiSFBsb2xoa0VvaWVHWklaaEVx?=
 =?utf-8?B?TDlRY3d2Z3JSS2MwS0pXUzJiRkUwdkNzNFk3ZkZUUkp4Vmd4U0FuRXlwV2Vm?=
 =?utf-8?B?ckpaRHczOCtXNm1lTzMrcUQvUDhDYkpSczlyRERjRURiRW5GV1hHTGF0QVhs?=
 =?utf-8?B?SS8wTEFkak4rUkNjcDlYV2J4ZTR0c3ByMVdPYmsveCtEMkVyWTM2V2tjUEdN?=
 =?utf-8?B?UkZjOVpLUTZMcVhOclJISFFvWXV1MjhZVjQvRjNKK3h3MGNrR21lTS92cnVk?=
 =?utf-8?B?SmRoRDFEREsrK0xsUy9Ta0JkZjFRMStlTEZGUEUzVkFZVkw5ajdPbmlQaVN6?=
 =?utf-8?B?b1ZRcGhqK1oralZUZXlXNmNxblJlK0ljU0NGeEFGL3BVNTAwTHlRQVVVSjBz?=
 =?utf-8?B?NytLZExVaFMyRGk1bUJOSjNhMTNMc1liRkhLWFZJcG5LZlQzNVBKTkFWWHZS?=
 =?utf-8?B?NGZEcm9Lcys3S2gvS1U2ZHM1MjBuYTBqaXBWdW43dXVJZEtNLzhMQWdLNzBB?=
 =?utf-8?B?LzhxaFZ4SE9wQnRUVitWbVQyZHlSUHhFb04wN1VBeG1uU2hXSE9LOWNITGNR?=
 =?utf-8?B?bXVldTVrK2lVT0piUTlYeEhTZkI2NmdtWXhaSTJCNExJRUZabXF3WjhEUlNF?=
 =?utf-8?B?TDc1a204a3AvbHA1Zk12ak52cVN1SjJlWDk3TFFneC9LZ3J3S1pSVHJ2WER3?=
 =?utf-8?B?NmVkL2xwZE8rK1BqaEU4QzRidkhFTnE4WHVPN0NuMTlIZUdiSHBWU0czNkUw?=
 =?utf-8?B?cFo2MGJhQUI4Wjdnd0ZHYko4TFFmQ2syUXRybDVCRTlSQVpPTGZNc2NpWGRm?=
 =?utf-8?B?UUxVSG9vYkZ2VTdZMGQ5NUp0ZXgvSUxpSmtZbXo2MjJTcktrNFhDNHkybVMz?=
 =?utf-8?B?YVVlbys5UENQRVdEU1hnQmY0SU5QQTRNNS9HUzVJT1FsZmRmcGdQbU5xV2xz?=
 =?utf-8?B?VEo5TnJqdGtpZUJ0L0hYdHN2dWplL2hqVWVCWS9ORys3K0dQbzZxRzJwa0V0?=
 =?utf-8?Q?dEyBkuoC8spJRVkIfixOs/L9M5ChdxxEBqawxfk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30771697-4c27-4179-f477-08d8cf412443
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 10:29:56.2921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KMwRauKSJduLyKqQ5cQB26e9WIxvVcNNVo3UkKd5RbsGL1B6YeoDU5cXyoZ7x7A1sZew42PAIcILA2Qcs9SiYK8+ZJDUxWwCDTn8qozzgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1518
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120080
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..snip
>> -};
>> -module_platform_driver(pvpanic_mmio_driver);
>> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
>> new file mode 100644
>> index 00000000..0dce6ef
>> --- /dev/null
>> +++ b/drivers/misc/pvpanic/Kconfig
>> @@ -0,0 +1,12 @@
>> +config PVPANIC
>> +	bool "pvpanic device support"
>> +	help
>> +	  This option enables pvpanic device driver.
> No it doesn't, it allows you to _select_ a specific pvpanic driver, on
> its own, it is not a driver, right?

Yes. I will update the comment.


>> +
>> +config PVPANIC_MMIO
>> +	tristate "pvpanic MMIO device support"
>> +	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
>> +	help
>> +	  This driver provides support for the pvpanic device.  pvpanic is
>> +	  a paravirtualized device provided by QEMU; it lets a virtual machine
>> +	  (guest) communicate panic events to the host.
>> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
>> new file mode 100644
>> index 00000000..9ea3355
>> --- /dev/null
>> +++ b/drivers/misc/pvpanic/Makefile
>> @@ -0,0 +1,2 @@
>> +obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
>> +pvpanic-mmio-objs := pvpanic-common.o mmio.o
> You put the "common" logic in the mmio driver?  How is that going to
> work for the PCI driver?
>
> Why is there not a pvpanic.ko that contains the "core" code only?

My intention was to put the code in both drivers. There is no generic 
module as it will complicate things: the generic module would have to 
have its own state (e.g. pvpanic_probe would have to create a queue of 
base addresses).

Do you want to see a generic module pvpanic.ko with its own state?

Thank you,
Mihai

