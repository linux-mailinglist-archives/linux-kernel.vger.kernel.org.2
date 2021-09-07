Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE37402E10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbhIGR7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:59:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59668 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345162AbhIGR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:59:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187HsZgo027982;
        Tue, 7 Sep 2021 17:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qcO7MZthesZA8nMzsdYLNqPVTFTOFD5KjwzK9EXwvbs=;
 b=e3catQP5NG0ELPz5U2Pai1O4AOxjaFJDRdHM6QPrbCkT1QNvCsIGCtM3+g1KRlkOHs5E
 vxjIAAniihB3vvFvFB1ckQ6ypoal0rE71YIAWx5b3vkl7QptKs/TnBDlgKEgtUgdWAfD
 QFVDDAKF/O0zvTdx8Kd1b20MHHV+FfexM3bnLa7F/IsyHm0/asa7MYBcOmSz31k3RIRH
 LOL3n0NdKn9V7R6LezCWMaDIq5g+iUVkfMhyC9u1gBDac4Y4lmAXNCxun4NCXdC7wXyX
 iZ9GbaQzulOP/BCr5SUBRtRYgn9lmo+01fsdYkFJ7nTheGQG2ytvYjeA4ZEzM3g+Ro8y 2g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qcO7MZthesZA8nMzsdYLNqPVTFTOFD5KjwzK9EXwvbs=;
 b=AyEjwiUDDu+pBSPkHyKON7eNAqQGIZN18ModHsrIt6SHS9/XjAj/Ps05uldNA+eLCuzy
 9YiCO3K8Hx1/Pe076L+8m/MYkZHEMN7RwKHhMBV81Qd+S87Tnm0U0FSt3Bx7EMeyuPWp
 wYp3JpcgiGpuLr0Bi8VE9upECIEggO35MfBWxZ33NbcjfqGTDiMNI4DT0BTHh4SyPWPL
 mlO4dXsp/MA+AUf3IPtQooolm/wJOpH+ap2wfQN7DiXJTG6beFw0nNmZgHwQJO7zpIM1
 1zQhAzfS6H4My98IPV0oRzJBRtkgJMuLjt9NLNK5DRxdmgcGP7EEQu2eYzg+tU0hHFtU Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw680be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 17:57:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187HuCkq086481;
        Tue, 7 Sep 2021 17:57:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 3axcpp8q1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 17:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx/RKx1Lyuo1vmHN4hICPy4MGv/mDMgzUUI4+ZmM2YP0cYHNAbTbRAMyR3tH1m0BjeBncWmgOaX/B2d/a/SudJz+kq/zejajGlaxoD3B6dlO0/49QURVagU9Kkz7MbUHVZy+itPmQDnyP6uxDNH9ott01Toh5Uw3JIsY4GQN7GtT+zTVu8SjPNuMegm5ZzcxbCucqtHvg8wCjUHZS3DO/KaPP5F4FwRkJ8RE5LBsrfMsx1X8VTu6CZX5xiDpKImiSWE8szs0dFII5TyU5GJQKMG/qc3GiloeXsMQsIrktiN8oTmHdK163G9P55ErgmaeXORTiyJlxMotr+xobDnPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qcO7MZthesZA8nMzsdYLNqPVTFTOFD5KjwzK9EXwvbs=;
 b=ShtBHM/1I2Zv2Et5hIBbbBlc32CV7LuEgUD+fzr4CzkTyjl292531DU4WehfTOekV3SKiNN3C4VRTxofidGB0tJPgd+9J6GwtbvXCZ6qyMxM4n/Tt8hFoIeDdfRj+jjOmAtqJ31XSyupaEq+bscRUoupXMYrfJnCZknDwQDyW0GViNbN5YMPbwZ7VOj+9IHPZELpDEo5iLTXzlj4qI/ynfF/PvVfwS965cPS/Z8syvUxWTKNO3Nmt5gAKBXFlkac7p/tqUg+FSWubGA8P5tgSDDOOW2l+Y9ljJw0T4QwU99GnV3qosFGt3+cg2Pfvznic5A9OijHFwA3yC6bViPL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcO7MZthesZA8nMzsdYLNqPVTFTOFD5KjwzK9EXwvbs=;
 b=cIA8EBzrRn6kkLWB/6IBqOheq0h2XOGH8GVhHa8VhxIfbrOTQuNsmEFxdvJzQM4OjlS8ey2GTHrzIi1kTzbMcvtHum0vkxboAcXDb//XtlD6xtfG7reKH7S3qL6hBa4xevNI5MNXxR76rNWVB09TPXXeWKxPSuJ85Q2FzqLEMbQ=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3660.namprd10.prod.outlook.com (2603:10b6:5:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 7 Sep
 2021 17:57:48 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 17:57:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mmap_lock: Change trace and locking order
Thread-Topic: [PATCH v2] mmap_lock: Change trace and locking order
Thread-Index: AQHXoGpZMTHOHeoOlEi9q/cbKaDHwquXHvsAgAGx3ICAABIHAA==
Date:   Tue, 7 Sep 2021 17:57:48 +0000
Message-ID: <20210907175740.utkiu5folrdajmgs@revolver>
References: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
 <c2fc9aff-4275-3025-fced-83c0f69e69b1@suse.cz>
 <20210907125309.7af5cd19@gandalf.local.home>
In-Reply-To: <20210907125309.7af5cd19@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f650b98a-4fd4-4c5e-4ee8-08d972290104
x-ms-traffictypediagnostic: DM6PR10MB3660:
x-microsoft-antispam-prvs: <DM6PR10MB36605211091731F5FD6CE88DFDD39@DM6PR10MB3660.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Vm06rMbfzqFFiS438VzOXEmeTXQtcLf+ZWpL+9qtV4/kGxXYYT3MM9wWXrou9KBAZ4bAstkm/HfzY1gb69VoDf/f0dTxOlKhO/p/t5tJNy8YV9vhDPAYsFNMRMGEQXaREMQ6iSymXKluNaX7ovcLNzDfFSDLq6pEdik0Hf2nytPqnUnYihnAp3AvIyAfuAElp2noqIklblflsM6HB3DKmDmXffzRwaWJcd/xRppxQBuKflvVLIjhJ/cT90v6dkul85dIo8tMenCtRoESVms6H3vgJ4kOq+AtbGlOUcCiIhYLki8lIp7wehbcSuhr6MGpqXddcEdQ16LtTnb6Bv59Ar1pYivDM7AeZK0q+wChH07mw33eGUWIe9A8gp7Gf2JeCI4eEDdH0i6awLn6uEq9gEIdY4l72qIA5T+b6fiGh7r861s/FfBvs2KW9S4UROxNnF66NvXlp2MtcsDhiUvujt2MpRdnA8tyuvut7j+Ejvd8XSYC/IwQO49PUbyAEsz7A50WyJdrb7+qEW0zfpqtEIKKYUQXtApzMQiz3AXAZ9H8bvWV/hxFz/WyVFK7ag3AjAUyyezFRvws7oQzSp2P8/I6JrQ/ZNjLSG1jFQt2caEvaB0U8+6ARdeyBO9gVY0Fhpq3pIaxXXwMJ0bNEGAtFlGJcIjYdj/lDAmAFvet5ROZdJ5e+ibeyssHnim5Os23MqLj7K3UsCInwl5S21bpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(33716001)(122000001)(316002)(6512007)(54906003)(6486002)(4326008)(86362001)(66946007)(71200400001)(8676002)(83380400001)(9686003)(186003)(76116006)(91956017)(5660300002)(38100700002)(26005)(6916009)(66476007)(8936002)(44832011)(478600001)(64756008)(66446008)(38070700005)(53546011)(66556008)(1076003)(2906002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wt6kY2gQjkkFu2oIJmfQrvMSPtX2u+gKfde3XioI232oTDVBZ1vivVkuLrCy?=
 =?us-ascii?Q?DIWcbajbOGiDr5dkm1ZGfYWSQznoPKilVHdYQ1PF74TDqU2W1oVDd1pjA4yp?=
 =?us-ascii?Q?QsSeTVvWjUsxMAy1qZYPZv+G8OnocS8uqexnf1Qr7W8P76aFn6HkWsSlD60s?=
 =?us-ascii?Q?9NS1Di9hZsLWgc8MMsWmLvted1x7aMhFck8FCw2XcQqrqOJtP1Xw1yhmGNQ0?=
 =?us-ascii?Q?cz0tUuVhCQnQaK/F5Hmoev0/57vkbEQBCefDYCrORLxOYaqJssRG1COaH6nY?=
 =?us-ascii?Q?Rhow7ezZF6nwfMsapgJn4W4aoaD3xCTJNsX3Vdn2OLCp0AiOxaaEMxU8bcwM?=
 =?us-ascii?Q?oB8LaJlLI/kGnki8bw15OQAHRLepIpw90UBy1LNS6tQkkZ7DN5PEsQWC1Z9Q?=
 =?us-ascii?Q?gWFhR2B8HJZRaSNSks0FHCUmEKou+BkicCkzot3XfMpBKTcKRSH2ARHiqVx4?=
 =?us-ascii?Q?RCGCNhesYK7/y6d9YdNE4s4sn17IAbIqPL3HZDDKo9vo/6aH6LZkzzmObOZw?=
 =?us-ascii?Q?YS0CKJCjE8VXqAo9x/Mo3tankUbNP06Rr6fFlqBUSXD3vq6TgH5KvC30dmX8?=
 =?us-ascii?Q?o14Pql6FZoL2v7AX3HLOSsp4MrmBbTJaVy6gM/fWXJzBgAyay8LOhLgMJgNW?=
 =?us-ascii?Q?quOgMinf8nVRmCgWXPpPgNqdVx3L7xC+L2bhyratAj/dR2Fc+3lalkPRIXxa?=
 =?us-ascii?Q?U0GSCFi/OvDdlycsqLYxPO1/COtHaIJP9R8Rb1llFGnW/UTBT19vMFjSRJeH?=
 =?us-ascii?Q?NayrPz3KQivkhHoJsujMnsQ2ktWZsv1TybAwNnFGuU4Dp6bTPZCnZaF9UiVY?=
 =?us-ascii?Q?z4/H7ZJUiE0x/EG8XwP2985YACPWwSF5RrQtZ8TPObEI/4Qyuw4sFcquYMPZ?=
 =?us-ascii?Q?piMkKEcuu/G9rGyiLNCpZWQkLutGRJzc1LD56Lj217LrJJHLYPVxPgErJmQC?=
 =?us-ascii?Q?p4rb2cBMEDeP/uIQ938HQ3ZeJ9kGjOU+v7Ba+iojIkfVs06RDAEnpN70RmUF?=
 =?us-ascii?Q?ZAp8L59t2M8UH7PEJSB07qAQ9wy1yyIFGQN7D4iyvEORITtKEG739AXwoKbt?=
 =?us-ascii?Q?Wfycx7yv85xRW7dRUNbON5PLIVwgXp5EpK8xKfXFsK0NlQMMClpTgnJcT/Th?=
 =?us-ascii?Q?3Og2wC66nh5FSUE2TE8tZdQIqT0PjD6/h1I+d97Yzmw6nZPMSN/1bisZJbYa?=
 =?us-ascii?Q?GRrzZHICVZ9SBsuRZdAExYIAjyy71Bx9JfFLsjQkFL/8U5V/PNu40E9CfOQ4?=
 =?us-ascii?Q?IwjbbABLoccnU5hECgGit5wmqkA96gzEDrATIi6fm7b/fVXQftuDIkHE8QOs?=
 =?us-ascii?Q?GZOeLsa5iAFBKbtAf74eMRTq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C0053117978D94EBD06E68986C43A59@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f650b98a-4fd4-4c5e-4ee8-08d972290104
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 17:57:48.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sW/UqeEF69WdZtS+/391zN9/lrmvAuRm+ILa4p8O6D2x5XbC7vqIz76YPsCUK4WpZBtJnW0duGvktHxPLGbY1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3660
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109070115
X-Proofpoint-GUID: FZDOmrEb_bP-IU3FxI3uyW62_YdJSvlk
X-Proofpoint-ORIG-GUID: FZDOmrEb_bP-IU3FxI3uyW62_YdJSvlk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt <rostedt@goodmis.org> [210907 12:53]:
> On Mon, 6 Sep 2021 17:00:18 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> > On 9/3/21 04:21, Liam Howlett wrote:
> > > Print to the trace log before releasing the lock to avoid racing with
> > > other trace log printers of the same lock type. =20
> >=20
> > That description could use more details maybe?
>=20
> Agreed, perhaps add something like this:
>=20
> Due to the tracing of taking the mmap_lock happened outside the lock
> itself, the trace can become confusing, making it look like more than one
> task has the same lock:
>=20
>      task-749     [006] ....     14437980: mmap_lock_acquire_returned: mm=
=3D00000000c94d28b8 memcg_path=3D write=3Dtrue success=3Dtrue
>      task-750     [007] ....     14437981: mmap_lock_acquire_returned: mm=
=3D00000000c94d28b8 memcg_path=3D write=3Dtrue success=3Dtrue
>      task-749     [006] ....     14437983: mmap_lock_released: mm=3D00000=
000c94d28b8 memcg_path=3D write=3Dtrue
>=20
> When in actuality the following occurred:
>=20
>    task-749 [006] - take mmap_lock
>    task-749 [006] - trace taking of mmap_lock
>    task-749 [006] - release mmap_lock
>=20
>    task-750 [007] - take mmap_lock
>    task-750 [007] - trace taking of mmap_lock
>=20
>    task-749 [006] - trace releasing of mmap_lock
>=20
> Although the mmap_lock was taken and released then taken again by another
> process, the lack of protection around the tracing of the activity caused
> it to show the events out of order. If the tracing of the taking and
> releasing of the mmap_lock is done inside the lock, it will protect this
> from happening.
>=20
> Andrew, I see you took this into your tree. Not sure if you sent it to
> Linus yet. Perhaps add the above to the patch if you have not yet sent it
> (with Liam's permission of course).

Yes, I agree this change is useful.

Let me know if you want a respin of the patch instead.

Thanks,
Liam

>=20
> Seeing that the patch has this as a link in the commit, at the very least=
,
> the above explanation will be archived.
>=20
> -- Steve
>=20
>=20
>=20
> >=20
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org> =20
> >=20
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> =
