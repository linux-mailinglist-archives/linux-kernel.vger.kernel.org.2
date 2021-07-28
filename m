Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495EE3D8CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhG1LbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:31:02 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:51136
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234517AbhG1LbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:31:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONTjwoY6mIM9PWu6v+8BqJZIeGSKsRXielXqcOfVZbzUhcBUyBVJroAVjdmUqi51GVPMfQPQxpoZIoygfXkoYnbrrID3sx81eTU05TCwst7nJManbswx4y9EgPitk125WZM4obmn5aoFgTWGyQaYdzEASP/Bf2+5+rfwgwvsZFX3gYb+KOTeF1LRY4T9zaf1P/YIFXln0U4uBv6G4m4ISOK0FVFTcV/3Te4YM13EQAL38qGbY8QjJJxXWfXeDllvIBmlNttPidw13fTeetMC1C+4g0Zz8etu3ZcNH5UM9nsCbGQrr8L9HEhqj10SdrDzK5RDz+CY7xPcwthyaG9tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/zesWdGlPPb4Wl048F8J+PyencH/XiNzqxprPIG2aw=;
 b=LkLDoHMS8b+EVJfmVDfDWYCvl2vKJTBffNQOiUmzJtbsJVJeuOOYRAEFqWK8CiQe2Wa3QWBtJ3cTinHCRl7+3pHePXLhPqNUeyxqrYP1d0tVRwi2R3hFE27IpAERG8O+ybluO35nTGEBFM31aIaWH/BbiupBSN8xuzkyynPYRWDYGJ0NRqD6QiITPl4+W1R7OZCkKboBEyF7VsRjEOXx9AIyMv8NZugcn+QjgoRHGgOEWyLVyQs5bV4hWsQI0vzDR35e9edJXE7WaKLzQ5XF8COPOfswGWqNtt6K5DePtzIHGUiy/84UYGKlzagxr93gzEHpBszrTrY2r0Dnb1Ag/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/zesWdGlPPb4Wl048F8J+PyencH/XiNzqxprPIG2aw=;
 b=nYnOzX2dAfOfASKdlEAmDdTkCQzlpLlut/Im1AQ5vvgBpTcxhEJf0t3V4934Q48qHJL0pYyC0a3bp4QUspFqFRI4DuBofgxSj/j/DlyyzsFwM6kXbEA+WNDrAwJZqeEDry0mKXsQlIa9nnLkZYj0tYdwOMKoj1ndL/vwcA6HhNY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2714.namprd12.prod.outlook.com (2603:10b6:5:42::18) by
 DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 28 Jul 2021 11:30:56 +0000
Received: from DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::c1cd:d67f:ae14:faed]) by DM6PR12MB2714.namprd12.prod.outlook.com
 ([fe80::c1cd:d67f:ae14:faed%5]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 11:30:56 +0000
Cc:     brijesh.singh@amd.com, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Gary Hook <gary.hook@amd.com>
Subject: Re: [BUG] crypto: ccp: random crashes after kexec on AMD with PSP
 since commit 97f9ac3d
To:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
        Lucas Nussbaum <lucas.nussbaum@inria.fr>
References: <YQB3B1RMhPqcrqzW@xanadu.blop.info>
 <F2C0BD57-3DC3-436F-98F3-44D85F9DEBC4@suse.de>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c88e56fe-e713-b3cf-1be5-a5f4f4d5b038@amd.com>
Date:   Wed, 28 Jul 2021 06:30:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <F2C0BD57-3DC3-436F-98F3-44D85F9DEBC4@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) To DM6PR12MB2714.namprd12.prod.outlook.com
 (2603:10b6:5:42::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SN4PR0501CA0001.namprd05.prod.outlook.com (2603:10b6:803:40::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 11:30:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc876dc-1769-4b05-6eb7-08d951bb2a5f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0169299E2D1FB2FA86FA5137E5EA9@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzZ+iIZWxx7qCtIQkrXPE0b8s4AbQiPx8eGaFz3MgXgZUf+7FGuSjWUlg9fARwXMucJBK9K3D1/b/7BV7M1KEC4PPk96qppPxCWL8Y+KLT7V9mwQDpBjw39tMgW4euVznEBjeO0oWojn/Ny6klWm91VzETTae0dln87Mn098/Tn/1ivlt4n9RSdjaWeogqIXE2ApbPc3LFm5ZWQDFPWvKsnmODqqruxL6Vv18jLx/YJVLxJb7nJ0A7scfrHws2FfW4Fnn01Ci1LHThWCkNLSPl4vzkihgOYTZNr3r6s/IVz0cGRiNkkqCS9Ytsq395cBEbIRXgkY9hcywH9UU8xGa2jynLq72dzAXzDbFIOv/D1IbuqST+7OT2rvHNPYD+0TLoTQtFIJrjeNwA5uwoIZDGYbcFkXTCcCMooOLYcE+UTAFfrtN+gqAXenki0tQzQz2F7q+xMokR2P/pbQS9tK15rVOydO2OV3uNuWjLS67gzjAw4YwQxieidJAM4qMo4CF/uapmXZdcmJng86sGWo47z4t47lvKTpKs18F1+kWzOHfSPAksV5BhbapDsqVkMqIelB7mESSWQdsifRAQwVjB54mPwV/lSXVhQ8hPpYvoa18rN/jZ13aIHmYp36kGm8XWBQBIrzxETszzKGfIb+V4fQ6G4sHKISqkt7vsOQ+rUAqrQhR/Lx0c29dFCo61RTO9Q84JLvwRFUheSmgQvqV0ZdVnWvnWhIW5A/biZ8sUcCLRso1bnXUij2LL0obUM7TnhCU3r8mccydOm2VGGF4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(83380400001)(54906003)(186003)(31686004)(110136005)(8936002)(478600001)(956004)(316002)(66556008)(66476007)(2906002)(6486002)(8676002)(66946007)(44832011)(6512007)(26005)(6506007)(2616005)(38350700002)(52116002)(4326008)(31696002)(36756003)(4744005)(38100700002)(53546011)(86362001)(66574015)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjkydGp0dlhSaVhoOWI5QW4waGJMTTFpcTEvc2xlNVJWS0Q5bmRPRzR1WVUr?=
 =?utf-8?B?QUoyajRQYVo0SW1XdVNJVWQraUpDS2RyMjhjeVNiU3IwZlprSWRIZ1dwZEhR?=
 =?utf-8?B?V0x0MXFuRWZKSGM4QXJuT3dCbURNSEhlSUlVWjZkUWdLaFZuZGdESVFwRnQr?=
 =?utf-8?B?ZDl1am52UWtYUGQ5eENnL2xzRllRR0lqN0EyeE9VcndZZFdIcS91NU1CNSsv?=
 =?utf-8?B?aTlLVHRTUXFNUGxMSzg4UVlJSHI3K2p2ODRweld0UHppNURPWGptYWxQVlEy?=
 =?utf-8?B?OVVXN1pnaFo1SXRVdVRPalM5dm9POUxsOGh0eGxGeW9jWXB1Y0VUMjdDMkVk?=
 =?utf-8?B?SFZtK2xBMXFkTGppU3h5RHZSVEdBWXh5Qjd5dzlzRS8wRFFNRVJBaUczcFBr?=
 =?utf-8?B?NzdUd1BqSWhFNjhZajAzNkJvUkw0L1hRRUlNSVpObWo1d1lEYW05NWJUSUFC?=
 =?utf-8?B?WXdxRG9VRWJaaUZBemFvWVE1c0lsSjY0c1FDRGpCa0tBQ1l4ZnU2cEloMzA5?=
 =?utf-8?B?T1lKN1NEMUJKZDNlUlA1RW5pRFFGRnozcDJLWXg0NUQwWExKc0QyK1ZlUnEr?=
 =?utf-8?B?cHZyNGZOdHUxZktodHZoK1lvNmJlbG5PQ21DaUVVMktUSE9LdXVOcVlUSEVh?=
 =?utf-8?B?aDk0dVFVOXhsQ3d4Z0ZrczF6bzhUTjUrWmMrbVBSZGxvdDlrcUdqRnVSMDM0?=
 =?utf-8?B?MDFmSWJYK2hFSGx1aEd6NzQxTWtOQ2Z6UnhxTEFRTXlZNEFIMG1YSWxVSVVm?=
 =?utf-8?B?dWZUQ2w2Q2ZoREdicjN0N1dkdXB4aXZyaEorZ2t1bi80R3BnQjVKNThabXVS?=
 =?utf-8?B?QUwrNzR6OTdqcHVpbFFCVUZHYXVFQ0l3NDRYWW8vUFgxWlRpUnJISnZ2SitU?=
 =?utf-8?B?VXNDVHB3ZDFmOVBFUm95RitXU2dFbmxMZ1ZKcENlSUllR2lxTWUzWldGWmZk?=
 =?utf-8?B?OEFrQnk3bkdmVlJUeU91NWtNZ2kwcHBYQUcyNDlFQm4wOU5mcVh3ZGFTVE9h?=
 =?utf-8?B?U0xQYXo4emx5Tzd4bjZTV0JMNTh2VDhneVBteHNZRGd6NkxxTE94RmJ1Zmtu?=
 =?utf-8?B?UlN6L01uTUJINTE1WVFBV0tTd0UwUHVaSDV0N2wraERmUHJGU3RmWU1CYzhk?=
 =?utf-8?B?UldJQUhQMkhlRzhpcmV3S3RUYnVqZkRJUlJPRmtHRUVkNlVLUGNFZTd5eC9R?=
 =?utf-8?B?bGFCSGtEOXlKenZnbzdwQS80TTc5NmthRkFUZ0RFUDhwQ0lPODlvdm5SWnNN?=
 =?utf-8?B?RTNJdGx4d3ZnVHNBOW5iUWd0WUtFaER3Rjl4TzFtZDN3alBBLzlqbmNKRklX?=
 =?utf-8?B?SG9lTGVQdHpLSlN6a3NvUlVFN21mSGhadU5XK3h4ZzByNEozL1ViUmZiaVVW?=
 =?utf-8?B?ZzUxRFJIa3d5OEVWd1JRMXpWd3R4R1dxTm9MVzhKa0pwdFM5VkkrNjBnNWE3?=
 =?utf-8?B?RnljRXprZitic0lLckdlV042YkxXa2lwc3BpeWY5dUhGdzVHR3F6cjBTZDdH?=
 =?utf-8?B?enBhWHZpUDkwUEovaldrK0pjMk80YnJ0dGVycGUxbmkvQndKeWhRaVZYYlhz?=
 =?utf-8?B?V3VteXhuUzlFWXl6Ri9KWCtNcDJDeGJQUHZ1Z2tERFdVK3dTR1RIYXMvWXJ3?=
 =?utf-8?B?T0RkZTJrTDdIeG9hOGM4czlteEZBRVZEUWlLN3l4bW5NUWVqT1lUUWhDZTRy?=
 =?utf-8?B?dFJ2cU9iQnpWRTJjTVpRejg4M3VCNUhRT2tYeWNaN0kzLyt0UHZ2cGNyK1l3?=
 =?utf-8?Q?xZJDHj7KCoQZA2v/c5LNs3YgX/IjmNgT5/7VB5a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc876dc-1769-4b05-6eb7-08d951bb2a5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:30:56.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+NMpIp6ICrZlZ9sLdO/z56hfCZk0e2eBGiIOogUg1HmO0gGF9lj1HzR7d5Zwqn5F+7ZwtzZBSPtb8XnO3eH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/28/21 6:05 AM, Jörg Rödel wrote:
>> Am 27.07.2021 um 23:13 schrieb Lucas Nussbaum <lucas.nussbaum@inria.fr>:
>>
>> It is worth noting that there was prior work about getting kexec to
>> work with PSP/SEV (commit f8903b3e, "crypto: ccp - fix the SEV probe in
>> kexec boot path“).
> This patch adds the TMR memory for the PSP. I guess a reboot-notifier is needed which shuts the PSP down and flushes all caches.

Yes, we need to add the kexec shutdown notifier so that TMR memory is
released before the kexec is run. I have add support for it in SNP
series, I will pull the patch out from the series and send it today for
Lucas to verify it.

thanks
