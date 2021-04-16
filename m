Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAC362905
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhDPUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:04:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9544 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243242AbhDPUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:04:13 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GJwuqo023156;
        Fri, 16 Apr 2021 13:03:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=MDUCQutxMdN1acoEnlnMVm51qtK28NG3OzP+Ff6Qj5M=;
 b=n+xBKngh9PD4f/z13QxyKbum0jGG7KbDaduH7fLZsnKNrCHb/xYRIf6jmUlLdXZS6gnp
 bZlgGKnHnJEv5Eu8SSFVerKFcwgP+dcecxKhugNh9kBCzjvHvxKeP29umyu35gPzas1Y
 wWzklQ7eaxfIsHY1RdweVRyllK7nAF0DLfY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37yb5e2a6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 13:03:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 13:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcnDW7XwkEE8XQQt+0jF4xyGBmGmA0fvBCsGZOqoRrcC/TZjYpSV4kQTwLzUGV65jqZM3a/ZRt0Zpu+GOFwPQQMxh2O4KERx89PHHruVlr4d4ubj6xOXFrBYvh76WlF1ABWHUVEU32OEbMSW9rFCbWRgLlj+yMDbN0NCFW+ujZ+e47NYCggDfEJLjXWEOG0LWFfpdf9PsioahffXyFU3AMEe+kRsBJQs3vsdSI4xYmbNcYjwOfKtsxb7UN4yZPxMT77UswxtsT6JMoUlsgmqsBkyf17ra+GUzFAkb5f6BfGQTlB196GjuUB5NJQN+7jPjtPISDW6v+3YzaRUDRKNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPR/I2hNUckHsxaeG1dmxQs2mK8/4NUVyB+ozPxRuMs=;
 b=MYNK+5saeTno/Ty0tp4JtFn/xVc1VZ3DQ9U1qtQjVnd7TbmXCrWZ0ZHm/nQw1g8QveLjEdiQCm9uZ4cw4uzXb34+e8UfP6Le+4J/G98YJalh1d2cbpaFEAQyQFasUTSZ7fsR8acwfXJtAAxZQQEatU+9DfW/MM5KI7v3zQsS1XkDLa3Ku+0/BTVH0UO1ANO2wSc5bULTCn21qfruppcFoXh7O9OGwihxzz3v4X87nxJciuRP6c7cYfXsBEf2Prh+Nwf8frRfY2fD4QYtaehdzrAS2U6q3NEVPQ+sg3IKY8ErsUTWo381R3f2i54xXBuUsNfPXUDYSF4ooDs/3axTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4188.namprd15.prod.outlook.com (2603:10b6:a03:2e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 20:03:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 20:03:39 +0000
Date:   Fri, 16 Apr 2021 13:03:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Pratik Sampat <psampat@linux.ibm.com>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pratik.r.sampat@gmail.com>
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
Message-ID: <YHntlmvfx3w79IUn@carbon.dhcp.thefacebook.com>
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
 <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
 <YHnFsL2G2bpOH8ML@carbon.dhcp.thefacebook.com>
 <8ea7c616-95e8-e391-5373-ebaf10836d2c@linux.ibm.com>
 <YHnYqMdyYtIdab6n@carbon.dhcp.thefacebook.com>
 <09a8d1eb-280d-9ee9-3d68-d065db47a516@linux.ibm.com>
 <YHng5nAPSLJHnRY9@carbon.dhcp.thefacebook.com>
 <2a0d371d-79f6-e7aa-6dcd-3b29264e1feb@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a0d371d-79f6-e7aa-6dcd-3b29264e1feb@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:3149]
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:80::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3149) by MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:80::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 20:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3182322e-d30a-4d2d-52c9-08d90112ba15
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4188:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4188AE3C9BC987B3C68CF4A4BE4C9@SJ0PR15MB4188.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsK+vYbtQF9dH0+1fhYRih4Zc1RnnNxxGEnaNNeTX0R14XKbtH9JlMlwN0w2OajBTnScRNL6TZfwo29KKEX+79M7DszvF2ujGt5AoDtF9Ymm04SPN8HzdSzsonlTyubIHfZC+5L0oOcwg7sj+UTehubHCKPt1dgIzuwYHw7rDdYj5Z8NCl6hAw05QLSR7uitp+6nzPThDAm+LmxK14WqooqjRl25txewjCu0ATtcS/x+xyVr0EsLvYC2yblwE42485CSBfCNLDc9smMGS6CANC6hyKONycIABuMD1k3BuRCD0C2qng6ulz/+ON0GTQwOvicChGK8dbifXNPijoeLu4fDpt5mL1pG4J0uLv2BrHdWcAstfM8jIyl3mQCK7qc3OcM2INbF90Ul1althMlcattTo8pvYmCGmSSPhOTVkFdACRXnR/JCDpIDxyF2Opn/Ee87MphAc7/DMqxg2COPVbGy3M/RP75LMZgL7v/dqWgObNcIw6L/4nwTjZB5a27GvotHVTWEXcsZpvO4IERqYiKpkYIkyE2EMaOKWcZCoC0RvHaam1UpW03CA7h2m6b36ovP3G0z9riys/I7mriCNVGwZcd0lEr57qStC1lwdLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(38100700002)(316002)(9686003)(186003)(55016002)(54906003)(6916009)(6506007)(7696005)(53546011)(4326008)(478600001)(8936002)(52116002)(8676002)(6666004)(66946007)(66556008)(83380400001)(5660300002)(86362001)(66476007)(16526019)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?nTuZyWrxijdbupGYoe/sZuXZvKd9OtGLKc0fucKbApKEDYH6Zgpot5axZS?=
 =?iso-8859-1?Q?wskKDWLf/M/B7TQtqNnWbbdnpJd9ezgqm6m6L2wBqy2KBMLy7kmDNk+SIz?=
 =?iso-8859-1?Q?JEmsoKZvM5SNFCuWlPMghj4rvCDQBDQVf23DsYqRu0C2CUkh3Y5ON8sYqF?=
 =?iso-8859-1?Q?59A2OgoFlSTEygB5Y+OtbXVdRuhkjqsVzt2mLOpguLi++21mF9c47cmeUt?=
 =?iso-8859-1?Q?+LlDAmnwPmSNCywbxbrJ0isBdOULvPirqLZM9lc0RYmRk4S14udUh0BLLl?=
 =?iso-8859-1?Q?XtS0WOccM9+ZK5niT+IpYMMjFy14qKwQQshSH63PfWkCMIGI6Orfd7sGSf?=
 =?iso-8859-1?Q?3bZwKmL7IyI5eHtO79EZHkgCtqeqm/JitfJNjeUhjaQzi8pa77wWOlg+wJ?=
 =?iso-8859-1?Q?Mcp9iGtA71uM+pqS/zdS0Y4kc6ipocy6Xu0wipD2So2VFTsUdma18oRB0h?=
 =?iso-8859-1?Q?kRpt4vYTxwMXxCPrB+1521m90dps63fnihnryuRvIn887ndhwnAyXwt6DC?=
 =?iso-8859-1?Q?GzXwBaIitjX/1lZtDraaKB1j6UEFPZMSzyunLd9DWz04h3bAETB2IKF9h0?=
 =?iso-8859-1?Q?GNfIaS7cBctILTkJxBG1Mj5SXDe6wD4aXZXNWwAtcqhec4RlEzdpoNd85Y?=
 =?iso-8859-1?Q?fnyJtwqCjDa134urem6Jt1I8EhrIokxaUCJ2iyoqOt89i99WzlxxLVOBPD?=
 =?iso-8859-1?Q?tfe/g/NsjonETQCp3HVsh6vr9DGc+rTKwwoo2S+REP35/jB3QSKsnQ0g3f?=
 =?iso-8859-1?Q?dAeCUkPgkzANdWKxIbOiBP0ZbY55UpSxU59qsMsdCeKipSAg3RtOwDMWiJ?=
 =?iso-8859-1?Q?e0ZrJ2R9TKh7m2MpxkGI/un3jeypCqe4ATDnwfW8rqSzCAXcrtR8PUQAlx?=
 =?iso-8859-1?Q?kDFe9Ilo/wGD6/e1oulNvsUj2DEtQCKYCUdtZ/inD1Mw4MT+Cy5fHkMHwT?=
 =?iso-8859-1?Q?w6dX7Wf0qnG9aCEjARBjobB7PRnCtHz0v67EHZGG1yJgWKy1hZtBjeD1Uo?=
 =?iso-8859-1?Q?DWTnuFgfBuw/i7z+7EKRm4I9y3kcd/I5BylY6tDQqPxmyJnUeTBRB2UQYY?=
 =?iso-8859-1?Q?9xrlOzSTnJ4isutkF5kiPZelP02jmUHtMJ6VKUkv8iNNcNRwtORviDQI+h?=
 =?iso-8859-1?Q?5mincTOXh+w+OWW+l625uspWBYsUeepz1hfSO4Nd8Uy1Q5lLY3XvLwrrrz?=
 =?iso-8859-1?Q?KYXWJ6rF2LZIrX0+6HeE+wkOruT+j34p2mWDW3hEAiTsSaIbrgNVIGcsQe?=
 =?iso-8859-1?Q?xTjXgG+cEE6Ic11PfTwB9zCRfV3vs2MngAArCBDAczYW566FjttsfUSQ0I?=
 =?iso-8859-1?Q?jO3qUrfDFsesWjbURdcUeUx6P7xbKYspsTk/k6bSWjy5bVJF1DGPgZunMZ?=
 =?iso-8859-1?Q?/3KfbiFUyRLnzPNQAsoZYVDd2aTdOuBA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3182322e-d30a-4d2d-52c9-08d90112ba15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 20:03:39.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75IKOfsjfpz/eMQVp6+sVE7USR54KaMo1i7k+n7MnFE50FLTjWJNx3AaQgqiwWmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4188
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: VMDbskbyBbz9TLcZfje3SGRvGNj9dHcu
X-Proofpoint-ORIG-GUID: VMDbskbyBbz9TLcZfje3SGRvGNj9dHcu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 01:14:03AM +0530, Pratik Sampat wrote:
> 
> 
> On 17/04/21 12:39 am, Roman Gushchin wrote:
> > On Sat, Apr 17, 2021 at 12:11:37AM +0530, Pratik Sampat wrote:
> > > 
> > > On 17/04/21 12:04 am, Roman Gushchin wrote:
> > > > On Fri, Apr 16, 2021 at 11:57:03PM +0530, Pratik Sampat wrote:
> > > > > On 16/04/21 10:43 pm, Roman Gushchin wrote:
> > > > > > On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
> > > > > > > Hello Dennis,
> > > > > > > 
> > > > > > > I apologize for the clutter of logs before, I'm pasting the logs of before and
> > > > > > > after the percpu test in the case of the patchset being applied on 5.12-rc6 and
> > > > > > > the vanilla kernel 5.12-rc6.
> > > > > > > 
> > > > > > > On 16/04/21 7:48 pm, Dennis Zhou wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
> > > > > > > > > Hello Roman,
> > > > > > > > > 
> > > > > > > > > I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
> > > > > > > > > 
> > > > > > > > > My results of the percpu_test are as follows:
> > > > > > > > > Intel KVM 4CPU:4G
> > > > > > > > > Vanilla 5.12-rc6
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             1952 kB
> > > > > > > > > Percpu:           219648 kB
> > > > > > > > > Percpu:           219648 kB
> > > > > > > > > 
> > > > > > > > > 5.12-rc6 + with patchset applied
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             2080 kB
> > > > > > > > > Percpu:           219712 kB
> > > > > > > > > Percpu:            72672 kB
> > > > > > > > > 
> > > > > > > > > I'm able to see improvement comparable to that of what you're see too.
> > > > > > > > > 
> > > > > > > > > However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
> > > > > > > > > 
> > > > > > > > > POWER9 KVM 4CPU:4G
> > > > > > > > > Vanilla 5.12-rc6
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             5888 kB
> > > > > > > > > Percpu:           118272 kB
> > > > > > > > > Percpu:           118272 kB
> > > > > > > > > 
> > > > > > > > > 5.12-rc6 + with patchset applied
> > > > > > > > > # ./percpu_test.sh
> > > > > > > > > Percpu:             6144 kB
> > > > > > > > > Percpu:           119040 kB
> > > > > > > > > Percpu:           119040 kB
> > > > > > > > > 
> > > > > > > > > I'm wondering if there's any architectural specific code that needs plumbing
> > > > > > > > > here?
> > > > > > > > > 
> > > > > > > > There shouldn't be. Can you send me the percpu_stats debug output before
> > > > > > > > and after?
> > > > > > > I'll paste the whole debug stats before and after here.
> > > > > > > 5.12-rc6 + patchset
> > > > > > > -----BEFORE-----
> > > > > > > Percpu Memory Statistics
> > > > > > > Allocation Info:
> > > > > > Hm, this looks highly suspicious. Here is your stats in a more compact form:
> > > > > > 
> > > > > > Vanilla
> > > > > > 
> > > > > > nr_alloc            :         9038         nr_alloc            :        97046
> > > > > > nr_dealloc          :         6992	   nr_dealloc          :        94237
> > > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
> > > > > > nr_max_alloc        :         2178	   nr_max_alloc        :        90054
> > > > > > nr_chunks           :            3	   nr_chunks           :           11
> > > > > > nr_max_chunks       :            3	   nr_max_chunks       :           47
> > > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > > empty_pop_pages     :            5	   empty_pop_pages     :           29
> > > > > > 
> > > > > > 
> > > > > > Patched
> > > > > > 
> > > > > > nr_alloc            :         9040         nr_alloc            :        97048
> > > > > > nr_dealloc          :         6994	   nr_dealloc          :        95002
> > > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
> > > > > > nr_max_alloc        :         2208	   nr_max_alloc        :        90054
> > > > > > nr_chunks           :            3	   nr_chunks           :           48
> > > > > > nr_max_chunks       :            3	   nr_max_chunks       :           48
> > > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > > empty_pop_pages     :           12	   empty_pop_pages     :           61
> > > > > > 
> > > > > > 
> > > > > > So it looks like the number of chunks got bigger, as well as the number of
> > > > > > empty_pop_pages? This contradicts to what you wrote, so can you, please, make
> > > > > > sure that the data is correct and we're not messing two cases?
> > > > > > 
> > > > > > So it looks like for some reason sidelined (depopulated) chunks are not getting
> > > > > > freed completely. But I struggle to explain why the initial empty_pop_pages is
> > > > > > bigger with the same amount of chunks.
> > > > > > 
> > > > > > So, can you, please, apply the following patch and provide an updated statistics?
> > > > > Unfortunately, I'm not completely well versed in this area, but yes the empty
> > > > > pop pages number doesn't make sense to me either.
> > > > > 
> > > > > I re-ran the numbers trying to make sure my experiment setup is sane but
> > > > > results remain the same.
> > > > > 
> > > > > Vanilla
> > > > > nr_alloc            :         9040         nr_alloc            :        97048
> > > > > nr_dealloc          :         6994	   nr_dealloc          :        94404
> > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2644
> > > > > nr_max_alloc        :         2169	   nr_max_alloc        :        90054
> > > > > nr_chunks           :            3	   nr_chunks           :           10
> > > > > nr_max_chunks       :            3	   nr_max_chunks       :           47
> > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > empty_pop_pages     :            4	   empty_pop_pages     :           32
> > > > > 
> > > > > With the patchset + debug patch the results are as follows:
> > > > > Patched
> > > > > 
> > > > > nr_alloc            :         9040         nr_alloc            :        97048
> > > > > nr_dealloc          :         6994	   nr_dealloc          :        94349
> > > > > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2699
> > > > > nr_max_alloc        :         2194	   nr_max_alloc        :        90054
> > > > > nr_chunks           :            3	   nr_chunks           :           48
> > > > > nr_max_chunks       :            3	   nr_max_chunks       :           48
> > > > > min_alloc_size      :            4	   min_alloc_size      :            4
> > > > > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > > > > empty_pop_pages     :           12	   empty_pop_pages     :           54
> > > > > 
> > > > > With the extra tracing I can see 39 entries of "Chunk (sidelined)"
> > > > > after the test was run. I don't see any entries for "Chunk (to depopulate)"
> > > > > 
> > > > > I've snipped the results of slidelined chunks because they went on for ~600
> > > > > lines, if you need the full logs let me know.
> > > > Yes, please! That's the most interesting part!
> > > Got it. Pasting the full logs of after the percpu experiment was completed
> > Thanks!
> > 
> > Would you mind to apply the following patch and test again?
> > 
> > --
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index ded3a7541cb2..532c6a7ebdfd 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2296,6 +2296,9 @@ void free_percpu(void __percpu *ptr)
> >                                  need_balance = true;
> >                                  break;
> >                          }
> > +
> > +               chunk->depopulated = false;
> > +               pcpu_chunk_relocate(chunk, -1);
> >          } else if (chunk != pcpu_first_chunk && chunk != pcpu_reserved_chunk &&
> >                     !chunk->isolated &&
> >                     (pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
> > 
> Sure thing.
> 
> I see much lower sideline chunks. In one such test run I saw zero occurrences
> of slidelined chunks
> 
So looking at the stats it now works properly. Do you see any savings in
comparison to vanilla? The size of savings can significanlty depend on the exact
size of cgroup-related objects, how many of them fit into a single chunk, etc.
So you might want to play with numbers in the test...

Anyway, thank you very much for the report and your work on testing follow-up
patches! It helped to reveal a serious bug in the implementation (completely
empty sidelined chunks were not released in some cases), which by pure
coincidence wasn't triggered on x86.

Thanks!

