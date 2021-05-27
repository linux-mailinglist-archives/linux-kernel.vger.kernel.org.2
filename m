Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BA3926C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 07:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhE0FPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 01:15:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42990 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhE0FPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 01:15:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14R59PRK113356;
        Thu, 27 May 2021 05:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PcIOPb6Fuk17jGkBYS9oUoM2ZHoLCFaBjBQQB2Rermo=;
 b=TZA2tii+4vd5E8ZQk3ayAXD6k01dXQtJQv8gy1QBSCiEqODNtkZd6Y65gB3HtUQ2nBKV
 ZawMCUzQ3+w6T+k3lakXFqtTQjv17uhCMmyzWKUMfgUShaOLwPen6pkik1BQWcF2vObK
 OqX/V1elqCpEC4+WFrEFJAJi8Gf5cwzvots3U+AQEvbY4gGYruHyIQ3e7hbR/j+Tyx6E
 KF5JwxAhBQGRJPKhej+j5pvqYbw85W9yGslH3L3xaNYq346w31FJwyajPXofCUQ3JQkU
 I6BRy3Ie/kBqoqdRmxWjT8BQpQDc8DgFalevG0n1qjY0f12LzV2SukwJ2xFDSRXg96/p xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38rne46h1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 05:13:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14R55SZj004830;
        Thu, 27 May 2021 05:13:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 38pq2w0t86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 05:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt3IIc0Hzjz8l0OX7EJDp7KK5G9yBkeSasgahkZTOmoTRrI9pX8bI/tWAwI5wbvAu7zQpq6eaHxlhQGMqhg99G03RewQqFHF4BErSZsrIsLCCUGm+eIES4hkjVLuJQKrPbgnksis0beRrTYQD4zwY8HMuWA5d4a5GVq6NormZY8htptCO8GsHPyNNr7/L1+a2wWqyjX2nJSsfNzij42CptkcZYnIi/W5NMwPQYeO6BSvV9ucB8kLL1SuvSD9NkPq+3ZqWNqVffg4rSIJVO7nyMMz00/hm2kY1BqJrJUgMQaNFyiM1K0i1N1N2woGxypXEGWoRbFjH9vnp4eaeKFExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcIOPb6Fuk17jGkBYS9oUoM2ZHoLCFaBjBQQB2Rermo=;
 b=PXnmlm6NXlZsv85KQbiCGENYeig+WtaKKEJnw1n80deSTkTqZJVWXN+gtBNTE4/5DZ0mnwixrS+KOYKVhsDXGe7478wfgRNox59WyPa90z3qfJjPqUU3OngBI5yTRD02yUXN7VA6SPR+ytL6/Bs0PDm1AHpmh6asHxwz9J0/GOwSN195sBmk4kJvcWIR7IcMlOZnOlIPkTCbtJNs8QB/d0fMnzo9OoSkf/9eFv/iXjDWUg7yxAr5rzo2Ru/JxlJJag3WbZ4aoKQ5BTsj4Zj7i/bUPh86ow0D/qJwFDimlwcltc6edCYLsaIAv5Ze/CQDKR/l2LISy/rjlHyThx6lXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcIOPb6Fuk17jGkBYS9oUoM2ZHoLCFaBjBQQB2Rermo=;
 b=Guq2VO4ZlwzwdB6wjpVicsv2D6amL+0EfBQ849r9ri4DGWeb0jUMj1ath0adtcirmQuTD1Zlo2iHGjOJU+EZ8urSobe0BuLO47LjOYC2/Kr7b1M63suwwYkr1FbewdAhg46QBCRW6YSFRtW4L0e4E/WajKgP2ZTb7wKB/k/y0jE=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 05:13:33 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::9813:f794:8bbc:5752]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::9813:f794:8bbc:5752%2]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 05:13:33 +0000
Subject: Re: [RFC PATCH] x86/apic: Fix BUG due to multiple allocation of
 legacy vectors.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de
References: <20210519233928.2157496-1-imran.f.khan@oracle.com>
 <8735uhddjw.ffs@nanos.tec.linutronix.de>
 <8e1b9002-aa2c-5314-54f6-d5156703e25d@oracle.com>
 <871r9uamu5.ffs@nanos.tec.linutronix.de>
From:   imran.f.khan@oracle.com
Message-ID: <0dd4a1a6-7550-7059-150e-9d143a5b20db@oracle.com>
Date:   Thu, 27 May 2021 15:13:26 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <871r9uamu5.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [1.129.193.165]
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.20.10.12] (1.129.193.165) by BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Thu, 27 May 2021 05:13:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9273410c-4c60-4aac-6764-08d920ce2c66
X-MS-TrafficTypeDiagnostic: CO1PR10MB4433:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4433D7DF2A4C7199A3D9AC2FB0239@CO1PR10MB4433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGt8SN2quuJ4PTBQxljK0oFfYOekdD48dIOUy85Fo2liPu3DOFydE6k14MAitCY8j721nvx6nhzDfFuARSjR42bT08Q4Lu117M1E0gQak/tR4Jn+Obpq+OC8B5rRpADFOMVmXTXGwX0qNsHF7f6gUnB/Muv2INUYy47Qouu1l59e+MSCMgC1y+pm+Al+/kD4CEyAozl69qnxm/IiP4Y3nrDHeBMWax9DjPTCtXZjKCXX+Agbkzf1xQC6CjevHQ2m9RKCkdtJRqG5j/MaXQTRCagCwq6p1fA7Wkw5SosVOup/TKwotFKmuJhrTYZXQtGnXAXEZPc60ffeul0+VPAWRwcUOlDLc/MgxrB3QYlmmxLLbOjTO8+lSn72tCTHYzPhIr1cSI7AkTB+c19lJ+59Fp0K4Zlc/Q7wTIdZxTaB2IPQaeh1jb2I8R4l0MaKFYtOc0yc1dgoiONdd1vm0EWyKZu07a89B/zKIYv1TrGZ4gqRotHkNq5wykP6uw0rhcECOiUX2zopq/DCcgVyKcz/4v7/r51D7Hf9gW/gpYgF5ABY2kuNTuiVIiIm7JbnurwFLrU39PQZrrSrKxCQSLnw2yT/EVIBtduMLkAoaa0prO/hqp5oKpcTfomL5ZqIa+sDqACWESYLrQqRwyPMnKO6rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(376002)(136003)(16576012)(31696002)(53546011)(38100700002)(83380400001)(86362001)(316002)(478600001)(4326008)(8936002)(9686003)(8676002)(6666004)(31686004)(6916009)(6486002)(186003)(16526019)(26005)(36756003)(956004)(2616005)(2906002)(66476007)(66556008)(4744005)(66946007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MTNrWjRkLzZaMTNCeFU1eG11bnBadTRRUVA2bkdIU3VNK1JwbTRkUHpMYVZO?=
 =?utf-8?B?akEwVUNLVktYUm1JRUJFVTVSbWdxTnYxbjFtUndrQnJGT3NWbzdVTkJPQlQy?=
 =?utf-8?B?VUhGU1BDdkEzckpxcHZoQWhKZGJscWZzaDZKWitGeGdwTzlIRGFiNG9TMnJR?=
 =?utf-8?B?ek1tZUlXcVlzd3h5MldHS0RWTXd5MVl2c1R5ak84UjM1ZE9ENExxWHJhdEEr?=
 =?utf-8?B?SmU4Q3NCb0RSOVc2NUUvSzVIem85UnhuTkVWd21uQzdpMm1CV1U5eGZZa2RQ?=
 =?utf-8?B?a1BvckFjb0F5ZlhWMkJBL2ZGRmZLbGYrNXpoWW5xZEltNE0ySGFET1pjanhH?=
 =?utf-8?B?cUIzSEV4b2ErSXRqbTczd2REdkZwS3JZK1hGRFlSaUhGR0NSYllHeGtuMmFI?=
 =?utf-8?B?Znl4R2hrWXhJSlN1YjVlaURuUnRUSXdMbERtbEg0MzFDRmo5S1lZOTgwVXVV?=
 =?utf-8?B?YWdjNUtkOWNWUU1Za3grUlZjaW9XSkljZ2E3TTVNaTVmaGJleEJYVDk5UU9l?=
 =?utf-8?B?cTBLZHM5YVRGTXhZOU9uWEYxZ0JJS2ZiVCsweFJ5ZWtSZlRqbFJ0M2o2VU1v?=
 =?utf-8?B?NmI4VlpqaVBESlQvV2QvM0UzNm11cVVwRkdCWmRwbWFoMjlBam5XWVovZGJx?=
 =?utf-8?B?cklIN1crQUZEQ2VLbytHRUpaZHhHVDYyb0JFK3RTQ2VIcXFiVlVoOWNqYnM4?=
 =?utf-8?B?ajZUSzlQQ1VSUWt1SkVQTUZVSmRkdUFjekxPeElRRmFJTmx4cGMxVXNMaW0x?=
 =?utf-8?B?MEoxUVRINFB6TFlLMjFTbFNCSXkveFVUWXJOK09SYTcrTkp0YnNDc0ZKSjdx?=
 =?utf-8?B?aFU0R3FaM3FzMDkyYUVrQ0dFUnZDSkhHek1HeEZGd1Z2ZnQrcXRQZTBJdkMr?=
 =?utf-8?B?L2dMMW8wY2them80dFFoSWhFcGJOUkpiVE9jU2JRYWU1ZzV6RWl1ZHcrVTdX?=
 =?utf-8?B?MnNPTDdLMWJVa1daTW1zS3R2S3dLdXRycUxSOW9qRnlibGl5S3cyNGZPS2d0?=
 =?utf-8?B?S3k0TzQ1M3ZVR0lPTE80U3dFQlRMWTBMUzVQakZ6SFRWMzdUazU4Q1FzS3VH?=
 =?utf-8?B?eHdsREVNTmFZelA3V1pxNmc0TnVCUTNUZE1URUkzQTlUZ1BDN1NiM0YyLysv?=
 =?utf-8?B?YW0zT3paZmZHQmdEY1U1MWZJeUZEVWNLZHhyeDZOMytmN2xkZVk5UnpDOEF1?=
 =?utf-8?B?d1VtZ2tMbEdDQy9LSURTeU81TWZLcXNoYmt4dVpxd2ViSDFpc01OQXBXWllL?=
 =?utf-8?B?dVZBSGMxdjUvdUhsMEtpdmZjUjcwZTBCS0VUU2FhdTZzTkljV2NlTi9SUkNn?=
 =?utf-8?B?Q1lZaWVLRnpBdVd5N3JZN3Y4SXlXbFo2R3lBeklwZFhQU25rVEhoOEs2aUJ4?=
 =?utf-8?B?YlFmNGxCTnAxWnU5OGxkVndVTVJwOXFmQ1pBZkw4Z1NZYndPNlcyTWY1TGZD?=
 =?utf-8?B?dElWRlFSV0ppVHpMTFFobE9wNTQvZ0FyZ2NRV0FTbWFnS2wzUy81d0tVNXQz?=
 =?utf-8?B?UEpHOWRyVTNMY3pEM0lzOWw4YkRuT0RRWWdjdXVPWjBRcCtqYVRDZ3BJTlM2?=
 =?utf-8?B?YjZYZTB5NWVDL3IyK3ZkSElpYXBTNitwNkE1VmozaFM0R0VRQis1VzRobEEr?=
 =?utf-8?B?QnNFYi9CQXJnazJFUTZjNU9XblkrN1htcUMvZzJuUkU0aHpwK2owVHJpQ0hy?=
 =?utf-8?B?L0h6SEZzUXFOemdOaGlZMVAwUXRTWFlLbDBmZVdja1BkZWFXK3J5NnplM2g0?=
 =?utf-8?Q?Jz7SbDqcrdwHU2RPFJ71hqXTC0pXWvi6gAuaXPA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9273410c-4c60-4aac-6764-08d920ce2c66
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 05:13:33.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msc+C5bBb4uPtPQ6bnVsIm8QeQrXFtv5UwoN1H6idJWPaQg2z6ncZuVN64wrLGQ3sXE6HY+d1oOWoUFzhspfrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270034
X-Proofpoint-ORIG-GUID: GWcfNspbwQtqw47tQuKX-u87s8BXABjv
X-Proofpoint-GUID: GWcfNspbwQtqw47tQuKX-u87s8BXABjv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 26/5/21 12:51 am, Thomas Gleixner wrote:
> Imran,
> 
> On Mon, May 24 2021 at 13:29, imran f. khan wrote:
[...]
> 
>> Even my current setup that was crashing with in-house 5.4 and 5.8
>> kernels, boots fine if I boot it with noapic option removed from kernel
>> boot parameters.
> 
> May I ask the obvious question why the changelog of your patch did not
> mention that this happens only with 'noapic' on the kernel command line?
> 
I was not aware of it earlier. After your first feedback I debugged the 
code further with ML tag and found out about the noapic dependency.
[...]
> 
> Correct. So you almost decoded the underlying problem.
> 
[...]
> So the right thing to do is to ensure that the legacy interrupts are
> marked as system vectors in case that the IO/APIC is disabled via
> config, kernel command line or lack of enumeration. See below.
> 
Thanks for clarifying it. I have tested your change in my local setup as 
well and it works well.

Thanks,
Imran
