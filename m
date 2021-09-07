Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9A402F17
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbhIGTnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:43:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7572 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345745AbhIGTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:43:44 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187JdmLj010019;
        Tue, 7 Sep 2021 12:42:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MHrITQelW0La51PhJJJJv58U85rom9SyGFGOyusMlM0=;
 b=HzWDfvuPd7rP683jZj6nag00aODVWfqCt5WVtfkDCN6NmhneXNmbxNiVGkoVgXIsc3xP
 DbyUTQdQEtJDMMg8j/EzVUzeZMUW++OqYBhuwfFoA86Vh0+wZ/gzs/v9X4P3luJ16afp
 MDvpR0AV6EePDw7j8Zg8dfBvtQR3SC4R/w8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcq4rv7p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 12:42:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 12:42:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrUzziObhUaxhnuk15WAtXbLZuTUTXDas1ai0TlZxPgPq56yTQ6FOLFRbYRRA0WD3mhLbg3IDH0jpeaNwkHCLXu4jdrOf4dx4vy+q/QO2jz//45ipCM3gNTa9z2X+9+UvMpvtufRkfPGLg4DUIfWbHiLKDP5V1Eny73KKBDBZiCzX16VWbEUp5F+jAXFU2Fv9e0ouRrrIdJTnLWc6z7sAxQJ/jmM3ls3sDf1rv0R7YNbL3d/Lww+iThnn69qa04MctQwTjB/eUrQRieyM7MBRfQ5VNJkpLfUDZCMoVxOQbb94fbdiD83wlDEruqYxZcwjUT74D2Zx4nBrYbCJuQCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MHrITQelW0La51PhJJJJv58U85rom9SyGFGOyusMlM0=;
 b=BxytlPGCcAZ9rX4K83C2Feeld/2IyvRzxdtzu5CEG0DVKzX9un2EDZ6nKdcOb3dQP1CUdmgbLf7ttUFtW2BhM6rCU8hETyY6R5VCvnEQGHdNELXq1gS5WmUSdbzIRoNEMdSrA7ZSNMWfnYqUy8TDIxjGSlZz82N3rnwSU+FfcPa5X4ksnj/dRr0LvjJkAgkIYVd5HmRYaKydaJaA6IpaPyElnowprJBPcbofmytWzbyTDB04cduSb6Q9j/9HuDy5ttIAjRTFcm0xThzz31xFih8ux3XmVpnTgsn/P+c0UgDLCciJuQLjWAhTDUl8SrRMxDUCdFQmNy59vRvGsp4oVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4273.namprd15.prod.outlook.com (2603:10b6:a03:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 19:42:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1144:84e8:6ae1:833c%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 19:42:07 +0000
Date:   Tue, 7 Sep 2021 12:42:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
Message-ID: <YTfAiaIbxM0CqEnj@carbon.dhcp.thefacebook.com>
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
 <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
 <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
 <YTeeBf64yUwj01Sf@slm.duckdns.org>
 <YTeh1WkseQtyboM9@carbon.dhcp.thefacebook.com>
 <CALvZod4=uY=5Zp_GCzjjMzCbs16856dR85SBWv-dpNc4kBrO+Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4=uY=5Zp_GCzjjMzCbs16856dR85SBWv-dpNc4kBrO+Q@mail.gmail.com>
X-ClientProxiedBy: MWHPR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:301:4c::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f46f) by MWHPR15CA0051.namprd15.prod.outlook.com (2603:10b6:301:4c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 19:42:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da73e15d-fc4b-42ea-8805-08d97237932a
X-MS-TrafficTypeDiagnostic: BY5PR15MB4273:
X-Microsoft-Antispam-PRVS: <BY5PR15MB4273D0F82217EECFF4F48BC8BED39@BY5PR15MB4273.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xblIDNzhN2i/ilgog8OOLmE8hLYlTCLyJllsQykWOEyr+pKFVXAN8gT+7teA6GlWztHylE9hx0sxq5jjMThtpnrUqOCXy8ls7uuSXXzRTWmAl5AVpHbUakbWk7lpiCmhI/uC2ydNdoPiB4vmIwJK4F3UDAaKddH/nfg4SkalS7913jZBZ7TOfxHWzxm3rzwuphdkUNCUMvNKg7CMpxPf5x5RKzzMGoLsmceuR5B+o6uVMmvi8F9PzHyt27UO2MPGmp+AQSyG3Hcqpkvs0pdbpcVmjToWAbNt3qIqXMrFlYfszUXIRTGU7aIGpYOlLvGyrxnF6na/mYf8lBBtwz2HohICotwBOxjRdWFMRZsKux2kxD+Ceeek3SQ/kl5TpcDwd/3so/eXG4wmM4DA7VMrTYVd+yXMtA+3YlK7+c9ztscHZPDyIP8gVKO4GqXl0ZGeDywr6gq997vkMcOuKuYEWAngDNGRHiISKIprxmMsXH9cLaxsY9kSPgGf6FE+bXI2ASqyuHSlftER5ao3S9uAyPM5kSx/YS6rWfiVVXSM3aIaHwtY921jAalGCW9a7OwYgiULvqC0/kY9oqbcIzjvWEysro1kgMt6I+C2R8bpC2seEAPMKYzR8UbSH+RGCodIcZKamXXzIM1IhUYoCITWLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(54906003)(9686003)(83380400001)(6916009)(2906002)(38100700002)(55016002)(5660300002)(478600001)(6666004)(316002)(66556008)(4326008)(66476007)(8676002)(186003)(8936002)(7406005)(7416002)(86362001)(6506007)(7696005)(53546011)(52116002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yyH9lM33OZpwNBAGoxzmyX1m0+B2qtDiGJK5Mynxjpjv0zq5kjIqlqLj7oqZ?=
 =?us-ascii?Q?iUFGE0mI3te0hC7ZKW0MBM3uY+m5AgKCLDq/+74tfoWQ5JEIK6ZVRMQJVRkY?=
 =?us-ascii?Q?+eib1WRfTtwolTx86i4A86upD//eCGdDQ1d5h86aOVJHN0SOEmaX3GIfsMUO?=
 =?us-ascii?Q?5hUMsD72H6bAOoOj7QkXmbjgxRxZrln19PGdYbOGR2lojZc9wCfzE+JJ9P/Q?=
 =?us-ascii?Q?9qX4IPVXmH2J5s6RhSjlbx+HcrW/MpbaXqkcc6lbI817PqqDqPjAVSGHGtaE?=
 =?us-ascii?Q?ed69SMf86Q1NZP+uPYl3u6FCTHcKSX679dJagQWnud98jNQeK9q4NYX5nrRG?=
 =?us-ascii?Q?kWk1FLkDVMRd1Eyo5LbKbzxIJsxynxgI8hdzdAGvqFZarUHeV+3wEUMg9KKY?=
 =?us-ascii?Q?rtd1O4xbnLDaXVW/pVapzUsdfkmgA5hVoIUSt9UPtY+Hm+P8UpifHuoiLKfT?=
 =?us-ascii?Q?iQsjp47HXw72k0pDJwd1mZbb++OW8putwmJ1DeLeSflJC2LOY9y5vkbTpj3X?=
 =?us-ascii?Q?PZjcUQlPIYYiEpcmLV+7c6q2E7vXcHSXdfw6w8VFxPdGW/iWeF008/K6F981?=
 =?us-ascii?Q?76EXdJj/w1fNPP3rqC5IoPl5+qLgzmellgOf4EPNLpXuPp2T0gsTlvI10VXC?=
 =?us-ascii?Q?fun47yr7yhQEbteRDEeSZeDvBXwmykvq5Yx1XW51l3/7h0PlNYi8IoWxg1YC?=
 =?us-ascii?Q?FxQYrWNe6GCdzxiWrYyk8ezNd+CdfNMNUSvrxeMtUBydisWSv6UneN7ZXa72?=
 =?us-ascii?Q?em6vpLpBItodyTLD7AcjR9vzFuFihaAP1bE+9GxL+GKQ83HOOHn4efZ634pK?=
 =?us-ascii?Q?0uTeeV+W2d6ZgAA2eLDnXYC9FXnftyP7Ho16O4FUWIxG60+JqngS/727PRff?=
 =?us-ascii?Q?C4Bix42p/Q3Ltv5o2r4NCUZ4EJpW8E3S35VVKin2llIKfKSkpIqgsI4swX7f?=
 =?us-ascii?Q?+Rz7JyQe0TcSSUnj94InQRX+FWtkIuyCrn5crNnxwULUhfGUNI1Rom985Pf9?=
 =?us-ascii?Q?9ttnKSDmajg7ykGRLlIoowLXNI6pcgLy4YDHNAj8YMRzRUzXGJNDtuhyYep6?=
 =?us-ascii?Q?Nza+OpYikYtILyhtVqXK4KVcchoeRlA1+5m5T0JXUIFUmeSwNRgkdV8Jxsnn?=
 =?us-ascii?Q?uICtL9EuB+lLzrsvc0stKHGeTNg1WU1XuCrFvTgv9fWJNVpoJ6hrMeynP38a?=
 =?us-ascii?Q?Kc4eu6qyUVcOE3eKG3n0lyeT0MMFM3xqYlNTPPytify1UJQYW/ID/wMfDntc?=
 =?us-ascii?Q?fzsZWhonNoyPvsdJK1hkFBwEFB8H9NhHCOBXVTDxDDQKZjeqkv+2R+oNTnyC?=
 =?us-ascii?Q?BnEnl/1ICNYqmotJpIPO34UlzEdDHDUo2fErNnvU63bmTQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da73e15d-fc4b-42ea-8805-08d97237932a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 19:42:06.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtVfs4Fyt8A4ycadrZBzkskTsznWBmwlV/52OrH3zuGh016rO/hhovqW51eXx0oc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4273
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CsRE8ZSoxbzpiG_LNHbgzC9rMO-ArMPA
X-Proofpoint-ORIG-GUID: CsRE8ZSoxbzpiG_LNHbgzC9rMO-ArMPA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_07:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:48:06AM -0700, Shakeel Butt wrote:
> On Tue, Sep 7, 2021 at 10:31 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Sep 07, 2021 at 07:14:45AM -1000, Tejun Heo wrote:
> > > Hello,
> > >
> > > On Tue, Sep 07, 2021 at 10:11:21AM -0700, Roman Gushchin wrote:
> > > > There are two polar cases:
> > > > 1) a big number of relatively short-living allocations, which lifetime is well
> > > >    bounded (e.g. by a lifetime of a task),
> > > > 2) a relatively small number of long-living allocations, which lifetime
> > > >    is potentially indefinite (e.g. struct mount).
> > > >
> > > > We can't use the same approach for both cases, otherwise we'll run into either
> > > > performance or garbage collection problems (which also lead to performance
> > > > problems, but delayed).
> > >
> > > Wouldn't a front cache which expires after some seconds catch both cases?
> >
> > I'm not sure. For the second case we need to pack allocations from different
> > tasks/cgroups into a small number of shared pages. It means the front cache
> > should be really small/non-existing. For the first case we likely need a
> > substantial cache. Maybe we can do something really smart with scattering
> > the cache over multiple pages, but I really doubt.
> 
> I think we need to prototype this to sensibly evaluate. Let me know if
> you want to take a stab at this otherwise I can try.

If you have time and are ready to jump in, please, go on. Otherwise I can start
working on it in few weeks. In any case, I'm happy to help with discussions, code
reviews & whatever else I can do.

Thanks!
