Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283E545D512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352772AbhKYHJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:09:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48540 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245025AbhKYHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:07:07 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6FeLl028328;
        Thu, 25 Nov 2021 07:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=yt3fU6qReu1ohrDilfwYKjvoriurgidpnee1fDWSlUs=;
 b=pNHhVPUHAodFd4q3pB+ljGcqiytaZlQlPJpbhIwr/upScmI54W+PGbWIGTq1FNzXkXA0
 5JPtYLI35AdUA6MFpO2s1hj49La5FymaC+Mkersqc0Hqk8l/qV8izrQIRV46QgjSwN1e
 7s4Bb5A2bdBJFH64o58nTRp06PCo2zsB+ix9s27fhQSU0+uW3+F2KWDUwRCsLaZPE1cm
 AL+2EJK2M3YEiOnMAX6xgQWoqJboyqRh+6/RbFbnDY/LphhHJMDwJxG4lHMHStXLTxfq
 MllkGxqYlD4VDlJATppD/I0mvWNvGSrgL1RXQEL9nM7qDrIIR4zd8ybzAtN9xiFt93/w 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chj7g5rys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:03:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6pA9h088938;
        Thu, 25 Nov 2021 07:03:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3ceq2h81b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+ENgLnY/X1KRJoolIHmCJQp0fBWRw8xrOE0KCLi2WjFq28/KyzQ7CH/2YlmR3gdHGGnVKdl+xTA5O4IcMVi6LzmCQEfGK7lDzLft6SpA/a+p8yxAwlS9vjqSiXVG6RDIdS/6poj9MeqptmfuLkpBinP0ACMGG+muRuQ88A6wWYrEoPkDiOHAZO0b33s1WIs/2Nf+gvj7jB3dzbSS6hb2JsIW4Yb5tb6N7PYBgb43qJ/NG9ymEhz7lbyjY9q4l+u4N1J8aE+8CzEaYsLC7Dz+QVj0L4HHjmP7EF57vT2M49Cp0V5ZK19Q958V3KSXRYOz5V4UxN7NrK658AOI+EA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt3fU6qReu1ohrDilfwYKjvoriurgidpnee1fDWSlUs=;
 b=BMJVyzQXfFiweXvncwP/njNi2NTqpg87zXeinyV0rPEsLZgsV81LNb31OX/uZsFX2RpBOdzO1r9NEu04IDJ21x54HvMsI7uG+jSVr4fCaJP+JPIZCGZG9zN03brkl3elZuICor7LoyYC3uL2LTGJlkABrH+Oc5VXj+6E58VxnvEDTzPDhmrMQVMkoY0AQTeZ+Jb90o1jq34UCnzzCi+xthYI+3RNYUQ6uZ5+NL7wtQUMcVzuhguptnsDW8CbJ6HM/hACFY9c2kQzvbm03eWX54vt56zqUbgSWscIFOxN+4V5X9QUofevYkAZEeogVZlRqUuBWdv1j4ZGLBpug20x7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt3fU6qReu1ohrDilfwYKjvoriurgidpnee1fDWSlUs=;
 b=kfB2nUV14IhZc943DlbA/8szPMICKrhTvl5J9xa2N0l2vxfBxEQ0IOALhSA32fn64o0V5Wr/geJR04gQt9qnhm2wVyQVEpxnVzqQjK1nAC08bOMqn1YH9yyArVVK/zEzFu6uR6P80uk5WC9nE1gWz9i1KaMRN5lQTZQB8c8js10=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5459.namprd10.prod.outlook.com
 (2603:10b6:5:359::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.25; Thu, 25 Nov
 2021 07:03:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 07:03:45 +0000
Date:   Thu, 25 Nov 2021 10:03:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Parav Pandit <parav@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should '(((1))) <<
 (mdev->id_table[i]->device)' be a 64 bit type?
Message-ID: <202111250317.VUsGtdox-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 07:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57538d7-000e-4b43-e88d-08d9afe1b88b
X-MS-TrafficTypeDiagnostic: CO6PR10MB5459:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5459193D27EABD1C359902A28E629@CO6PR10MB5459.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WTwCEl6kdsulcbGwZJD47VN23bJ8xxYVs/RO3EqqgMagZ0SopddERf1I0ASdSQU2JIOf3HOrbtmRbmKbXjTsMg1UYQqcuzNYf/Hm1Tfyi4unIBwd+3On5Y+uJL9J/EUrThmnVOH9Dn8MwRsVwSyBzKSD31xbeZQnRCq3SBRAr3pGoe29gyzuJm1b2j0tlQAla7ncqqqgo2b3nsG8NGI/v+eDbwRpAtKto6uAmpYBoVRSHNvKzZzOkctGCOfWdijBt1N8OGgWO0K3461EJWWJyvll43dEMgsEwYcuTQEroXvQp+WVTZzSogf/RALGsu4P+GbsLUk+2JVcjdIe8gGkaxwJefkfycNwWGISMZKMt7FH4PpkccWY9geFyPC7WB1WgBgQEwvOkaqG+zwok+839Gopoebmmes3+dbDGjUGqLGvYE+h5MALBd8SRgH4hQaBQjJoiPms41XR8kPVFYFnROlWj49fsfR8Q0GU75CF3kQR/B6YEepTNPhlqjst0c7mjryZtPJApGOsBoc+BzSuEe++ANGVGLRAagzDSWo1oOoTvkZVxu64VEF+jKPpH8bzsjUu6NPvGX8uhhemiHL97W23mFMb8YgAOVXnxLLM5Oh8aU1Pt5O6dSLobHgVnuBX1gx4TChOdQIn4VuRBkZyuc2pUp4eLgV5C7QADPXwWF7bOV3BS4SfECkkOE4GImeBpRmC8ALIzKRObs8Avd8Tv9oyI1vuhMt7SmxFPpcyzZTJO2oUQdR7IO9tJXXDlabEVIv0cOWk37BNHaZ3ysviCBzT9dyOVDQqf1+vPeTkMzNPA0e2+bdkNXgFoJVbC549VGVLARdaHYzy6JhJ38OtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(316002)(86362001)(8676002)(66556008)(44832011)(508600001)(1076003)(38350700002)(2906002)(36756003)(4326008)(38100700002)(54906003)(6496006)(66476007)(186003)(6916009)(6666004)(956004)(66946007)(26005)(52116002)(83380400001)(8936002)(5660300002)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?li6OgPymhFrFdz8bBQmn4zEd/EJLTpZCWnXq+AdwjjXSAnyVDPvSR6lHTSn0?=
 =?us-ascii?Q?3oFzIdTM22WvLlqrrUEcw/Mt7Kmj9rJi0A3x0C1yst0Hs8rnnAKFTOwZBguS?=
 =?us-ascii?Q?BoG1zQXBU2zBySScJeAS3MIoJQ7Kucjlpw/K/PlVszTPWZHFr7jBTrfV4zOb?=
 =?us-ascii?Q?Cx0+rh0eLZ4kKl293IGX0JuNYGGqeduAx3Yo8svTxAoF3mRQEsw5vnUG/Ipf?=
 =?us-ascii?Q?czYzxwXDYnQxA9ixTMoOgvRyjkvSHQM086CTtWVlQSnbmbnFTwMoLqOLYZel?=
 =?us-ascii?Q?twI6AkSwh6oXkzQ5Exu7VMQcrdIEzT36NgX9hMVZdyC+ceSiPcIxb3hHjeg2?=
 =?us-ascii?Q?+hE83UCTDl/Z2xnEcvhFlmpnRd0Cpj7vX3X4DSiFjOH0e0H6TmOj1nSX7xGR?=
 =?us-ascii?Q?+lCCebqunhPuku4mXvkabqwKjkW6eLkNmjv2M7kCqs4zEefVSpPmgVdq2XM8?=
 =?us-ascii?Q?tKsYAc/1yhhtTTCHLr8E/g+558idTc1uwUXFT3RQh0WKCiQf2rqz1Jre7Cpw?=
 =?us-ascii?Q?rov8YZM0VsHT7KbPw3C5GVvfB+JLTe0L8URiFh5yWKhm9o6woiz4MX9xAlKg?=
 =?us-ascii?Q?0y54lSpVXn4Ydtll/m3C2Lxcnk//gxaMmbll0wukbEN5pXwJTPD9Z0dySSWu?=
 =?us-ascii?Q?8CtOPLTa1i2jXwhH88c8ojq2NdxlhOf+O8FYXu79A+/AerpUdHiyPo08ELtp?=
 =?us-ascii?Q?8lV8yxV8p+iWLlqHsDGpo6AaMtsMfOYpJdNedrkgaCl59xuBTvMeofAvpcZr?=
 =?us-ascii?Q?eISIvtXxMjblJW4itcA6g1LN6PGLBWaaIvyWh7djKTrGTrej/Gpi6/hgkc1h?=
 =?us-ascii?Q?v8yaI5HhV7VgCrWEfiQMJBWONXayI/mvASB4bqizq8QZIPsmI48Ultc5Fsjq?=
 =?us-ascii?Q?T6rFfuOa13C4iWwoQcQSM83nPE+nEcU3YP4FYtXB4l9Uruz00pRBtRuZxzMB?=
 =?us-ascii?Q?kctRZgMCwWIfxi5Adpb5IOQIn/aC46L8rV222lYI3+BNcO0Dgm6uo+5PUCqu?=
 =?us-ascii?Q?vuTlI6dOd0xRAs7JL1Q0on9PgX5pNR7ig5dqhrMtXaPCYGTrTJk5jSXBdLwK?=
 =?us-ascii?Q?gqyN1yDVUG/yHJ3pVQy/4E4vOisrRs23wlBDp85Ulvusjp3YD4ZCnGjBfhbp?=
 =?us-ascii?Q?ahQQCnaCuGRG6K5/EU5zY5DHWyK8fLYA0g5HTg+a5KUdjLOLL+RKGHNizTTd?=
 =?us-ascii?Q?JlQZbuzQ1Fz5+qHPzKwQ0gPDPLG8esfuJCDmAv0uj4Pb4HXIDFG7CTYcRfY/?=
 =?us-ascii?Q?Rkfnx2wsReQAGBzMOMQU6zT7Rpf0y2b7NGOAK9VsMb+JNGGNR8hyUaBA+Zic?=
 =?us-ascii?Q?grDCzHfgrSasVCSzxIlyBXYgA4PPSh/4bnGPXQRzyt1lwL0is4GCx7GpmLZU?=
 =?us-ascii?Q?Bj5+wquTuwYpkDIDf6HRyUIDjMlutlK6/50c3cYhkOD97srEPXfnItHyfIU9?=
 =?us-ascii?Q?0QCpRvcXcltDpgbkj1SUcCGu5TFoUMAR8MWv6HenmqFzMzRPVdjtaxI3J2We?=
 =?us-ascii?Q?Dlbsd6EVlG6sPnqNdR5bb+HQRF206yXfG5pkuKIjmrgMbndZVxtdQaifceeY?=
 =?us-ascii?Q?JiGboG/dNs69HTv+HlUuhuT3BnqinVsBVkWe66uGrAJqESVyf7+XJjJYqbtM?=
 =?us-ascii?Q?heuNyC4dj9mzYEk8UEZivxMB2sl/AB5CoYwCFD5JExshkbkfh7yBROfUnRZU?=
 =?us-ascii?Q?uMQkbsDgu4EEg05xUdT7xJ6NXC0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57538d7-000e-4b43-e88d-08d9afe1b88b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 07:03:45.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZ78RrgiPZI+axLiI9g8vGOly8Ra1/C/1dk8gnzQ6ieojt/ewj9ZloPBivB5fGZvegZFLzId5dkNABmHvNO6rgfJoegL4M24BzXa0YB2DJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5459
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250038
X-Proofpoint-ORIG-GUID: EdEaDJIF7JXkz3MbzP9u_XNgEb7pNXov
X-Proofpoint-GUID: EdEaDJIF7JXkz3MbzP9u_XNgEb7pNXov
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
commit: 33b347503f014ebf76257327cbc7001c6b721956 vdpa: Define vdpa mgmt device, ops and a netlink interface
config: i386-randconfig-m021-20211118 (https://download.01.org/0day-ci/archive/20211125/202111250317.VUsGtdox-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should '(((1))) << (mdev->id_table[i]->device)' be a 64 bit type?

vim +296 drivers/vdpa/vdpa.c

33b347503f014eb Parav Pandit 2021-01-05  280  static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
33b347503f014eb Parav Pandit 2021-01-05  281  			     u32 portid, u32 seq, int flags)
33b347503f014eb Parav Pandit 2021-01-05  282  {
33b347503f014eb Parav Pandit 2021-01-05  283  	u64 supported_classes = 0;
                                                ^^^^^^^^^^^^^^^^^^^^^
This is a u64

33b347503f014eb Parav Pandit 2021-01-05  284  	void *hdr;
33b347503f014eb Parav Pandit 2021-01-05  285  	int i = 0;
33b347503f014eb Parav Pandit 2021-01-05  286  	int err;
33b347503f014eb Parav Pandit 2021-01-05  287  
33b347503f014eb Parav Pandit 2021-01-05  288  	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
33b347503f014eb Parav Pandit 2021-01-05  289  	if (!hdr)
33b347503f014eb Parav Pandit 2021-01-05  290  		return -EMSGSIZE;
33b347503f014eb Parav Pandit 2021-01-05  291  	err = vdpa_nl_mgmtdev_handle_fill(msg, mdev);
33b347503f014eb Parav Pandit 2021-01-05  292  	if (err)
33b347503f014eb Parav Pandit 2021-01-05  293  		goto msg_err;
33b347503f014eb Parav Pandit 2021-01-05  294  
33b347503f014eb Parav Pandit 2021-01-05  295  	while (mdev->id_table[i].device) {
33b347503f014eb Parav Pandit 2021-01-05 @296  		supported_classes |= BIT(mdev->id_table[i].device);

Which suggests that this should be BIT_ULL().

33b347503f014eb Parav Pandit 2021-01-05  297  		i++;
33b347503f014eb Parav Pandit 2021-01-05  298  	}
33b347503f014eb Parav Pandit 2021-01-05  299  
33b347503f014eb Parav Pandit 2021-01-05  300  	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
33b347503f014eb Parav Pandit 2021-01-05  301  			      supported_classes, VDPA_ATTR_UNSPEC)) {
33b347503f014eb Parav Pandit 2021-01-05  302  		err = -EMSGSIZE;
33b347503f014eb Parav Pandit 2021-01-05  303  		goto msg_err;
33b347503f014eb Parav Pandit 2021-01-05  304  	}
33b347503f014eb Parav Pandit 2021-01-05  305  
33b347503f014eb Parav Pandit 2021-01-05  306  	genlmsg_end(msg, hdr);
33b347503f014eb Parav Pandit 2021-01-05  307  	return 0;
33b347503f014eb Parav Pandit 2021-01-05  308  
33b347503f014eb Parav Pandit 2021-01-05  309  msg_err:
33b347503f014eb Parav Pandit 2021-01-05  310  	genlmsg_cancel(msg, hdr);
33b347503f014eb Parav Pandit 2021-01-05  311  	return err;
33b347503f014eb Parav Pandit 2021-01-05  312  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

