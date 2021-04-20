Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D949D366181
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhDTVX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:23:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56082 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234131AbhDTVXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:23:21 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KLKKXq002555;
        Tue, 20 Apr 2021 14:22:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Au+ILy00RdVvyuQy9tyEzC/b8IfxyR4BcTNwJhZsf1U=;
 b=W6g+emXwwSANWKXLNxfnd/FviAkXCnaST73hbwju/kAdIKVDJGf1E2dnsGxBvfH2HzC2
 gsmlGYi4u/C0RefXtNLMcFVZoohLJzme1jfW6ioavynInrTvCC4tDoVV9/Y7QyGllZ9Q
 gnqxrbBD7wIZhalkij5UL2yC0RvNrNnjo3I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 381mxedchq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Apr 2021 14:22:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Apr 2021 14:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbePAuZ+wxPv/QQzh+jpwP6XLigUTuqhAMbath42FNGjJsDgFQcFkT8WbI75f8tQ7vUIeMxrc4uotlXuNIw3q5+8g4IUxrJZPtLR6VGzUIjdFSLmTJLVWxEE+hr58Pvb9+mDQZTb6356XSfw84i9xT0ng2Hl+Cxo9sOa0WNfQPqLrGzG2nE4cs8YpUkcczGoUaMsR2jjDg/GAqGfibL25LX4saZX5YO9/pYenlQlcQTVwxSabS63BJKK3t9PCYxrGc7TJlCcDFGtvEVyoDr0SlIkgq2N86XXhiUUEKETedM9M68AtJXYPDWuwulL7m49jpPuCrGEX54Jux5tcuf6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au+ILy00RdVvyuQy9tyEzC/b8IfxyR4BcTNwJhZsf1U=;
 b=U/jLyuOO2+oRqCrxcRYHCpAQayf6y44o4piWqeiB58P6DoeGt7/JlofL0HyVocWR/z4CeW2qSN3+UufCEzTgTcHpTpoV0ILNaSuyZ95hfxIUc/Lci1y378/iQK5NMgE1gtX+jhkuCj8+Jznd1SKOgKw761wAR+L5maUN6EF+LyACFHe4BT8kgiqGUmyVuV5amxT4H2ycBVasix/pEWB3GsvwHh0QjZruQfTs3kj4NXGcSkpbTntT1C7SIkvaCv6xbIBBCXSLa4vIC2kiUtK0qIHoaFA0U1l24fjZSU0Vn5pbANRshtrzUtBWtOR8q2tBNUiw3wKAWvqFzQr5D/q3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4647.namprd15.prod.outlook.com (2603:10b6:a03:37c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 21:22:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 21:22:43 +0000
Date:   Tue, 20 Apr 2021 14:22:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] percpu: use pcpu_free_slot instead of pcpu_nr_slots
 - 1
Message-ID: <YH9GHrHKw6riW2X0@carbon.dhcp.thefacebook.com>
References: <20210419225047.3415425-1-dennis@kernel.org>
 <20210419225047.3415425-3-dennis@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210419225047.3415425-3-dennis@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:3ae2]
X-ClientProxiedBy: MWHPR22CA0069.namprd22.prod.outlook.com
 (2603:10b6:300:12a::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3ae2) by MWHPR22CA0069.namprd22.prod.outlook.com (2603:10b6:300:12a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 21:22:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94e501d8-9d57-41c4-562d-08d904426f6a
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4647:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB464762C23B2120EB9874883DBE489@SJ0PR15MB4647.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMGvTDqVmz/f6ddimkpt0yvTJOcnkXorv2Lpi7N6xOkaI1aN7yN2FdQTuhujPks4X6KJ3U3vCLP3zLrYyhd/jzOaXh/eCgJeXDEOTjakPevhjpDGCn61ThNpQG2q/PkbzcYof8z2UhO4zIUTLW0rcMj5INEldKiFuA6RA7lOrwTQM0znIxLSvNBdsTe3yjc4FmGYcM4XcpjzSV70KBhrWfAoWl//keF8hqhklS27jycf3UGIEYV1QmInH3pXTkOFttdM1qKX6CPwT8KI33aSHijdsRfGb9GYErw9J7VNsDe1J0AGY8Lw2LTdyu/fe8BhXTx7wO+F5Y/DvOlM9mHE4LfCVjeoOWTxFYyuQzf1ZRHizJkhronFtKr/hHJlEY6yAcfangAACAF+5wm2zrAzTEB803loPCMgX1+Z+0hUuvuqMhL3j4EDXDV5ne7LEHlVcfMZuKQ2DqRKHnjquxYR/z5vrqIEKe0C8MjI0mFz0ZbUDYl/+17MMfLTrT5YWbZ5hoY6fAXgINIbc1tZuWC6Fn9WEdmSLccXX7zxjAzYEtKp+72vJd+Zm0yspZxl4kI8tHUzKdnsB/8OovS3j6OIsXJ8KHE3zzbwhtEt5sZUkr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(66556008)(9686003)(8936002)(66946007)(52116002)(8676002)(6916009)(6666004)(66476007)(86362001)(7696005)(38100700002)(316002)(4326008)(2906002)(558084003)(16526019)(186003)(6506007)(54906003)(478600001)(55016002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tkasFo2S+9YMMT+tAe4xkWcH2BM/n3K8zObV/8kC/6htNSxewCIMktaujHdL?=
 =?us-ascii?Q?MDgMhfbM7mr2du30RlcV48UfcfBOKk44MnA1Ult2yp5P7oFIfzgUKfkFu3nQ?=
 =?us-ascii?Q?Bpp7IKiucow1J1haywTlZyIhVoyrXAeo/fLWx5eiPz2GakIRV7XNkxTx0l0P?=
 =?us-ascii?Q?9Y1hpDQf36hrashv+ueXIJc5jXWZ57XT49wrccAJHA5DDJjpms0ze8+m2lqi?=
 =?us-ascii?Q?K/15lo/h5/rKe4RO04uFIapYAF3RtQu04RFejlaT5aI9MgOescBfoXjTGZc6?=
 =?us-ascii?Q?jKKKLJ4DDF7x1XeLYqufRxK3xRnbE5ppWhudTvWIW9fKDcJvOiQNX601JVXZ?=
 =?us-ascii?Q?a5TgEkBSBhnOz0A5g8L55M+FRnp7nwL5zqf7Sr38x6hPAIORhD7JImGo1e8f?=
 =?us-ascii?Q?CmviPvPeEYluyNVT9loU9vvZTkia/n2wqe40vu5GMXzp4O35x5OMU0vf8Tvs?=
 =?us-ascii?Q?Wkn3YJ/555a/kYbbqoVgNF8WSepBVTyiTFE7Dbn++BToUvXnjcIlp/N0Mapz?=
 =?us-ascii?Q?EsVGKUo7vuNyqSP6pq01TcMEV8YeeV7VXq4LHMTcISXIKynIL6hsgNc87/U1?=
 =?us-ascii?Q?FaEvgFsNvOWUYgduCNsjrbJt0fiTnGeNNpkjt1YA3mAggbnzDvJPyDOjMWCz?=
 =?us-ascii?Q?HcGBJB2KWhA2VZLC9PH983S/c5fovvMG8u8jj7o0Pk/Di5GfiHM7lOKcHN55?=
 =?us-ascii?Q?bOusKqeoV135tE2vd4Ux1kq/nornt2g3ELE840xwis0eAIA9uJMHoRpM22A2?=
 =?us-ascii?Q?nlJ0p3/c7kpr9/hnj/1ed3na+QLtLaS1n8+8rJaOzU+Qb7YObV7d4Dxx3gb+?=
 =?us-ascii?Q?kjKVZJnSdWZm9Iw6LjXoJIhxSXi2HXzs9ujQHchwJq8GU9xpxQ2NOmEzzg7p?=
 =?us-ascii?Q?hnd+6brL1hOQOpg7RIqOqOJkrCnHRvNlJ2kt+Pu4EdX9nJiH8eGFfA+CtOah?=
 =?us-ascii?Q?cRVowPX30eHh1RY5xw7Rly5I2t+6coLgWJOrOoerV6x+5SY6tnGYUf0lWUZC?=
 =?us-ascii?Q?YRdswvC727k4a1pTzQXAMtnXFIBrEBG6iPmwvI/MsjJpLpkjYfFZaW63aBFM?=
 =?us-ascii?Q?APYjSbjOxRTy4toZ1Exzw/SBFYy4m1H4I1k93dkuZp9JFTS1JYICDHojfMSO?=
 =?us-ascii?Q?21CkH3xjcceVkrcndIFitIW3HN28w/xxCmtfWwvUFf7v8bbkX1fjDJrJqI3O?=
 =?us-ascii?Q?7gtqqPIRklWFnwLexr735N5GBgJA5BLP/uyRdCkTIgTDM0UxcJm1JlkWZGom?=
 =?us-ascii?Q?GuFUd7tAahWUqoRX/gDhb8OKBcW33TmU34JT+ZNlBdKGLBSl0T/yyTHkDMrk?=
 =?us-ascii?Q?xkDCXs3E5ffvxBwnA12vhgyeVHcRdpeqw5w4zTY8SfUCXA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e501d8-9d57-41c4-562d-08d904426f6a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 21:22:43.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wo1CzCsc0VKaMQudv3wujo9OWrM0QSBx4k4J+Heg13gYRMc11JE4nG3ayI9tmHWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4647
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 1ZQO3eSkqi29xlRqHRpEac7RPlTgz4JC
X-Proofpoint-ORIG-GUID: 1ZQO3eSkqi29xlRqHRpEac7RPlTgz4JC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=475 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 10:50:45PM +0000, Dennis Zhou wrote:
> This prepares for adding a to_depopulate list and sidelined list after
> the free slot in the set of lists in pcpu_slot.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Acked-by: Roman Gushchin <guro@fb.com>
