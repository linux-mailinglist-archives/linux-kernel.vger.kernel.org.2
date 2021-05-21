Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24A638CCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhEURur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42004 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbhEURth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUZhG083307;
        Fri, 21 May 2021 17:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=H3Nt8qd9cup4SgdHvGSvyPvDbY5GDpzJp6VyUsxCjcE=;
 b=t2jIEKU6ToPnBP1HYGH5afJODQ6XfPYicEP9QIKPCL4+HInvY/OSqgYO5dKuIKOiNI2D
 c+q0afuaHBsDWr+XQ+QlPZNvAqL9PU85lbUSGHGpwS+4Z20HWpPVIJcj0kbetwSMjxr5
 vrg1Nn7fX+QqJ6nrKycqGYC4EqvqVhit9psLEv6hXeIbM1GnF4zuEpa028XvJ3F4KCfg
 Z6i1bfx6aHEL5EQ6uO6I9BRg+cbkeTg/EMg5FQDh6ZD8tW1U/p2mDy1/BW0Ioey2CEdX
 IDtGhJ66HJ5gG8dIHU8mtbGexxAhw1PrYgzMSmC0UvZJiIL0y5u0VRWY9e+1DYrKx6hw Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rc189475;
        Fri, 21 May 2021 17:48:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD1r8GqM3W31+7yFaTdA6TQj/0SvM9KcCKw9KifJH6D7D5sGfkRYSyDPs/LHJAwA6pqNV8hNUXj1tVtsM0kOpTbKYB+Jc7/7CM2kkWWWlzQLse0CuW3yU3SUtePdo0GjQgFikRa7d21GuXF0e9oHzk79XA+vCEFknGekrl3xhwLXWWxKTXTasFyQ5dR1rM5xKCPRpOfsiuly26LrZDbs3M2HneG1Bl6BHw2GMera1wI3gLKrSjUWZaRLt1yl7bKvZNsAOXvgSDJ40ZYmD558j7IaB7aTZ+7m32Tqazwlki6jHux8tgpNBMwXEOE9V6xVI4D+66nhLQmfwQKbIGP4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3Nt8qd9cup4SgdHvGSvyPvDbY5GDpzJp6VyUsxCjcE=;
 b=ncZVxQ3Fftcs/pl5peDjJbQ9RhLGemB8mSlom1+E/2H/phXs+MIwELh8kKnmb3zcscdKS0ITVDqdIuZB2TXVAQgYx+0Jqsjv3MSpoJj87DjxpD4+4bdjTyOuQvRB4hqwDNajccNe+0MxfOrvFt4qpQ9mb/1ccv70sZykp1hU0mNhiTwlSjImek41H6BMmgePaf4y56WgJAPWMNmLVShklPwDWmj8O5p/dPh/57ZGgusNDtTokCwNwz+dU7kl4xBwcrEpLiQ+ODgC1khUJru2GgFfqIVrp+sZUpi7qcmbJjUfxa5GW1N/Iw5Lig1/HUdM12pYu/DvqlVBvU7HF9LKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3Nt8qd9cup4SgdHvGSvyPvDbY5GDpzJp6VyUsxCjcE=;
 b=FPI7AQrvcB9nI8cYc2as8anwSqcTLkiNdNsbZbmxfYvMfgYRIvUUHF8gqJcXPxPh0TU9RPyJsaQ9H72wdlnZOVeWWwzWU++yRRENfCbau8L4yC6Y1Bc1KzMNQLroqS0Ym0uQaURPiFIuwI/dfF5VcHZ1Wyfi912io4s4rgzqH/A=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:04 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 14/22] media: videobuf2: Use vma_lookup() in
 get_vaddr_frames()
Thread-Topic: [PATCH v2 14/22] media: videobuf2: Use vma_lookup() in
 get_vaddr_frames()
Thread-Index: AQHXTmlz9rnXXxNZn0CvlX1sB/O8qQ==
Date:   Fri, 21 May 2021 17:48:04 +0000
Message-ID: <20210521174745.2219620-15-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1b60f70-6c75-4cc2-5884-08d91c8095ab
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467C9DDE97CA6E4458986F6FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9Qt2bI8Tf3lz52GZRIwuHgwK4xn7wxc85XTLNspEuxtXrmaQGyyyRnW/ETyCi9M/qBcw6D4EV8ZoFAh3SbLN52pfhEcwELOqYMFWb+XbnXLdodn2veOjz59GG5ALH4FOWlkbi5xxSVUXUTQXVpJPtSPXaSgJUWvUKkMErgizMly7w6s9Ka0XMRrVlj/pUciJVsV3O0GjR2a1bLCMVqSTkVwNC6IS0lko+hdJ6wG2sQ+3lzWD0vhsKUkwFjd2A50RzDNPirU364m0xiL5jFL2KehOqBgAcKXloGLglJlXclVpOJCMJQBvH7tG2xwavT4Tk5pcMQwEmpTFtDZe3rv5TXzvyvShn8WmbaD8xf2Bpg/XdvftpU7J/IfKEubY9RvcPIuZ0Hc4hNv9TMU4K9/A5UECQ4YmPyAWgeoKlzPSIk3ZuACnihzlOmgicG2FWH2bClNsPmkIQFrsQXpoj9aXo/duSa0VyE57C0lE4YHj59RQfT2mAg0dV2W11o5wXUi4p2OYbksXgKrT7ghfFl+QebY4GwP0OHmKYcEYO9OpsxMJkN3WipO0OES7TTKnQ4/xXS/4+EH6nVg4xsDzq9TpHywwDM6z+o8JmJHecbZEAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?UnKWSMlpR7r7i2OKUEZsTaLppbGuioIJ29v/jWoY/8LEND+Z9SGTlazFN8?=
 =?iso-8859-1?Q?Xas52MtTX6i5KD80WPVje4JMSCcIrPXrmLcct4UFKiCr7THbCvpPZQFSIX?=
 =?iso-8859-1?Q?4GiKF0dd0UtrNAeIT6A0ky7x96cOzjkwJDwEE/QFPUdqGxqjXke0lrbhph?=
 =?iso-8859-1?Q?COGR3VGbJH9mhlcUTuEAB6q0QS+kY3aYuClx0i9VuBMrPv2RwYwqQO2FL2?=
 =?iso-8859-1?Q?SbEdKTcOZ+5F5Tg9MGvEtxb17heOunRTVig76ZtHIfN2Hv6qLSxpcDrj8z?=
 =?iso-8859-1?Q?+bwNOYXJIHQpb5zSuBrlfiFA+5q55A4IB9ZM5bbj/EEBQ7jZ7s5YhSjm+T?=
 =?iso-8859-1?Q?44eHhxxQaTXfwpHyWdei0gVKyFukURQAhTgJz5XGa4lb/6C+d0Q8Ft/5Iy?=
 =?iso-8859-1?Q?drFCR45pOBRFsbB3Craa3mSrkqG3nLPO1ff8O2rVKIZ0datbEbUjWhql4R?=
 =?iso-8859-1?Q?WKM4kW1FquOowiUl6BLUQpYa3VFXA/FTInFcZblG9GUufQQI5NvR6+n8qV?=
 =?iso-8859-1?Q?OCGUI/cOHB9edlCmEgxAzHgh9lSPr9Kyu0F9L9ilGXUPNQ6grwu6nJ0/8N?=
 =?iso-8859-1?Q?nVcvOLjih0h7MvkLNRqPCFfQb6NqbxTlBvtMBwI7xWhaAxhNWgTeDrB7Gf?=
 =?iso-8859-1?Q?VQbhQWzAAz0uHkRpf9CiMubkuD8SDtavQ0d1rStB18GFb9joCLxPUuGyEn?=
 =?iso-8859-1?Q?6f4MBcX/DsHllyZeZXR3q2rqk+Mf+6savtHvB9YhpDsNU04IMAnNAXwrQ/?=
 =?iso-8859-1?Q?1Zu1dqoIFAA9T1+3j/yzglo4yD06xb4+gegvaEsHOTipVzE5fwhGT4HDqj?=
 =?iso-8859-1?Q?7qavJy2uAZU3nK8MARfpA4+rGee0zpEE57Ssub0L1V4Q/Hxf3VYQvpRawI?=
 =?iso-8859-1?Q?TXQmzWs/0D/kSpTNdKuji8a7cbpaHl+9JsPdB7iieJ92+h8mn40JedhJ+4?=
 =?iso-8859-1?Q?SRzzmZMcZ6lq5vnY3eSOdG2vWGwqvorhl65ug8vJ9cEPXltBm/1UMg4W1a?=
 =?iso-8859-1?Q?FZk2Zdw4pFMa/z6B4FJ9xFg8AJKqmjfgOURPQYaFYJeRd0PwT8BCrr7tMx?=
 =?iso-8859-1?Q?R0OiSMk5d6CGZbuk8UaVzO9MYap8AuQ6r6G6dpWfNu2YoEdfw6wCY+prQL?=
 =?iso-8859-1?Q?OnWUYLO9zYJZ0Jpp2xf/fC5wZ8vf83ZfyVktjRsEfkaeuSkPd3c7VdSiN+?=
 =?iso-8859-1?Q?Wnxh3YD5aVm765QPtXw8V2EGKzwZ3NpjvSShAe2elci3KTfSlHj/0L/x+9?=
 =?iso-8859-1?Q?eKBCBAm+fvEjKOFNShmqE17py8mq5KYzf89pIJPrGoLT+h6QaQnwMdrtyW?=
 =?iso-8859-1?Q?NppJjbl6Oh/PgGUyED1RMechqOLongPgwPiIQfiUff7LeITUFkV7COvPz8?=
 =?iso-8859-1?Q?3wVWQX9+rM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b60f70-6c75-4cc2-5884-08d91c8095ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:04.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PsTtz6FeNAAR1zPvSj2YaE2asuTXOMXkJlCN/IEkO/smXs0TOnVc8w3I3ppXuS5WFq24flN4j72gDZbJYCiFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: ZlQ3r91eV7aDmowudCe8Tg46gn1_JU7F
X-Proofpoint-GUID: ZlQ3r91eV7aDmowudCe8Tg46gn1_JU7F
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/media/common/videobuf2/frame_vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/=
common/videobuf2/frame_vector.c
index 91fea7199e85..b84b706073cb 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -64,7 +64,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr=
_frames,
 	do {
 		unsigned long *nums =3D frame_vector_pfns(vec);
=20
-		vma =3D find_vma_intersection(mm, start, start + 1);
+		vma =3D vma_lookup(mm, start);
 		if (!vma)
 			break;
=20
--=20
2.30.2
