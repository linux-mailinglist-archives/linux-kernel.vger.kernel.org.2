Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E238537B838
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhELIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:44:28 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:44778
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229968AbhELIo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:44:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzSqa6FJg0xynHjZM9MxzKM3SEsP/o0iOO/mVggZyiG+RGUtDPLdQ5m8YyHou6MV98FApltCqynuO2osP6Zgo6EAqC9iLVRGqoaA6uwsJcVfFr1ej6aLVY+HpeXDBNpsK7U/xy+9EoUFKB+/klcsApDwj0seqvgKShHOF9EdDu3QAoE0yEueq55yrUTSNub8kfzruwaInMPppG+sHMn1MwgFEYXAE/JnNCBNzlHScyMFBZ5RDxxzw9zHv+Gff/KdRH754/yBlJw2mohuDiL7k/3l+rCHSYsjXpzWs5zjMlob6uiY/3hXzcuDnlStPKg8TG1lUd6G2GeiQsTw3xHvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFBscHaqNNHGfNvQLG+fbAY/6IAEEow2xCf8KfyRWmk=;
 b=Ihfu61u+7roWNG5lyVPqXgyXR3aD1HEkKCrLP3le41WEsd5B9BWYyrizEK+DcdjAzr51hLq2fQ3vEY5ECdjiFrLFcG5iuRHiLUvL4um8zjqIbAkGgASUSACUo/spXnVR82Cssu1mdZWHBMN9fwEDSTsvIhfNzpfMOoL42vRx+FKQra6u4tSqGihWNnRLFBGw7kHuDNnTlcS+rhR8uGeUmB3posBgS7u6JGih+X+E3qgFsXI0NufyIdavGwU61Fx1iIVq+ZnO/sPMneQjpPb6UHrNjNZuEWMY095AgAilrwtO8vaabLj+5wPwDadwQPQBs8+KFOKa4Krwae3kotsv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFBscHaqNNHGfNvQLG+fbAY/6IAEEow2xCf8KfyRWmk=;
 b=X/+9hNni4AfbMmimLlhLo3ngG+BOPh9Iwh1H9mwv240iqtty2PYZLc3HN2G/oOXSs9H/8k85c/+8+fAA7tLRb0r5xoywe6rA7QTM8ZLbpkqH8OGvPHMiFVPglOb+m7TPjZxypnNi4PWD3Se91IIeSGWXFkDPL5NYz4CmsgNsFLU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB2000.namprd11.prod.outlook.com
 (2603:10b6:300:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 08:43:16 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 08:43:16 +0000
Subject: Re: [PATCH v2 3/3] audit: Use syscall_get_return_value to get syscall
 return code in audit_syscall_exit
To:     Paul Moore <paul@paul-moore.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210423103533.30121-1-zhe.he@windriver.com>
 <20210423103533.30121-3-zhe.he@windriver.com>
 <CAHC9VhQXawubMsKg2F282k-bJqZFT=vNurZAeAPKLU1ZZpYKeg@mail.gmail.com>
 <c8493e20-c7fc-67e4-f2cc-81601535f21a@windriver.com>
 <CAHC9VhTEcp0KHHt8fNgEXXUHtL+yJh9MtjEBrnLmT-Oumo-CVA@mail.gmail.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <e9f86d59-4541-d807-0b3e-df22dc650c3b@windriver.com>
Date:   Wed, 12 May 2021 16:43:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAHC9VhTEcp0KHHt8fNgEXXUHtL+yJh9MtjEBrnLmT-Oumo-CVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: PH0PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:510:5::17) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by PH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:5::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 08:43:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c69cdee-4e66-4df5-333c-08d91521fc2a
X-MS-TrafficTypeDiagnostic: MWHPR11MB2000:
X-Microsoft-Antispam-PRVS: <MWHPR11MB2000CBFE7D63C0DA77B022848F529@MWHPR11MB2000.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvfHk32XJYICkaAvtRbA0jzemMQnhy8EsAH4OHBYR3oBbgIDhZM9ponI8Ik3JPn8ta06pcJjCMMqA171MgcC3EIfH1G0w8XoohzAijeb74rwC+kgWVt2NNflFylUjECxBwfmhMHMuF6tzms69x6MncOcCTpI3Y0mO+EoP/JHZjmi9esNfoo8U5TekSGcbhINFH26EYagHzs0PTsdv4prorqLh9K9tScnoxSk4S2tWOoWSROj9HTJWsE/91WdvDE/rN7beOC6WQ5+xifmrY8ElgguTZUHZJP9uD+vxS5zc5MFExkgz1mKtwB3FGXclNCsYctBdqPME9tknV2LX03kA/3YU1KL6ck5kBH9S2a3OoVqrfQtINCNhk9fhMUQxCwMaq63ifA84DztVF9m+T9mrRDFaxg/rFGq+hTl6/v8uYsMriLsq2oyeRVMaFWK83rPuPsVCuChY4QgmMdaOwAzwjl00A2n3Re1Bxw2XciyV67E4fGu1LnT991+sAYfovYl7eoSpnYl1dPZhNbTHpB0D8kB5yyqsYx8jMJ2/ZxITniU8bHv36s/lEa/gl3s6ZIwoUu3iXo34FyucQSS0Id+wiNCR+67rM+ceUkyLVYFSK1sPnqnhPNXQ1AAgWDCtligkD5NmzTVQMvMOE2qtv08LMddZmh6xpkp+DAttLdTMBuC+VhmFPbF9105GUpUi71dXAxL6uzaIE0KHlyoP+WKm8H3MkLdQiCSliQ834cCYtInAaX0BWEsG9uInKcYQQe+OWDo55RWNX/zADAZ4EmUIeZ4D7XpLJOJuGAZiaMjXwGXnt4noSCRYRtaGnSDKzK7sXkWObSc/wQxj3E4qmpSWRpFGop65G2n7bFlpuFs3fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(136003)(396003)(346002)(186003)(16526019)(5660300002)(2906002)(956004)(26005)(2616005)(6706004)(8936002)(478600001)(4326008)(66946007)(66476007)(66556008)(966005)(6486002)(8676002)(38100700002)(38350700002)(6916009)(16576012)(31696002)(53546011)(83380400001)(316002)(6666004)(31686004)(86362001)(52116002)(36756003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnZJL2w4ODVWSHp3Y2hrMzRKcFU3cSs1WFhwZU9uSVFHaWVaVmorclQ1eHBS?=
 =?utf-8?B?cGU4MExYNkJ4emJxcnJNSWd4U2xsTDhhQTF1U1B0azloUnBuRU8vemZnOWo3?=
 =?utf-8?B?bzlROUM2a3RNUDh6V1Ewck8zMFRQWWpyZFFMZWFwWUNKUEZUc2I2THB0RXYy?=
 =?utf-8?B?LzVaclE1dXErTmdvZkpwdW1IMlhaK1drYkhYbGVDYU9jdy84RCtLbkQvMUJy?=
 =?utf-8?B?dzc3MTMyWmtLWVdmT0VBOU5xQ2VrbzdwSXhQVUFTQkpMWVBBeHkrWWd4V2s4?=
 =?utf-8?B?WW5HdkNlMTFVdmNHdUVEYnlzSEVJMWFCRExkbS93THNkYVk0L2xsQlhIRW1W?=
 =?utf-8?B?QU5hbVoveEFmRC9KdDRqaGhPYUcvcldZL3Bja01NNit3dWZnYjAyUTRycWh4?=
 =?utf-8?B?ZlBaRm1kQlZSYUdDU1ljcStKZ1g1ZFpVekU0Q3JxY3BLZWRJanVqK25mU3lE?=
 =?utf-8?B?cWQ2VkNiNUVFRVYrVnd2dlBITEZaZTFwVUFRWXo2Z0lrTHpRTmlkY29ZbzlO?=
 =?utf-8?B?bnJ1eWlIOHBOMTVSRnhHNGY4VDQxOXRLL0tvSkR0RWEwNUVHdFlBcWZYVlFw?=
 =?utf-8?B?K1NtL0dVcEFCaUlBN2ZLa29UWUhkUmxyQ2JDMWZlOHpCWndQTjlhZFRLdE5G?=
 =?utf-8?B?MEQ1WkVtOEtSUERzVDlwb0IvVHRTbHBYS0dLNUJTTFJhT1ZJamFOUElsQVBC?=
 =?utf-8?B?N2dSSjF3WHNqanV2dWY5c29vTzdHNlkxaHEvNlNYeHREWVY2eU5nMnhJT21q?=
 =?utf-8?B?a3RKVXQ0aDNRQnkrZE5nS0FVUklRWDhXdXdMNUJUQlJ6VkdUdWNjK0QreDhM?=
 =?utf-8?B?bGEvRTZFTHcvdDZYWEwwQTY3VHM4OS94T1hmdysxUm1lbG5SWGE2dzRTUUQ4?=
 =?utf-8?B?Z3NnQ0JMQUhPSkNON2EvK3d4YXJJc2dNbFNVSTd2ZlFxYXNuS3J1cE1pYUZU?=
 =?utf-8?B?RlRQaEYxdXpnTXNnV3NCOUoweGVyeEs4RFVEQVpmTysvWGdDRHBsNE8wZWw5?=
 =?utf-8?B?clNsb3QzdjJzeCtGWUZEYmJyejBmU3pnTVFJQnNIWGQ5a0lqMGlWMmM4SUxK?=
 =?utf-8?B?RS9YaVNHT040cmhYeXBSZTlwaEFMSlNlUURCMGFkeHRVWHNvcW5pODc2ZlV2?=
 =?utf-8?B?WGFXOVUvd1ZTOGFCLzNhaE9WQjhBYTlVRll2aWt3UzJjYXpjTmw2T2kxQVZX?=
 =?utf-8?B?NEFVY01hd2VrU2F5TVIydlptYk5HM1R0ZmptRkdnVUhNcU1GdnJzUkUyQlVZ?=
 =?utf-8?B?aE9vYnZ2OXl2Vm1qN0FkTHNWTjlYTHZnZDV4eG9makM0S3ZINmQ0QzdySXpY?=
 =?utf-8?B?S2thYkw0TGd3dVRVM01RWUxCRDBQQ05XQmhMSnVoSFhHYmwvZ1lzSFlFWUhJ?=
 =?utf-8?B?aitVOVlxMkhzTG9YbndmaGljSHIzWjhsdk1jR294Skt0czJoamJmZ0EzYkJW?=
 =?utf-8?B?S2dsNmxuUllDQmxrTFI0VU9lOTR0V29aaUhlR3U1b2puSkl1N1A3WU90UzZm?=
 =?utf-8?B?L3MyeEpiRWIvVXpad2Z2SDBaa1JMUU11YVVXZWtVRVc2MDlKUUxqcEw3dm8y?=
 =?utf-8?B?SURiTnJURnZwUC9Td2RXR0cvNUpRZXgzM2tWcUl3YTZ4aDduU0U5VEN5aUF2?=
 =?utf-8?B?R1hzZkdsK3FIV2dRQW1CcVdxbUhCQTJZL3VYTGFLTjAwNU5rMDhFMnVVY2d5?=
 =?utf-8?B?ZVgrdjhJcEJweUdJa1ZPdUFUVzI4VHg3Si8rOGxldEpIQk1iT0pZV1NQaEpG?=
 =?utf-8?Q?xm0dB6GZFHfBA8FCA+ilYrwRknF2Qjh2AR0H9pe?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c69cdee-4e66-4df5-333c-08d91521fc2a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 08:43:16.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuz1kDDIbIpON1FMsjJNxVSLZdUM9zV/bMpd+8gaYyUubN4+rb/im4isAB17qSABgp4NdcCD3vVBLxUjZv4IqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 10:51 PM, Paul Moore wrote:
> On Mon, May 10, 2021 at 11:19 PM He Zhe <zhe.he@windriver.com> wrote:
>> On 5/11/21 6:38 AM, Paul Moore wrote:
>>> On Fri, Apr 23, 2021 at 6:36 AM He Zhe <zhe.he@windriver.com> wrote:
>>>> regs_return_value for some architectures like arm64 simply retrieve
>>>> register value from pt_regs without sign extension in 32-bit compatible
>>>> case and cause audit to have false syscall return code. For example,
>>>> 32-bit -13 would be treated as 4294967283 below.
>>>>
>>>> type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
>>>> success=yes exit=4294967283
>>>>
>>>> We just added proper sign extension in syscall_get_return_value which
>>>> should be used instead.
>>>>
>>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>>>> ---
>>>> v1 to v2: No change
>>>>
>>>>  include/linux/audit.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> Perhaps I missed it but did you address the compile error that was
>>> found by the kernel test robot?
>> I sent a patch adding syscall_get_return_value for alpha to fix this bot warning.
>> https://lore.kernel.org/lkml/20210426091629.45020-1-zhe.he@windriver.com/
>> which can be found in this mail thread.
> At the very least you should respin the patchset with the alpha fix
> included in the patchset; it's a bit messy otherwise.
>
>>>> diff --git a/include/linux/audit.h b/include/linux/audit.h
>>>> index 82b7c1116a85..135adbe22c19 100644
>>>> --- a/include/linux/audit.h
>>>> +++ b/include/linux/audit.h
>>>> @@ -334,7 +334,7 @@ static inline void audit_syscall_exit(void *pt_regs)
>>>>  {
>>>>         if (unlikely(audit_context())) {
>>>>                 int success = is_syscall_success(pt_regs);
>>> Since we are shifting to use syscall_get_return_value() below, would
>>> it also make sense to shift to using syscall_get_error() here instead
>>> of is_syscall_success()?
>> In [PATCH v2 1/3], is_syscall_success calls syscall_get_return_value to take
>> care of the sign extension issue. Keeping using is_syscall_success is to not
>> potentially changing other architectures' behavior.
> That was only for aarch64, right?  What about all the other
> architectures?  The comment block for syscall_get_return_value()
> advises that syscall_get_error() should be used and that appears to be
> what is done in the ptrace code.

Yes, it was only for aarch64. No similar issue hasn't observed for other
architectures on my side, so I was trying to minimize the impact.

The "comment block" you mentioned is the following line, right?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/syscall.h#n77
[PATCH v2 2/3] was used to cover this concern. But as we can see in
Mark Rutland's last reply, there'are more things to be considered and we are
still trying to find a proper solution.

Thanks,
Zhe

>

