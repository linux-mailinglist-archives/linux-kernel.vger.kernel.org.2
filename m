Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A63F26CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhHTGam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:30:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238427AbhHTGak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:30:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K6Ap1J023472;
        Thu, 19 Aug 2021 23:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+hSC5hXBhc1Ziv3LvhCQmO2SmvVHOsbY0gBOmSjqd6c=;
 b=C0pfYhvsG3ZH5boxPW9zWa1SnkhpnMCIGaog+ke4/xfrwBIdUY6mNVKf5nhD3lgpKl5h
 izz//LcnnWDGqKRr02ljN81DkcZ6iCEg1hLJhDzZuJlf99Z2FwxlHTr7YJ7QH8O5AGGU
 i39QXgIlieOLsLnfYfH3okWuRM3Gnk4sQeQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ahrtb4xa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 Aug 2021 23:29:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 23:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSvpHM7vxV2sMorw0bivDrZ+dtWva+5HP1lfSOHpS3wTpB3VltZzlPbQbvtJMT2wYyFJ8mEWeKpoGxws4vDDqS216WKbgFE6U2PcguR4mX7Vmyj9ehL7Aj8rgaRp2X2hPFmzayRxd/O/VmhMVbnqaYZ1lRFTBW90pBLK1nhh91BAuWrKb9sQ6WqpoIQlPjeDhwVjbJOuG47otk7phWIpjg2VjujV4gBTNBVAjL2N04JncxyhH13ijQlg7LHtx1Lma8gYxv17qqw4p9/RXDywyO+0m9hCnA2MQX10g4fpnnvd1PdfYJ6TdXRsdrdcxeVEiRi7TTNNXOB1vtvQSkvlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7sW4DRVm0TobIgTYrYcwS0n1WUSwpkYkk/sT9PMm80=;
 b=cdYqxIsaBrazXfTNkRCaI9RpsJhmPvye8gJrDfkHQ1U61vXnkw8KzGQPnG3JVnOUKksjpAklVzcQZKm8qLQLZQeKUrmWnBGDi89CwtXPEGrX+KrdK/ISrcPT7CVZbgRSE8kxfePrxXiRTyXVUmEGducjOaGP/hBPQquMyAoJ3jbdP1leMoDbu4aSiXmVKO4xMRNNmKoYaoAc5u5veythVi25BVy2TvPvZsFz9j9Xx8M5rfKXwB+hKBGvxNTY6WvFa0Q/lFqm0MG3vs3nQNMcO0J8wcIKLBWF7MaODQmLgimw72GfQtdW+/EilFPnDAtyFpRVz+5yNSlfq2l6O5yO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4045.namprd15.prod.outlook.com (2603:10b6:806:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Fri, 20 Aug
 2021 06:29:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 06:29:30 +0000
Subject: Re: [bpf] b89fbfbb85: netperf.Throughput_tps -21.3% regression
To:     kernel test robot <oliver.sang@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <lkp@lists.01.org>, <lkp@intel.com>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>
References: <20210820055009.GA29369@xsang-OptiPlex-9020>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <449d7b62-9339-2d1f-1798-2150e2764063@fb.com>
Date:   Thu, 19 Aug 2021 23:29:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210820055009.GA29369@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::184d] (2620:10d:c090:400::5:468b) by MWHPR1201CA0005.namprd12.prod.outlook.com (2603:10b6:301:4a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 06:29:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15355cd6-4002-4b81-08a7-08d963a3dde4
X-MS-TrafficTypeDiagnostic: SA0PR15MB4045:
X-Microsoft-Antispam-PRVS: <SA0PR15MB4045374E23B2CFD9E4C61F8CD3C19@SA0PR15MB4045.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rjh00JoSLXNFd0gIRgWvU0iDMQvomoAX9oU2qt30RXpKhlE+xmThKkNGXOVT3P43kcCATBZpalZsmXrRALna8t9Dnqfbng0RfhfwImc/tCfRmbbC007+pGU+rWboDpC56PQvIfOLOGSonWTP5dQB4T5xf3ZrVJg29mHZ44l0W4npcKmilOu8iY0FF5zqqPnOtkXd1DS6YQCjR4YhgHLtfXafZVmSwg6D7lrLBZC36yXnrlKFNPCE8tMm6tDN/xH0iskWYPKtaSRDONvOkRXQBcTippGCa+Rm2893IqxrSjTK0ivYp7tAP6N325Fj5CbNltmbrIBZlleKMi0Pke5qbPiT6C4r4f3UmNEtgzu8vePURplw/xKfrxlSneVMPqHdZt62uUIub5hsRe4tl7zrJoE55oWHVA2AyNI1PH7P0jX4KqARInaoOa/C8YEabjhRsIvgxW//X55chNaOiNJJscW0MlsCVYClH9FbnwcXHhLWo7yrFZnL3xIfbetgBuBXtkDXEwjx3PAFvlIcszYoiiegA//Bzzw0bv62cl/1SOsyhg6vtiqmHaPh4whbFnGPNr8uiQsh9SNRD1DSn7wf55EUVOUIfps7HDezKWUq1OMzUgnAlYJM0Y9Nz1SDUBOMzLN1BstAwXpRdAyW/3iKwrazlZ82nlEXrXk/gzJRXFRqYP2ysO1YlqwO6gTQ5/QiF7NjL7r5+BpA+3Ikd/ov8PtFkv5UuvzFIpflklEL8rQnx9ZIDs/SgSQUsNwkJnjKmVCDAwhIBQV8exhMDdmyplgX8ZPg05MDyHYA33F6SRwDlmRvGKzewC070y9k6bSe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(66946007)(2906002)(6486002)(36756003)(66556008)(66476007)(54906003)(52116002)(478600001)(31686004)(86362001)(53546011)(186003)(83380400001)(38100700002)(2616005)(966005)(7416002)(4326008)(316002)(8936002)(5660300002)(31696002)(8676002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?1hMSSfyaa2Av/QLzsUaZKI34kqrxWMZFSwd0jnGxSG0BVHsx+PBnfwXB?=
 =?Windows-1252?Q?5ANtQdisf2Id+2XxbCFtzLMqP2ySo7WSbrTGNTZJZb7q2r5g1QN3s/Gk?=
 =?Windows-1252?Q?5/PCEPvd2dB/GFT2KIWQ8rW2Au4ZzSO2b5GxQIRI9cSrgK062aPDgLTr?=
 =?Windows-1252?Q?KGW0Cd2a6ZzHnlvP+mVgq+cwCs9WvSGzJ/YHLqdgdRX9nX/JflGWdkaE?=
 =?Windows-1252?Q?47FHg67u+tLDkJtNqKXIsCC35TVdw6MF8Xgt037UiT5PQFTz43tTO1hO?=
 =?Windows-1252?Q?cJzXe/wpmcUcrdGj+9ydrKG/aLNDFpMvi/qRtPuWbeY/DCSv+71hdbSG?=
 =?Windows-1252?Q?a/xa8NT4jLiruajRLN7H5buzilvI7GgF4oZN6usgi5EV+1S190KEQVXy?=
 =?Windows-1252?Q?zkkVCYKuGT7DzJuA6GTJEBys3kIpueq+ibSjNQBSJlDnt87PJQu1kWJN?=
 =?Windows-1252?Q?U2k9Zj0LWlbm+C3L+hAzA7VLSJJousfSESvfJmTiN4zvo1NCwRfTMVXT?=
 =?Windows-1252?Q?8TCT/bYXXYjM4z6HoeGRYT9zE6oJZSrsSXaFZN8G/6edqzL7qSizoyJA?=
 =?Windows-1252?Q?JqrVTG3sF4j1uWh/uunZnuy46KkH0ZI1z1Odb0QIT+9T9k2A5gH/H2Ot?=
 =?Windows-1252?Q?7q0FCPA5dFxvFnPSoLvwe1VoQywJyiKw6f4UOZTVrHoi4+MWzuffqKRm?=
 =?Windows-1252?Q?yCiUbbU42xt1EdjELw3hTh3mE1esDKLFhMBfbqAezjve21W0dc2fIE6a?=
 =?Windows-1252?Q?kYXqG2h0mIbLjR7Icj0bM6b8OUsaIRQOZQKt/zPBEOTyMtaVhGjotRuW?=
 =?Windows-1252?Q?poEQsRi5L/56LDif+wg1Q88aiE7iTzTLBm0rVnGoTGslaBmnakDXfx1n?=
 =?Windows-1252?Q?nFFyp8Ib6a48uBEn9cfEAhL+wd8oHUE5e8klSfFT0U4FlGYnPOwuCrN+?=
 =?Windows-1252?Q?wqXrXmB2TAUCfoXnuXLt6Hkmr1qzmNEA/dWblpwo1kFEG2dPoS6WUqlz?=
 =?Windows-1252?Q?ZWKuE66X9s4zb3SzRkOOVX6nP4ZdtGkqx5+TsSj1Qv13JYMzrLYweLqE?=
 =?Windows-1252?Q?T4iUaHM286Xx/mBcui5rhlNq0rZznKgJK4b5BOhniGUBRUHO05t5H5ul?=
 =?Windows-1252?Q?3YSiFnr58uPFz9BE4JPF5rr2ANiZhz0iUxSmN6Xl5Hr1cNRNJi1sYOS1?=
 =?Windows-1252?Q?pULuDcqZj/SY78wRwGgXs9SLt86CigHiKSVuut04rD7N50oikdVxmPKM?=
 =?Windows-1252?Q?1mAIDp5h8FfYRwmZDFONuFnL9RFuoqVkqBOzGgF/22xx0giH9mlkr126?=
 =?Windows-1252?Q?3VX2F071FQ0ek+kL6Qwo1N3ojakvnok+8pncTuyrlQvLXUPJv5Ib/RE+?=
 =?Windows-1252?Q?gfU5ZdhJOmXhXxmZwyLSLiSxCMSpZM+BtAuOPKwoY5GWH+GIwNHsg+0i?=
 =?Windows-1252?Q?XWDQ0YEy9QMabP9YOz1VHw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15355cd6-4002-4b81-08a7-08d963a3dde4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 06:29:30.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6IKTryOQggVYde9CZez0nkUVaoHYKuQd1DFrRzYnNGftkpnQJiril11QBUvygvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4045
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ON2D7jTiqxCvRbCkhZQ2dZ8wnkpkrKtr
X-Proofpoint-GUID: ON2D7jTiqxCvRbCkhZQ2dZ8wnkpkrKtr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_02:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108200035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/21 10:50 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -21.3% regression of netperf.Throughput_tps due to commit:
> 
> 
> commit: b89fbfbb854c9afc3047e8273cc3a694650b802e ("bpf: Implement minimal BPF perf link")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Could you do a test again to double check?
The above patch is related to bpf perf_event area.
It should not have any impact with netperf.

> 
> 
> in testcase: netperf
> on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 16
> 	cluster: cs-localhost
> 	test: TCP_CRR
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
> 
> 
> 
[...]
