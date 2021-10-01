Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8C41E6EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhJAEvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:51:01 -0400
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:42882
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhJAEu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSavW56Zg+paGSl1SXSxbDI1I/DN3Sjo7yvlr+++wtjVzCISIhr3vexb35HexuXmF9HNoUzfpvBcGrH9cNNeYvxcfcEefMT/sxJE7HbxxZ6ComqM32RumoR10KbLvfk61VwLalyIwR7ZawlaP8RDqFoHMpjCnwQoPVQaMvrTgOMWQgqn6EeRiBeI3hJHvRAtpa+DSdv+Stms/h5sAcfCc3ak86hd1z1CdTySuHoiRN6cDXfNdQgKNZ96sZlQaGhZAS7bKoFYO1UAo9xE5He9VSodjKPdxmeNzZY2gQnlkCSH1Iqz0APzpWukK8A6ShOC92MElmfeWhIAmB9NhEswHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vZV+Gg4On0AjIuWZvS8iAax9yEFKNBa+61PsbBJgMs=;
 b=Q1csgfSKY91juFwsl41WJqtoIU0i/lgflC9zq6A3ufmkPCJkQwyPAwajjgIFvtnehge5flfn2XyaBbNHmQp7kZNgeuJ3qxwitKEgSpKjYa1yI1lOXAzTgj+PAMw5uJgjRwte9sn3hpo8kgXkJCB7SXd3vh2NJsnlg/YIdktTw7WC85LT5PbhDpE5kBH+FfDjRrgekz1vMdxYtPjf21nsg08afY4vV32nXLKzRNzWP2ng5yCLwfzgt99uktXkg4UmIFvTrUYQNq+anadF0RL/BEGVlmpNqMfn55whuCxGeqWr93VfDSBYxYFDe+3gVNfrQqkstVMa0GRDCb/c+qaQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vZV+Gg4On0AjIuWZvS8iAax9yEFKNBa+61PsbBJgMs=;
 b=w51nryNUbb3L44UBNlcB65i8ztkTN+U4DgHbGBzB+M8JumCpHursyqAauFCaTqfxYM62EuXwo+6VZ7dBubXpw3bMZ2DFAR8si9FMGIBWo+XyjLL21AXJGd3WLa4k3yvLo6aNTa0sFrx34JdGvi3NyeJf8HpP07mSTQtgij5PQSQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 04:49:14 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%7]) with mapi id 15.20.4544.022; Fri, 1 Oct 2021
 04:49:14 +0000
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
Message-ID: <30a9546b-351c-bb46-7693-4b67d53ab366@amd.com>
Date:   Thu, 30 Sep 2021 23:49:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 04:49:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f9a06f6-f39f-46f4-a93c-08d98496d14c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5150EFA361B6FDCA816C86FFECAB9@DM4PR12MB5150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdiPshQ5SFKmyqhPIovkFzUqU/OdW/EcJ7JLh710F3ZX8Lf2KND3mTYeLjH4w8ObOqj1+ZNJ40TMKZNDAwOP17ZZYx93QpJH+3o5CCEg0KyuoVERhM8P1ZQVbzZiutduM2AUVtt7273Lg3hQ1VOXJrUf6ouF9dgecN9QO700j1tsWRmy7OBxs47EaUNRe2DV38yS+7/QUetHzY1UHwS+NIjsZpT2/y4YJpYI49llU6Gad9q0xCYZErMOjYhjAshbp17s1lzRuNtARIc+gmHDDSjM4eDnAGMHXLBSXd+lyUyrCF/SDFnh3WY7/a6iddgsF7V9txIWMVU6aZ2FwuoJ+pKCC3vOwVbttHXf+Wc4SvvB0zGJOQei1RZEPgrS8BAnKgJhZ4DcjWkmXsj6iFjyBIq12uPgstuv/VNKlKF7ZBcizbnEPzQOgc2iwxyGdHSGJV9GzRj0lUiav7LihzyjubVwwQs76ayv8aCzbmQT5hVZ2z5XBPSVgSUMSMIVwCEs8JVdQn5yE+AdjaBUJ6zn+MhkHISYDSBBHXYjSQrKlUKX1oeizwZUV+wLqLsBeTYsuMNFJcetEaTCwZ6S+sQogalLXpEf6UyAr88MLirzDQaFgdbywdjSDRChZVQlv6tZoAa1QMHHFHc0z5CjqJ/LM8Y4e1AuPtiESupjMDqzWch+oytHmGPCi3EI3hDZdqlrFKMXsZ07EGVFImgBEjJcCyYi0n2Au91L/qDFHtEECzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(53546011)(6506007)(31686004)(54906003)(508600001)(4744005)(26005)(86362001)(6486002)(83380400001)(316002)(66946007)(8676002)(956004)(4326008)(66556008)(66476007)(186003)(2906002)(31696002)(2616005)(6512007)(5660300002)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulhpblhzc1hSM2IxNE8vdXZ2MHd2N0VCR3dpV2FYS0JreEdqT3pDN0srY1pa?=
 =?utf-8?B?eW9tN2hIZjZGTlVoNVdUa0FZbzR2VlZiZ1BoUEpGYVBYWXN4SUsrMTBoU2x1?=
 =?utf-8?B?a3lIa2UzaWRPSUJCMzVTK0ZNbGp1NFgrQ1l4eUhnODh6bDBJQW12TkQ2d05p?=
 =?utf-8?B?WTRDb1o4VGhDMGdNb0R3ZzVYYWh6c2tHWjVaUmtWQm5nUHhzWnE3bjFCSmFx?=
 =?utf-8?B?N3BwbkV6R3lwNWhWRERGbGw1MC9ic3E2aXlaOFU2TFl5Qkx0RzdUaFFqOWVD?=
 =?utf-8?B?aGYveWluQ29MRXFPWGRwYTU1clpEa3ArZ0RiUGlqV0grMXUycEhaOVNyS3Vw?=
 =?utf-8?B?YnFwMkNWUHUwdm11TitrdmhWM1VtWGhyQTVnSk1WbU5tc3dWU0JXbTBwVFp2?=
 =?utf-8?B?TlZaMXBUQVVlM1hNMWdrV3dBbG5yUkVwems5Zi9oWTdhbGR2WUhwR1lOUjcy?=
 =?utf-8?B?SVZhY0pmWUREMFhmRmVpbUtxWUFvQkk3MG5aKzhIZEVFNXRjSUVzVGRjbTJW?=
 =?utf-8?B?MXNmQ1ljaXpGUGtoalF6RGxGVFgwaGtmQzVmVFhRT2VWd21DVEUzNGZOSnZj?=
 =?utf-8?B?dVVObmJ0RHhUY1FVR1dHR1F6cG14bXZhSjgwUG9MNloyeHJxRzl2bjgrYnF4?=
 =?utf-8?B?bVdza25iMUtNMzNzVmNuYWxyTHdzSWhGTEdLQkIrcFo3YzZqVlYxYksvaXJr?=
 =?utf-8?B?NGFwVUdCcFA4TWRnSzVoTU5DMVNyS1BnalB3SmJ3ZWxYZlhiWDZBNXEyZ0dT?=
 =?utf-8?B?N0pFaTRFZDJlL2s3ZE9JM2dYYm83a016clZKZk5SZ1FCNDBaSjVoRGZyazg2?=
 =?utf-8?B?Wi9jRkRuMjhISWpxeFZJR3l1Rzc2NW90WFRJK3dpMXo5cytvVkRpb1ExMHc4?=
 =?utf-8?B?SG9KaVJnbThEUmp5TElkNWVJdER5eG5MZy9WcVRUb2R4dmV6V2FBckdjRXFz?=
 =?utf-8?B?V2pIVWt4SHBGQ05jQmNjSGp1bkJlNndQdmpvSk9PSXVjcXE2VkRsM2VVNWJN?=
 =?utf-8?B?SC9kYkZxS0tiZ1UzSk1WRS9wYjZUeDZlSUxJcDRmWHNRTElFZzlvemhaOXdZ?=
 =?utf-8?B?Wm9DNG5EZWlTQU4xcGZ1OXhMdnN2TFljOGVWM0dqWllWRElmNkswa1BwN2Qz?=
 =?utf-8?B?QnBCa3BYbmw2QlZ1TDN2dUdKQko0WG9OU2cvUU1sQnY3cDVRT0pMSTErbkhi?=
 =?utf-8?B?WTlMdFJPdmxsWTNDZmxXWFNMR3VxUm5pUy8rMWJDNUx0Sk5vNDNPZ1A1bGRv?=
 =?utf-8?B?UVFBckJoeTBtVDF0UGNjSTU2Zk82bGwvWXdubUs2d2cxK0ZLQkJBMlVMNGla?=
 =?utf-8?B?WHdSR0VjU3VxTjFNYkJES2NVOUZhTkZ6UEtVWm9ySmpMLzdQREY3WUZ2VVEr?=
 =?utf-8?B?ZlVPNjdsTTQxZjlpZkg1aHVML2lEL2dXdCtiR3lGNFlHTkRFZzhKV0w0MTZJ?=
 =?utf-8?B?WDF2cEZFVCtObFhrRGtTWlVWbXZYMDBsaldOejJDM0Y0MS9Xd2tmc2Y1dk9m?=
 =?utf-8?B?N1pDT1c5UkxQZGlTcC9MYUFaK0hYbUw2YWN6T0x2QVh3czArMzVSUjdkVmNY?=
 =?utf-8?B?TjdkTlZkaVZNdCt2MjJndWZ1enRCL1BXNm93Z084R3p3M1VjcGZ0WWsvUWlF?=
 =?utf-8?B?a2JYV0IwMEQrTXNIblVRODZxVzk3OWtZS3hrS29CcmlaR00rcVpJYXpvQmhN?=
 =?utf-8?B?S0tEMWFyNXdkL09rcmJpWXhZbzhkWks0K0cydFlmRGNNTVpQYWlvb3A2bEdL?=
 =?utf-8?Q?6HrnlBY9Jk0X0P63QpdsC8qKdBIVG1uIdcZmdq0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9a06f6-f39f-46f4-a93c-08d98496d14c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 04:49:14.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxka1fasTWFAeUWn+Qto2DRNqgb2kn8oo8eTsbUD9eexowwdzIovCPRx7kHf6OoRw9j5pxixjYkdzaj3DKwhyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 11:40 PM, Tom Lendacky wrote:
> The size of the exception stacks was recently increased, resulting in
> stack sizes greater than a page in size. The #VC exception handling was
> only mapping the first (bottom) page, resulting in an SEV-ES guest failing
> to boot.
> 
> Update setup_vc_stacks() to map all the pages of both the IST stack area
> and the fallback stack area.
> 
> Fixes: 7fae4c24a2b8 ("x86: Increase exception stack sizes")

Arguably the Fixes: tag may not be completely accurate, since it was an 
issue within setup_vc_stacks(). But, this is more for if someone was to 
pull the patch identified by the Fixes: tag, then they would definitely 
need this patch to run SEV-ES.

Thanks,
Tom

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/x86/kernel/sev.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
