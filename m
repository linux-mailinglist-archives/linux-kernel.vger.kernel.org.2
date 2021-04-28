Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130C836DBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbhD1PiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:38:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64004 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240029AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM7Fh009825;
        Wed, 28 Apr 2021 15:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fSj17pigQzq8xSduCC37N7a6DJGc1V6TuHmtUhMGSk8=;
 b=Gqodxw/P8bdCtOjFEEO2iabMqX6vQuQa0ZSdusFH41NIVJmdBjLxiXi6eq3r3ZMct4qX
 4FYct345xYjvh9Grv05rO+/5ELBLrlbYi4rgerxV8PcGtPLHq25nq/jD87D4Rql2ilFc
 5+fdO/slKYCZVgSa5Hd1a4Inn+DBYTrah7VZO8F24UW7ZK1x/xPASb6hCzoDRX84PbyW
 666oaCvqBZ1pZxcFZ8uSaDXuRjROTw5TpuLz2ak0N1BSFwDGkfH8oCkIcEO8xqUHi+g2
 FtVAEvnZTKw/nd9yh/UEPmnStFdGnRWSBt55tyWsEcLsk6o/NjLZlB41EG85b+fDXRFz 1A== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:53 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAV003673;
        Wed, 28 Apr 2021 15:35:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0I0akEh8MutQ89vme7tCP5Ig4RMSZJ8YfU0fFHn9EAnVEta2tmc/H2TAocAmU1gDFZ/sPFz8Z1jtfFFqSrfDzt26CyuQI8Mfbk2PL2dB+UPnorEDghM5pekBYGOt4Zd67D3OMfSG2SLryKViiWx+7y9U5aonmt7dr629oCy0R5vA/gaxVKVx+lzb55WV1vq2IsPgg/5x5WGr2XE+TWxRt6XeSQticsTz8+8/NrNFYhhPVTmDc6rOUkW5GOgAUfmxhYRhCyYppA0e4vwPSoLAFMUc6pgkfKq1gdpSB1SRD11DZGCH8Cbr4zo2kRrF1sPJBl3YiBjvYQZGv5HK20BhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSj17pigQzq8xSduCC37N7a6DJGc1V6TuHmtUhMGSk8=;
 b=jkOABdeoVSXSS7DSrrNlTHfXZ5+NEzaBeq08kRj+iK/4V0ORJ2V07P32QRsfT3UbjQsmfg42nLQt8jVGQcscdivLZGkzJfmyErhAfYpHxCH/xRo5Dl5u34qhA/Eiw02zHVus+8S7RHphyxa5WyMloNPedtIIXYQ+oF97QUj6zqtpwApDak7b25GYElaIPvb52d53zaGBA72Kk/hmeR8+6386pU8AhVu1ZV555T+gLK2wqibducP8UQjAIMbL1IEmMBGMoAK/AxqyEx+YfBaL2MR7akcdHM5qD+eiTJfmZXioHgzUly9nIPd+gNaOGFqeWxqt//62r/Z2RTPPOBS5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSj17pigQzq8xSduCC37N7a6DJGc1V6TuHmtUhMGSk8=;
 b=XXRmXI0slMoadzIX3FcmPtqYUw2x9C/DsW/H832PY3u2HU0IYJi0EaIVguNvUR+UrLJRdF593PplCJWVjNuHr+N/k1ar2ih55qDmWgXp6xXL9I5/IPSpuuIDeiz8ck1O6xNI81Q1UMIu2wdhRzqPSDZB35fNZvm1we54SuleXH8=
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
Subject: [PATCH 11/94] net/ipv5/tcp: Use vma_lookup() in
 tcp_zerocopy_receive()
Thread-Topic: [PATCH 11/94] net/ipv5/tcp: Use vma_lookup() in
 tcp_zerocopy_receive()
Thread-Index: AQHXPEQp8UB2TyNdyk6saSzMjU+oUw==
Date:   Wed, 28 Apr 2021 15:35:48 +0000
Message-ID: <20210428153542.2814175-12-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: e5531415-db87-4965-ec89-08d90a5b4bfa
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497A09C638E5EAFCE7DED8AFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dteaGdhSGzqzQbhYUzglwMghb182/uguMUxT95MZk0phDq9qqSqSZwigdLlukRlnjZBOFlvDem4Xl5txVA+xZwbzrbWlTNJwTojkP7mwpQ+MytyVCdsfZHPmdIvwFVPxF/vFsoWAp1sdfYi7Tmcirrt31kqfKiBhc/LAFBAh9s2gDaNXshYysWGgi8SsxcCv68HQe+8nKkRRHaTwU80Wqqy4lVqNOntowO0o8ZkA/MjFGoxlF7MBizqzG22rJPaz1mpYmdhGdjKiu8fMey09+JMJIBOjr2A/0q7X3nwxgvKqFr2kUxMzaAutFNfiUhbOplLoWUk4KtNyHi9ZytpgG+7wbL3S1+iWmbXf47SUYPoPdiHHgs800ILbv7/pTQvZyPZsMNnazhXs9wXbe4/YiYDM9d66CgIqf/bKF4RCqq915zGRXcH4zZTkze8hZl3VyCgNDI+nvJGCubH01i65v5LwBiq9yLQivLC8PyxyMikLIJN4JHqM5jO/gDxL7EWd2iaUsg/2LCGBDlxrZNidvEa9OWnRfR1dQuAPRk14r55Iu3a0JAe9kAwJnqNIlraAFNNWYG0eC9RqUG8bXDrXO2V3fweeskGK6VnCN6byN2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?AdU9035Rgsppgw1vT/3qRSz3yvZEo8DTOTs3Yb+bzoEVox2dSyVE0i7QIH?=
 =?iso-8859-1?Q?6IkrqG7WqiXb0h9EErfREgS+ytFjR3UJi/Tmx/BVNi1xVSbLWtniX2F3gB?=
 =?iso-8859-1?Q?QBJkKFsz5Kjc14HsXHTagRG4E9vp8mtekWhh0dDHazaonjOY7cNeXuPiDt?=
 =?iso-8859-1?Q?OGhgUAsXYK9TGYJiCsfrsVjzsf2fWwFp8XMQG70rN1xgaSbYJm0vXEIeUW?=
 =?iso-8859-1?Q?QZ/eXAHeK+NFafy/KDjeSIsFf6tJtr1fAlXopVtQEVy5lX0k0yUsafw9/R?=
 =?iso-8859-1?Q?fWIA9RSpkADrgdM+gk9/UjRk66cROg7VZGkkP8D2npxQCLVQ5C/wvi8G8M?=
 =?iso-8859-1?Q?88dnSseJrsmcHXMjowFApan4zTAcOwpDWKbyH75lL1KpU705W1Qg3P++ws?=
 =?iso-8859-1?Q?6WzoEZDnePFk2ZEa1JMDqRUsDlrg0vkjUBXPSUh2uIlgbcFAIoUq/86PS4?=
 =?iso-8859-1?Q?41uhO2rstpWuQnLI0iO//60vFw8gLauhn+zQNG855CXAzJVhhQEahDERCo?=
 =?iso-8859-1?Q?4PwVoVPkoXNo9s7Ft+c7Q8zHvtGi/cSarWw4hz5P2zoahHpNFS47qALEwK?=
 =?iso-8859-1?Q?HVS1p+a9GfJmDo1kI3dldRM/7wq7zDYbtXQMCISiEI5un31bW2h0QRe4Yn?=
 =?iso-8859-1?Q?JHWcn9P9cxK37dHGPWJ4GaPA12eXptoyd6xl57Rc3HajkyFsrwE3zaiTb3?=
 =?iso-8859-1?Q?wf6VARty3zmjorFO/NcbQ1RO4CAOIfp9r+egyNXPAdu/018yrickwN2Pxl?=
 =?iso-8859-1?Q?TKr7po8sq6tqGl+zTeA80ARKWGWBDUvtAvHiGdykqoIARxmaHFfdQ7p+NU?=
 =?iso-8859-1?Q?w39wsYysatG0wvLqmg/V0FBjkNRKUt6OLQmSU6yOayxfo/ythEQz3MB48S?=
 =?iso-8859-1?Q?/Hld4hEGbSY3HEdq2UOCFli1lVH5Lxj0rnvUjfPd01Ew+Hc/zBS3KFr0cg?=
 =?iso-8859-1?Q?QON8aWzVyH904H8UbofxkNR16MAN9NOwgfd8hrpuBJ1OUER8i3nKII1qu0?=
 =?iso-8859-1?Q?AnOCBvdP0ddjxUOKvaTjXJDXWOsXRxTM12nYGxV0/MsXJhP7Ztw4f4BUPV?=
 =?iso-8859-1?Q?HRGGu966ckl5SGddt81+RtPxpgDwjN3Rx4yuGkk/FzUIcgxsNpfPeaO1HK?=
 =?iso-8859-1?Q?lVgt+xMrl9thFrU/okbWAT8/VkvtpVcavJwGH4CJdC7Ua7C3hMsX9wC/aV?=
 =?iso-8859-1?Q?9m20olxL9IPJAn0VAkl4ckLDrtY7bhSvUL0wqHVJU+5y86SrW40/Xls8VV?=
 =?iso-8859-1?Q?IcEnUVFDdws2vNh6njTwPgGSHeUrZRn3wdeS/j5pOCbzyNgHh7tyzO9sps?=
 =?iso-8859-1?Q?OEJ8bffy6+qJGsXC4zttK8eUEvGh7gGeyNUTkih9P2YZNSbzkU2LcLSRfj?=
 =?iso-8859-1?Q?zHZ5qe5xmjSx9i2QzVexgU3F4f/EPLaw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5531415-db87-4965-ec89-08d90a5b4bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:48.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8LZ2rehxPGQkGxlkVv5xVkI+ttTExtW1IvN/Lk5AXmK/7Lw/xtQzgOFiBWMyKfYOObgHw80yDxJXCioRvSZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: c8BWifuI-LkDbfawj6QOH4NIO1mETew7
X-Proofpoint-ORIG-GUID: c8BWifuI-LkDbfawj6QOH4NIO1mETew7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up code by using vma_lookup() to look up a specific VMA.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e14fd0c50c10..d4781a514012 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2094,8 +2094,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
=20
 	mmap_read_lock(current->mm);
=20
-	vma =3D find_vma(current->mm, address);
-	if (!vma || vma->vm_start > address || vma->vm_ops !=3D &tcp_vm_ops) {
+	vma =3D vma_lookup(current->mm, address);
+	if (!vma || vma->vm_ops !=3D &tcp_vm_ops) {
 		mmap_read_unlock(current->mm);
 		return -EINVAL;
 	}
--=20
2.30.2
