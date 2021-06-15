Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E155B3A756E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFODzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:55:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFODzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:55:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15F3mwv3113222;
        Tue, 15 Jun 2021 03:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=e5In0YuaEpsk6qal0b3SOPVSIFAnY8I1DcQkaO2fkUI=;
 b=GMhIrpRrEKZk5ikHtiXo2rlulDDcBKSoTaqGNykE2cXSli/sJ+TFnkg93jL66d55aTCC
 VTjNtTeagHOyqzEVuPWgebhBOlTZoYQ/iF0fe3YDC9yECbzBNeuNxUv2TL3AX0gnIN6q
 Y/NG8JraSKxcX0jxHcPzvIKY3Ew3RKiZb1vJEM4FS5zgaLcPYzmhVbS1xai9rJlF3Thl
 DNSL3F492F+kmZqBY2yE6brJQ0N0THu823YRIllVdkW8LumiiCzHzYSSTraYXLl9hHG7
 rwgp9T2fae60umQUVrJbfK1Ewek8iiJaASNK7Rbg1bc284zwWW6rMmhHu8BgYk6bBncx ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 394njnw011-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 03:52:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15F3oxoP070005;
        Tue, 15 Jun 2021 03:52:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3020.oracle.com with ESMTP id 394mr7x8au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 03:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnA/jSyy14jFRVNsZL+Da/7TzuMctmacxVrmIb2uRVAWIxUEI4Zn8MVwRqGYCTVIpbJ21KuP57Ozd/fqKJrUxAIR5M3yiATx7sMQ4At4ncug/AigHKudlJXb3oh/QDbav+/SLEzoQ4nUAwpZV23SnYbJg93pvDMBHdfYzFM0UZ0URrFeHO3qhX/XAJWZJh+VlXAy+RONNkhljecfReWd1Mksv/uMspK5V8DWVpMQQ16JeBIu2JZ4tzAPvUCbR7L7+EahYckOhH8UVQhJULndmTeBPR24Hto5XC5Ow0/ShUI0bKVPDw7OVZdeScHNSeTRyVopfo96vnzETKQP/K6+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5In0YuaEpsk6qal0b3SOPVSIFAnY8I1DcQkaO2fkUI=;
 b=MLks3zzpjq3RS5BP2KUgJRzi6EDqLO0cqRZBfgSvGCmWMRAhilyBHAzuUGLkfh/NGbTsrq1P3jA+EOq1yWFmBQsJI6ALZhOUP+g1JN2/Z0xBT2r4PUA293CurgCaskrDD5ucujw1NCSrdQhhcgWjKGGXCux/nqkBwEnM1eUZmhvyPC7JkIo7vMzHZX+ecSMfAa/YJHoGvJvf46RBpAq89yA6otwmNnl3oh6nrxX71CFoxGRptkrowiFfujIVicEjb127FKVSTQQNx67hGJmDiZMDTV/WN82t3iRSVGg8mD2Zb50Pe6w2/unPBXSEVl+noP7BI6/HUv8mQmzoLZKuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5In0YuaEpsk6qal0b3SOPVSIFAnY8I1DcQkaO2fkUI=;
 b=h8YIXN07to0McHzK/fjjaPHnesu4zMXA/Frbc55HNUdECeULZ/m5i22hUPlXN84BwnVVjX1uKIQ8OLU10QN2iRyhI/+uEf/6WgdYkxQqP9MLLN4qRg8g+hU9vW40/zFQiQBvGIz7Ix0FHPv0IilPlafqKmbimdxTfF8nsrvq5rI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3446.namprd10.prod.outlook.com (2603:10b6:a03:86::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 03:52:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 03:52:41 +0000
Subject: Re: [PATCH v2 0/3] Split huge PMD mapping of vmemmap pages
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210612094555.71344-1-songmuchun@bytedance.com>
 <20210614181237.5513724624dde3ac930b75d8@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fe65a409-b989-5e05-952e-6fcf6aa2ab55@oracle.com>
Date:   Mon, 14 Jun 2021 20:52:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210614181237.5513724624dde3ac930b75d8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 03:52:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 106e39d5-4499-495f-dd8d-08d92fb1064b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3446:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3446CFB848DC221FDDABE084E2309@BYAPR10MB3446.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACOHzyg5KqO9TDC+U2Ukm6JY8h6G3zFbdlkW2GQszYsNKHjVKo1uWqbCtbfqelKZceIhHl0yYDfrsPIlLfTP2Xhpo+nBCHCZgGId5mF0mD+ybpUkLBH9otEhOUgk6hl8r/hfp5wJ94tz8SAtfiTUbMNMlAAtDJbbkV2sLfls1w+1IGFT8TrgA6U0tPXvOzkiAvSvGycucJ1D9XMAU5NXxyz6N+acXJBZesZ0OM1svUa7C4PbVtaYwFuNrCaZ+GeI1FiugtrWXZltllAkFcrHKEmQKNv1jB/eHxuvLeLDQwylLjVyk0MZ/QvxrPnUDQtgAtmxCwm1dkrfTjJxTMofTURgh1Z6nuZBFhwYpPK6J6/0RFzO3giL0OvPEUrOxirEJtekmzW4vwLgTs2cJYffni/J+ijqqSd68SlYsG8hTmCefh8Truc7x79APYOAQdV5zwDzNo+KyTPHLrjcVB9nwHpHMIkmqA/mePowlPfOzNUHjoHxkaV2r4eoTn8s6HnGcNIA6XQP6/ekoE6CRmxb5hDaenbOEqCXE07zT075b9mvA3J5nL87gkEhHXUYFj9sDbd/NWi8ZlspDZ9+DwtR+LyloCdb9J+qgaQ+aoWYT/wCLXTlwh9K8wjgNTAVySsaL0U3GuZHhlQlGDRbluSU10eMXVVQsrWQ8z5qnJeCNloQ3xlmZRuGBdI3gXNODl3VhsCzUfBTzMx4zdeSSKL1wRgjtRmBvsxFEFUOFPs7Ul+nYDaUKtNMGLEPcUDgeysxQJDb0towvyjA07sH5+2+CrN6tSn4bE5YZRJ+GbmUKpIFdWJpuo573yqXEE1Ol9wTonIR9zx8P2ox+w9GSo3b7CHTnqTVDfCMZjxFc9saxqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(39860400002)(346002)(53546011)(478600001)(36756003)(83380400001)(38350700002)(31686004)(5660300002)(16526019)(186003)(8676002)(38100700002)(4326008)(110136005)(2906002)(6666004)(26005)(52116002)(966005)(31696002)(8936002)(66556008)(66476007)(956004)(316002)(66946007)(6486002)(44832011)(86362001)(7416002)(2616005)(16576012)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmxoTlJMREZVdEJOc3hCbEloRXIyQW5vS1A4dnVlcG9DYUh2Um9zbXMwZER2?=
 =?utf-8?B?ZUJGR0cwVGY1V21TTzdMQ2hZeXlMRXFEbzNmem5ENDhhZU9hOUZ6QkVrK3NY?=
 =?utf-8?B?SlBWeGIzaHNBVGUvanExd1drdmVkNWp5b2hFOXo1MWVYYks4TVFLZGlRN0lu?=
 =?utf-8?B?VjROajdwbzQveGlWYkF2YWZWajlHTnk2TVVralV4WG8raW5IZENPUmNzV2RL?=
 =?utf-8?B?bjBudXdSaHlya0piV2pJS1dPeVQ2d29DczBGWWtiaUpiTm9vdlJua3FPOHlz?=
 =?utf-8?B?VFBuekVSb1ZpdDdSOHFqdm9kY0lHeUEzQjJZL09WQ2syTkMxVktrN3hNa0VO?=
 =?utf-8?B?eHdGTUFPUThyR3Z2d1dhUkhGdENTdmRHUmVjc0F0TFRITHlOblFrdzZwajh0?=
 =?utf-8?B?ektRVFJHTWR3MUkzUk9Va0YzN2RLdC92eXBHRzFRRjU4bkhkMXFFN1M5WlU4?=
 =?utf-8?B?OWdwQkdBMWlCUVRKaHhHWHFOdzVPUExmcEpLNGhRRG9iY3JEdXJmLzJOOXpX?=
 =?utf-8?B?S3g1TmVJNkhNaFIvU1ZHM1hZQjQxUEdwSStaS1lRV3BIQ1lQWkYrczVVZ3Zt?=
 =?utf-8?B?aXdqWWlta3dpWDJld2wxUDVsa3RVSTBUQXptdFdLR3dJUGRTaDFDL0JLTm5q?=
 =?utf-8?B?QTBEMDZ0TzBRNlVuQzZiNEdBYTBBM2x2cXRsdXljYitmSEpaTDBCR0FvNzIx?=
 =?utf-8?B?RUR4M3VsSHFzWXpZRWtFa2Y1cFZ0a3QrZUNEZHdSYmN6UzlBUUowbjZZcDgw?=
 =?utf-8?B?cTN5eC94MlVyWlRmZW9IMmtkSzY1NWJ3U04wTC9lVWtVeXp6Z2tsNHBYenUz?=
 =?utf-8?B?YzNMbWxYa01FZmIxdW95K1UzK25Yd3ZlUDhMUG0xN25HUlhLY2FWaVY3ZTE2?=
 =?utf-8?B?Q0UvN3ZXSC9rVGkvcDRIWkw4WWRiZjUvVnVLZ2RISFNBSDd1eXZXTzFMZmF0?=
 =?utf-8?B?bjNMRUplTkdhd2FBWW1kRDhkbmYxYm9wWkVNc25Ra3F1MHlKQ293Tml4aFh1?=
 =?utf-8?B?R1Vjc3JaSVlRNG9jb1JGWDVsWXZ0YzBxeUdYcU1sbnFFSkNkQjFqVXRyaFJx?=
 =?utf-8?B?dGgxamJiKzFqc201TFlaNGthdU94M0t4QlJRUUdLV3cveDZxR2IxR3h1ZDdy?=
 =?utf-8?B?UnVzQWhxbG95K1VJbWE0ZUR3a2pBd1lzV293Nlc0WjNoSjlsOVp1cU42SzRy?=
 =?utf-8?B?WDh0dkNSUW54ZTdFWmRMWmN4SCticXFKMldaQnFCOW4yU1BGUkRBU2NweFd6?=
 =?utf-8?B?enJQRU9JN3MvS3NrOVJYUHVjNW1VK2puSnR2ZXR2U2VkTXY1STBGUE5CWTMr?=
 =?utf-8?B?ZWY2a05VaHNPSFcyaDJrVlRiV25PeEJ2VDB6cncwZzJQOTZ2Q3dHTnhuWVNM?=
 =?utf-8?B?ejVFTmdkZXIwU2pEVVg5N0o3eVk1ZERzMTUzOENyNHd3UnNtLzVVQ1E3QWU3?=
 =?utf-8?B?TXpMNFRBbGxxZDNtdHNsUHV1d2UwMXR3dWcxRm9EMERCYWwxTXBxcU9LdDIx?=
 =?utf-8?B?NTNDU01EQ1lRdTk1RHZ2dkk0dGZERzRLMzRVMmRsYk1JcWpyWlNNdFlvOThy?=
 =?utf-8?B?akpUNDI4WEFLM0NNTDZHN3JrNkptNjcxSW1LdVF0aDh6U2NIMWdUNUg5eTlD?=
 =?utf-8?B?ZjNHcjI5dHhvZXlXdS85bkZjem0ycUV1SURrOTN4d08zbUphSis2VTUyRTc1?=
 =?utf-8?B?Zzdidk9pSEVaWFZGSEFOY3FmWDNpL0NMRENvdnZoQ2tGRmFtbGVzWGxUaXFM?=
 =?utf-8?Q?5cfdSgQcGwOWAzvsKlvuHK/RgMnbfMFhSVXP2cO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106e39d5-4499-495f-dd8d-08d92fb1064b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 03:52:41.5368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydlq2bokSgOD2LFkyDYrFBSYd0rdo92Qmkf85qz0NfXi7suQ/VU/9SIybOnBxf6hhC4EAgSH/BlU2/LzyFMOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3446
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106150023
X-Proofpoint-GUID: nJBM7X-Wm_VpNCGiFk4fEIsI5WJHMu0O
X-Proofpoint-ORIG-GUID: nJBM7X-Wm_VpNCGiFk4fEIsI5WJHMu0O
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 6:12 PM, Andrew Morton wrote:
> On Sat, 12 Jun 2021 17:45:52 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
>> In order to reduce the difficulty of code review in series[1]. We disable
>> huge PMD mapping of vmemmap pages when that feature is enabled. In this
>> series, we do not disable huge PMD mapping of vmemmap pages anymore. We
>> will split huge PMD mapping when needed. When HugeTLB pages are freed from
>> the pool we do not attempt coalasce and move back to a PMD mapping because
>> it is much more complex.
>>
>> [1] https://lore.kernel.org/linux-doc/20210510030027.56044-1-songmuchun@bytedance.com/
> 
> [1] had a nice [0/n] description but the v2 series lost that.  I could
> copy/paste the v1 changelogging but I am unsure that it has been
> maintained appropriately for the v2 series.
> 
> I think I'll pass on this v2 pending additional review input.  Please reinstate
> the [0/n] overview if/when resending?

There may be some confusion.

This series is a follow on optimization for the functionality provided by
[1].  Early in the development of [1], it was decided to drop some code
for ease of review.  Specifically, splitting vmemmap PMD mappings to PTE
mappings as required when hugetlb pages were allocated.  The
'simplification' in [1] is that if the feature is enabled then vmemmap
will only be mapped with PTEs.

This series provides the ability to split PMD mappings 'on demand' as
hugetlb pages are allocated.  As mentioned, it really is a follow on and
optimization to functionality provided in [1].  As such, I am not sure
that repeating the [0/n] description from 1 is necessary here.

In any case, this should be clearly stated in the [0/n] description of
this series.

BTW- I did get through the series today, and did not discover any
issues.  However, I want to sleep on it before signing off.
-- 
Mike Kravetz
