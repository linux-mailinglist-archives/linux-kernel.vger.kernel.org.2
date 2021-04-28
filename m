Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1236DBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbhD1Phs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36450 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240053AbhD1Pg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFTUtp018934;
        Wed, 28 Apr 2021 15:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Oyz82/gRBNARid7fxmhPXzEWf8EeaO+qR2I4kMIyBTQ=;
 b=ktEcjaE9W3PLWeP1ifwH5MwYoqNjeandy/llFPVT8wR0fQ+VYussihqev4OIrL7S8+Yv
 UtXKJ1MGOSmTOfhUN75VnkIs4yFK2ENnzUBx00pEP6KHJAduzegCtmrOL7LMqvSp/CeU
 Z/ZvFY8eU7a3f/i8AKVskeGcpRbSi9cQb4ZD+apjYiqtmFEHD64lljgJLhz0iQ05CKHr
 TnsrllZK48wCfjIYy3UNLVjkrrSvDqJmB3JuV6W/PlA3IU8E/8l1dhDFvIFW3UzB6d7Z
 S7gMr4HcCMOQo5mb7KGGynzcLS2H0CBUodi41FPVkT+Z1vIYwMVKwCvfE3ZhRuWQ0uiu Mg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:53 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAW003673;
        Wed, 28 Apr 2021 15:35:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnvAEtVUt0I7H5UA55pCZrix5w/rp7rVar2mcw38KUL7mJg/cZWHv0B+2NfQFlNZUJlgj/CxIdZylwcrLz1k+NxmHqnpVkC/Dea99kgE4tiyJizyp53ErWdPjGQCitBjLa5gdIU5oIgVD2WEiY7GVYOFKQ5N3USp8C2PrwHyu2Le/CcJHNxsxnV1sO+4Rsmw4l1dobuP+OpHtv6NEKP8oU1X47+EYh3root7ggu25/rRpKBTab+P8okVfZoW1Aic7slQiHCDR8NxbKXiQN19jZMccsNUqhNiNB2/fy/09RIM2E763pivZRogPxkGeNEiBoDY+YXRn7553wBqupO+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyz82/gRBNARid7fxmhPXzEWf8EeaO+qR2I4kMIyBTQ=;
 b=F+DgAejQ492qdZNbRACoKNp1tQJWHgV3eVtY03B3BL7R6izxKRzbbsTnTqezANH/N4UMwesrWbHA/fVOM7dZ0h5PK/D0tsesv2+MNbQ4/aVJpKofaHKfNRoWzhVd6vuAhpzfFpqmhLq+lGC9iK4oJdnvYheBWTPLC9YSoOJZFk80/ZJGkogr/MaJMHngTm4LssR9/xLOIbej4B6zRpdFntKQWx0ExAWFDdbdv8T3ENDGXlye60A2UfOZ+5rvU14/uK5dmmds8x9l1nzvz7ik2ayCcjSDTcnCt7WT5D6UCX/b+uuMEJg7zPptdOopptyr606GPNy004BlUdJWcf0hYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyz82/gRBNARid7fxmhPXzEWf8EeaO+qR2I4kMIyBTQ=;
 b=CCZoxX2sC7tRYYbEiFYKVFS0HiHfY3cLbfn1l2YC2whcHPrQVuhI2M6z9nB+5AnpgTxDowijqjf19zF60jca7oGO4yGwPWeOBQ7TY9IssjdfL1xUS/cpKm/YXbbzkWKfcsy5yZRBQKxfUKpfzAzd2/RilGULCQEkpgjNbcX7eiM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:48 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:48 +0000
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
Subject: [PATCH 12/94] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
Thread-Topic: [PATCH 12/94] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
Thread-Index: AQHXPEQp9y42mznYlkCmra8nI/96JQ==
Date:   Wed, 28 Apr 2021 15:35:48 +0000
Message-ID: <20210428153542.2814175-13-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 29b8c8b8-fd91-4ec4-8a23-08d90a5b4c4a
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44978DE0CA7CB514DA544FFFFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlfPbVNh1Nd6T/Fi7JbqEAxNKhyzQNPAYEhVJuddX0wNroLFTQl8O5Cm8T9IO2XnTHXHw5ARmd98valIFLy/SDlRwb6tzLyuqKRWh5JjGUQ/W/kDLyACaNsBRsg8oNcz9OmxjDMEsftB+0zC6QEQxw+hD+t0diXnPw87lEeBLWgAwfgXwDpmIoUkLpw4cFilHRBq2tKYBNpfeNEzoVvlG6TR4hsok0C0Ju1PGyb6B3ipEssDRBEXTu+hjTRNoqmRzlNAPJ0DSi7JYvCY9suyVfVsATPsky+eB1MO5V4PiWounatUEirjn2JEx9Vu9gyTCXo0ydhF8vNh8LEdSu/UrZSnl+MR5mvK+7AkvZoRvB/Df233hsyS+Y1u4UReNRl88Laa/0gjtGW2IFktbHQ5HzELPOEiavM4EF3m87uwkBI9GwQPfvRvaQzvFqZp0qcCYE1aLqVhDx45rKOVwFLYj/wLIZpBYI+sOtBDA5e+gm+WgGM37xq8Jr0rL2+xohNyAbTZnVQzJFvvLlPFi/PZuRoGYwhLJrb+2PEz+hJWVAT3BMfFLqi08rrmxIlv+BEv/Vm12TokbF2xUFGuktrLWC/w5d6gc7wYLL32lidB8QQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?c/+qo4zzkzsJmf8L8wf/d3mTFsseCvmtVBV+wt/TI3itmL2tsW/e8o82RJ?=
 =?iso-8859-1?Q?cfVB+P0DKusH4Ay/Y0hOgBGmK5os5lYEUyS9rKrKY3fdaBtIRzpw0g6itC?=
 =?iso-8859-1?Q?XUwyOlH13B3C8lhASfwsz3uBJkQP0HEUtQ354F8yk8ptBaaJo6BUJDGJsz?=
 =?iso-8859-1?Q?xOht4gz06oHh9ZqgVzLtwlaqFSNcIxEg/WMzLxhTfyaLwsHrk5hADipm0Q?=
 =?iso-8859-1?Q?fIb0PY6Hscr2+E6YlimYI93yD6Dq+dUmDgyglUi5eGj0NPYzB2Sm1gAg6C?=
 =?iso-8859-1?Q?+mkRehyBiUoIf4PXHtAQ62/Cva/DDg+7IUcr7xraSiRX1ZvToUx3+e6zUa?=
 =?iso-8859-1?Q?RX5cISLcR9vu4Mu+cfnACIzBwX4drA83jca2Ri9ex+e4sYYhE7vcuoesjF?=
 =?iso-8859-1?Q?t0zZDMuD08HUorAwoWNeIXHXBLFj72//3fcOdJYDbDS1TfW0DMuSdI1Fbc?=
 =?iso-8859-1?Q?GppTs+qZp5EBNQMwMRkVGzARZ6vyDyKfdV3G4+Us8Xal5KVsFtktjoknYy?=
 =?iso-8859-1?Q?5HKHRdmlFrlA1ARPsjU4+7IjzQvQdsLVWRSw1UuDoNiVgqjq+PXbub4ETV?=
 =?iso-8859-1?Q?+MsftI21lJ2TiPxXIjpokh55cpBevzf1wDtHt87Kk2Ze9QCfR92438gI9R?=
 =?iso-8859-1?Q?Y2cCKKJCU7MxmCKQIYCj30Ar2J597CczYUg/crocpXchy4AUTssOarpJuk?=
 =?iso-8859-1?Q?vpnNyHxQzrnkAInHsAv6kCrW1+ga4QK/7pfp+aZ3KJEP34GsyuVWERznuv?=
 =?iso-8859-1?Q?mlTfifJ4wjNQJXsCMD9ZD94Wkcdm7MeHoFXxI1+h8jsMdTFyWbSXQbZAvN?=
 =?iso-8859-1?Q?nZNcdi6NpZGC28q3C3oc4sBoIukbtMlffxbkZlvXiizMPwbZlXIB9ECMGb?=
 =?iso-8859-1?Q?kan/rYJkSH6+Y3vmkkzqpHbXJSSCnTEGWVCayQp7+QhNHAJVOvKszp0kkC?=
 =?iso-8859-1?Q?+VhGPasLbv7Yz6bjhkveN6/p4P81mPtbTGeKKjKJwy8UUbv0k39z9k0hL7?=
 =?iso-8859-1?Q?LB+q8Z2MaY0DfkrzwmiOwGgtV31uQb7/ZYZLcmRJTLJNZrlH3NN4+4Ie35?=
 =?iso-8859-1?Q?tjpbZDqkThseK9zfnRvbG8YYAmqvPY0878gwcfLPWkSQy5VGsHXf6bMjXQ?=
 =?iso-8859-1?Q?fWmqlDvoMwSfhc4CBp1WffzqR3XRbs+NuCtFME6PlBxkcVP+VLJ9W6ktvJ?=
 =?iso-8859-1?Q?HmU6lk9RWRmij2zIvIassjJ1Hv4oP+wSOSlu1Qy7by9wAfghGj9IiFuORR?=
 =?iso-8859-1?Q?LCXAqn179d0HM8JBcIxUYcusRywaHB8QjwTZoQxuKpy4hWeJ9sZqgBUmSt?=
 =?iso-8859-1?Q?mVbqBzuJEro0yPcgfrC7oaps9le4HSvqCg1igAU64rX2YS6d/YJlUTM5LE?=
 =?iso-8859-1?Q?pl9lLzwSC1T1UJjt5VKncVMoEpeAwBkA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b8c8b8-fd91-4ec4-8a23-08d90a5b4c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:48.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGb5FiqNzt5VByEmnDCL6kwGOmPwsi6VHpLF9GVeOXjsHYeQ2EbV3aAgQCkDcYnP+KEAUURJTKQeYZVyf0EOhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: FJodqbOkpye6Mhrtjs1p7lgX5-D3dY22
X-Proofpoint-GUID: FJodqbOkpye6Mhrtjs1p7lgX5-D3dY22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() allows for cleaner code as the vma start address
validation is not needed, as apposed to find_vma().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 3bef0432cac2..bd8df9bc9e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -709,8 +709,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, =
struct page **pages)
 	}
=20
 	mmap_read_lock(mm);
-	vma =3D find_vma(mm, start);
-	if (unlikely(!vma || start < vma->vm_start)) {
+	vma =3D vma_lookup(mm, start);
+	if (unlikely(!vma)) {
 		r =3D -EFAULT;
 		goto out_unlock;
 	}
--=20
2.30.2
