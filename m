Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831E33AB155
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhFQKaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:30:35 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:17160 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229716AbhFQKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:30:32 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HAKeAj020697;
        Thu, 17 Jun 2021 03:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=DrVlDdOlDvqnrzCUgBgj3EMgoj2iTcgTN0g817bhbwI=;
 b=TV8E39g9wjN4OHXlmAZt7NfNadqufJQPOJU/eNaMmVFxnbZSwTnbuqt1ynXo1zQEeR/k
 y8fDILP6pSi8SWuoKw3trKHEcYy10GzPhgvii+0klWrT/mLQkU4jCeffiIcKBX68gNet
 /P14YVemNonEPsgTZ93E+v9Un6VORvnlZj82Cs8a3ffh1cKFV3NjWzsPiLK2FbvGIoPl
 73gUrjXf5H+aSbMT4UCN+w5wvqjeZcw9l26e203aqTSoyAM3eRsvh7kRGOIKkH5vK6zY
 PbO3NFDgtnx3gvMS1edeDoibQqlHpaVI0Ug8SPBD/9zoYR95w1iCC48qiMlkbwqHHeAJ rQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3975jm7evt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 03:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9WnfAdeOQaKoLZt6ouKGg+IYKdRJL25c+gzfWp4HdmXzmf1w3f7lX/nHGXVKll+qzrOY8sLaOf0fANsDTkWfObBmOL8jWYv0C5oQNM3VObhQEKEPeI4+4mPFz8j8ycq19WVfIrd4hh0xKbmFdVYkS0Cb0cK/RyyFbpMEHhZPdEsqZD1i3O45Z5qc2Nd1Ms5jj861BxslzgCNd2hWvf7KR4MscXm2G1u/zF7gIvyQvXGjm8Ob4twI6I0vOhAT6Fz7R9z47L8WQxKG/rNkEzf98mv5+qOKt7zDMNSX2twP731AbdRERnxYbtWXneFOQvfGStEWazTUC6+zPNcTRYGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrVlDdOlDvqnrzCUgBgj3EMgoj2iTcgTN0g817bhbwI=;
 b=FAET4wYeuFf4koe3o9Xs0uwx1FOAArar3NAJ1AKr2iMYiMK1Ox9mx3NhfY2mWXsPn4JllxoexXkdiNpWizXGeUDH3nHR9qTx3aYmiT5HQxF2J9rO4ItALxCU2DUAFuh2gIr4EdWsauCRimo5mpvpyHyUWUOwYjpVTUO9wq3MfxKAdHAAB9itFaGVhJ9VwxRmdQ36UmL8u0RiwyVFJSbNL32OigcHcL9GBET8oYIeppncL40RUAzuD7GwFlU97a3x/zwwnQ/QnSvf4wsgC7AlY8x6pmKATMrq/uAW/mQUv9fTHaA6dzNB4fOJypPbj5nfl/W48ArLZlBThOMybEXGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrVlDdOlDvqnrzCUgBgj3EMgoj2iTcgTN0g817bhbwI=;
 b=iUcP4Xb+8RWV7xYSxqNhXejZk3GjZ8y9ruNsQtmehqqRPbLxzPgXg1ZcG9AjLmMobvyuCmDDhPVebZgNOKai9XNgnM2+ZBnlisinIA+1a23/JSntzp72wLtCN281DjdxBh4Y4v0QSimag9pZeU/ZY/MpWxDznrOd1qnib7MXMOI=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY1PR07MB2524.namprd07.prod.outlook.com (2a01:111:e400:c61a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 10:28:12 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4096:aaf6:cdb7:ba46]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4096:aaf6:cdb7:ba46%9]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 10:28:12 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v10 7/7] i3c: master: mastership handover, defslvs
 processing in cdns controller driver
Thread-Topic: [PATCH v10 7/7] i3c: master: mastership handover, defslvs
 processing in cdns controller driver
Thread-Index: AQHWxuDs+/K7hYXed0i4eOriGwBa1asL83QAgA1A+kA=
Date:   Thu, 17 Jun 2021 10:28:11 +0000
Message-ID: <CY4PR07MB2757DF7CBE875313D6BDDEAFC10E9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
 <1606717233-4259-1-git-send-email-pthombar@cadence.com>
 <YMABggBQHWCSPFcI@piout.net>
In-Reply-To: <YMABggBQHWCSPFcI@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1iNTkyMDAxMC1jZjU2LTExZWItODYzMy0xMDY1?=
 =?us-ascii?Q?MzBlZjIyZjVcYW1lLXRlc3RcYjU5MjAwMTEtY2Y1Ni0xMWViLTg2MzMtMTA2?=
 =?us-ascii?Q?NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIxODM1IiB0PSIxMzI2ODM5OTI4OTU3?=
 =?us-ascii?Q?NTMyNzciIGg9IlQrL1pGRzJpOEpsS3BsbUF2UUZMUGhaUUJZST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUlvQ0FB?=
 =?us-ascii?Q?RDlFZVQ1NUZMWEFjczhNL0V3RXoyc3l6d3o4VEFUUGF3Q0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUE4QVFBQXJBRUFBTjRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVk5zdjVRQUFBQUFBQUFBQUFBQUFBSjRBQUFCakFHRUFa?=
 =?us-ascii?Q?QUJsQUc0QVl3QmxBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFH?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFHUUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BWVFCa0FHVUFiZ0JqQUdVQVh3?=
 =?us-ascii?Q?QndBSElBYndCa0FIVUFZd0IwQUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQURlQUFBQUFBQUFBQndBQUFBQkFBQUFBUUFBQUd4a1VZdWlBcmRKbXhk?=
 =?us-ascii?Q?cWQyT3FxWFFjQUFBQUFRQUFBQUVBQUFDNjg3TE90d2E0VHBnNlpWazM4L2Q3?=
 =?us-ascii?Q?T2dBQUFBRUFBQUF5QUFBQUFRQUFBR01BWVFCa0FHVUFiZ0JqQUdVQVh3QmpB?=
 =?us-ascii?Q?RzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VBYkFBQUFHUUFBQUFDQUFBQU1n?=
 =?us-ascii?Q?QUFBR1FBQUFCakFHRUFaQUJsQUc0QVl3QmxBRjhBWXdCdkFHNEFaZ0JwQUdR?=
 =?us-ascii?Q?QVpRQnVBSFFBYVFCaEFHd0FBQUFxQUFBQUFBQUFBR01BWVFCa0FHVUFiZ0Jq?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCa0FIVUFZd0IwQUhNQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
x-dg-tag-bcast: {3DE89042-74AB-4755-9D53-B536026EFFC6}
x-dg-paste: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ed85a00-e848-402d-c30f-08d9317a9bdd
x-ms-traffictypediagnostic: CY1PR07MB2524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR07MB2524095B3A778FC565651DB1C10E9@CY1PR07MB2524.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zk7wBow3rvvMR1G+0iihjK0Esg6qrUnhcJen+G3WK02OX6YQuX/Sp7k9zmSl4XHLiKz58miJK4Kbog1lsz24VCw6OZYV6gYynf33D6OlzbBwm3xptq3cAgvy2edrUoZK48/g6GAFjReEnNEukBMOmvuHrjruQCxgILabCpGLRahT2ES+Jsj00GGjOcW/qS0fRQMHr8Re6wfvrGLA4+hoQ8g+O+z3pqJqo+zOqDZbmtTyj+Gin6KnxDqkBGyBHkMjv5WdHeFSXkqxxGAk6ybn01RfstotuNuoBuNOMCYWqTpiwdWyPXvKf6M54O+BqpdEB85r/Me+nF/Np96pP2aOR54MpOVmKmu2EEqLyMavNZ1cOlcoWeKM0G21ZN2+0tGsp41b5D0u+ow+9SwTgtUZVyjuMJGKsdlJK5+b/IIlVUuaNYSl+Rcf5mVmAia6L5mCC2WG49UVaAcW7u8eJphRX0I0lolX6TVWYS8+HrHjsrQra1AK31HmIvJSSQBLOa/nrqhwgBcaIic+WFTAdwiTvW9helQxTEAi+LHmRepCPP/dy1QyE6IB5JZpK+3LQbmr0qqor3nf0GDC7Lx5HiHOFtL1PnlQoQyfRRLL+n/MF3pc/9QeULXr6xO1fHwZZQENWa1rBsOMHKd7K8EydMfKqabs1NXZbZP4SbHg+GJcO5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(36092001)(4326008)(8936002)(5660300002)(54906003)(186003)(2906002)(26005)(33656002)(38100700002)(52536014)(83380400001)(8676002)(71200400001)(76116006)(6916009)(122000001)(55016002)(6506007)(66556008)(66446008)(9686003)(86362001)(316002)(66946007)(7696005)(478600001)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/RF/p2rYcsCO2+312XrIPhgJz3+IWIQwZmXx5sU7QqDtLjMw8x3oeQiqwm8E?=
 =?us-ascii?Q?aEMsuc0pQLB2NUNT0jikBTkrwTSUjtciF3oCi6FIZm5LOi0NY0lm0Xc8rt92?=
 =?us-ascii?Q?bnNngBajr6Qzb5R4x71AEAoCtUaYlMhI6eS++AaT0LCcKx48N+flUXGnjjQf?=
 =?us-ascii?Q?SkdK431Rc09b7oUVZLdf0oL56fR68vtmmxhEBnKExmIYw8pBbRGlIt05MlsO?=
 =?us-ascii?Q?2bdcqgeYOD7oAYyuFg4+aAY9ZekT0lBhzO2rsXf6Hqv95jzZosoUdf/w3PFU?=
 =?us-ascii?Q?YQDpx0/zWQUD+hTW8NYBOP9r/4aU1TV+Muq+agOmBRPY0zPbUz7aEDa95G3N?=
 =?us-ascii?Q?un1yWyFC3UhYFVDoZGJaD/JvRHBoCHEngiNLWnB1mnJgRJa67Tf+M4vmyu+X?=
 =?us-ascii?Q?3pT0+OGlX2LVe5yWaUZ2H7iPBvGYspRcc3we7uweHTByclRo46ose53jumn7?=
 =?us-ascii?Q?L+UEPYenFcmwMUDmz3pyIp0PHbDA+UHZNPQUCOTjf2i5A2TS0xjsdBFmKz83?=
 =?us-ascii?Q?Wnk9pze+aB/Lr3NIQD7PGzsaD/0Mo1MYSmujcfZ2lOAu3sf7Zgbk8d3sQg6j?=
 =?us-ascii?Q?IKoOAfldwMBqtQ2vsl08PxzXf5Zloksganwbq2lsrKPaWmYBgXOSvV/f8fFT?=
 =?us-ascii?Q?Mykby02Bnw5eTHA+NM++DwnFDIIL5oICoqOdNRS61/nu5yVG5bPXVIjl+bSj?=
 =?us-ascii?Q?cNvRRRY8COD45dosgzEtbOJ8XxzQPobEcUubT32d91v+EagfbU5VxvPYBANf?=
 =?us-ascii?Q?XUA2327hxt4hhPiXeVttQIjTErIsx3zlq6lRMkjMbtqMFqurc4+S+RrhzJuj?=
 =?us-ascii?Q?4umZcjIA7jxKFJXKtzl4wu9YWP+/KZ8/puVkkbwedxDfmEXTJMuQM/slZ787?=
 =?us-ascii?Q?Zn7a5EOMV8T8wPZTfmrITCDRuN0jz/2eHFAmeAFEQjLQqdkk23T9mbsvtrIu?=
 =?us-ascii?Q?OMm0zVTRIJ9pr5Jr8R+2VB1UcBLK8xJ/nXqJJqHvHFqivhMcncidDLyDXPb5?=
 =?us-ascii?Q?pA5A0N0N5FrA5Ra8XXe1EiDhyDVjPRo4j2xT7qjiCitfUiNinEH5O58TXjq7?=
 =?us-ascii?Q?uCGCCvF+iJc51UrW/M3z805Xs/8ufzb37lWcM3r6fyVuWa2CMHx4IOsO0flk?=
 =?us-ascii?Q?c/UoezFc5v2iLxY5O6zIrBYk/enGO+T4WNyrFnOY5V/qgkAzVp4hIfDZcIi0?=
 =?us-ascii?Q?JMB4j7yZU3QaXlHnpL2bP8Tkv+eVv/2y4+/WQe4wOs7A6Pn4wwDRFUzvANA5?=
 =?us-ascii?Q?5WviwS3N03IwIaW2GgVRyN0v93cZBbiq8MkWyg3oaBE8cLUwmmAQvwZlIgbV?=
 =?us-ascii?Q?SWTllVCQpWvDu6F4ZVLa3eWi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed85a00-e848-402d-c30f-08d9317a9bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 10:28:11.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqtXffFmXnhwCxKOS8unwi5mTxmxyi2b4qi/h6iNJlhnyrFZvxxNQWmSpsNWBxD3R/M2/KwjAf7fY43AKDRBDonx/+V/Yx1ZxN+jdH6iHig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2524
X-Proofpoint-GUID: S1IDt2GtBiYmf2Zc4Vic86ASV77d7gM-
X-Proofpoint-ORIG-GUID: S1IDt2GtBiYmf2Zc4Vic86ASV77d7gM-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_05:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't really get why being a secondary master would be hardcoded in
>the IP. What happens if multiple cadence masters have
>CONF_STATUS0_SEC_MASTER unset and are on the same bus?
>
>Also, it feels weird to let that kind of decision to the master driver.
>I would really think the use case would be that each master on the bus
>is running on a different system. I don't really see the point of having
>the primary and the secondary on the bus on the same system.
>
>Then, we definitively want to let the decision of which master is the
>current master at boot to the HW designer which will depend on what is
>present on the board

Since I3C bus can have only one master at a time, it is necessary to be dec=
ide
Which master device is capable of doing initialization which includes assig=
ning
dynamic addresses to all devices and sending DEFLVS, and can be considered
as main master to call i3c_primary_master_register. This decision about whi=
ch=20
master is capable of acting as main master seems controller specific.
=20
Cadence's Master controller IP can act as main master or secondary master.
There are differences in their functionalities. However, if other controlle=
rs
support both modes equally, their driver can chose any master device to act
as main master, or use any other controller specific methods to decide main
master.=20

>> +	if (secondary)
>> +		INIT_WORK(&master->defslvs_work, cdns_i3c_sec_master_defslvs);
>> +
>Don't you need any master to be able to handle defslvs to be able to
>request mastership?

This is for secondary master only. DEFSLVS is sent by current master, after
DAA, to ensure that all masters have information about all devices on the b=
us.
