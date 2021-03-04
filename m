Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4BF32DD5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhCDWv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:51:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36964 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCDWv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:51:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124MnjCa185835;
        Thu, 4 Mar 2021 22:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7E/emI42z+xluUUU5Fy+9mhJUUsNzjkeNP1wCBZBC1E=;
 b=aW3i9Hfl2bPWXRKHpnLPCfUx+iYHpNzSP68LthbyiAcQagliH3YTixfHKJ+4+smpSnFI
 XLHA7ud8zs67LeauxnN7xYeYK8CUhn8Vn8mYnD3afbbiZhqJGO0kEkebF+j6MjrB+H8Q
 sJGx4eTRap/H0KFtNTi+sY28OXmy1m/axyquPUiUo+K0YNWVmKNlKNNGvZqC4WAVkTr8
 pTHjFlrlSfGNU3QhWFdKQ+Az3/+p49dg3X0OdYOVza3mn966PL8ZRdnbozME45xVA9q0
 t6joqNuJJTa8Q2ZJkuiyEurRP/4CpJ/dp2K1vlL0wYcm7wWU8dB6vkiBc58OoZhBkhdp Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36ybkbgufd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 22:50:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124MohFC135140;
        Thu, 4 Mar 2021 22:50:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 36yyuvfkxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 22:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etDR5rs4tIysVfrtXn40mc0MET/2AhV6wdJhlQdYbYvM1+ZxX+LbSZAACzxTiA8MKS8z3xINR9KABJz9uvt25+KgElB9zfMpAicSt7hOEWZWD+M+cRJS8BfL7wmH0jyreE05M2YanvXk7zcxalNRTiHHF84gW0KnHSeuDsQhm/t+OC94WF/lOdwjf7yeKLtkNX1LF7XoHl/wrg2GjN7mrwI0Zjw6CVPaArOvY7lKLAyZXVhhe0ITeDLAwCx2h6BESl8fri/G6wMzcIfXzs7sC+Am9JdNNcl/zpsL4YAJpY0iSMrzS4Jhzq6zKUoE/VtJfdbW7cdd7LvOg+bKQtF6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E/emI42z+xluUUU5Fy+9mhJUUsNzjkeNP1wCBZBC1E=;
 b=H309I8Zoo5e7FY0NPHmeF7NeTG5CBdljCuiHb/sUGpPOrcK/zzoge+BcP837lPbk7oUWrdpZNAN9mKqmhIXa070FpcJy+tdoxzNCM3WvlJRXUegBxMqoWrRM9UofBsTFoLU3nL68gIwPTKXmLX4eZe5HgtGi9g9wck0kP7XUKBtRadtOw7g3pJsnOv2lnz5VOnpSMj3uv39H3dKkoCRSkkqY6uotSgVWqLBm7i0w9PHoJBPs1Rcmmq2Q7sfX4CzoOGfHP5m2dUhZE0wnOEQhrKg3e/Vb4m8fxvLR78iIM8FY9BkijHWcWKgpbGwIlbu8gYdKyJ0tLn8d9B1AgTca4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E/emI42z+xluUUU5Fy+9mhJUUsNzjkeNP1wCBZBC1E=;
 b=dg83+DFU/FG6nFC8TNKgVW9JQ+Pf8N1UT5Glz47qZFVgnFfadq6k7BNQEMOyJ6HEbH9a2Ihk0M01PQhPjToaIpQA9s6rzbu+Ba/V8UAIhp122X9N7rrdC+A9NoifIIFS5DbXhfQul9df4Z+NAwMulxmBC9WomOc9lqZui/urtvM=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 (2603:10b6:910:42::14) by CY4PR10MB1976.namprd10.prod.outlook.com
 (2603:10b6:903:11f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 22:50:45 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::2419:5987:3a8f:f376%6]) with mapi id 15.20.3890.026; Thu, 4 Mar 2021
 22:50:45 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] mm/filemap: Drop check for truncated page after I/O
Thread-Topic: [PATCH] mm/filemap: Drop check for truncated page after I/O
Thread-Index: AQHXEHw6nXORVZmbv0Ky0D4i9gotfqp0cKUA
Date:   Thu, 4 Mar 2021 22:50:45 +0000
Message-ID: <4BF4F395-B102-4FAE-9AD9-9EDE93F5E6FB@oracle.com>
References: <20210303222547.1056428-1-willy@infradead.org>
In-Reply-To: <20210303222547.1056428-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:b43f:dd2d:927:3c0b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b73ec4df-7572-4db8-cb69-08d8df5ff244
x-ms-traffictypediagnostic: CY4PR10MB1976:
x-microsoft-antispam-prvs: <CY4PR10MB1976F50DF75690D4B12FBFC981979@CY4PR10MB1976.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kd+kCKmeD4doO+Q2QjLVoC+4VL9eA7vHzP51kcM37ZDGUfZZW87PUnSfBDDnY/QC++gHHhLAKjJJyX+hNKtGyqWSJJA/5+CYpnhTc+YnTEFBdq42Qpl2e//DlM2wY5ABs8cKjw5Yo9W/NqetAAzQUjoCh8i4nsSqlwRI7fnxlasxgYU8tkH4FHoQblrjR3CrIJZ2P9OUCeR/cD0/XRJUWt+mEStKh/qeUx3uelgIbbz0RXdAdPdJjtAtpU23wjrfyfklMUnLbEtSlwRQpKhqIchwYa9py/2cvioal7Wua+SioY4V71+c0PMMLBgFqvV1ln9RjOO6ZwGlPgzuVb4uCGse6Gfad/JtpMjgBtRwTHxLsc75qNgkXMIDqnPKWLAUea0s43pcAnfrvMgoC/x25RojN3wGymNvQJyN8OanfqvICcY6B0hadzmLjPvgnZ3mqsOTS57XkMm9bgUjk78cz/XXX1m3sNh1eOeUueIvZs4u14pJZS7+cz0Dq/5buj0x58T74ahFhM0uPKKmMfEyOep0JIVRzmt8QMtUhhNPF/J+14Opr+9VqC7LLfxludGOY5eFObSDANelL4EJbocC7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(136003)(376002)(396003)(54906003)(478600001)(6512007)(316002)(83380400001)(6506007)(8936002)(53546011)(36756003)(2906002)(4326008)(5660300002)(8676002)(71200400001)(66946007)(64756008)(2616005)(44832011)(66556008)(86362001)(66446008)(186003)(76116006)(66476007)(6486002)(33656002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6CbgGUS7/vbSqSq7OHGvbRQIhZcwRDxDJUHo8jlwUQgMZMS58JhqtDXcudAu?=
 =?us-ascii?Q?HHpkbiY0fnbl/BPIbklWbwhv99AqcaL8EBi68kb0hmzLMf9GJoi8QTgV3MRg?=
 =?us-ascii?Q?uMLlSO4/KtNvAuZL9HNhjWLgg7mqFsvX159OR7hT3noXhQiqNdHxMf1iuyI3?=
 =?us-ascii?Q?ldgPInMUREJuQacpFzdnpC4xmJ224O37bXnKbIBdKcTBqE6RI9DBOhNWtpET?=
 =?us-ascii?Q?KXFIac2MGflFK3SibCwRPnaHr9wHs1DJmu7nvDJWgnwVh6vnMytjQM/7WPx8?=
 =?us-ascii?Q?JxCgKtsm8iv9VaJNHSxXzBv0/nX6+A2XzsTQXz1c3vLNtY01LjOpMXc44q8e?=
 =?us-ascii?Q?xrE69p63O0wu1yYS6irW8IKpMriBe9UIWMNtCags1TWmBm+daQbAwAehpvq+?=
 =?us-ascii?Q?Uge3V/CsgEBL8QmZbEovAxmz+JneaRdX+JssghjGel8I3sxI2XzPikXb4J+K?=
 =?us-ascii?Q?5KJtAoaYa5jnjyaSgRDkBF4buwNajADdkToj3bfVaC4YbWk9G7OIY2AIEBrv?=
 =?us-ascii?Q?OpnuMNu0VjAcZbyvsBC9or+W+xsyplyA4fgn95RYIJNqtolt4h1znxLwnO4N?=
 =?us-ascii?Q?7HHY5p9CxaRCpQ+HTKhs04wHEOdD1WIhjG30MsLlROpHZHrAd++wWVi68BwS?=
 =?us-ascii?Q?b6aqj4sqGl6u4RVfTOSHU/dVXkU86gxHYSR4C2ewP55iL5+NjLiCyxy1Wm5e?=
 =?us-ascii?Q?SS6m/uSBzLfsZ4JTAKva8jkOKCV+cackmL6H6oFfIjwgpYwh5tcHwNzDQ2Se?=
 =?us-ascii?Q?I/CSXlKGFlaFnLwmAj+D+N4+CYVagnd+emt4NjsB6W2dMoma7/141diCBn8s?=
 =?us-ascii?Q?lFOWulWcnItowaAzjo05Mot1MWZwnWDpqjLnKPGsfh6mdcVpe4rrx8CnACXk?=
 =?us-ascii?Q?xrCEGTnv92VvXK/unyCNYeoxXBFtBW7H8sbjZq8NmD8QMHTHIruMbR1A34mi?=
 =?us-ascii?Q?Oc9aFm/2N7kYnEOuoWG7gZZWyiGBYeD2NRoRoXaufqHd0fIdY0iaR9AbxUfa?=
 =?us-ascii?Q?0SiZel3uRlNVIINgTc/KuGJZezgWoDcenpj0BpO5CKL/A/cwDuQsTZx0ivyT?=
 =?us-ascii?Q?uQ9Odfm1s9qxqUqkEw2ovcNuh3a4ZDmsTswYTCk0tDKZNLdqM66qI8pe2f3V?=
 =?us-ascii?Q?9ULHCMY1+ymqJ5vUdlDfLQtV8vpJcqbilWGrhQSLeBEMEMO3uIgDv6I8DE0A?=
 =?us-ascii?Q?W+Jh9upjJagcHg0dXk5yS1yRIriPwI1EtqRnBqmplz07OSKyB4j8td094qVw?=
 =?us-ascii?Q?BoNPLvgTKuJ7EUQTRUVmkmlAABBzN6Pj+V48TdZdzvMcvYP7LtU6MCU3d57x?=
 =?us-ascii?Q?OrEQzK7G1YJc9tJycMTzOAHHupPvDb2gqe1ZahHmuDv2snFPe92jCmLYCFiR?=
 =?us-ascii?Q?uOgPaeDf78gd8PEQ+a83jlwKXJ+V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A0BA0B3C8035F46B346E7C6EDADC69D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73ec4df-7572-4db8-cb69-08d8df5ff244
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 22:50:45.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HocjVABaIATDdRlYUQvfgGtQUmwbestAAUcOTKrse7av1EBEokvbpwlBh2h6b50XY4uNAC2g/kpymHlqHg/7MUdoPQ4Zjy6xxGFWjfVrP5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1976
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040113
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Mar 3, 2021, at 3:25 PM, Matthew Wilcox (Oracle) <willy@infradead.org>=
 wrote:
>=20
> If the I/O completed successfully, the page will remain Uptodate,
> even if it is subsequently truncated.  If the I/O completed with an error=
,
> this check would cause us to retry the I/O if the page were truncated
> before we woke up.  There is no need to retry the I/O; the I/O to fill
> the page failed, so we can legitimately just return -EIO.
>=20
> This code was originally added by commit 56f0d5fe6851 ("[PATCH]
> readpage-vs-invalidate fix") in 2005 (this commit ID is from the
> linux-fullhistory tree; it is also commit ba1f08f14b52 in tglx-history).
>=20
> At the time, truncate_complete_page() called ClearPageUptodate(), and
> so this was fixing a real bug.  In 2008, commit 84209e02de48
> ("mm: dont clear PG_uptodate on truncate/invalidate") removed the
> call to ClearPageUptodate, and this check has been unnecessary ever
> since.
>=20
> It doesn't do any real harm, but there's no need to keep it.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> mm/filemap.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8d3e0daed7c9..3d1635d3be3e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2238,8 +2238,6 @@ static int filemap_read_page(struct file *file, str=
uct address_space *mapping,
> 		return error;
> 	if (PageUptodate(page))
> 		return 0;
> -	if (!page->mapping)	/* page truncated */
> -		return AOP_TRUNCATED_PAGE;
> 	shrink_readahead_size_eio(&file->f_ra);
> 	return -EIO;
> }
> --=20
> 2.30.0
>=20
>=20

