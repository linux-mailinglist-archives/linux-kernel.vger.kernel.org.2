Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012B93794D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhEJRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:01:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34182 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsrmq173800;
        Mon, 10 May 2021 16:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZQ6DhgSmILPgxwuZminVS7WP+iQ3RecLGk2JYLzdDoA=;
 b=kSiMhm4JL6TYRTiP178AYsiaBMRhF6m2T8mNghShuj3sX9dKjU3klk7VMq0MPVSQ2jSE
 53yAKdQaA/+j5aBbtsZBcLAubMkdcNp2PXF+S/yCNzPJwlTDVdAnL1X+Z6fDsVvBvU11
 E536ZHiLdOW/AxlXwhSnIF363gzU5Cp5TD3k1XWhUHAOpe1gvVHJGsVshpttQeO4+Tty
 /jiOEwo8+6UOF8PeixXaOWFU/oP1RvwTbhM3hLxXzWUq/+g/scMo5HdTroZXs8RjLNcI
 ph3AF4NS5Q0xfd+93SzipSH5n7y7/7pxMDgwYuIYZUDTDumK2NLIUa6gt5bgN9iQA3yI +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38dg5bc2g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHL109288;
        Mon, 10 May 2021 16:58:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB0BZQoo3XmiVdIQsmaJ8zUDlTJ2oW9SO3zBHpy0pStEXFlCdxTAdPtK4H7fAkx0/U/JLN2aDsKoNBeKmIq2YaJc+kU8xDFphXTfTQe/bJi8lMYmaB+GLs/1Z1pTTEdmkRLXmVMsYb/dpI8LXenqqK3IElbEwf22oTZ2rRlPanWzMlRFIqbd69uK40L0mE2xl6JRRvVU2F6zk94HIl39xnx97H/EafHLUN98V6dlt8H9PPDwTHM1zaYUQgrsOAPn9eASPjoy8xOcBiLqY/zte0oGjehpZx1BCCJgrkKo3CwBWaSDd+iZEEtUT9lyBLk08FkEqeTMUDrDJTWRbSdLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ6DhgSmILPgxwuZminVS7WP+iQ3RecLGk2JYLzdDoA=;
 b=PYT2CCSWs7rLDAkNGVvMFf5k538+5xw3vNm7eVBkcWYuogdW2XZj9kP48vL7LeaVkAmCeZ7p+X4vt0QGKLP4cjCge1elZ6P8qmqk8YoFerJLHUSVRUHiBrwsrZdAwa7R+23CTnoHdwnX8PZv4K+iN7x8uHsqUjhWRPpvzzWdZB6MNcGR3NX/A/7net0Xgxwh02buRpKOFSiJ+lqh6ZvElZJ01Y+PDTKi4bUx+QkaVedrm6MABWG5C6Zz+p7tdoLMKG2nmjs/GHsekKU9R4mcygI/DBGrSpd2idtWGJfEg+SOw3kV8yHwQUMJR5YpkuVmskUe2b7Rqf6xIzSOEctIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ6DhgSmILPgxwuZminVS7WP+iQ3RecLGk2JYLzdDoA=;
 b=H7lP6kNmIKTDAfNJxeUt4F56X+oEdL3qNKJcOciYcfjf/QOfyNtMNfqopD53L+qdVPn9dNJ7fYYG8ETeAmFRo+nAIGIobinqnv9ZsLyjOHpZM1kUM2NxTKytgLr50c3jHy24i+IG1CQR+mudxsUDd/6wEvV/xcnRcTMoGYUY0I0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:53 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:53 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 10/22] virt/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 10/22] virt/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXRb3BmHSz1vVWt0SFbVsOL7CLyQ==
Date:   Mon, 10 May 2021 16:58:53 +0000
Message-ID: <20210510165839.2692974-11-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 48203634-2d7b-4f49-9a6e-08d913d4e466
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769A656D7297DB926714D35FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iorz8TQHQYNbMDTpEyPsToviNHMylxvQIhKkvF8ItYc4VQDCBbFjZIFNEDb+2D5nyrpQyj2sLyx3wFNf5t82P7LaK7id5pJ1Q9ezRa05jIJTgGKBIDyJocydFtZU8tJIE2Fu1zWg79EI/lzjRlEtzwoG/9Q/ko51uAcD//uwyCiJ7UCT5GrIHgANtmTb6sCL6Dhqsxe0gtyRyIA5uLPIWx1a/J6POAC8CXwYxDq2sWxWMHjVDcD2FRaY+zGUH5yUhMeKw9EECbwneLXa14OOUqAOBwamScOAzHzKlWRUjfDDGr/pm3XxQBD55k3woJKCH1C+DM9hRcxoeFIeCZOGJtSlRHI/lHIdfKPBMPf/NHJSkgbt3J3SH3L56+Lx2VJ23dKnluH+6Natm04+1cx/5/cKNoHftrRoYlEA3aWZlxtSYHk+eSoQT/0jmJwslRPjptE9BcdrVRoEY4z7MvQBnsFV/jCUIMTpxCadOxUWBjDKwr0SmOeD1FrAcSnsgO+nVfYc3g92fYW2CdEzCoowQuo7EH4F9bdYuXURTNSRfdriH9J8QMzbuD1OJRndG28+0CMmzlldsCvWS0g1s5MRHP6x1HdyHRNzd25/jc0MGHA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?InfB2smy/MQOMNzQHdK0waSaIP8XX9H8I+bCe1etaRyr4+B1pTVQn8VIg6?=
 =?iso-8859-1?Q?p/fw83E4Ssd/rRVtnGnwWxMQsdUz2lJIohphkfuXllEGXmxdp9VSsSdSHK?=
 =?iso-8859-1?Q?oOwGR44MtUO8umrS3YYvzVfQiZqlFjXn+I+FnBjeWaoxLgmuAjjjLnKLw6?=
 =?iso-8859-1?Q?wrWGf0Fy5GHuPXgRvzqMxdo38fXS2t9/NZGowzWt2z5CL2PP4FzvYl/C8l?=
 =?iso-8859-1?Q?V2rKSwioLyUCnqdAe9bjY45H4eleN3Q8iVH0MzQXhECcguuJTQgb1LRerl?=
 =?iso-8859-1?Q?sUEqjwKeWQBGttBapgHzbQ7vO6LsB0FuQWd9YpMneKcb5oVOCx/EqJnpH1?=
 =?iso-8859-1?Q?19UQyuwO5iRyTgChH/q+D8Xq45C2zMayKCE+bH2DylSRHuGpqpT1ijROpG?=
 =?iso-8859-1?Q?MoncxElHYiMqwsutsZw5AU5gbxd7RtOeIekkD83pUJDjPUPPapGQdbV2VZ?=
 =?iso-8859-1?Q?gy2Bz2bAKLhILhcwUQDrpeLnzzvgFVYbUW6QYaJtHWxcN+dt4cMx+nesrH?=
 =?iso-8859-1?Q?6Elz4lGARcKsA71TiNVg89vTJJZ7ecIsNIODysIcYICo9BnWQ5C+uFsPCO?=
 =?iso-8859-1?Q?v3oNIB1Dif3FEyir7Zq7n79MZbt9aEj8fD/JpCC6AMzuSpXVt6cP8Y92ZT?=
 =?iso-8859-1?Q?kVJlwlmPLoZWMszapqcUtJSCvyoNPso19QtqGjI4MlOeYD0WGcCuRxLLr3?=
 =?iso-8859-1?Q?VXoJCDAwGUAlspTrSTwsdISTO/Yvi1Q7vCYTJlZAyq4ioJZPPgcBAL+bPN?=
 =?iso-8859-1?Q?2SYrOGp3W6XZrd5MSJf6enck+0MHiGt4Zipk09uSrGreaH7UzwUPudo8kN?=
 =?iso-8859-1?Q?E3UqEBJGQm5e06r3M7yFB4ZIY28Z9OQ0NAaphXqUR9/Tf+AeqCUJWfBnNH?=
 =?iso-8859-1?Q?NwAVUY50tDYF2NrOhYFzIhq6sUqzO/Z5uaG50ssT8pNLPih6lOlspq89ts?=
 =?iso-8859-1?Q?d4WyFjjfP8bN5YLzIqJ0EMHCkOlwv0sIEDCmJQ2X28W0CgjfEnQQqiCX14?=
 =?iso-8859-1?Q?0fOl3Sdn02K49e7cmYFw7r1TBYWsXCEkiZo4FLqQDtcva9IS2LcAmNfxm1?=
 =?iso-8859-1?Q?dyH/zfNIjZVZWZ9OVNiwVmKPDO3Jk9FQSd+CkUTxttJ3NIcvERiU5swWrx?=
 =?iso-8859-1?Q?nDYSq410EI540jJP25tv3BOHKGdE8GiqlxwiFtmYQD/RnTP/kh9hjYgu1h?=
 =?iso-8859-1?Q?qxQ1GlK9BCQXJ5msLmI7x8mu2F4X+9RxsorqT+R7NdOtq67n9OYlO+4MIs?=
 =?iso-8859-1?Q?b4rava2/+2HvbYdr/9gBYL+qZSAd803ApeSo+habk+ThFf/6UdwB/ShvJn?=
 =?iso-8859-1?Q?L5nVcxvLFeIowIfswiRdcRtLk9M4TAnknzkqS0dSFnTHJgBl2xtIGUxcKW?=
 =?iso-8859-1?Q?CUQvj/sg0w?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48203634-2d7b-4f49-9a6e-08d913d4e466
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:53.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H2AIc1kRROwn8WnxKtltoi2c6p6N7NVEj00RahpAAkaTnUh+jwh249Svtf27obCfsxv8hKzVOZdu9i/Z626LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-GUID: Z7tPLiX4Y7dxeAYCWQtN8sScO_U4ZI-v
X-Proofpoint-ORIG-GUID: Z7tPLiX4Y7dxeAYCWQtN8sScO_U4ZI-v
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2799c6660cce..a7703b11407a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2154,7 +2154,7 @@ static kvm_pfn_t hva_to_pfn(unsigned long addr, bool =
atomic, bool *async,
 	}
=20
 retry:
-	vma =3D find_vma_intersection(current->mm, addr, addr + 1);
+	vma =3D vma_lookup(current->mm, addr);
=20
 	if (vma =3D=3D NULL)
 		pfn =3D KVM_PFN_ERR_FAULT;
--=20
2.30.2
