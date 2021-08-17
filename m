Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE23EEF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhHQPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:49:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12246 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240180AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkDaf023520;
        Tue, 17 Aug 2021 15:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=aDTii3MQLRlM2pvG0BL6tqtpzPDdPjGdpC5L/iqTnbgZwjI0vdsQtcI37HzvA3eBbV8N
 sJ1d82UOOIU87tjtQihmhj85F2cn4Y43zLLtXimAl3MF/6W16VoiWubjXlRKwvFwD94O
 HAcYXDDUfSF2XPlQqy5+zn2M5f6kk5KJlyhhw+CdosnHvyO7z8V81mGWjP8+kfMbq55w
 5zqwA3eep3VrGA0nyGRG+qD1u21rEZdvSlYJXwplon07YaZ/ttbSsYb/FnCbyrGI9kVq
 KWyJvK5SdyN1Uwa5H1n4JWFouYhJygqdf/hmZdVH0AdiMoU/F6+G9RcvDIX/ArJO3cMN Fg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=dJ0u8N+dBnVqO6y20Np4sAGjPf2fJ6T6d5v0oL0EsNjOZtZRSy1/len7V6V8bUCU8OdS
 pVBFM2cidNSuMggmbEzQjq5eKcyjI9r4739XeHMGRoEf5hcsAY5q39xh+SZ8/RzRZgPg
 OgV1bCf/k1cX9V2OydGD/dxxrc68KxlgXC2mhiaJaMmiPUKIudcuSFHvZYi9pGjMEKdM
 p438V7qhJbvfI/kEEIR3etnzFpG21C65tkSbBtI+0Rz5MOqeB9VlAljDnmSPtjJugPnK
 QUc3/9L5XmQOFjfFAdL35nxMbDbbW7lwhRfsXuF/5vnv5+uxZPlIUhjEPgE0d36TwZbN MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkt3X094574;
        Tue, 17 Aug 2021 15:47:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vftd2y-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWDN+hNA5ih6BoiiLw9TpWI3zYjmG3hztavZw9ZZ74G7QIrfyEeNgV4sm1sSwntV8BKxlqilZ3EeyTj+x8QVFPkedPALSPJLd6KHKfkNxwu0kciASv4HFwfcx7iMd1LU3isCmmAgr++bXkiY6m4GF/QPEXEKachua070+AmW7DnFKRo4hAi43uStjzY4fJ36vbSfpkK2shzNpfKwLs9QVKq9dvHwIznMX77kdj5TWHsBiBbI0+Oua0IvyA/+Bu1fvo+TWa+rDfbMlEFXfYykDtAZ0l+ljTK15N3xaJD6TzBrV1t00r68k3yM7j/Md03UJ/M5NTQ/qqAtOkGCOaCWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=kgHHwdu0DrX/Ti7mM36jaINJ2U4Q2LfRMeAYWZRpZSClsUpQde0TC81Ew7h0Ou1+peg0iav9AiqH9w9+JjTM8prMyacmDBghjYgMH35D+xoLR1boFYG0a2f6CV5fBk6Cw41L2hiN2NnbOhKej7Esl3ntdhR/oIaSkRxVvIRlJJcU7iVuECPSEbVJv73FHIR57itoMhr3T8OlNn/joIlkv5RlUeBn04caucyKY5cNtsIamVSf0KPnLHKSCL+Ka+QqT3ZFVniAK06GNjdR82AyJkzUexXnNmkgiXaXzqEUdeOK6guW4VHo6K7iBDaU8g8ibAo1VoVYqHBWFPruqXzscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=npu8gGQr/QPGYqtqwIaa80R6TpEb2ucK9xQHbDc9NaNmMy0srkxg5+I5U/pggs0t5XtVk0JiyNDQmsNn53DJnJUOQbUkw8097/CgnjFKX0gXieKW+3b3WerDkAVKG26muJkZ4xeA8EWhbhWAvg+Si0oFTHU1mGhwFDpKgHtHEGU=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:05 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:05 +0000
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
Subject: [PATCH v2 02/61] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v2 02/61] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Index: AQHXk38gVPSwUgC9XEGfB/ZP1hAvNw==
Date:   Tue, 17 Aug 2021 15:47:04 +0000
Message-ID: <20210817154651.1570984-3-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9e7e1e4-a62a-4c7f-1b79-08d961964369
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB30974BF289F14A624896789DFDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYRnMXtl48xeqprq8apj0Fj2s3MUXNSaXBM8iNR9+2PM6Q6INRZai8GWGbJJOU14H0OTxcInA+FQBOAYUKFQfa0oR16CA9qJ3xHHTdLfJ1B4eYpwf1ZlvScHCk9YlcvmDTMKyXlTO3QPfnrK714Y9vkMoWuB7mHZw+BY1IptfO+I84Aq709mrcAQT7LGbJvENOAF68dh/iFbyrMreLqxOS42yDXZdIR8anqCDKm5QS1/AK2Tle8BgO6B7t3nPRjo2JBEJlUovG5/ysBCHtbz/Md1dBN10Flo67EQiXbvrylJrTwqwf4YdGhGfiJgNTpY2xcEXmL3d9pc98ZwZg3Im2juFDlLsi9edOqHvy1n53CCbALs0FFvXvl/f7WzX0K+D4iFuwk8Qx5yVv/u10ngxksoy3w49L5t31wp/dkPb8GwxGM8fKRCqs7Px6opVQ5OBpYIEJQLz86fVEwPgKTw5EugRw+VHy1LTlscgxSUqc16mtFEK0qVg0RX/VPvhWwqwFm2LK0ajWwZvZWH/QpDrUU+3M9fFcg+S9tV4qeYfy/gkZ/teVtkyhyNyL5+GkYP6991n948X6cTXsLHdeJcB+7wCjHXjq3w3mBBxsmLmPDrRZ7P/m+ydJGe4m1GbmR4+ZjYDWicIEgtpInIGuf9tXT23/l/Gs+S/mn++OeUPBisOVOZGuz7y7jXmSqIblFq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rGIMeiYmlfWh7TZvJG984chCg4TCq6kBlxKCupKFtAm3BB5LpBZjYWlAjP?=
 =?iso-8859-1?Q?DBfvcYwDF0RRzvUyt4Rkw1nK86+p7vFumtFUNrqbu2GxV5TGcTQ9e52xbX?=
 =?iso-8859-1?Q?dfWgcXRF2QuxUYH0IYdjPEOiJEjE8hjxEJGiqMCiD7hjXdoNgeniay8rDv?=
 =?iso-8859-1?Q?HkJhol3actkSpNDi9Kd/y0MwaAt/m7i4MAPbDk57ZVVTmaHUZy0Gz0J7K2?=
 =?iso-8859-1?Q?j3rHNMAZM5Ww9k133+ZpVQ8PNyH9sDQlqwdQKDh2phIKTR8848ekpE7G2S?=
 =?iso-8859-1?Q?2TtnCOPdL+qzM3sOIukVR61Jg9UEsUAASKVzKWHV1cf5I4RUkV5erLE3wN?=
 =?iso-8859-1?Q?yWxgsVtMdTsiHETgZ86jAw7d3U+Pn3r0m4hJQFB+hdU76EoRxP1UjU7yZL?=
 =?iso-8859-1?Q?kmra44isMbBM8j/ueo3qQkIt3YJflUXuf53UkwtPa1uqRrKK2I8XQinKHK?=
 =?iso-8859-1?Q?rtRA1JGVUwGvc7FU4MoKr4cC0vducmjZv1ryqkRVcVnvi5qAgesF86l/E6?=
 =?iso-8859-1?Q?cT2aYZcBD/j3p8dC7d/yqdJp+kSYWiIScAk0raNRbLK1pYk5ioOpLuXYoQ?=
 =?iso-8859-1?Q?hDKNyYE41rbmiV96WfFr77tm/cdMqOmg35+eaVSLMUjAjnkBZMjarAMG2U?=
 =?iso-8859-1?Q?ZGD3I6XaLxGrnPz27cN5OLw3a67nI1fay+I3RnxZ7iRDAviazKqUv8gQFq?=
 =?iso-8859-1?Q?eXKeKgqZBu2xgVUisgPPAYLM9zD5cGQ5bDy5E4J93QQATWl/dickBlghhg?=
 =?iso-8859-1?Q?VGw9v8OMC87jISjS3AdVbt0BQ2vlcdnbm4+QBwVOIYqwH5lHweWWYM82Z2?=
 =?iso-8859-1?Q?2iBpIDHQCSPPnD3qHsQlUpg1ABfCWpQl2yS4i5pwj52h3U0Mq+oGvRURoV?=
 =?iso-8859-1?Q?UYtMM8U+EhZKLSJ46tjr+Pke2MeDtNG+DzlIsBjBrvpQcv8NAdA/CAghqa?=
 =?iso-8859-1?Q?UXAJQ8nc6HvuLtM+X0jHwJm8ul1j4DQ8mGpbOiACGZwG1plVw2EzSPh6l/?=
 =?iso-8859-1?Q?KaU5sk8/Ayp8YTDIrnmlxZ0gvwwytnn5qvEl3JInihpzgPviHk9U9Ymfr6?=
 =?iso-8859-1?Q?gnl4lCAyYXw6loL4eMKmpWlp7a3YkWRIw4rlV/kfFY/gUP7C8NZ5AzKss4?=
 =?iso-8859-1?Q?Kb7Ruf2LQMaxv6Tf3HiuQ/pRzrkla/P/0QlIXablLNYsvHZGNN5sI4mOna?=
 =?iso-8859-1?Q?uLLfqiBZZ1pL2J3heldsWRjtz4pMf4e2zykSGSR91j4F9f4NWORtv9rnMG?=
 =?iso-8859-1?Q?Na0QxufBeXckWHp755RxDV5VlYqalgcHHhZoXLYQQGF60evzpahOLkQXx3?=
 =?iso-8859-1?Q?kzQsrKenD9/MlwAZDqy9HJ+amPm7VgpEZFzWqwQOSNdf9VaXQuIqwOuKjx?=
 =?iso-8859-1?Q?cPAX58i5C3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e7e1e4-a62a-4c7f-1b79-08d961964369
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:04.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IHl3by60L4C0WjPFRj0Tsi2kkjKsKJ8HeXsHsDSMUut/RWNRQaP2jxkCimfFgoMmCUUZSFsD9ZId2oQzcFrhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: jC2LzxwYqWzitx0YcWCtHlTkfR2dQmFW
X-Proofpoint-GUID: jC2LzxwYqWzitx0YcWCtHlTkfR2dQmFW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..00ee01a14652 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,14 +24,24 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -116,5 +126,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.30.2
