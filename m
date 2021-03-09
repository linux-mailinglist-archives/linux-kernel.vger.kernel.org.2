Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2F3322D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCIKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:19:19 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43182 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhCIKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:19:09 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129AHjZl011707;
        Tue, 9 Mar 2021 02:18:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Yx3at8+ckEgqK6hqMhebSpYLRjD8Q48l8yjNocLkl0g=;
 b=mP0KQF6HCG86ozPw/BmoiSNpSGcLpSJiTPnIKrEp3kNEyuVyUGVzhBO17bIunXvx8rjG
 E3ipR56tNX8XGx62SS74OY5W74z8QZeJPrKh5lv4sUjToJfEWhECKJ353rI38HeVgq9q
 btgJc0wCLZ5H7jUxLOLvngaZHTBsP6i9minqBTYqjDk/rp0yskx7pby8+cp0ed4xCQAX
 XHwMS2r5NyNQHgHTfUsZguRFp9I7afleq+fwXl9ZDq+n4j3m+ZAH8k9YHNXMB3u3bNNi
 IqWBY6sy9O6PcsT+4M8JHw8Tp+MkW2D6mh8T45K5xAllzgkLd5JGuRgnIFGnp6fq4aVo 7A== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37476305s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 02:18:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9j8nSYpc2FgWSuBG6aGp4cFZPUoCSOjwiavOEixQeqEMBsw/HJVZNLKwfv+Wcxceacljxgz44sLp2ptqHPJ1gKtUZdNhgHIoFtNOeLKCpsOsf5TIqAsZrBvJsYGtH6qUWcYkfkzeqJdxq8r6tka1LFuGodVINHBoZ/XAlGkwDoNmC5kS1n/zcZzGx2VzNnlaWNxyY+fd5x+6TDK+kpfTfq58gt587KGBQObGBNtLUt6kd/m5HldtW/aKnvKcQ1+ZE3iytpy6qId21C9DZbMp2HAKdsJVsztO5LAN75v7ntHU0PPHr3CyyC6H6/tUKRUu52galqPOIcAhdquAsAtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx3at8+ckEgqK6hqMhebSpYLRjD8Q48l8yjNocLkl0g=;
 b=oFdjCLXqLYDfwy24Ww1X/el4sDW6EePskq6SHSA48oMaEBBxbu5uNeilVb9RRn4lFNtsXFTgaUKzSobYKrjRrp9niCxFbKFJwys4WLsrd0WFjXJ1WGe1lzxdW+L5s/jaoKMwKyzhc8oR28iHpvGItW5Ybm3B/yobEMmN6aql7GUzS77o/yJ2/L1zjVWqNLLghf6XwbKLhMfm4gEPJfOOqq7XdC3sORHDRfLVQDh1Xav1NRtaman5FhTf6pnWt7+dg1tfE09DATMsdVul5aTDz6LswfEflWjKY5HXm3iFJtvjfe9MAdNL71BndrTg92Iu+r0FoMXeBy+8Sd7ezaigYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx3at8+ckEgqK6hqMhebSpYLRjD8Q48l8yjNocLkl0g=;
 b=roVn5Ds/EuON1g8ohcQ22byGq2wCtIUA/iyQkMbOXVW7jthFDpxfVwOD/BLS+qvEW2MEkcVaZIpqucH/I3pNXJP/qvHG6WUb+fnHmi3JiMKWTckzxBH7y2e5xOSre1+H6oITzj9omfalvam6k76tDKKJZaqwdaUtPNip3TaTF9I=
Received: from BY5PR07MB8119.namprd07.prod.outlook.com (2603:10b6:a03:1d4::15)
 by BY5PR07MB6513.namprd07.prod.outlook.com (2603:10b6:a03:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 10:18:44 +0000
Received: from BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759]) by BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759%8]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 10:18:44 +0000
From:   Sanket Parmar <sparmar@cadence.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Topic: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Index: AQHXFKPlwE5egmmpm02b66W+ylYqvKp7Y7sAgAAIZFA=
Date:   Tue, 9 Mar 2021 10:18:43 +0000
Message-ID: <BY5PR07MB81197BAC5B801816D2B2566CB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <1615267180-9289-2-git-send-email-sparmar@cadence.com>
 <20210309092804.GA76839@infradead.org>
In-Reply-To: <20210309092804.GA76839@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Bhcm1hclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWQwYmRmNTI0LTgwYzAtMTFlYi04NTc0LWQ4ZjJjYThhNTI5ZlxhbWUtdGVzdFxkMGJkZjUyNS04MGMwLTExZWItODU3NC1kOGYyY2E4YTUyOWZib2R5LnR4dCIgc3o9Ijk0NCIgdD0iMTMyNTk3NTg3MjAwODQ4MTk0IiBoPSJQOG9JNUpUUE1qVzBrL1U1dEJKYk1NQ3VQbUU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [192.5.98.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34997be2-dba8-4bc0-53f8-08d8e2e4b7fb
x-ms-traffictypediagnostic: BY5PR07MB6513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR07MB651334C936E1534D5B7FD56DB0929@BY5PR07MB6513.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rf/z3oyyylFtvtgDfG6Lbu8xuI13OlaPxs37RhoUkfQG1H4Hn+xOQbbEUlGwVuXhHIloO38HRmRW3Uq0ISETzWeiN8WjCb1RdxtgjMBH6ZIRmcMh7qlxbfERlHzpn8wwJTIUV9B3zEkqBjKavvVCzxEaQkehqofKW9b1sPgDyr1vIUc7OraHe7WgXELQ6gtUfx9TuvmeUTmiZkHDPN2YxDwq0krSgzUsP9hGpy2xKqxs4OljuEzEPwhEcUTOfuijAA9wx4jA15JxFjGDpIlrm5nbvLUvn0k7LZkVSHg8nKkD+Q6na10MkCsGeo+Z/H99xHLZzQO0JT61eWn40FPTA6GQLCQPVjRCaXVSVTkJrlvyPdyacjGKWIxXLB5Taq1m3sAsrKO1LExkSr3Ua/Hr9g73muTmTiBnd8jH2PBRElj4iduJf6/frHyd3nkFGSy/QHN6hZzAXqTwifwMbhOXTJdkKqCPtPugtetqaHagBaoBuw9HYjW8206RLpFDPQJp0aY0YMpDwOMYxWzy4Qg5DurFd7uPrvSxgZjt9EGR0ZNt36iaHtjkQjGUF0NHbUkaGiCtPmQ095/k0JJeArITuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB8119.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(36092001)(76116006)(83380400001)(26005)(316002)(86362001)(52536014)(478600001)(4326008)(66946007)(66476007)(5660300002)(186003)(33656002)(66446008)(4744005)(54906003)(66556008)(71200400001)(2906002)(7696005)(9686003)(8676002)(8936002)(55016002)(6506007)(6916009)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wIFFO44klgqorakFvK5vBYHnrejnVvcwJF9Ob3bFLot+iEvMx7MP94bwbdwE?=
 =?us-ascii?Q?5ssFCBwVSikujfn6lRtGA9mSTZEoFDPvDvH16yekIjSEv6ORl8te16X6YAyx?=
 =?us-ascii?Q?Y3ul9iU0/DqXOC+Ruh2/FfmcvGkmPCEzxl4ZTuCxiD25kAKP0TCHL1uR02qS?=
 =?us-ascii?Q?Km4f0QucEUth+6vKseQGiYEyajU0DlOohma0Orc8iHB+2ciyoTJUpFX1ijma?=
 =?us-ascii?Q?CenivIYQoe7RRfII6h/gc+nQJU9cKvViyevdlHtZ+obxqDTfGu7iVksT6m7/?=
 =?us-ascii?Q?xKCYzVVl/wVRA8HvA+0F1GJwe5zBGdq0g1LjIMj93mKiFiziwyNO4UrPrxFH?=
 =?us-ascii?Q?11ZjTIvOtwqCoyht+9UxXdKGvQhm7WJZ6WKvs+Cqp2s/LqtLmQsi2TVS7fhy?=
 =?us-ascii?Q?Nhfw4clx2vfcN7wylb7ch1DegHqplJq9t1ltBNb7e0yfkMLHFp9Exas/NpF4?=
 =?us-ascii?Q?IwZ0S8/NL0I3Tfny5C24L1Si0Qd1qe7E/5cwjOf39BgKB3rv05yq4XNGh04/?=
 =?us-ascii?Q?B5oQA1iOIorjeXQqfRIb+3L1My196kk65n2iDdbnwphQIpluWBZL7GyZ6wjM?=
 =?us-ascii?Q?9qOePBblZ/XU0j8qkJiw42GVlfxQpsdcmJvZQOsSVoaBQD9eMD7I7tWdo4GR?=
 =?us-ascii?Q?K2yffHCds2/KoAiWGiiKtnaL2pJQsRzakfsWD/G+AR82EvKfnFuEGMdRvHgv?=
 =?us-ascii?Q?yTBfeBR+uZIZPnxIi7590vwwusyzMawnsiPaV1Y1LHsorz4H248H+8cB61qX?=
 =?us-ascii?Q?idt6b5BPW3P8WiwpncoXi8LBYn9P0D07ON4uZO7i8N3G3M/NDH9Fn2kAjkfg?=
 =?us-ascii?Q?t2oQ23WDXgf8NPyHqPLRkpE+qUu0q7t83ouF7oy7Lvh1foUyUUUTmLkvph49?=
 =?us-ascii?Q?Cdh3+r1JXZ+HvDPbZGLua4/f5QY3t9/+T/RtPPf9CznuuDBWPocPZLTK9ZyZ?=
 =?us-ascii?Q?OScm8Ol5POWEa+vq9uKS4C/Fkdo4LeWBwoei0r9H8Sus3fEmDD2uwsp4OdcV?=
 =?us-ascii?Q?tMSBxo8Dw7RqXK21ffPU+s1CuUBPqxW1sewAUsDFmhphbvsOV0vEjQLERCv9?=
 =?us-ascii?Q?P/ZF18/K6RCu2IZ4GY3yzcyIU/IJ51pOgHcm0gbZRah7uJttao4LBEYmica1?=
 =?us-ascii?Q?zlTG95eHLeEuxVYIGx0+SfQohscV7VElxAp5KAnh9io1O8GI4/4k9pbxvDbn?=
 =?us-ascii?Q?otMHdhTEhjYY2Bco2t5QrmDJSRyZ2MpaHcFxfIJ2TVSfWPGsmTfMa7yP+Ud3?=
 =?us-ascii?Q?RLQSQTz54/gEF3p89nOD2zvJC3a3FZISOu/GqMQKhDlwd/wUJmxWbjrees8Q?=
 =?us-ascii?Q?s/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR07MB8119.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34997be2-dba8-4bc0-53f8-08d8e2e4b7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 10:18:43.9131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAOwzh9oRSaazxUHSZ40G4bZrMp8l1jsMbU1pmofle47dbwhw7VssQpEoxNTwF/gs2Ci723zoLsqrp9fUNsV3swnHbAX+L/hFNXdI719JUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6513
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_09:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=1
 lowpriorityscore=0 mlxscore=1 suspectscore=0 spamscore=1 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=223 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103090049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 09, 2021 at 06:19:40AM +0100, Sanket Parmar wrote:
> > dma_alloc_coherent() might fail on the platform with a small DMA region=
.
> >
> > To avoid such failure in cdns3_prepare_aligned_request_buf(),
> > dma_alloc_coherent() is replaced with kmalloc and dma_map API to
> > allocate aligned request buffer of dynamic length.
>=20
> dma_alloc_noncoherent is the proper API instead of using kmalloc, which
> can lead to unaddressable memory that might require bounce buffering.

cdns3 device required DMA coherent buffer to perform operations. So=20
dma_alloc_noncoherent will not help here.

Also all gadget classes(except g_ether) use kmalloc to allocated request bu=
ffer,
and device driver uses usb_gadget_map_request_by_dev to map the request
buffer. Similar approach is used to allocate aligned buffer.=20

Thanks,
Sanket
