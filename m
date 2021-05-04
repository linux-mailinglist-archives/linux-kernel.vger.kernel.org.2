Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336BC3731B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhEDVCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:02:54 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:14080
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231445AbhEDVCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:02:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSuHNpsgRHWNAZQzfCheW1AODkyl4BroN6gqx8btrEkCw9Dke9/EK5claA9Rqtk5eLpGtWM1kxZd9bGZI0DPrviI2m1wtpUbBah9KeYD50x09C9CI2lXUKvd4On6HwzcdWv82y0fBXEr28lslU1cxOfjXoU8jQffJrpv9k8ye81sUefzJBp7fX8OG7yIlGOMaNjenjzf5GK8dvJzcuUcrV/JyCFhcU1QMkkgukxkW7wG6eoG70Ju+7JzxTguZ7DA7UUAPmFvtBuwWf8NmQUutHvOQ2R7ng5RgcWd+5o+OeFXV0Blpsj0n61547vutIbX1tFWoLZ610h7RqjEzp3pCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3GrcEI4pl3Oj3uSsqjFQNPqXpF/UHw/UkHptXk4e8c=;
 b=RhPTW+DwcyG7lyTjtLr7m1Zygw0dnC7/PIb7buU8grpDWBUjLnXcm5LWGjTSAan3xeVhNHQ1wfXJs3ns/OdSN2fEZ3UpQHFueNxF9zwMhKlPDSyplrAMHtAAo6Fc4jZtN+EgGBgBzKumD8gHCROfp6LnU8XTAe89hgypDxg10q6XiSqVhmjgc/ZiS+q5nF02Fw6bRIIh5NyGcbEXucoHSo8FYRKGPEJljwycgU+GHLZOUfvGZc7VHDuhXxEIA3uMk5bWl+UO9mw3uy6VeYW1Xc/vtadKdfbVAtG1OUy9VI7koBDp7ZNCT+8eaSwC53XczD6jLbYHTgn2zEj14RjVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3GrcEI4pl3Oj3uSsqjFQNPqXpF/UHw/UkHptXk4e8c=;
 b=j3VPO4CXmaF/NFv+iaL3WcShUCBR3ogdymH9LcXg1tbSxs9VmZrpruXqoYUSeMGasFOc/uQV885fZNJrTrBX8NtgJik2FjtnYklbzH0S/MDC9IJv6IDEtAz4bApoitsb9JIXDvzp/uFtb+JIPOXnxfb6ehnUY1bIYQPWkV3sL34=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB3705.namprd12.prod.outlook.com (2603:10b6:5:14a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.26; Tue, 4 May 2021 21:01:55 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4108.025; Tue, 4 May 2021
 21:01:55 +0000
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Reiji Watanabe <reijiw@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
 <e53887f8-c09d-28db-5041-bf8822370c46@amd.com>
 <CAAeT=FyAmSxKy5cpGLBH_kqDohXeQOdi4r02KjQO_vycq=4y=Q@mail.gmail.com>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <d64b9e19-7124-640f-0ca1-7abc7816d642@amd.com>
Date:   Tue, 4 May 2021 16:01:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAAeT=FyAmSxKy5cpGLBH_kqDohXeQOdi4r02KjQO_vycq=4y=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN7PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:806:127::26) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN7PR04CA0231.namprd04.prod.outlook.com (2603:10b6:806:127::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 4 May 2021 21:01:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e82f0dd-d2ea-4e3b-8c06-08d90f3fd942
X-MS-TrafficTypeDiagnostic: DM6PR12MB3705:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3705EDFB1AC6927DC0C2F9C39B5A9@DM6PR12MB3705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlWNavYQ4DlDeIHbJotp2kUZuVIoWzfXeofa6NxvKNr6kzLKJJhliLRyhDTHV0YXy0cWemoluIFV0S3Tx0O8M0GgQd8qQIpiormNo60GCgfG0tLs9+0UcXF3pwLwlQ+NMeeHAzuD1X9B0LEQrZsk6MCDqEBbAuXULLE2jiNW5NjlWUwUu2KbDRr3S6P9o8l39smV/Q6X5lXnypOBGCtcD9sTUOQPWcVJnnm3DD+Nr/zgfMPcOlO67x44/V20OHrdvO0FJKU4fwjhpy5cfopJq5aM8GEoGEDnrlSPySzHgzE0j/PP5atykp2EOITrolYXRTRBI7+MaGE9XaTYiif23+0kARnQsCJSM+FmG+lL6kwAwMcOPwTWvQcoxJHG6HPDFx1KRAx4ZyD8Sow9osnS87/zSq5dP4Xek5ylCEnIDrb5DDVnIJ8cZ3D6nGa6Pm3xjKO3TmdBjNc1RINxQ42f6dRfVyjghTeNQDnJJlh0BaGApoLQwq7UueJvFd9SLS2035leKy/58teVinxtYMC5Q11u3LQwzvpa2GmSwcKX6uPqiba+KQG+pPlMHfkJEBfIjDq4ZO35sHY3uq+DJbBN3ENp/yjEd5HKP0uyyI0zPphYCln2xVcz7GbMe6rp4MbskxKlERr2RIehTLXrUL9ntvuW0NX82qghRdu496Oek2o4UWDPCVfmE/OwhwqecLPc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(4744005)(26005)(8676002)(38100700002)(16576012)(316002)(36756003)(66476007)(5660300002)(2906002)(66556008)(956004)(66946007)(6916009)(6486002)(4326008)(16526019)(31696002)(8936002)(31686004)(186003)(54906003)(2616005)(478600001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bjR1dlFzcm9HK0tQM0Y1bDhodFVETzhLM2JTMEJzSUJPK1pweGljZEVlMk5o?=
 =?utf-8?B?ZXNuekVWUlZhUkNvMnU3U0xHSzl4RWl3dVR1MkpwNzdHMzcrUzlveEkxMWJ1?=
 =?utf-8?B?ZW1hYVE1TDlXSkpXaU5SVmVsZVlwVFB2QlZzVGFUdi9FeXJLZkVXcUxDN1Bo?=
 =?utf-8?B?ZGJjcE1BVzNTUktkRUloTUNwYnpSWVN6SlpRSE03dGFCSGtESGFKWjVoVDNM?=
 =?utf-8?B?UTA0WmNPNjk4T2JWbld2SkxvbnVJcGIzR2tuOGNMaVd1Mm1pK1M5ZnEwQmZC?=
 =?utf-8?B?Y2pKc0JRd1E0L1dDN2lEYzNZRDZUMWNOL2kybEw1VUZrUFpOd3NZWDdza2ZW?=
 =?utf-8?B?SjNQbVN4RUJZdnlHKzQ0YVU1eWxRaUdyZ0JRNll5c2Z3Z1Q1ZTUza1VtR3JT?=
 =?utf-8?B?Si8yak5sMGRwVU9Hc3QyTVhWSGg1azgyNHZaandUVm5YY3l2bG1sS0h5Z1dN?=
 =?utf-8?B?dGpWeTdpa3Y0WHU5TEdLbGIwdDV5RnRqdW1zSkFET09lYXdoeXpIOVkrNEZ6?=
 =?utf-8?B?a2dsL3ZvRXZMNGpwbDhpVVZ3UzBQQ0l0T2grbk9pcjJ0R0xxMUNROHQrRVlQ?=
 =?utf-8?B?U3pZdU91b3hxcXJ0eTZKcFpiQ2xhV3ltTHk5TnpTZ1NoMFdOaDVseFhLNWJM?=
 =?utf-8?B?TjhtQTFVRHRJNmVNMmFJcDhvODlTSGFpUmVPdjRLbGlMNjQ2alYyaERiTFYy?=
 =?utf-8?B?cmNYSldTL3VXYVB0cFdSM3lUYmVqMTNaMUw3aVhWQ2xWRWxGcnhVRUtUeEo5?=
 =?utf-8?B?UC9hZDdvTm5RQ2ZnOWJkNnVtdlh4OE1HZU9LbGFZYTlCSnM5VzY2MG9panBv?=
 =?utf-8?B?MzBlTC9uRTl1ME9iYmtyRTBMNHNLZEdqZ2JBc3JPL3NReC9kbEtXbXdSekxE?=
 =?utf-8?B?WjhLZEp0S1ZpenVYUHZqLzVaR3doUm9yVi9IWjh3TXh5Q01aZk80Z3cxd01U?=
 =?utf-8?B?bjhWY0FBVCtTMHBaMmtHQzd1ekxScXFTZ0NFK2ZWTkZwLzB6OTZIVmRIRHhU?=
 =?utf-8?B?ajd3ckczRlhVZjZoUGRpMGI1TVI2RTVIVjhoRkgxbFBVcFY3ZDdTbE1TK2Qr?=
 =?utf-8?B?dzB3MkNuVmR5a2gvT2N1VExUcmcxcnQyZWtVMlB2ZWVwVEVKajhJMEZ0TmNX?=
 =?utf-8?B?aCtqOVRxT3RpeStld0lCR0hMUnlGZy8vOEpPTkRSYjRoKzNKZzQyZkJMK1JV?=
 =?utf-8?B?VUY0T1RQNndaZ0NEaGMvWXc2RWtIczZ0NzNHckhoUndJTHdkYkJ6bTlWd2Iy?=
 =?utf-8?B?TXpsTDRpUWZMclp2UVdwMGVwZU1DSUZmRUdlZm12VVdFdTFJd0Zxd1Mya05V?=
 =?utf-8?B?emN1eUcrNDhha085bDZEcUlpejY5YzljMzZQU09Db0JaSE4yMFByUyszODBB?=
 =?utf-8?B?MGUzV1pmbWtwQVRqM2JxSzl2c2lHYzFOUS9rSGpsQUJVRzl2Wkc1alduZWJI?=
 =?utf-8?B?bXBOdUdmaXdVNFhxL3F0VGxDdTExYXBJeHFRVU5NbTlrRlAyYk84c0plazNj?=
 =?utf-8?B?K3ZxZ1VZVitmd09HNVhEUWYwWGt6YndqWFI4M1VWQ3FCekswTFgwdkxNSjht?=
 =?utf-8?B?VGMvVzJIWjJyMTU1OWlQMWRFb2o5dUttbVp5UmwyRWJMdXBkK1YrcHBKMjRw?=
 =?utf-8?B?UWRuRTlFT09YZmlHSU0xeHBBQ0twVlY3ODlIZE9rMXBKUzR4dXFBK0pCeTh3?=
 =?utf-8?B?eHdKZWtBWTBMMDRZOURLaVl1NkFIcHpobE1lVEtJOUpDdGhKSEo3c0FBSi9Z?=
 =?utf-8?Q?c7uu3cC3DwOHK3yrHZM5RHjWAE3pPuAK7ro5Bs3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e82f0dd-d2ea-4e3b-8c06-08d90f3fd942
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 21:01:55.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5AwceqSJ9kQJMD6CSCtXhh6z91Om7VTko0dQnOMl35oYR67/xHv00kBWP5m6nxNQQjTEwnXF4FOYOaiTSwzYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2021 8:50 PM, Reiji Watanabe wrote:
>>> Considering KVM/virtualization for a CPU that has X86_FEATURE_PSFD
>>> but no other existing feature with MSR_IA32_SPEC_CTRL, if a host
>>> doesn't enable PSFD with the new parameter, the host doesn't have
>>> X86_FEATURE_MSR_SPEC_CTRL.  Then, it would be a problem if its
>>> guests want to use PSFD looking at x86_virt_spec_ctrl().
>>> (I'm not sure how you will change your previous KVM patch though)
>>
>> Reiji, you are correct that X86_FEATURE_MSR_SPEC_CTRL should be enabled so KVM guests can use PSFD
>> even if host does not use it.
>> I have this change in my KVM patch.
> 
> 
> Thank you for the response. Yes, that sounds good.
> 
> Thanks,
> Reiji
> 
Boris / Reiji, I am wondering if I have answered all the questions on these latest patches.
Just checking to see if there are any more changes needed.

Thanks,
RK
