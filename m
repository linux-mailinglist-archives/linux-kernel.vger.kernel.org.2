Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CBA35A3F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhDIQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:50:42 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:12135
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231402AbhDIQuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0D8rCdoxt+5qBjo/gLcb3jw76hRMiIxD0qQMPb1QUkBVKoWkKnshTASYAKHC0cX2c1lyC4qMAijuktfdN8DJSJ6L437phioSiUrI2QU1u0BR8OW9TqbUm+kBsIqqDVacxXplqvk2sjR00HLZ45qBI61latcSAUFRs+dPUw+0iYVoFXpTfYEANz+asJjRpE+LwvhKPjmud91sKNXLrgLiEJp3k4qXjY9gqQ8xwOmbrO4wi9J/xjzPAtjDEgJHWnHA9rj+WmxxC2+9hANLQTUaOQ/wBiZR/iZHTiHEUzFQzVRN8Gjeo/gRkO3WrZmvVLOWpLmfu+dJ5RyKzcgKPa2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQrowW6eRiq74Awp67F0Wj3ecU2t6WbF0G+LM9LrZWA=;
 b=dkfDCsdsLznamBy1LfSoiL7sjddT6m9gQL3Ok2xAMXj5RTAEQM3zANDsE+BK32xF1QdjTUTeg6GZAz9HChfLVNn8n9oNPAcOTYGN9OdxXNPw0Zu+3U3rP/98q9cssiBKHjLbhTrVcP+AzsEmg3vjpHlr+R/X9JJ5Ax1D03bLsoPFP6SM4jESHTkz757BB6YyiDbDNyHtxIVdlL6TDYo5Kaj6qjJ9c34nAE4BDOF1Ja8XsnPWOEhsr6Y6jE8bbFm0FI9UcvcKyNzPHdXrrJE5lMJ3AzsbETcfEvw8yHdMwgF2QXDKapaYh0ysuLzFRmU7ASV0OQsxVR0ydJdI2U5NCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQrowW6eRiq74Awp67F0Wj3ecU2t6WbF0G+LM9LrZWA=;
 b=CP+S7IaVkrb4kGAFGHOcDFIEs57qwB/rVuMls+EnzyGqLI+/yXbGKBnTeZyqVaU0pmg8D+8WMkC2kwtcbORJVHAM4GoXAqPS5EDSVXNWelosVn/CGAS9iMv02p3U9cVaildQfD/hZb4XxFw9KSkTFMs0ZEXp13gjKPqg9h5O+/c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB1467.namprd12.prod.outlook.com (2603:10b6:4:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Fri, 9 Apr 2021 16:50:19 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 16:50:19 +0000
Subject: Re: [PATCH 0/5] Introduce support for PSF mitigation
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210407223905.5dqgzdaibvgq7jeq@treble>
 <e72bc628-111f-5e3a-bb79-7e77c9fe0424@amd.com>
 <20210409164554.w2xtazch5jkivou6@treble>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <4ca51cab-a60c-fc7c-fe92-0913cead4103@amd.com>
Date:   Fri, 9 Apr 2021 11:50:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210409164554.w2xtazch5jkivou6@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN4PR0501CA0096.namprd05.prod.outlook.com
 (2603:10b6:803:22::34) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.231] (165.204.78.25) by SN4PR0501CA0096.namprd05.prod.outlook.com (2603:10b6:803:22::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Fri, 9 Apr 2021 16:50:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80fa56b6-5702-4090-91ea-08d8fb778f32
X-MS-TrafficTypeDiagnostic: DM5PR12MB1467:
X-Microsoft-Antispam-PRVS: <DM5PR12MB146719AB33A954705479DF7C9B739@DM5PR12MB1467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqffMQJlB2O1FcdKDWjZpg2IaaDyQeTrClxLP3eoWvd2/YFnTH0ZNOi2ikNG7+N7e0+LifQGGf/rl6gjwehnT7O2Pr2zfWCIdJD/6L49qAfna0u8f+uIylNEJjgYKzcrVJLf7q6M+h24nplUuadKvmGlfpuM0+fzJ3l3g2TP8DG5yWNW/rAzuzUz33dSMA6QwHoHz4Yzn5r9xaS8OBpNiWgpjQjxxHfoZkAinSLjagVbEg3eZkgcQCFe2meiop2FxeOYqJVYGXD3s/wJbjoTV1ilUDkgNXmuddjQNIsgWJncbvq04VF+u1rgyoNNJsBW/U/aKA3yK8gs1fDRicMBIOa7t2/tAKYAAI2Ml7JbK12jFQLgzBvQwa9/DgfnqvrhNgR5mbR9Ky6sj1WxMlirebJw7ChO7NBdMj00cAfPwIREOMxVj+Kmwj4iOdhAXI1EO+cQD6JdDxsSd3wf/M3ygtRCdijcDbAiqMdUwlkl/Meosv7zxGuE0HKTfcqgNjv11eJy1UzSoGnjBhKJN4+/euBCUNRSIq+6FpDHfVEkwrPCZxoqTGg1Yh/0ZlUxfxTgktRcC0tvKiRmM/9uDrKmRSc1+1ZMdEWgFELfjd9EFGOFPUm2GIFHgGaPNQXg2I6TNNj/GNRnuAdpJn682QVYtwFkPXZtx9qnXi6FiTqwcPvU88I2R2nfHTvURh3QZ+w05TZvC0HSMSm25dz9CjYn9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(53546011)(38100700001)(26005)(31696002)(956004)(316002)(478600001)(186003)(16576012)(8676002)(2616005)(16526019)(5660300002)(66946007)(66556008)(66476007)(4326008)(6916009)(6486002)(83380400001)(2906002)(8936002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K1RUUmVmZG9SRi9mOWJoTkJnclJVa0hVSHN3QU5CQ3NTbjEvd21zVkhzWDJj?=
 =?utf-8?B?VDBCTHlVSzRjQXFObHNXTzR4dmZMNkdSWFV3SVlkSm80WjMyMmp1cldKdkRN?=
 =?utf-8?B?TzVQdFZXaXdUVCttT09SK0VTTm9NZkdMNE1pQiszaEdZcHA2K1NCdVFZOVlE?=
 =?utf-8?B?SFNrNkJRQW51MWdzakFqNjFCbmpzZUZ4TStFRTAzNmhWUUlLbXoxMWNuM3BJ?=
 =?utf-8?B?bE9aNHNOZ0xGVjJWRzVIelRnMU5wQVBtbXVaU0JKV2V4V1ZCek9wd1hGanBu?=
 =?utf-8?B?MURBV0MzOVc3aVo5K0o5T0MwZW1iY2toTERsSkZUOEpueHJhYUMxazJ3Y3c1?=
 =?utf-8?B?L3dqT3YyUm5iWDJXZUJuaVpPaXd4V28vVlNCRG5DTjJTQXRVcERZUTFibVVw?=
 =?utf-8?B?dFhXdklmazFzemg2OThpUjZBWSt3UjBoSCtIdWZaVEhoQWpVVXRGYitTSkRa?=
 =?utf-8?B?YkxQUEw0VjlVT1RWWCtqeEt4amxwd00vNld0YitVd2RuVFJtZjNudDlRbWUw?=
 =?utf-8?B?RGFUVkp3Qmdncnk5MVpjMFI5NHowRkhGYU1lR09XMXVaNmoxVUF3b0MyM3Z3?=
 =?utf-8?B?RHN0WWdMSGpxY2ZxV3NFTm5QU2g4MXg0VHQrRXFuRW8zdkxLME1kTEc2Q2o1?=
 =?utf-8?B?dWtHSDU1bzZLYzVmYmFxSVZuUnpzVFdycDRhNEk0MFlrU2FpaHFOL0N4SEpK?=
 =?utf-8?B?UG9IVWMweWVXQnZ6SVlDTEhFL3piZy85Z3kzdGU0T2VMZDZ5TkRaQlJGZUw3?=
 =?utf-8?B?a1JZcDJzdVlEaDRxUHhzZkVCMnFaUU9Hbk9TUkkxTkczTXBjYlNvSTZYN0hX?=
 =?utf-8?B?YU1yTDdZdFR5QUFzKzdOa3dFd2RrQWJ0OWxVWjlLdFdUZ05QYzhVVWRGTUhD?=
 =?utf-8?B?M0hlVk52Wk1wMExCWjZmd0RvQS9KZEdvQSsxYXoxVG1iUjdlUEZwSG1IeDND?=
 =?utf-8?B?d1VqV0dZUHhIOXpVc2toY2xCWkMxd3hQTzg1eHpKb1JuOHRPYWZPdzkvMHpq?=
 =?utf-8?B?U1hmWUJVS1orZEhDNGh5TURIRTYvMWdLUWEzeUFaeVdwS000NW13V3A3MXhO?=
 =?utf-8?B?eGQvYVdYWEZTSUh4dDNVZnpMaUhaQnlFSzNEanlVZXdWKzVtV0RHZU14S2dD?=
 =?utf-8?B?YTVHaldyc0wxc1RrVVZiTU4wNGIxT3NUYzJiR05wTXdJcC91ZTRtV3pzYmU5?=
 =?utf-8?B?bEhlaE9uTHVYY3lIMzVmUDJlVGxVZmRtK012QndBdjRyWTVneXI2LzNuajJq?=
 =?utf-8?B?cjExbG5iZ1NtakVJNXJvczllWjI0KzAyT0prQ3pPSkFnakNYemJsSzloaXpK?=
 =?utf-8?B?VURnRThHekkxS2RLL0FqZkpVYVFCSlhpYTZOTStDVmZydURCa2tPa25MSWxI?=
 =?utf-8?B?SUJyUFhGZVNubU1FTERpTWtMZVRZa05NLzd1V2p5Z0U4QXM0YkV2Ylg5Mlg0?=
 =?utf-8?B?aTNpZGdDdnBOeEVZTU5NWjlsS3AwWC9scms4RitRUkROVjFpSGYrbDFKOGpx?=
 =?utf-8?B?QVZoRVVHcnF6c2lPeUg1bi8xUkpwRkhnd0pMS2k3NitpRFliSHZlL25qKzc5?=
 =?utf-8?B?K1RZMnRDMWIxZ3puQ3o4cWZFdEdzRVdoelJZUGlCRzRVM3hCdnhIdXZHK2Zm?=
 =?utf-8?B?MDBWUVZ0d2k3Q3J5MVNaVjg1T01XRTBGQ1daR21PeEFjLy8yV1N4ZGVxbnVZ?=
 =?utf-8?B?NTNMNG91T29OQjBSY1BzQ1BaaDFiYXdnc0hFdHBOWFNVZTV3b1dJSWh6NWNB?=
 =?utf-8?Q?TQxGHG3wRHA0KwDeI0uFnEQNJv8ZReJLz2vTw5D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fa56b6-5702-4090-91ea-08d8fb778f32
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 16:50:19.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+3Ity7G3nrXD8pl0Py4rGzUGptKSot1ffpbRM8sVR4lf7EtF7FHYnAug9gcCpdzRZgZOAG3m5TWQmOsejF1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh, PSF being new, may be in the future someone will find something new.

This is really extra precaution. 



On 4/9/2021 11:45 AM, Josh Poimboeuf wrote:
> On Thu, Apr 08, 2021 at 09:56:47AM -0500, Saripalli, RK wrote:
>> Josh, thank you for taking the time to review the patches.
>>
>> On 4/7/2021 5:39 PM, Josh Poimboeuf wrote:
>>> On Tue, Apr 06, 2021 at 10:49:59AM -0500, Ramakrishna Saripalli wrote:
>>>> Because PSF speculation is limited to the current program context,
>>>> the impact of bad PSF speculation is very similar to that of
>>>> Speculative Store Bypass (Spectre v4)
>>>>
>>>> Predictive Store Forwarding controls:
>>>> There are two hardware control bits which influence the PSF feature:
>>>> - MSR 48h bit 2 – Speculative Store Bypass (SSBD)
>>>> - MSR 48h bit 7 – Predictive Store Forwarding Disable (PSFD)
>>>>
>>>> The PSF feature is disabled if either of these bits are set.  These bits
>>>> are controllable on a per-thread basis in an SMT system. By default, both
>>>> SSBD and PSFD are 0 meaning that the speculation features are enabled.
>>>>
>>>> While the SSBD bit disables PSF and speculative store bypass, PSFD only
>>>> disables PSF.
>>>>
>>>> PSFD may be desirable for software which is concerned with the
>>>> speculative behavior of PSF but desires a smaller performance impact than
>>>> setting SSBD.
>>>
>>> Hi Ramakrishna,
>>>
>>> Is there a realistic scenario where an application would want to disable
>>> PSF, but not disable SSB?
>>
>> It is possible most applications have been reviewed and scrubbed for
>> SSB-type attacks but PSF-type issues may not have been looked at yet.
> 
> It's "possible", but is it realistic?  As far as I know, SSB is
> impractical to scrub an application for.
> 
> Do we know of any real-world cases where this option is needed?
> 
