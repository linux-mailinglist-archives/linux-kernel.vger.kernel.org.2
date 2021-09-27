Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220BD419185
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhI0Jau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:30:50 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:48274 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233587AbhI0Jat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:30:49 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18R9ImNH009120;
        Mon, 27 Sep 2021 09:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=7KI9AzoZqydn3jSxaiWho3+zoPX9dii69XeuI95S0po=;
 b=LMUQonHTiSQ9OjIwWzjS7QiQ6w0cgEZOALZeCKB+/RwOYcnkFLjsQyQ4blBUdMlPeRGB
 CVNEo11Rb9CsNtg9EeVxSH7P15XKeFchK8m27EsvQC89qUU8CqCfc8NbE8f7AQ128D3w
 sYxv5kSrbz3VK8+gI6loCcRhoiQzA1qQLXSF56nGGOrpYNMWhb6gLDQow2xIPNo0InyP
 BOBoueT5O7K1LYhLLrOn6idykCJOHZTsnGysE2JJCsRhTv49/upNQ4UsuNXmAI4OYuSm
 qbOsu1YXi8m0hgOADZLYjE6klXz1pw3uf7NdLiB8GKUYKd7IPFdOWx5WbmYBZRUHMbPu PQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bb8nhr35p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 09:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTSb/YUFa4+SIiE7BzFSzetxZmbTTVAVpBvEZRmqw1tTUXsSjNfuXuyn1TAfbBZYBO3bEXrapPfFPY7uvxG0pPE03bZUTGaWD1G78WfIUI2k+KubhNOwMlyPG8JxRHhVuwP/nx73RuyuKmqAaom1ViP+/ehYjv5rh/iKVTCi0ZC3FJv1CEIaBqu/GA6SrlWqs3RdRnTArTK1ifum1FQtN5FupAYEFAQsMilJYLOXOvXcrXVlqMhaofN2SAlzUXmK1x+U+vfzTdXW/A+8n8lrA6GXrbALfVW7lUkmR0RQzXP9DMcLi6xK7jnG39sRQxUiIJxCC9Jddahsvf/Cx3khWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7KI9AzoZqydn3jSxaiWho3+zoPX9dii69XeuI95S0po=;
 b=Xk5OSdlnhPUVizDORHCyuk53KxAbaF71MRLIvHvY+rk8CPzJPU/R9U8UWoNFagjJ4N17Ao8/gEk7d5Br+N2ItTAMLS9HX2qTINuvgWeuZe7qxSabMbCSKONs8WUkE03FEc/dkCBoJjEKOhbrCHZ9xxLmtAw8eJiCa7kaxC+N5d9dgKl4BVg6RHRUBU5BHlOZdRo7hv0Axt/ly+P43XocXa6pYpE9gb4Malg7E4+VD1nd2ofTpgpqdCooGsZ9rhJSE/APGW+cTAq/2mEIObUKReILnRGaf41zNuC4RkLMPHBvbWgWvC6eTbKMytOqy4R+CnrlEaK2wphYom774+tU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB2809.namprd11.prod.outlook.com (2603:10b6:5:c5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.18; Mon, 27 Sep 2021 09:28:59 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 09:28:59 +0000
Subject: Re: [PATCH 1/2] locking/mutex: remove rcu_read_lock/unlock as we
 already disabled preemption
To:     Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210926101624.2460704-1-yanfei.xu@windriver.com>
 <9569eee4-266f-d83b-2af6-194a1a8b165c@redhat.com>
 <70424003-1b4a-bb92-1123-7820d6321717@redhat.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <0222bc32-9807-8bd4-bd76-dbc62f512435@windriver.com>
Date:   Mon, 27 Sep 2021 17:28:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <70424003-1b4a-bb92-1123-7820d6321717@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from [128.224.162.160] (60.247.85.82) by HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 09:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539ca0d7-c74c-42c7-81b1-08d981993c1a
X-MS-TrafficTypeDiagnostic: DM6PR11MB2809:
X-Microsoft-Antispam-PRVS: <DM6PR11MB28091AA113B8C7F25FFA063EE4A79@DM6PR11MB2809.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VusDSzhxE1du36YRX9IjfYjaMqoZS0mmHBccRRHGSt0qkknIwv54iTNiqoakJYKXAygocNCU3PmQf1XLTGetx+931Cjoh6csHpODImDTQ614dQxUgmPt2Fq/PAiFDYSlhWBtqR0Q+Jsu3yfbpvZO9cULqB9fSks2Uotn2Re/L7/5YsjbCgE8YyI/pDt7gebSmKJy1gLWS3ibDJqLI9orV/XkZZoKoqqCK8IuDBooE1Q8gaJk9XOPlAT9JxETTXEn4uK4N+Rbr5B56FMQ7fXX5kbRh9ltlfzx2tN3u8q/FJ16albjFr2sj8OTM12Fzxm+bLOmRgA4UUshiYEZRhcjcU2EYI0kDcEU1S0Zr7JSdXAIzMGZp0negVMh4suJMCSA6FO5HwO5baeAERafXpeONcbv+ROKfnPBOowBAJvKjHWgj/+lK9fo/NXn0o5SzouF8Uf+UzkTKLaOfSz1RCg/K+ZDWdzP/vSzqPP3kBTJIIiHFvOFAEEiEi7AiaWA+lh6T4Yr6ipxnYoz7E3xf2fepnUehI4lXIQXBoXMGxHm9UpdBG2eFgoPYZg1RrT60FBvwP6SVYktjrG879dVyVoGy1YbUWyYIqVgRotTC2ey0QYv5IQcajLLyKkOf5P0Qaktjn2JuWf2lVoqlTXrbTXtl090hgVMryNIc/Sskvwy9ahpfO61LATLsYRD1Sfz+iWu19aTuc9R0AN+pUaX+2WoUAQumbhbHFjFcAtLHP1IbtnJAbFTY0sE7MPx/VF0QbApiTH4a3NhEilZavQwo5/fgn2USkWCuDY96fXH+8sGVGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66476007)(4326008)(52116002)(31686004)(86362001)(508600001)(2616005)(38350700002)(5660300002)(316002)(186003)(26005)(2906002)(38100700002)(83380400001)(8676002)(6666004)(53546011)(31696002)(36756003)(8936002)(956004)(66556008)(66946007)(16576012)(6706004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnl0MWc2ZE9zdCt2eUlrclQ4c2dNd3QxaEo0YVkrL3IzRWJsQUJCVk5ESExC?=
 =?utf-8?B?VEVmdnBRQ2I2YVNQS1VhTTl5ZXIrcUFLR0xUSDlYeHhYQk1LL3VLdFQ0ZkhS?=
 =?utf-8?B?TGUrS0JCclZYaC9mYk5zeFlqa1hyZlBUS0YwbGNSTG9VdFhzKzEzcGFTR1dT?=
 =?utf-8?B?WmtpSXY2ek9MQ3FpcG5PMFZmS0lIL2pOQ2pxV3RZUU5DeUhLVmZCL0dJdkxJ?=
 =?utf-8?B?N0dtcEsray9KbUFHbmhnSzBRaTZ6aUVaR3M5OWtIV01VelJXbzFwUjdZSUZJ?=
 =?utf-8?B?NSsrVFhCbEtwNjYvR2V6dDdwNmN2RVlCWkFCQUpST3N2RkRtbFpUanZHbHk3?=
 =?utf-8?B?RkdlMEJURFNzNVRPSThWUksraVNMUHRzVjloYTd2eVJmQ29PU29LNVkwNzJV?=
 =?utf-8?B?cmE1VnB5cEFMS0gxL3NXZzl5MVgvMFVhZHFMYTZXOUpvN2Z1djlMMDR0WUNi?=
 =?utf-8?B?eWh0cHVBZXpieUY1dkhyanNJM0RQMkpEZzY1cFI0R2ZxOUtvQTdEZlZvczA3?=
 =?utf-8?B?TU9BVG0zbmJGRGRnR2xjcWorQXlHQTlmWjI4OWNZRHpjQ1hRQ1JIdHNVdUJ6?=
 =?utf-8?B?NGpiTUxPVDB6TldQaTN2K3V1Wm91QkNUTXpZUStLMDNZYlRQbHFxaFp3MVZt?=
 =?utf-8?B?OGZjbTIvWHdRbHBQRDhqM3BrN3BzWDI3bnpha0NVMW1MYnVKV0hhRlk0Sy9Y?=
 =?utf-8?B?VjZyWGVFNUppNlovb3dTa1grWXVQY1FmbXM2WithSkRReG1JNDk2RkZSVnpa?=
 =?utf-8?B?UTZnU1BFYnp3c0VsMWRnSDA0VHRVR2ordGthcjZNWlgxSHRUU21id3ozWmZS?=
 =?utf-8?B?WFkwNnZYVzFvaVVFdllCL3RxYllOVXBBRllNcEZ5NkZLeWlWVEt6ajh6WGhN?=
 =?utf-8?B?aGQ5NmpEam5ISkYvM2M0ZHFyYmhMR0JtRDZ1WTdGNWladmlra3ZXeFNrTEZ2?=
 =?utf-8?B?dUt2cHlTSndHeXA4TGtIQ2hrYkMwMGwvSU5xcUR1VWRsRHgzTkR0NGdtN1pj?=
 =?utf-8?B?eWNiNFZhMjJERzkrd1hEWlpWcWxiL1JRQWJtdlBRdkpCZ3NGM2Rzd3YyNUJk?=
 =?utf-8?B?MUFwSTZsSG9ZWkdJOGdkYUJ1NktXMHlZQzREY2lQUTEvR1dacTE1d2JCU1B5?=
 =?utf-8?B?WDVodFl0QkVpbkZBZXRGTkZXYXhPanJtSFFsWEthWEpxdm9MQ0QxbThUREVL?=
 =?utf-8?B?NWFGeXZ3UUh3eXM5WkRsVFNrU091MU9IVDVpRkt4bXNVVmlDenBKSVhxTlQy?=
 =?utf-8?B?UEE2ZVYxYzBnT0pJcjJmMVdzQUlsaG8vL1l5TDZYdWZvc0NZWWtyVW9EQXVt?=
 =?utf-8?B?VnN4c0xqZjUxL3NEOFU3R2tuOUw4ZHBoSG9sTG5sa0ErSjN0aFlCanMvVExu?=
 =?utf-8?B?eHdmOUhQeURWK3gvM0ZQNWhvOVhvcGRYMm9RcE45bmdIUVUvUDRTY25rR0Nt?=
 =?utf-8?B?YUtieUtjWFZ5YmZxTjV4cWIwR0pRRVJCcGdJVDR0dEdpTERsTjJvNmowL0xj?=
 =?utf-8?B?eWNMakxmVVJ5S0ZhdnVFMDdFamdwb2NqTE1NdzJSZnZpT20rdktMM1JxNDF0?=
 =?utf-8?B?K1BwUFVwTGU5SVZJYmxtQStTNDVqZ0RIK2FYZm5wVk5XRVc0OHBXdkV3Y2kw?=
 =?utf-8?B?aXZLY2NQVGhyQkY5K24rdUtIMER1VTJ1b1pKYWJjT1huUWlRRXpZWFlIU0tW?=
 =?utf-8?B?YzZKOU1qd2hWVU9ZMEUxUmR5dzQ1V1pLS1duVytjRmlWbmF4YU1PVWxuZ1lG?=
 =?utf-8?Q?39K4sn7jiEocyrbSXsEUEDUmyfin0vP8x47EpMF?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539ca0d7-c74c-42c7-81b1-08d981993c1a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 09:28:59.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie5x8NC67tYstsOHlI4rVmSyoDyrNZPLciYYjWrLIeIWt+p3q1xB51DiA5Gu/OSdQkvSOb3U055GCLN8Gifiug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2809
X-Proofpoint-GUID: QEP-zk0Z0daUsT0qTzXy2QqObD71ld_O
X-Proofpoint-ORIG-GUID: QEP-zk0Z0daUsT0qTzXy2QqObD71ld_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_03,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109270065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/21 8:46 AM, Waiman Long wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On 9/26/21 3:16 PM, Waiman Long wrote:
>> On 9/26/21 6:16 AM, Yanfei Xu wrote:
>>> preempt_disable/enable() is equal to RCU read-side crital section,
>>> and the mutex lock slowpath disable the preemption throughout the
>>> entire slowpath. Let's remove the rcu_read_lock/unlock for saving
>>> some cycles in hot codes.
>>
>> The description is wrong. Preemption is disabled only in the
>> optimistic spinning code which is not the complete slowpath. Even
>> though it may sound reasonable that disable preemption is likely to
>> prevent reaching quiescent state, but I am not totally sure that will
>> always be the case as there are different RCU favors.
> 
> It does look like that disable preemption can serve as a substitute for
> rcu_read_lock(). However, I will suggest that you also insert a comment
> saying so and the task structure won't go away during the spinning period.
> 

Will send v2, thanks.

Yanfei

> Cheers,
> Longman
> 
