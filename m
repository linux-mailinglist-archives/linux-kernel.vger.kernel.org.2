Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF03FED62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhIBME1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:04:27 -0400
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:33729
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343950AbhIBMET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:04:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtxhsEBaiAI8l9x6H7GBIS67thI6HjLPyD2GFAMredF3QcnT6q+OXTcWoiGiDPGgjAwoJkRui6EIYivOD1mdZK+PuOqs+oomAOwArFuKZ1Xcla9gx2K4EyYYvFjaurh9H8pAO3cc6S2qlC1sNOOMsqA2xwoxJarlcoRj8ZQrihkTXkHhP0E+NVVnHPEVZdrB/kSfWUHnhHtXN95YsDAsCvxVTD/8YcMADj0eKNL7dx1wjyrLXYKaGko/+4AwlaiOoh4R7k1M+hujvGi9c169rfkewpxJokzfh+cRiT/yDHoCyL/HSh1OoK9zbPHqY4fwhs5prQCxgy2V1kIvWkZqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3lVusWbdPoXxmiKkRB55i8mxzmUFz4GfDP1yUsfZ6bo=;
 b=LtulXxVrvGLHOYuYlOTZh6i978vE1XB04Oo0vQwaLIcxvHQ5a4S7FtfRDBuINNEowzJIzraqVqbOG0qx6J1sGkrE/T2QJ6+TPv8gbzeKkm1gDrXArjhR7KjpO7rKpQjZ4DbOU18ZecDcwYQDYzn9j4b+2YhzPFmMlp3saOevCnYYDrq/7nh397Q64ElHFBl1kIa6BTjmU8zaI8TZiqR3hJLU7F60BMhwcK4bf03uaDa2vJTmmhx2GgakyqRx+GHO3wh9lBcZticXCdaeNkewrx7MY4aT3fugF6kKx7ZJfC1N9fmdac+3V4RLsn12fzZ7xMMvl8jC++AQtTF+xFzl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lVusWbdPoXxmiKkRB55i8mxzmUFz4GfDP1yUsfZ6bo=;
 b=0/EfUzfPx78qMukfoBzEtkLAjmbRTgnYXMSWqoG7b7tAFO7L5XfRrQElraw2RZOCAY3TZ3GJ8Vf8osmZn8kViU50yX7GqBXLKyc2r5GWVYbKElTPZKOerRhX4zxekMm0zY9YXx+aa1EjbAyPzn3R3T7SBcA3MIaBq7dZRx7BTw4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 12:03:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 12:03:18 +0000
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nirmoy Das <nirmoy.das@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
Date:   Thu, 2 Sep 2021 14:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTCpuo00wM7jGSIc@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:eecb:a21b:e309:246] (2a02:908:1252:fb60:eecb:a21b:e309:246) by PR2P264CA0044.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 12:03:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7223e05-739e-406c-7c9c-08d96e09a66d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3950E03A52036C55773B209383CE9@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkdWHrsVvdTdLyqPdlBLV1NVhT3Mz7P5b4BiuLuFgI7zc4JrHNZjtg3RsI30+GgKNZ6YUjuDr9axd+nxQfgGFvXiLgHIf1lAQsVXmmKmR2u2ulua5k/CAXRlQtbeTY8sOWy1Qc+6DJgayd+PlcFKyqniSOnSB66d9d2fBuP8Zan0y2aZw4UMtpzw/fU+X0xB7JVJ9o+xqZsLQhIeL77tsLMsEZ14Tm5oxcNor4qBa8m3/jw3xctm5lCs+L9RnLPGzRn31y6/TqwsbL6Sh+0kFbGvbeSki7GGOL3vh3sTBxfzf6Askfj5XWQ//ExdHUk39giRzCxma3Miz3fTijf6FrW2JGqM+r78Ed38UjBe2RdjONhP7JJEOxSAmrik2u+nl3MfwVym3UwN/5xEQtkxmJkh0CvqrFVbTNUHioSJUVR0qgBPJWWnCgucCyj46e48TJR8+9zg0SUnSl136DiJMkJA1KQFhQNlPlTOUFUZ/Ivn5zQGHtxYdI6BwjppgVgQ45qVVP15WCUM8QAdXPKJo+SWdTH/kEahusf/3i+NTCZeJLp8ArgYDDER4GtQyowniq4qqTZPLWWOCHEcp3aSwfHNGTuO23PwmIQEVjZmDBTmiktPfXO+oHwqxD0cl7Zn1x+hfMUyt4YrJ7sdFANNHiCM6bTIqB5ljtM/i7DEAKFXTOFUjC3bJ2F2K/qda5nc6RTctMopId9n5dfI71utXtdvfiL9Eo7pjoA3RsUxsaWlucbHnoSt8wQNmo61m2qL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(2906002)(5660300002)(86362001)(31686004)(83380400001)(66476007)(66556008)(6666004)(8936002)(966005)(8676002)(45080400002)(31696002)(110136005)(186003)(2616005)(66946007)(4326008)(38100700002)(36756003)(6486002)(316002)(478600001)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VHVnc2djJtblFCL2JsdE5vTjRTeW5JdVFrazFUang2c3l0TmVYa21nck9h?=
 =?utf-8?B?V2UvTGNYaFNLcmltM29jcWkvR09GZEVDd3ZVTHZRVldMUTRVcEVYa0RCUk9B?=
 =?utf-8?B?T3YzeWFPWU8zU3BDUGRzd1pSU2h2ZjlwREFaLzlnbFRNRlVESXhuSUQ2VnYw?=
 =?utf-8?B?bXVaYXl2MDQwaHRyMVZpTThuZUVVd3h3azFacHQ5YkVETS80QlJuMVc3a1Vh?=
 =?utf-8?B?bCtlTUFRVUJCS3IybDBOZGN4ajEvdGRVdGlDbytOek92R2dabTUzUDNUNWtO?=
 =?utf-8?B?bFdFMTdFUElWV0hpNitvTWp6YW9leTlBR3N1WHpVcWMxYzVrYlFkVTdZaDZK?=
 =?utf-8?B?cmVRRXBkOTZvSkFOWDFScG1uUU9ZSXdvKys3d09DRUY0aVAvZnJYakRyQ0ZH?=
 =?utf-8?B?QjRkVnRTdFprUThCQ1VjMDBoYzFWbGRoRTNtdnpXV3NlUnJMY0FGbEQ5Vmo1?=
 =?utf-8?B?Qi9ESktIU0NXMmhkaU5YaVorTnR6VENRampUK0I1dGVJRVVkd0swMnhibkF3?=
 =?utf-8?B?U2V4MldvL2xzaDhqV3MzQ2duZGhmaTNMRXptZVB4QWRxTGxzcnR4WHQrQzFL?=
 =?utf-8?B?RWR2Y1NhV0xJb0JQczJHRmlId0FkTUZ2ZHp5eVowM01uelhqa2trNGlnT3NB?=
 =?utf-8?B?R1ArekNLcDZNOC9PaDZ1c0EyQzIyejhMMCtFSm1BbnRvQ3d2ZnRrVjhPRTZM?=
 =?utf-8?B?WXZzVzh2N1V3emhSWWZkWS9PWU9ZUytCSGZnQkpaUjJWdnBwcHAxMG55dE1w?=
 =?utf-8?B?TGtaSllVem5UZk85cGhRK2Vta3ZJNktvZ3dQZUtOZGQ1c2JlWFl1NUx4Ly84?=
 =?utf-8?B?UlBNOEVOUU81VWQyeXo5V0RhM2tpQTJtWGFBRVRFNnJUem5xY0ZWaUNQemhY?=
 =?utf-8?B?UUpEcnJRSHlnNkU1aXp2OXFFM1h3c1NlWTJUUGlOUDdKRnVEQUlSNlFLbXps?=
 =?utf-8?B?Tzc5R3h6SjNaY1Z1citUZkN3RmhRNTVhbzllK1JwUlI4aFl4RVY1M2RVSzFj?=
 =?utf-8?B?UEFCMEprdllFeDc1QlNPN0dZQjNhc29hV1M5a3JMbWw0ZVVtR2J0TFdDb1ky?=
 =?utf-8?B?UFBGUFJmcmlqSEJGekRxKzhGejRMM0xYMmVGek1SVjFMTkJZeStnMUNwbEhM?=
 =?utf-8?B?K1VTeXREbi93dTVKZXFEd2VQdFNiZjAyZmtBRGlhcXIxaXpENUc2aVVyeDgx?=
 =?utf-8?B?UlM4ZUVJN0QyRWxSSWk0NnB1Y2luWkRLUVJmOW5EcWY5TlBaL25DZmYxS3pF?=
 =?utf-8?B?aGFxbjRlZVdVU0tqdEtkNG9pVWIrc2g1M1orbGsvb05aY1ZWT2JZQW9PaW1L?=
 =?utf-8?B?QnZyaHFUL2pBbFdRT25iM1lSOXdxMmFjbEliWEllcTNRUnFGRWg1S0YrMzV6?=
 =?utf-8?B?eUhpZHBGNzg5SFVGUEdVbVpVQlE2eHgwZmduTGsvcFlNbGVGVzcvV1JKZnZX?=
 =?utf-8?B?WHk4ZjA1YkViZThkZkxxMVNsTHFSZEFRRC9YTUxpTWVPMlhxZXAxMGFjaDdu?=
 =?utf-8?B?SU9aSGw0b0N4ZWlRNlNITzYrSlJuMmVVeU05cUwwQU1JV3BkK1Z5dGptNEJ5?=
 =?utf-8?B?ZmZhTHovRVI0RGtKSzhiZkNQMjQ2dlh2dnBETWZJOWdwQWRpZVYxZFViOXVz?=
 =?utf-8?B?ZEpudVlpREVUZ0poSGdzc3NIcEYza09EMlM3OXNXcEdsbmROa0dKRXpNVHhv?=
 =?utf-8?B?K0VxM1luK2NJeGEzd2xhSlpLU1ROdlluZGF1MTM5aGlXdWRBSm54cE4zaG5U?=
 =?utf-8?B?VEVjdllMZGRrc3dqNjJ1RjRmSmhVZXlGaml6cTZWRXpkNGlyZ3l5RXMwTjRn?=
 =?utf-8?B?VDBNR0ZaRkt4bDZDc21hWVEvVGI4UUNCTG5WQzNRaitkMmFqbkRnUmUvYnpu?=
 =?utf-8?Q?Ek1IcMIidFKJR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7223e05-739e-406c-7c9c-08d96e09a66d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 12:03:17.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WhTn68VN/Lbi67cATLNkqu5eviJ0Ur9yWRXSGS5pja8M3R5Qsm9p8m/Rg9Eol/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 02.09.21 um 12:38 schrieb Greg KH:
> On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
>> debugfs_create_file() returns encoded error so
>> use IS_ERR for checking return value.
>>
>> References: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686&amp;data=04%7C01%7CChristian.Koenig%40amd.com%7C82691bea64d3491fe86008d96dfddc60%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661759378883940%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Xs4xnihnMzNvl%2BSEEpCcWkdvMaDw1Ofvekn%2Fnvz1mM8%3D&amp;reserved=0
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   fs/debugfs/inode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>> index 8129a430d789..2f117c57160d 100644
>> --- a/fs/debugfs/inode.c
>> +++ b/fs/debugfs/inode.c
>> @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
>>   {
>>   	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
>>   
>> -	if (de)
>> +	if (!IS_ERR(de))
>>   		d_inode(de)->i_size = file_size;
>>   }
>>   EXPORT_SYMBOL_GPL(debugfs_create_file_size);
>> -- 
>> 2.32.0
>>
> Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!

Thinking more about this if I'm not completely mistaken 
debugfs_create_file() returns -ENODEV when debugfs is disabled and NULL 
on any other error.

So this needs to be IS_ERR_OR_NULL().

Regards,
Christian.

>
> greg k-h

