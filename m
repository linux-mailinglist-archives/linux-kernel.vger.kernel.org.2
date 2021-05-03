Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132C03718D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhECQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:06:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34466 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhECQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:06:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143G0JIW124314;
        Mon, 3 May 2021 16:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Lw/DNAnNx0cmLWHFy4wywn+EDSAHHdjw+ifij1RaVys=;
 b=ozWPl2qLGtjip5z5ocP/5LVWDuU/ipvSjcwknMGWp/M/AdyqpVhDqwPnxodG7MukE7AZ
 KaDXtYCj+LV2Kp1Pwq2yuB5eGv4YdeWokIzmIQdDfn43RDLOmEtWKOrcxHFsVO5YHK12
 GUvofwuSHg/y/IFVsuHYX/v1iWy+HPHf7EeNkVGQ5JhfElEIuSSzh9NysjaWM23kFvIA
 3s1Ow8xfXJtZZThbyrH/A1bkjLwhUX2S2ovu9S5qOCeyKUQIi+XCTRNNnK3Gw5iiBvCA
 /ceJFir2oKxh1qtNjMECNEZ5Fl+e9/yydSJc05IMLrL3kn1YYsMFQ5rvRFQq65t3lzzL MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 389h13u10v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 16:05:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143G1BIM126080;
        Mon, 3 May 2021 16:05:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 388v3v5cwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 16:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGdhoPx8mmgTw4qyQa5UOgJuFexDAnkdkHd49mrXLw4ddL6AvtEEYT6TrZHqUrBzB7EPIbLhz0qfcwaUn9/bOVNlpJ98J6cYarrHRbCYF+HEt7VyPptdCCUL+ftAvmQo1QgkYezdkAPWL9PAVbUImVuCGASYxUyS38MUdgBdOOBzua9NGEjbGR8KASe8vzVKbPB+fgkVfdVDDVpwvAKI5d79nBYMRdtcuOqnxlYLUsZpNR1eI+KpJqTXeh/coMtbKC/l/R7C2oIBt8j7Hh8P8IKpeHKJirx3Nag3um/Xs3LDZtk4qOgiKlRKxIWVNUYqPupxqybpP7zg9bbEQTklsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw/DNAnNx0cmLWHFy4wywn+EDSAHHdjw+ifij1RaVys=;
 b=I8VrfUEUZzxx1m3TdWI0SHso1nrpNQRUIepcF6jvqAV0GmmtBH39AHRg+3lQDioTf2aaInC/IFdBLvXr74j45jT5R0pUU3cbxPBJk76dXBuZoC/PnoJVwkkPZI21ZNCrZZ2YDIonOmHoFzsd9L6UjDiKxbNcdRiIBy985ryMqZq95Agy+rFJcOptF6duW4k4wDYcOxabyubzrR2OhwpKkHkvQ60XZTGEevoG10cxsItUsF+z4IAyY7fju6ROP+YMvmJIWAw827isnsbw6497EQhhgIe0/F+2BMQjCAM2WTJnElDdT9721z3dE4gGIHsECT2zRsb2IsWpUQezEwbAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw/DNAnNx0cmLWHFy4wywn+EDSAHHdjw+ifij1RaVys=;
 b=D17hvKp7zD4bxShuwTpg8sNlK8I3CkhYDNk+2Arx+kdODUHBza/RYBvnLa9e85Y3Eij0ynD1eSG83n/I46AG4sGNHl6tA6+BFnDixrtRTB1C44BFG3gp2jbqWdVOcfrUxMInEsKJ5cKvrWydanisgTW7+w8ufOjcQLw/UWsrSQE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 16:05:09 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 16:05:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Michel Lespinasse <michel@lespinasse.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
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
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 94/94] mm: Move mas locking outside of munmap() path.
Thread-Topic: [PATCH 94/94] mm: Move mas locking outside of munmap() path.
Thread-Index: AQHXPERDRfg+Yjl5x0SvTuH2bZDirarOKbOAgAPJ7wA=
Date:   Mon, 3 May 2021 16:05:09 +0000
Message-ID: <20210503160456.avsjwschcfua7uzy@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-95-Liam.Howlett@Oracle.com>
 <20210501061335.GD5188@lespinasse.org>
In-Reply-To: <20210501061335.GD5188@lespinasse.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lespinasse.org; dkim=none (message not signed)
 header.d=none;lespinasse.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc9027ac-f2d1-4427-81eb-08d90e4d39a8
x-ms-traffictypediagnostic: CO1PR10MB4674:
x-microsoft-antispam-prvs: <CO1PR10MB467440B273B239C2C61BC890FD5B9@CO1PR10MB4674.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U9TmuQPU9g3+B6YAgIrJzqM/uzmCWF06hJwa0SQp4lnNvfYpDIcllbOvv1Dgvs73g7AyBPBfQHJIs+0s6t7huR1Z/ZNKkpooPo6sS2poIfgcOLP+wc8BqK1PMNBGUfVbbkguvyy7YWVyxu/VekJK2E5IpREvUJngfW1ZOsOb2hEGxMu2ceqmvrayNWxObdKBlgbSxftdTUBeVS/5k3gtFC6DNdMLvTXMyA1i0KCZCCdcViAjwGhf+lQu0znxadPYYg5PCQ1WYUrSH9p5svWjMqLxfKq3mHkoXcMog1WalSGcjPubwwkOARx3qTzun20usqbQvrKFL9FEFX6+GCQHB9ITrc7NWPlaQXUb1pG4+UFpG2nK9mUrYggTgxBHa+Ypar83/F9fi25e0wOQFzApU0jAtYzaTEA2NfApSqPue6at8pQ/pqRkyUge0IZNXz4dsZXV4Z5yFGGvBauEmxlVuLcrAiNBqtxg99grOltdg3YgHlXimUGgGxOViTT16+/TIaFtmugIUD8yMvyyHlsNuev2NPyPz97uzUDbVrLLKTC4d9oACXtuETD9k9IEGi9o90bQhsy2JRW1CPakfSjJOZq9KVdsF+qMcaCickob4Yk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(7416002)(26005)(33716001)(91956017)(8936002)(8676002)(122000001)(44832011)(71200400001)(9686003)(4326008)(4744005)(6512007)(2906002)(316002)(6486002)(66556008)(66446008)(5660300002)(6506007)(66476007)(66946007)(64756008)(38100700002)(76116006)(83380400001)(186003)(478600001)(86362001)(54906003)(6916009)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FhCnG05PaErkyLuKRtDypopnr6nlZYrS52qNl6sAybWJwTxk6VJ2lDC/yJns?=
 =?us-ascii?Q?ooZhGnHt4oLE3Ps9kLpfrdr6V4Xipp7I/DPqo/EaXZqFN7XFchiNn0ocJIBK?=
 =?us-ascii?Q?T5F2JzcZ/ht0xFTE6L+qygNxe4c5zQvv2iBUAGME5mR7JpPmdn8dRgyGY8l1?=
 =?us-ascii?Q?OR7X/5RQztaLlEwYtZeY3WxHcXaf3Cgpgiiv/+UjrWMcEQulnylUpo+hDbnC?=
 =?us-ascii?Q?FEe9LUm76SgNvDWNK8Zc+/LfPo4QBfZjbN4B+JKBXVTx8WuSLO7VmUAMOtpK?=
 =?us-ascii?Q?2r/5oo0/ax9hI4XB5mdNuBQU57qVdUoXHPYp9mAdEF/PKdEXvpKiIFQnu3B2?=
 =?us-ascii?Q?ZdosRRNkUUaVeIcvVkzNx3sHbIRzaVMXFG5Bp3qpsxQhbOd71/G9ou2EvVtv?=
 =?us-ascii?Q?gxeCSn6DCKJIztjjrzmrU1c4B2jXfPcZib46Ras68q24yKLxRVgq9RmInFiZ?=
 =?us-ascii?Q?qHgq868xAZkgYVnu9dRUmN5Lg7TrZ92+I/xXGYOChiCqxi889uk3241gs4tp?=
 =?us-ascii?Q?WFwEfmti7zvQnGRcnPmisPi7a95K7qbHAzOPm2N7OKA2XfAj9o4NCrs3gsc3?=
 =?us-ascii?Q?1hQpQwCnzV+P4qQwwxx9AjjKqQeFZJNZpRjKXFWFwkPr/78iCLf5vrOvfkXz?=
 =?us-ascii?Q?3fFGkbQQcmSHiXirlI/wmKg9nm7pWzAGbgXbadWjxL2rolV3dhGu+zHHz9i6?=
 =?us-ascii?Q?3lTTwafVpwuCLjVuNuYk0vnBQvULAswK1E2xjBTALRHbU58I5aVdlOe2ADM8?=
 =?us-ascii?Q?gjliLGFp4u1kY1o7xeOgemYNqVWP8zS6CxKmZ1iHZHyz8GaB5CHNKzj8tALR?=
 =?us-ascii?Q?hYZ6uD0QYzFVWT4T8kjH+DNFACO7ukfGVksNDtdpJguosLtyWg8Sss5WHORn?=
 =?us-ascii?Q?VE329CTRazv49bl4pQRY+sxy6v05l8tLg+FS8ONRZ5davXii07jnpgsCWUpA?=
 =?us-ascii?Q?3oQsPAyfbXIULRQcSQFBER+K+2zvs46MgzG4WYP4jDLVd0JnBCicINwYEhNk?=
 =?us-ascii?Q?DCNssZFIriAR44ff9Qvqrl8Tr6XMlYWkQuWmexDpT6j0PtW2MffktmqroRBo?=
 =?us-ascii?Q?eGqhQi7jdJ2MXg21uT78KTt6P8ZlK3N7pM9fIOFQ9Cc9SQUevWRnd5KJs9uX?=
 =?us-ascii?Q?+BmKTU6dZl57cRnhI9ONZG7X69vh0dZ+UTyiPsuz8bZ2gwz/AzvEG6XwdxZj?=
 =?us-ascii?Q?KOaaUtDwXZdqtohDasXgqVvYPTHc9UqFifMVnKeWHx4d6UerJKOGdY1VisRL?=
 =?us-ascii?Q?r6087YHxkyCqVbc9tDx3Wi8QagW+f0Nb763KfwJNmBddas4o14YVqCm+Ny4g?=
 =?us-ascii?Q?0XGlws/fC9qr9EWugm0vuHso?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD26D0081366F149A4550A5E5961681C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9027ac-f2d1-4427-81eb-08d90e4d39a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 16:05:09.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHzlVpd2I6Uo0nvpdb/Khkngz5soadId5ew07IzUsK+40bFsDLLL3XfWlQ2tSruuL0onggsIXyVOr151/zlgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=847
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030107
X-Proofpoint-ORIG-GUID: l6ZdxoziG_VGP38fZm6eJZ2zZaCwf5LY
X-Proofpoint-GUID: l6ZdxoziG_VGP38fZm6eJZ2zZaCwf5LY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michel Lespinasse <michel@lespinasse.org> [210501 02:13]:
> On Wed, Apr 28, 2021 at 03:36:32PM +0000, Liam Howlett wrote:
> > Now that there is a split variant that allows splitting to use a maple =
state,
> > move the locks to a more logical position.
>=20
> In this patch set, is the maple tree lock ever held outside of code
> sections already protected by the mmap write lock ?


No, the maple tree lock is a currently a subset of the mmap write lock.

Thanks,
Liam=
