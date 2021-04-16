Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722763627C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbhDPSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:34:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236085AbhDPSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:34:55 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GIT1tw029920;
        Fri, 16 Apr 2021 11:34:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=C80xXtpJD6D634HvXz6xsJMHWtJP/KI9f+UYPmG490s=;
 b=L0Yqf8qS/bOTYQsA4Xk7V3OL0dOVeFQdCFuYHb8+YrtVmxXgvNpkzfASJTt1F5hXGJXD
 +PJbCJOu574cg+QDVV5dNe0i56cDicUxsbeAzpScxRGluzvOnsT829zVrjO1uuOWh8/d
 VdsTIjS+23exA0ei/cHTdZaLrfgRSBhN6/M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37y6tyk4tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 11:34:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 11:34:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6rQyLlpLaukhKjU7tAUoKdcgP+AH2Z4qhjK+EK7O3ZknMvOcvZn+CbKyr9tL2cEokHf5hIEtWuXFEBOxL7xbsJ/eABSsbd3LFYM2c/kWWr9iV3iGn2bL3qk1XuV+N9G3PYHAoHpQkIcxh8SC9HSL+F+elPIC4CEZdZRe3XOr/3pWS5oLHBDtVZ/6r7saZysqlQO7kJKQMjqO7QChYLyWwDQmqU87q88DoMa6uzSNMZk+uwZyRDCkp6i8kqELOFJ11lf5r/fv57O8io/V+BpWCWSnGGLIcgfMREThbhQd7CuYyQVXfjr91ushGXr9/UL0lydV6CSf+bDLk6fDyI0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HthsHW1Dy0q3ca6ccRRLkW9r/IQBA/brrrlTYNC+q1w=;
 b=gxYya9UpdeIlApvFb75APlK4xL3G0cREsZ1uC47pXq6EgtyGp3FjG3qiY+Bh13aT7COYXTO0jng0E6yPa+/ckxBr6YFiQR0Xi9s7gID1du+2wwu+9B8xl043SyolEAknCAnNpY86xJpPK25MJFjrQLTpCW3Mlf5bvv8Hzrrbxeiw5r/+GywIZ0BdhxFoz8FmT/w7F5zf87o4qgNiyV3fSArktFZ7OzdJ3NFvJhGatx7o7XpnGxaD31rwcsRFToW4JFrOPUxXPnKmWlfLiib4czb/JSKZS7Ju5vKZHpr6/fzeIUucfK8HqtG0ut+EB3/6MWbcK5HWf0oHQbEkLS1oPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4357.namprd15.prod.outlook.com (2603:10b6:a03:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 18:34:21 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 18:34:21 +0000
Date:   Fri, 16 Apr 2021 11:34:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Pratik Sampat <psampat@linux.ibm.com>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pratik.r.sampat@gmail.com>
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
Message-ID: <YHnYqMdyYtIdab6n@carbon.dhcp.thefacebook.com>
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
 <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
 <YHnFsL2G2bpOH8ML@carbon.dhcp.thefacebook.com>
 <8ea7c616-95e8-e391-5373-ebaf10836d2c@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ea7c616-95e8-e391-5373-ebaf10836d2c@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:3149]
X-ClientProxiedBy: MWHPR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:301:1::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3149) by MWHPR11CA0023.namprd11.prod.outlook.com (2603:10b6:301:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 18:34:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb923eb7-3b37-4abd-9b84-08d90106402f
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4357:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4357354C1F1D46B16D30D43FBE4C9@SJ0PR15MB4357.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVjMzcqXXtxvXDlOF/x/+ay6iqsnm+ofLFZlBAg9scHM1JXBhPKDO8/CrQh91dpdK/sutVGOUjdtfa6ZMkge1HXTona2l3NLyAzW/JfnVCAjPpk9rMJbJSWZkgTC14am6ef+WMSs9ry8zjg7JxQgnS0FjSLrUFg7+yc4swc65Ah2CDmnJed+T+CA3JXRfblLl2fKCKzqJkf/QuchB1ffb4qRVpjb/CH68uwcO7Wro1jqegJkQB1rpKX6WQTaNQcga8kVwb+tHxf69bxYBWIZUuFeR5MrrBviKjGs4qxVCjE2gNMnPMgpY3sPdv3ewcKjFoX1a0G/wGmQdxbse9fmG0eby2tK9XIZzmILBR10BNzN1UTAoEEPa+EbCjZkO5I3p/6sv/qK+Jmqq0hPd2pmffbyG4fjHzJ6aY8u4BQ7dvnHGiro3p9LqnRTFzuLeB9KV5SGihfem8nz+U9dkPQGwwBJEwVTuEv9VIFHqpPNFx3VRL5FhM3OkLYE5oq17Sls81Ibwd0dqDlaU1pPy/voj13+e+HCOxMUvfsh6+16UkERlW5Jk8Ws0XpLHDpD84lOFEsdVV5LQrejG7slfBHpFjYI2lccePZwgVrpfNeHHUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(136003)(346002)(9686003)(86362001)(186003)(54906003)(83380400001)(316002)(55016002)(2906002)(6506007)(53546011)(52116002)(6916009)(7696005)(38100700002)(5660300002)(4326008)(16526019)(66946007)(8936002)(66556008)(6666004)(66476007)(478600001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?wcfujjmdRWRWB8QShtxfU8Z2kza0hIXmOke6Qi/3vKRNBwAb3gPzUKbcHM?=
 =?iso-8859-1?Q?4k1kYfDhCa0Jr3qvN+MSVGT+seS+cNoWZ9KJPp5oeBxHzZPlpMCyDSXaek?=
 =?iso-8859-1?Q?SQLGl0fGPbwQdnyJWfylF08kNKR5yAI2Ad6B6wwD7fNl8oul5TBKojAREQ?=
 =?iso-8859-1?Q?5QaUHxSkIYSgUPS64W4STBephkEH6Z1CxG9IN2r1MlmDZzu/j/l95oUBd7?=
 =?iso-8859-1?Q?fnO7CrGYv0GVkizn7y06ElURP7Jo27UKz+GB8doQ1dXBBYNDFe4e4TNsIx?=
 =?iso-8859-1?Q?6RPdRBXaet6BOZQPW7999nJhErdxM5HuYxKUkuX4QbYMxmQqDfWybAMWiA?=
 =?iso-8859-1?Q?8FVuXGsgPUx/BKS1YHdEx7Kzh/AvFSN1eb7OR8f/DAIooQw7VQ8mSfKKzw?=
 =?iso-8859-1?Q?Pn4PBgv4VR5yQ3QibLJPjqcdhtAyHP5hAu36Oki54GXRZa2m/8U6F4U81w?=
 =?iso-8859-1?Q?g8BfscJzbztoih5xtRTPF8CIbgwNWSXzeeCzkTxrQP1AubldMLDby670kf?=
 =?iso-8859-1?Q?QNmt54XzOMX5rO7BkfRBAWceTJG88OqIsJR+ShxrwX63MTMpUAbK5Hzco/?=
 =?iso-8859-1?Q?UB4Lx1quXOkzA/LWEmRrJJrBekU7+SF56XWfpoClfuzJ6+WRQCizAORNqg?=
 =?iso-8859-1?Q?1WirmdFJR2469QhbiaYN37ezop/1nemuzk7EwP2aishdPUDXVMwJ+w6xfe?=
 =?iso-8859-1?Q?mP5xg8gZXSMgdj2B7ZS0NmHLgj7SGTmEGRR7LEY4TLymFD8hqU8sW5BcQ9?=
 =?iso-8859-1?Q?2/wpDujdJd5vSdSsGNmb20FVX5Ln8zOot8fTYTRGChh684VXF71XkhxOP6?=
 =?iso-8859-1?Q?ELNpNaR0P75DTU5zwSGc4dT1nJFUqNETerSxJeRVQL8a/8MRYbuRDeG7qZ?=
 =?iso-8859-1?Q?pPpXdE1lVXcXy/3nfY7zgkd1nFKHIx4KU8nGmrceVTPZWfWPNvqCXswl1p?=
 =?iso-8859-1?Q?HTzZ+pGur+f56a1qrP4PK9rUfmMHZ3+uFp0s+xlr9nRXmJeS7KvQysxgdD?=
 =?iso-8859-1?Q?OLzA8NZRTs0eub38kJWDrxX2z7060fyq4oiprtNPI1qZc77VjG2Qj6uSzO?=
 =?iso-8859-1?Q?E1de89RnMMvbYElslTx/oSliHqaM2GLYPGsORMtXM+kg1RI0t/adQqbDOR?=
 =?iso-8859-1?Q?IbOfk3/BgMySaKpCZkcl14WpX+xFc4asdrrz80yXVCYKG4Fzm1tAHlZbJt?=
 =?iso-8859-1?Q?k49zy/SVv9aUI1P0eZ7W5eTufZM2tc9S8ypA1bmYBmvV1vaHIjF5k6ehmi?=
 =?iso-8859-1?Q?7papkPo9dQ5BFQAut6xtQgG3qmKe/qIObJDhVH5oVIq2xjSK9/HEmS6dlb?=
 =?iso-8859-1?Q?gFOc4rnYbqm8oUyqGLrnVzbTtUHrxVyH1Xe1PeRjFH401EHezDOPke+LiF?=
 =?iso-8859-1?Q?UQoyCuVFSpmv6+v6lF+hoNw2YzVM2PUw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb923eb7-3b37-4abd-9b84-08d90106402f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 18:34:21.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydUqDsMlf5xlL9tzzpKqrYbzI9Y3JJ2WQtCBsTN+yF94nCTX3xNzS8ckI6xyqW/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4357
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: R1YDKAqzC6PyH9jYg1N8WtFy0vckk5fX
X-Proofpoint-GUID: R1YDKAqzC6PyH9jYg1N8WtFy0vckk5fX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:57:03PM +0530, Pratik Sampat wrote:
> 
> 
> On 16/04/21 10:43 pm, Roman Gushchin wrote:
> > On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
> > > Hello Dennis,
> > > 
> > > I apologize for the clutter of logs before, I'm pasting the logs of before and
> > > after the percpu test in the case of the patchset being applied on 5.12-rc6 and
> > > the vanilla kernel 5.12-rc6.
> > > 
> > > On 16/04/21 7:48 pm, Dennis Zhou wrote:
> > > > Hello,
> > > > 
> > > > On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
> > > > > Hello Roman,
> > > > > 
> > > > > I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
> > > > > 
> > > > > My results of the percpu_test are as follows:
> > > > > Intel KVM 4CPU:4G
> > > > > Vanilla 5.12-rc6
> > > > > # ./percpu_test.sh
> > > > > Percpu:             1952 kB
> > > > > Percpu:           219648 kB
> > > > > Percpu:           219648 kB
> > > > > 
> > > > > 5.12-rc6 + with patchset applied
> > > > > # ./percpu_test.sh
> > > > > Percpu:             2080 kB
> > > > > Percpu:           219712 kB
> > > > > Percpu:            72672 kB
> > > > > 
> > > > > I'm able to see improvement comparable to that of what you're see too.
> > > > > 
> > > > > However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
> > > > > 
> > > > > POWER9 KVM 4CPU:4G
> > > > > Vanilla 5.12-rc6
> > > > > # ./percpu_test.sh
> > > > > Percpu:             5888 kB
> > > > > Percpu:           118272 kB
> > > > > Percpu:           118272 kB
> > > > > 
> > > > > 5.12-rc6 + with patchset applied
> > > > > # ./percpu_test.sh
> > > > > Percpu:             6144 kB
> > > > > Percpu:           119040 kB
> > > > > Percpu:           119040 kB
> > > > > 
> > > > > I'm wondering if there's any architectural specific code that needs plumbing
> > > > > here?
> > > > > 
> > > > There shouldn't be. Can you send me the percpu_stats debug output before
> > > > and after?
> > > I'll paste the whole debug stats before and after here.
> > > 5.12-rc6 + patchset
> > > -----BEFORE-----
> > > Percpu Memory Statistics
> > > Allocation Info:
> > 
> > Hm, this looks highly suspicious. Here is your stats in a more compact form:
> > 
> > Vanilla
> > 
> > nr_alloc            :         9038         nr_alloc            :        97046
> > nr_dealloc          :         6992	   nr_dealloc          :        94237
> > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
> > nr_max_alloc        :         2178	   nr_max_alloc        :        90054
> > nr_chunks           :            3	   nr_chunks           :           11
> > nr_max_chunks       :            3	   nr_max_chunks       :           47
> > min_alloc_size      :            4	   min_alloc_size      :            4
> > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > empty_pop_pages     :            5	   empty_pop_pages     :           29
> > 
> > 
> > Patched
> > 
> > nr_alloc            :         9040         nr_alloc            :        97048
> > nr_dealloc          :         6994	   nr_dealloc          :        95002
> > nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
> > nr_max_alloc        :         2208	   nr_max_alloc        :        90054
> > nr_chunks           :            3	   nr_chunks           :           48
> > nr_max_chunks       :            3	   nr_max_chunks       :           48
> > min_alloc_size      :            4	   min_alloc_size      :            4
> > max_alloc_size      :         1072	   max_alloc_size      :         1072
> > empty_pop_pages     :           12	   empty_pop_pages     :           61
> > 
> > 
> > So it looks like the number of chunks got bigger, as well as the number of
> > empty_pop_pages? This contradicts to what you wrote, so can you, please, make
> > sure that the data is correct and we're not messing two cases?
> > 
> > So it looks like for some reason sidelined (depopulated) chunks are not getting
> > freed completely. But I struggle to explain why the initial empty_pop_pages is
> > bigger with the same amount of chunks.
> > 
> > So, can you, please, apply the following patch and provide an updated statistics?
> 
> Unfortunately, I'm not completely well versed in this area, but yes the empty
> pop pages number doesn't make sense to me either.
> 
> I re-ran the numbers trying to make sure my experiment setup is sane but
> results remain the same.
> 
> Vanilla
> nr_alloc            :         9040         nr_alloc            :        97048
> nr_dealloc          :         6994	   nr_dealloc          :        94404
> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2644
> nr_max_alloc        :         2169	   nr_max_alloc        :        90054
> nr_chunks           :            3	   nr_chunks           :           10
> nr_max_chunks       :            3	   nr_max_chunks       :           47
> min_alloc_size      :            4	   min_alloc_size      :            4
> max_alloc_size      :         1072	   max_alloc_size      :         1072
> empty_pop_pages     :            4	   empty_pop_pages     :           32
> 
> With the patchset + debug patch the results are as follows:
> Patched
> 
> nr_alloc            :         9040         nr_alloc            :        97048
> nr_dealloc          :         6994	   nr_dealloc          :        94349
> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2699
> nr_max_alloc        :         2194	   nr_max_alloc        :        90054
> nr_chunks           :            3	   nr_chunks           :           48
> nr_max_chunks       :            3	   nr_max_chunks       :           48
> min_alloc_size      :            4	   min_alloc_size      :            4
> max_alloc_size      :         1072	   max_alloc_size      :         1072
> empty_pop_pages     :           12	   empty_pop_pages     :           54
> 
> With the extra tracing I can see 39 entries of "Chunk (sidelined)"
> after the test was run. I don't see any entries for "Chunk (to depopulate)"
> 
> I've snipped the results of slidelined chunks because they went on for ~600
> lines, if you need the full logs let me know.

Yes, please! That's the most interesting part!
