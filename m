Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877373FEC2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbhIBKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:33:16 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:5260
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233714AbhIBKdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:33:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnA5GCnW4DXbAW2swxJ0TNRQCsNBxwcJ0N/aytiOQmEeVMxpypFotvQtz8TlY3aPNo9HMJwtFjE+RzsgIy2OG4vvthxobrlTAP1nBjpmxBpc4s5TGCSKF2+6WzDEu+AL6M0fsE/jkA26AEpdvTmSxb9vZKLRb13+Kp4Aaa4N6AXYGzrUAwKmVsNVOJI39klNAv+Z0uV6wLYfmpgwoLJTp+jOk4lt0Docy5MSgiIm6Ndb0NaXpCN2VLSTZPDXbMvNfiB+F60lvpee+LyLIie70QbbT3U1jyEYBXwUyH+A1Vhk9vQIFof9ioHXLeHTGzSlD0TytonhqRM3vP6KE6LrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rJ5dk3yBYugpE7yPp0jef2EAyWo5qZJhtsiEjwCxCs=;
 b=VE+sHMGp1354qevhUAW2/nYBDdS3lzO22/DRfTBujoeBWgX5O/UrLE1/bdaev/w+t/hXrAke1YdVhSS4YqEiduFxs9gVL0v6vnIPbGkjhJnoRrjLSawc8ryyg/fly8Qgg3DjiBLickT7yj0ptZ5KkUXPqKJi9Yt2xkJKfcUCyW4233yFqj6gWRGe7cp5csaOYGsgUDyGvWZWthGL01JQukVdm+14mspP32u60QZQ30sxF3rY5K/tz60JelCWETc58OscC/0G1ijkWwgLLYnUZ/tENjlRlbKYjUnl3CGwY7GP5taKBItqlkJSfaCVuWB+Z4kQaAeD84jCOMoqNk1cGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rJ5dk3yBYugpE7yPp0jef2EAyWo5qZJhtsiEjwCxCs=;
 b=SoFhzkWjp9AIFAzWJ7/34zpqbsv/wk9qmF73xsHxnsdWFMtBXn/TXmgy+qjENXhZLIOVEJ+BOFqZkpvOAJcJi3xWNqEiiolEOKGKrirmVlIm1QRcf2BoxTw//V2q0uwaFwuDvFNN+36YQtDJpxztXbpw3SRdI0oteEhoR9+z01k=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 10:32:09 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 10:32:09 +0000
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
To:     Nirmoy Das <nirmoy.das@amd.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20210902102917.2233-1-nirmoy.das@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3f34d9a7-d5cb-5b41-7813-11d75eb25f0d@amd.com>
Date:   Thu, 2 Sep 2021 12:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210902102917.2233-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:eecb:a21b:e309:246] (2a02:908:1252:fb60:eecb:a21b:e309:246) by PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 10:32:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77597c99-d4c4-4cc3-63dc-08d96dfceb05
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3693B8E1B75256EE4C105FB083CE9@MN2PR12MB3693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnGo1E2oOR1WMDnpgv+Qjf7T3x09MThaOVqnbeRR2Ct7/3m3rdK+81iz+26S/OWgiYTsgci5f7FzhXN6ORbTbCkef6hQ7w9z2/SF5VkGdPlKKfxeya7qPdMDeI2lJM+PRm1Leg6Cm48KKHr/ezaCZAVXL223eKDRjMPuOCMOSGbiyeCMSExemzxZ3U3NVYk4gaXCuEpVHvx5YVD+4y5XPto+tSWBl28QMCO30q2wXYlepVCI68SDOdrpXdq7V1Q5DZAG9oJNhUmNsBwAvxOPlBooW4+7wWZWZuGSBhBNyDGe6SD/An+yohwMeS1LrXvuyZ1gS7A0YVDIrkFfWnAhSM/cj/yqcM61Li2ygk4tDVrMYMoeXXCaLC1OAilxNv5qK8U1IKtIJL8mF9h4WMNWbCxljcwzVqv8LU+VM77EBCbsxX6EyC5wX39zZC7GZcGtH4DXY827wI8ZcOtATDqFEpmilzRerYqBgFiXDV5alJDewEa9y4xG2CoP5qJJlKzuW3CO7wHVCEVhiF5eFhqRMpBV+hvIc2T/M3IOC0qPrban2WED4tsgP0gbReX42fzAsyeps6438yRmKMKEbQuzyoHMobd+Mblf3snt7mgWtfB1/IQbHaR1eQpeX4JtWLoUSTJTNxJ+ORjgEPZVq2uMJAMGz7sypQz7bdXRTnBv7iHSwkfsSfSgReiQshGai0uDbKQBHAYqqNIdQIcD7LmXD9x8CSiEKNdyRyt5dj7f0bY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(38100700002)(66476007)(6486002)(66946007)(36756003)(508600001)(66556008)(316002)(66574015)(5660300002)(86362001)(83380400001)(8676002)(2616005)(31686004)(966005)(31696002)(2906002)(4326008)(4744005)(6666004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk5NZE5VS1pOSjVqRUdHUkgyTFptTHVMb21JN3lDMzlyclNRWlpSMGJua3lr?=
 =?utf-8?B?Z21CNVhXWVd3RTVOS0hwWWdIYnVNVEdyV1NDaFRiMEZic0tCeEJhTytjNTNV?=
 =?utf-8?B?aEdKbVdxT0N3b2RYcGo3QzdsNGVOc1dMQ3FLRk5Dc1RuVHU0UTdFalJGV3NS?=
 =?utf-8?B?QmtOREF4U2I3bWdsQWduTzRJSFlLdkpUd0tMdnlFc0cra1EvdlIyTmQzeTJ4?=
 =?utf-8?B?Y3krNEttSHZlM2MvZjRJYldWM2RNZUhYUGh3ZldXVnJWc3puZjcxWHg5QVV1?=
 =?utf-8?B?SndjcVRIWjc2SWJrQ3BtcEE3VmIvVU9meTArZUJvRWtvWERUeHV6UWVNWUl0?=
 =?utf-8?B?WVA1RmZtNm5QYjl3bFNiMlhMT3JHM0FYLy94R3hOVjNXTENhc2REV2FzZ3Ni?=
 =?utf-8?B?ZW02UThqb2Q3cFloMEh0Zm53WVIyS0ZuYWNIZkNQWFJiZ2tyVEhVL0x3NzhI?=
 =?utf-8?B?OUZQTE5LZnFuUEJleGdkWCsvdlFBK0JabWo3TTJrQXFPajNObzlnNmZFWHVz?=
 =?utf-8?B?WFlVNWoyd3dEN3VmVmdXWlVtRFBXb2hyMnFUNlhtTEpHM3lTV050YkxPd2VR?=
 =?utf-8?B?MnNicXgxVGxrZUpLQXNSVTVJQVNEak50MkZpYU42b3JnaDNySk1uYzFOK3hJ?=
 =?utf-8?B?TVdFakR4UElhdzdJNUhlRTNydjZHdEhwL0luMzZqUFVNbnpIQ1Y3NGZFNDVX?=
 =?utf-8?B?bTFTckhON2MwZVFURG41UlBnc0xZL2dsRU05YXIxbmVybkQ1VVBiRXBpV0VR?=
 =?utf-8?B?VXBCV3N6KytiMGtiN3VTNUdGWFdsME56MWs0aUZSRnJzYm82ZnFGQzlpWnhF?=
 =?utf-8?B?VzlsZk5idElLbEdXbEszVi9ueElqSGVRT3dqRHQ2MU1ZRnVFSmxwdjBpNk1T?=
 =?utf-8?B?cHhrWGNPK09HVWxaUS8yOFQwUHpZVjZUeW5nVUswTENwUk9sUWk0TGZFNFF0?=
 =?utf-8?B?UnA3MXBUV1Q4ckpBeGN0WjBwQ3N5bWhDc3NTZCtNWVM5cllpdmtNVHFPRm9K?=
 =?utf-8?B?R0ExaStqVklNV29OMk9yZ1AxSmdxOEtkSW83ejFsajNJWC9WdlVwT1AzWFVy?=
 =?utf-8?B?eTM0SVZjdGFUOGRucFBwRXZvUVhaYWozdEc4cTArMmNKWjJrNVV3Y2hlRUhP?=
 =?utf-8?B?QzcvcmJIS25tWUlucHkxREVmcVdzV0JtemVLNC8vTkV5U2puUTRQVGdUUEVz?=
 =?utf-8?B?WVBLdHhMQnRsSXcyd2R1ZzZMY2ZGZ0ZiK1QyL0IvaS9jZktnZmFOV1RZL29t?=
 =?utf-8?B?Z210Zng5NkZXdlhGVDltakduSUZmNi9FMUdHaVJYUFNWdkRCWFE5SjZmNG83?=
 =?utf-8?B?TnFadmU1eCtwN0l4R01rZFdUWVJaOEFnZVl3UEx5S3lWaWJlbFc3YmpyWjNi?=
 =?utf-8?B?MXZwbGU4M2lpRFI0K1NTcHEzY1Rkcjd0S2N2UTcrUWlaa2lwOVBOaSt2cXE5?=
 =?utf-8?B?ZEFBanZLd0x3REJDOUg4ZXI3N3JnV0QrNms1YmJZaGpObzN4a1gxMzJ6N0Ux?=
 =?utf-8?B?T0N2Mnd4ckQwT1Z3WTRWb3MwZG1VQjdXSUZzYlBMWTFIWGMyMGpmYVJSVDRS?=
 =?utf-8?B?LzltTkRvVm9lWEhyVmNGSXRoQWMrNmpYeTZRNjAyWlpPNU9IL1RxWWQrVldx?=
 =?utf-8?B?cFBvSkRaU3JieFBqOFgrZUo5UG1aSnVXbk96U2hFM2xxQmFpUGZKUjh2bHZq?=
 =?utf-8?B?bW8vOGs2Qi9MdjQzSzNLNmNYTHZEUTViZXFGdXJsWUxyZWxDV2ZTS1F6RXlJ?=
 =?utf-8?B?bVg3Yll6T0hkYnlxMCtFSEFIOHlnZ1cwczZaRTZDSFZWbmVTNDhVRWJoOWpS?=
 =?utf-8?B?Z3pIWDNhejFIbnFibi9Yc0tjN203TWJUbWdtRC9kdGk3RFIrNjd0Q20xMEFk?=
 =?utf-8?Q?cRIsjsC7PVFEL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77597c99-d4c4-4cc3-63dc-08d96dfceb05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 10:32:09.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47RQwYdF7HPU5i4rbL7nahde4B2f4sV4/OK8hl06QGIZZYMnrhYfSYs07k/Pu0/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 02.09.21 um 12:29 schrieb Nirmoy Das:
> debugfs_create_file() returns encoded error so
> use IS_ERR for checking return value.
>
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   fs/debugfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 8129a430d789..2f117c57160d 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
>   {
>   	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
>   
> -	if (de)
> +	if (!IS_ERR(de))
>   		d_inode(de)->i_size = file_size;
>   }
>   EXPORT_SYMBOL_GPL(debugfs_create_file_size);

