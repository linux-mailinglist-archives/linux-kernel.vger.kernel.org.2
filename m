Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB13FF8CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 04:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbhICCLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 22:11:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46700 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232931AbhICCLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 22:11:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182MsQmn002819;
        Fri, 3 Sep 2021 02:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DQCg+0cc5/+VzuOQOBtVYGxYekw/rhB9qPrsCahrqCc=;
 b=gM5Y+JJQHw89zaGVlreVbIzs6YVmuN9do8OrXwX0nw80ReNV/im5fW9QueU1HpD4Svur
 fYMPXhOuji6VmByMujBTiT64cX/Q+autkVR2CvknewUwxVk/DWGjdiwzXJXqHakHapyb
 mZMuvNRcNX6bDquW1s4kenSdYQBsBkLoAYyyKLDCf0GsZJsWfx5RxYkQqiEYWK40AImp
 ME79PL/aCafK5gARRt0W4Fhyc0I6oHUyujwf7s7TOYqctI/sTPWIVf5P56M33BVgLwWf
 GqMk4YFMhF70UkZqa1djP88Mk5A7ZGDImTbKZ9MH0SGKN1eTixg+fz5o9mccVOKRYsyq VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DQCg+0cc5/+VzuOQOBtVYGxYekw/rhB9qPrsCahrqCc=;
 b=yPzvYGRhrL4QAKVkccNwHkCmpjjjL8tnwVDRcsNPKQP0YUbddEvqLnipjTXLGnwoNAtr
 m07Sff783TM1i66p4iKsf/gQrNNYXzKFd/COmyIX953l53UfhsYJDQyf5GkjdaWk3wKB
 BoJ3DVzMtKZGnKiZwzN74MF5vOPPw5PC9PZogdlNCLkWZDYPyjG384CT4A31A3P6p5ia
 35c7/j2pXEIC5MlF7udxDoJ1QKvcyqmqIw1oVaEq2SZEIpR/qY5aD6EQXe6ZQKaFDHFB
 YtxDUW+h5eBatrgMKfaFyB+APxQQOoZj3WKWO7yg8sHdMg596iBSQpct20jdysRxOlk/ YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw1cn0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 02:10:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1832A08Y172910;
        Fri, 3 Sep 2021 02:10:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by userp3020.oracle.com with ESMTP id 3ate00uess-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 02:10:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ8OJt1ihYm8lVh9nUJi0YcaLu1uahTxc1+wC6kPovu1P38nEyMkHTobdYq9IoO68oaZOBNp0fXQTiga+lsJK0XlJNveAazmU9ua1eHzP7s2mcdKPjztlu4k6WXS25eiz8ep0zXCMqrDUO2H/4KYwxMD577qpXMNomRUadkQjuaELCklRfLUEPvOABLCEH/JDpIFAxqe+NYa1rpwgr8v50a0/nVdr61B7Z6BecCA+LmGn38QhTOoTyE93szcgAUQsdrKT/ojlZk7fkqe+x4l21yOwJrZ+JeliDpfe4u1qxeFmS8iVOUlewqGkuSbvfoOTcojhKtyDKkmA0MKzRlp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DQCg+0cc5/+VzuOQOBtVYGxYekw/rhB9qPrsCahrqCc=;
 b=MQAihxhfG5ITYuHVNFgiIr9j7YZ/HuTIJ/9IDLZ4p2iAWo2qf+Lb4FDn2lOicwy2d7akUJfXSlGTnMztHlv4TiXfLbDhBe0aanEtQFRGpnLZal/mwNxduckpLJYogFZOVIly5rVgQZTiZypemRJSCtltrPIrZ9RRmD5Md4ZTQEcNAyom7D4xkiD01+5iMZ4pXNUDSjgrPD8kdelVb4+Rsa0qH2PuEigXSCMnRQeHr8ur/DqTGUR0SsQug299o+sTTRIJYCyu5+jRTIuE/cqbbpPLS7XxC2lBk177t8jz5fP3Y0WqsI9jgbtDuLfV3j5lnzsdoATsCVgAOBZqynCMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQCg+0cc5/+VzuOQOBtVYGxYekw/rhB9qPrsCahrqCc=;
 b=ZIYv+BIfzqQvM2OlOR3vJVsQoIYwAZnc44FgJOouaEuzN4RHN1PW+O5AIkC4nmptec2Pp8gqvD4gdzwSWVY4beIpIkoB5wwxA+4tIZevNaVsplFYhQaFcDqs3cY0ssgRizYantgQzgWx0EUIo2Tu2ueJuz8FohHOArZilDKxj08=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM5PR10MB1436.namprd10.prod.outlook.com (2603:10b6:3:f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Fri, 3 Sep 2021 02:09:51 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 02:09:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mmap_lock: Change trace and locking order
Thread-Topic: [PATCH] mmap_lock: Change trace and locking order
Thread-Index: AQHXoGP7cpc0Z7mp8UOLUJvtQyIsu6uRiSkAgAAHk4A=
Date:   Fri, 3 Sep 2021 02:09:51 +0000
Message-ID: <20210903020943.rogfn5zy26m4r5l7@revolver>
References: <20210903013521.1802774-1-Liam.Howlett@oracle.com>
 <YTF9jE+GXId/tp0o@casper.infradead.org>
In-Reply-To: <YTF9jE+GXId/tp0o@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7234639-4510-49e8-81be-08d96e7fea27
x-ms-traffictypediagnostic: DM5PR10MB1436:
x-microsoft-antispam-prvs: <DM5PR10MB1436B011CA0E44E87D871DD8FDCF9@DM5PR10MB1436.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnIrGPYZdWBZHAIttO1QSJYl+lPMm25VZn/j2fXsFFdBM0HtsRhHnP5FJigU3dSJ/3ht+HuALtJ8kQbNh+qadR+MHPPljiNsQrKV0cqn8gdkixuuiKxAR8kHPUBq6o6b20jG5i1f27e5FjEEFjyYk2pvTxIJG45vlkbwISCpjDQUE/o4zXeJlODaWkqanpjWYj8yBZB+S9xIBiZB7d6yKhWdaRUhxBp4gMt1S2A8nXdm9bfyWm3QeWLRjEIN4x48ITrJ+8t+ak1YrCcE8eHUm6kA2wT+rrQ6DZc5Thv/xWPfujK1REpvZ4A+9h1YgCFz0dlOvdlvCFDBSZO4F4LBf9UPQr1BFxORmVz2dyhaV+Er9SlW76vYsl5wCkDccFsHOW5Y5ECc5J/lAMhs9gxh5E0jjTSR3+lYgqzG3SqastHeqqMiuweiF68ihRZotee4gDrdzIhx9+hUZ2bgA0/gPwVG5xlmF02O0RauGP/sFxze78P0tvkCnDVKApm6kUhJ34mRYhwy/NFeAuD93zy/QpCi1eb8n+Hi9/yow1kgGWI2rHZa1SOAIj6jTU0iu4lbBqp0T5mAEKniDwubBMV6VFiXiUpDGDdBW6qiqa5G2ZPgFAuA3hCmWzpix6brJ3cN7jAbSLhnSIeoZf3MSuHHNb/gT/wYLLmvvzToFwuDVXXZ3Wv0nF1mW1krfxmtfF3clbfsDOXvaYVv5JQTJ7Eayw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(376002)(396003)(366004)(39860400002)(136003)(44832011)(66476007)(64756008)(122000001)(6916009)(66946007)(66556008)(8936002)(38100700002)(91956017)(76116006)(186003)(26005)(4744005)(1076003)(33716001)(38070700005)(9686003)(478600001)(6506007)(66446008)(8676002)(316002)(86362001)(2906002)(83380400001)(5660300002)(54906003)(71200400001)(6486002)(6512007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XZ9j53+NdeNxxm8fjIbZAUzIioZAkctlMI8Y5xKuUyHOfwoeyS370JIC8uAT?=
 =?us-ascii?Q?CY8qeUDMiorTAhS4M0CYo6WSDCW0egu/NoMnnpp4q2c8/hOVZ4+EqWfFRtxg?=
 =?us-ascii?Q?EQDCfAJ1fV2YdOdQcp8tt9mFnbk7dZTujsUfS67LXxM8gCTHVvrwHZ0oMqI7?=
 =?us-ascii?Q?oE+dLOfMgCIpno+6PS+7FtPUl/hbpniSlNC42DZi7PFlyvBCOmoMqZ1mo9+E?=
 =?us-ascii?Q?QkKUqjCZvWVO2c3u/paA7FcvH45bb123P61gz01PRS5xvzdkm1i8DtrSg5jW?=
 =?us-ascii?Q?9RUey2v1bOLN/bkdCKZDlKSyQTEoqB2TkMCIAQ1yTWkiezKlE5tXT3HdBuJK?=
 =?us-ascii?Q?Tl16buuerHsjPSpPh7R5jQnWehO0/zPiUS6UHh06hxZjyvx58885xiQB/TDP?=
 =?us-ascii?Q?GBhWkjkzBK+KiMSUfTIoL/7a3O2KHKG+oumk1nglmOT8hT65CVYgtj7IC+Bw?=
 =?us-ascii?Q?gl9LnYdMotADGy+aUHR45iNk/9olo1XJR+8xkKuCKIie4uvM/pYi0ppGaBYH?=
 =?us-ascii?Q?Lo26Dpek60nTXPrEaQKlgNjY6kUFLRG9deZYo5AKDB9ZRYkoH33LudsX4nOV?=
 =?us-ascii?Q?u+2aTzdfiA0RPudno5w06ehKJRyqJnCLXGhQAJWx4kLDfpqV9babmWJOVCgp?=
 =?us-ascii?Q?BAxgu5zT1HhUgIMvrefXUIQgs5SgdbShyGxoYD7c63bZ8Im9GYHIlarzEu0Z?=
 =?us-ascii?Q?hYq+OwZovuOEyyzQuf8pqQMekYCRZUQf+/ADzaT20InUagYIyK48L5M2Vsuy?=
 =?us-ascii?Q?fXCvhcx99LDYjMT2tE5idM3udMOrnmInDtREYcQfjfD3ZAxwmkrsm77UJmFw?=
 =?us-ascii?Q?phXQOFJENWaPyfOLQN0F8/X4wEvsfVKSkRSWqEVUCdAhIGAd1snBChzN7b9j?=
 =?us-ascii?Q?7Rm2QY5Hzquiqltf2qb2fc218kkflOJaxgnIi80dnSRmHFY2JF0RCqnITo0t?=
 =?us-ascii?Q?hDgli1wuWS1WfsCUiPmTy4nq2a19fS01mPsODdmP7x8b3CJXEScWMIL42C63?=
 =?us-ascii?Q?ocw3zN5IpqqccnTzOGWi/7klQVvCUiAwtZWvXoHspVXq6mRAnu5cp801Whwj?=
 =?us-ascii?Q?I6aCkL42Q+C0x0EQJhos+7+gL7OwLpIYQVQUbOlZfohWpapdr1NP5/4Ne5WR?=
 =?us-ascii?Q?F2umUpMRmkOnb1LCOwzwd8VlgnsN2TkHHYvL4jiRUoneWfF4RFDGHEEr8F8b?=
 =?us-ascii?Q?uIKdpVnKF+RyP1RjUbs1tp0w4FcZUCzAOf0FBbpvoe7/cX1INjdTLPb9/FV6?=
 =?us-ascii?Q?3jEf0Rb6xj0hmwu+6HBtIGGzwSLr1WIKUH5K8konl4KSlnVZHDjBxwdX9Ezb?=
 =?us-ascii?Q?/DJhigb6a0cDDDsajutAfwEV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAEF43EDADAF0B40AF35F5EB4673A73D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7234639-4510-49e8-81be-08d96e7fea27
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 02:09:51.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnLvtAfkK2SWV32zMAYfjJiGdKmPnsbo+/7/D0ELRxxrV+hqYZpRB9I7A4RSwB3zJrMVjzRVZklQj6CrutgMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1436
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=504 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030012
X-Proofpoint-GUID: K6gNnvlZbooO59NNpZOdwK-K_63CxtFg
X-Proofpoint-ORIG-GUID: K6gNnvlZbooO59NNpZOdwK-K_63CxtFg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [210902 21:43]:
> On Fri, Sep 03, 2021 at 01:35:31AM +0000, Liam Howlett wrote:
> > Print to the trace log before releasing the lock to avoid racing with
> > other trace log printers of the same lock type.
>=20
> Aren't you missing mmap_read_unlock_non_owner()?

Yes I am.  I'll send out v2 shortly.=
