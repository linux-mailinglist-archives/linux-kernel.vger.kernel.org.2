Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E49836DC39
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbhD1Pog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56464 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240737AbhD1PjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:39:04 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMebt009359;
        Wed, 28 Apr 2021 15:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IGJpDMg2lG1OAyF+78uwOAiX7SGNNbMur8nehBQzRq4=;
 b=QLcGlWRZldaU5EuNoN/Sd2iTaYdO/FRk6l1+nsFAvQ+6usSoIeHVyuL7fTS4KTTGLG4Y
 p2+bJPXzUhrcjgRkLxzTqCn/kkYyyxPq3ICUZPJUeqJpdv4zf/8dyMmOakfrh04LYW2q
 Zfezxi0Y9yz2BmMLHq8huTpSkgSlEuGlmb3vG/KIwp9gzmJF19DN73l55CwgA8bWJjZj
 HJkay4SV+Vno+FvGtH/d9IkIzCfMvh/MwGjJ2dqXLh7jXvAXoqLWZKfpckpYIGr0sB9I
 P176mKQsPc1ooca7KFrWUdHhrmC36Jy41AiG0ac9g/iFz+vBAGlgaqDIhZaaOkV2XCfK Yg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:03 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFc2RN027246;
        Wed, 28 Apr 2021 15:38:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3874d2773f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRMO+r/I/+utVmpa84V3mZqyi/GXq0LwUGsFfsph5QDHw9COjjTSOpD4Q+a76j9iML5GmISKurchAKxXOMlfMmzOvS9QU733kfrMnT6D9ep9MI/vovSErgza/Fp224Z8RitVE4Uvas5mjX14VaZyHp/jctGO8/+okvC+e4/Qj0DSAI5EL0DvZxBm0UE7zOkrOSacvmsXyK6ig9koWthf1eifpN7qmeNESiMABHj8lBB0L2HYmhUxqNhXZQtt9UTZVSzrdq+OuD+FwdJ5aeE9KSMVxL042nnzBlsQSn97VQ70k+m7exEpOZwcXmkY1oqnVgnHncw7b4MgZnfX8iVI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGJpDMg2lG1OAyF+78uwOAiX7SGNNbMur8nehBQzRq4=;
 b=Uft6VtYrMxfTOaRDUyXuvIvT2sHfgCjBVCv6sVlhJE+g7pvc85MKECKA0YofWTr71q/Cz7IJdLmfTY1H+byFjnt4tzgDN5/vw14zwEan9VewlsTqjAzw7CSQAo88eD2qK1PhtZLDqVLwZa+XJMmQDzhpNGpcIUloXnUJGonw0tvdEmxGv9HhpKdOfTF+9TgC+fGOBSskL0rq/DzK1q7ui+OjsTwgENjzGyP7oOWOlFzsUUTDccbBSwZ7cNxVsFZ7MWZ8Ew3a6ciHdlI4x9MnTyUv8tXBuk6Q80nqYCIAVwUee/n9mKRsY2WZ89HiSw+sI+f9Lay5eS+XxBAfldy9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGJpDMg2lG1OAyF+78uwOAiX7SGNNbMur8nehBQzRq4=;
 b=aH5FwIRsyD9mas8/rbaAA/uVU6+vvA7PknFfnohqfL78ncC64E8kXpyLcLD5JJRrrzVINmmrC60BK5SOTgTM/Qwliu3+JbcxVeDfSJD6Tlcs11B/AGFxw0xsMeuij6SqCFQlGDTqQC66+s4u8jL99/QhpYWQyIWIFyRA10Dtglk=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:38:00 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:38:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 90/94] bpf: Remove VMA linked list
Thread-Topic: [PATCH 90/94] bpf: Remove VMA linked list
Thread-Index: AQHXPERDlT9aoUT8Uk+Bic1SvYaLig==
Date:   Wed, 28 Apr 2021 15:36:31 +0000
Message-ID: <20210428153542.2814175-91-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce136f1-9eec-4c49-d896-08d90a5b9a85
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45484DAD685D70111A950EFDFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PiXgT+k5WCBM5z8ylN7b10KK04dP+J7NmZ48p6Y6imCQcEBkW3JIGhQDuS1j0L79f6CMjsqc3uVaJu1mBnMEmAkG558eKNelIdjwVfBwoMs3+/3x3p4yuj3Oo7SRstXopdk/OQ2HEWk6v6/dE+S8F6i3pY5qfg87e8/XUqfSXnwNqko2eeLpsdigCqIKnpnUEA3WyAXsk0GlKswuRwKZNMotRXz4ci2dDsi+HFX/z39hyaCQNUZYwOktS/2lEHOcY8jY7g79oS9BT6U42LcJ8qudxEjzdpocsN25d9U2s5MAxtEoRYaIuisFkpsORlb3Twb8G/XpZj4CWQG1FpPPHy2PGpVNoGrsgg6dv1PJQSLrjlzArAgsa1S2X1tyywE0DkAGxJSm8RJZvZqlcjoYSjc4DyHSuKsBMhv+170vWF+bE3wJxmixiSsBOhU7rwrNSrIxCliUjbSe7UD60BR/sES+sjuxt9eEhitoW6Nb3TytcGwlAgaEpbItFjOJksoGzs7XqvWTKxATTaiAiqFmAWpz3xO3FQYBLqj8N2QL67Zf3TEzx9AE8Z+cQk9a7aBd0wY+pI0F3LSOBDXDsVqapQ8FfaFkqEILeq5yDXp8NE0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6666004)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vkkKql6GbekiZOaHwSOIgjt2RMM51XLWYKwqwRkP+W1lQZY6Wzg3ePSW0D?=
 =?iso-8859-1?Q?ghQLjwk2y3A28qzjLmq3fE+RSHDbuoLBovDGpmUc5092YOyIHH7ynlSEQv?=
 =?iso-8859-1?Q?qg2NwH3cyki4wgMsabEPE6weMZ8FlstfZiIP6vcpJuLFvPIad2OFQv4O9x?=
 =?iso-8859-1?Q?L0AqPCOH+XTLPIao2Diy+FRzHS8IVOL2zZaX9vIqHdOTlXEgiVvOQcUxNV?=
 =?iso-8859-1?Q?8YJHw5VTnYlSGHlyR/DggwPVazYMaNVfaYGTNngHegngk8YNqK07BqWgig?=
 =?iso-8859-1?Q?HOt37oK8LFQ9hXMQ7isNg60ikLd+xNWf5cRAbZAYr7htulpq6ujykn+bpm?=
 =?iso-8859-1?Q?FsnD0SzZNn628dIfSQPegs8yGJvyENCu10I3PVwxaHpNDCKlspZpntAsJy?=
 =?iso-8859-1?Q?tfEX1Jhl7rTbOJu8mnwciFFRyq7FOT3ACF9xPMcCc6EXgGh9kJ1UHJhjJB?=
 =?iso-8859-1?Q?iP18ewyNy6en6O2U42xneNHcfRcjy61I/whHCyTEQ3uzIFTd4sF0QGUf+C?=
 =?iso-8859-1?Q?s3cx/bBTOtrYqw4lM1A997MeDQl14ODTiV5Xx9H5MQ0ANO7BxTuvJYynMe?=
 =?iso-8859-1?Q?/qgnu6R0zLfT2Y12Qtg2mSZ925Wdn8aycKvusO3fgo/lYkahDH4WqYn3N8?=
 =?iso-8859-1?Q?/lkOSaduYPE/nK82X8sYxDn6ze3nrEGYA1KCPA2NBaLQ99upDB9dtBwkn3?=
 =?iso-8859-1?Q?d3bxHaxSBKQbePpfcJEDOuHyrkE9TGIJyX1/Vp3J9BseWL1Vak32sMwI1z?=
 =?iso-8859-1?Q?NMe40ZTOxFO/Iovg7Y11wTtaZq45XV/Fv6Y7GjhQJL4sIdITQjCnd+uKJe?=
 =?iso-8859-1?Q?s7g3w4erUoLIe53xF/VJ8IQJIJ5TDW64NmLT/spgU+EKnOavavR9BH5OF8?=
 =?iso-8859-1?Q?019zCeI1rtcEwRVL9oie87V5oMOHe+HnD7U+UQkIi2RzjOcdtjnwi+9IxA?=
 =?iso-8859-1?Q?oUMiZdqPosoMRQ+2Z23rjQhk4P9UAoC82KPqUBBWQK7vxeUX/S5fCuEHHx?=
 =?iso-8859-1?Q?xcE/WyxwPII0kF8A8T4RN3qDF6PRkHWFh793A2hhb12+ub7YkSq/p0lI78?=
 =?iso-8859-1?Q?Zfly1pk0FU77A1s4gv+wHOlXVU8lavKcN5VUV1nEaCwcjvjHemMIftNLSf?=
 =?iso-8859-1?Q?foC4GaI8EsC7cTwwJdCNbIfJ2G3d8LryfGVkUWfsy6we/iwGl7Y+8WfUeV?=
 =?iso-8859-1?Q?aKpQjKKI1Vs9K4qf3FZWlPxdalnEWJsxVOD4r4e3zO33Olkr6+1zQmW9C4?=
 =?iso-8859-1?Q?6AdPN7oKEUU0P/XyBIvq9VqBc4Xxpvxi3biXl1dNye4mDH01Tmi0eW6zaF?=
 =?iso-8859-1?Q?pyAlZoqDZhSgZnSARnG3TzJrMa9YtB8LdxHzvhaw1aC2AnZOjzka+Jg4Lw?=
 =?iso-8859-1?Q?X5TsTIcs7u?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce136f1-9eec-4c49-d896-08d90a5b9a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:31.0893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Sk8yLp86PKV9ReFj+qTb3tUTDwBEuIX/q7dz1thbjDCoRIZtAWpO7KAPXUv0+H0pVCbzk8zhHITpWfo3n/OpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 4DDIoJufDC4vezTmmwWiuF6Y782vSR83
X-Proofpoint-GUID: 4DDIoJufDC4vezTmmwWiuF6Y782vSR83
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b68cb5d6d6eb..c1c71adc7c1a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -400,10 +400,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D vma_next(curr_vma->vm_mm, curr_vma);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -417,7 +417,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D vma_next(curr_vma->vm_mm, curr_vma);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.30.2
