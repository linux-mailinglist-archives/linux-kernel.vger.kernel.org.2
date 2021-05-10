Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADDD3798B2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhEJVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:02:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45764 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhEJVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:02:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AL0X2h022566;
        Mon, 10 May 2021 21:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=l4XV84N+1N5eQqt2hh0oaMCnQXmTAcL6yy5KhEPKw1U=;
 b=G5FfqcuxuvvuFPrpXDnHf6zOfc/k7UPMgVuRn264koKprgd/ez9LQtuKkDvfvcbgf7UA
 8nfUTZHvF17mEMvwfnUdrKSkZF4WJm4/6GlS+FtmH9nzS2QQ10qQKEFdcv3Giina+BBU
 lLfC85Nem+6C0nZYoCCuLdb3tHfJlC4NrvJ4dW1fJFQg1iK5zfcieN6TH/zk6kMzypHm
 77zyLHHQQ0FbFjxzACKOPQ3aglCs14MoVqIy9+1qrGvuXdznHS91rnDab5WGBvW31tum
 um1FXcXzawBGl0Gz30QNkHt4r0Ol/tDq7qv7UrE65cr7xETIvfEs8dAVHWyj7Hh7nYSq Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38djkmcnpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 21:01:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AKxYm5106846;
        Mon, 10 May 2021 21:01:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 38dfrw3mes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 21:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/17ZF+MQmCwuYoheWVCe/pNmb2+jc7SwlNY8h4B9NfIaisZdvwTbwjASFAuui3ciY1iBEcL1my6KoMMzlVmSl87MX/6M9P4w20gJ/M2qJn9uWGrz7dTnpnnPJfUxRWD+8dqeYVeH01DF/FZ8xxKigzDynsSNlnI++HMOCLC98jHegU2zi/YDh1YhYeggAhYahOhQ1DCLCDCyfohctzk9/rUidu5NLo0H7MtGh1Qx97VAQEes3BGnyCxpeZdMOBj5UYrbLpk6chrTbZ83m1uFJq9dmgQp5CzdGU9pnYLRtdA0FeGxIJBZhXSTNXWUspIbk2OZ5i5JClJ1FGZVbkxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4XV84N+1N5eQqt2hh0oaMCnQXmTAcL6yy5KhEPKw1U=;
 b=a0hKc5EHskDAck293SWmEF9YIecA7iLrJX7EhfkwLRXp5kdL9wESiTbTN1kfuvfn6vF72l4dIlhccpcZsfGx5cQKrKWrf1SN1maqiTSlLeM5EefN2LgUdMlK+L49RE58T10gMRroEELUcBS7pyE7o1UMVSsk4rmCtHMwhV2VgcQb5m299SSqvf0EqRCPWfJn08hua4FdL/CvBwW3OHy6KzpqikgNTL9Xw0sF/6Qajh3DPW55gfv2VABeXgXjDgDg/cdc0RMM10Trg20TnXJ8LwX0PAkcX3qTdmP143ta4+HoLl5FWezKNtRIW5YNChWASi+G3FzSr3pHaC852Dwreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4XV84N+1N5eQqt2hh0oaMCnQXmTAcL6yy5KhEPKw1U=;
 b=vyTGvyDpOHohvtZlA9c1PlJy8L9THjfmWFJnKMuMO2nLzEVT4HA13ngytGYbTEn9zO+UoRN4wkTTuecoQrwfxVk3JUBlGnz6Ay76DUEkqziA6TICxkrqiPw2GKNSaSVOHm1kQ/uSqyIko255u9SsXqVJ1Iei+YcxmnBau4jN8IU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1309.namprd10.prod.outlook.com (2603:10b6:300:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 21:01:16 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 21:01:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Topic: [PATCH] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Index: AQHXRdW2cmhwkET57kappKEjcFfu8qrdIZQAgAAR5YA=
Date:   Mon, 10 May 2021 21:01:16 +0000
Message-ID: <20210510210057.mk7hgtdrxa5c5wt6@revolver>
References: <20210510195020.2778501-1-Liam.Howlett@Oracle.com>
 <YJmQBp9r5UgvQiWr@casper.infradead.org>
In-Reply-To: <YJmQBp9r5UgvQiWr@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 294b7cfe-3bbe-466a-ea7b-08d913f6c0a3
x-ms-traffictypediagnostic: MWHPR10MB1309:
x-microsoft-antispam-prvs: <MWHPR10MB1309D7FF3764E2D40019A8C5FD549@MWHPR10MB1309.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztd8Trp82/EOU1xdOh2eoOZyxcxUUllqhc+TBuaWlsdenWJVdU+RXUhktzsT8Rs5EMunbluQWoHecb3U1+fBZyY5Dzq0fIIJvLf0yRubV4HXcwpYzJrcZVYym0TIIcw2LVOJvDht/sMW4JxY2jfCiIY2TSlG7RwkJaoXmIM/sSsiD2CVBR0eN8IHquuYtND6ywkd+Kdum7dafsCnVFyD21bwnffdz8arrDwNB+0O0RZk41hKLJksKbwjlJZ43LV8qZ/wfET2B43tXJOMQyumPlCj3EV3A6GmP7CLaO2+1nD3ODhLy1AmWHRyGgsOPE98f89y85EXuklL9B7ibi0bWpoKR0l3/kjckqBnnOP0JNFHPtkBxWy1RweHk96Ut/6nXs/aojSlS2kdndqUxVl5zxIoPpRgDFbY3hNruQF2I7i4iJ6VId473mEM80ZCm6j8XtGQMv7WO5CbRRmRcdxWsktZ9dsP0IhN/VLOhesb4fcp8wTJbCDc5aEe47Jz22zckIfUhTHFfUGxaEXI5owKowchN5xV3+h/CmxYKHLN4xGkHZhHsWmYu0/wAAUbB4sAUBw738r538An0JZqiQ86LVhUkQ/WpvtANmp+OIYdQsI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(136003)(39860400002)(376002)(346002)(396003)(33716001)(38100700002)(186003)(44832011)(7416002)(86362001)(122000001)(6506007)(26005)(83380400001)(4744005)(66556008)(64756008)(5660300002)(8936002)(4326008)(6486002)(66476007)(66446008)(1076003)(6916009)(2906002)(54906003)(316002)(71200400001)(8676002)(9686003)(478600001)(6512007)(91956017)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/CsWMVHanINT8ije8A+r7X6+pd4Yuk1DvPO3L4GfoZv7I1dwF4DZ/VsPOmdW?=
 =?us-ascii?Q?Cpezmi7aiVM3Nhuluoiv0fx3S4UVQF/NN7aSvIAChD9duIbTguG075N3WOtl?=
 =?us-ascii?Q?Jm2tVPXSsfJNK6i3on4DreMkNAX2qOoedRqNknN5pNXtBtxrtdtKsZ/9mgmb?=
 =?us-ascii?Q?fbdw826J2XWGPQ+qTXFX8oh6EYnTXF8JP7sXPE+kP6erlEb58r98YqCFZXvd?=
 =?us-ascii?Q?CCVhw5EHwrPbotOFErAVbvCO8bEJmEE8YZV8PoyHtQmIM1irJZ1EDC+o+Kh3?=
 =?us-ascii?Q?cdnYAvMhHgLlDeHgycaGVtkw0uUNgbIvltIpMBTYzskDTHUjYGzRZxcW6KvG?=
 =?us-ascii?Q?qy7nd9W2rtd1Ma2GJt6Mnf8bXbT3pBj1cMl+HHjQHwXoW0vCBkh8Aj0HIZai?=
 =?us-ascii?Q?YbSuDwa7/3eTlf2JTE+WDuGZudTvcQGQsf7cYCuesAfRlbUxtSmO4B3DrvhM?=
 =?us-ascii?Q?KNZHhg7JM1eO7soI7ZtQOALw86isO5caHnyKhCufDTbxObzfqXtW5xxtVvwi?=
 =?us-ascii?Q?HmYq5mCtLJLMZS8GiMBYWmpxc3zU8uQXOBdpN3o2y4MOMG2jxzmTE8ywQEZs?=
 =?us-ascii?Q?Jc8y3vsgbU239+JMjSk+qvzKS5xBgUKi6bxlQigNioeq8FwtY+tUXqYBUYh1?=
 =?us-ascii?Q?DEmwLb/ZSnxvbrM2O1C9CGOSz44jNBEY06MOXdXe8Kqrp5GDHB6naTcgGUUs?=
 =?us-ascii?Q?AUFBviLtCW4iCHP0gYVRuTGKH5unXNgE1HY0LwNmqunrzbK9EDrIUk1sZUFv?=
 =?us-ascii?Q?efgrsZcWUJGJXKa7LSCHJnfjDMZ9hw7+JfTpL7lidKOCa+f2OPJSl4ph3aiF?=
 =?us-ascii?Q?rrze7JonZHsscX09nwlgrIW8Eg7yZOlWKbeFPq08YAhRR0CHZqWX1Q8Svgmu?=
 =?us-ascii?Q?6UV6Ku5lkc/LoMOfnHq347rKvH3PUGuOCVtLSGVuSkJsF90ijbLIPdVWoB0Y?=
 =?us-ascii?Q?9CHlEkobf/VppgfG9dNajLqfD5jwXIQFvR/7mU+WgGYWWBD7fcyXX7ZOt746?=
 =?us-ascii?Q?yYOzG0ksxmR0RTGJXmTyOiEKjx8ixVWOD/ktASUYbGy7v26NRYg3jNB/5j25?=
 =?us-ascii?Q?Dsd7fJCV0k3cDxQ8m4R14Pp0E/2h+97ctOtPKr28EIZtlTctdpcm5kTsmrLO?=
 =?us-ascii?Q?EkJ2ZzpEsCgrYh8Y6qRsegJRNansJuL2Q6P+yJ+WwS3L8kQmHnH+SVmR2WkO?=
 =?us-ascii?Q?Zz91YrflhsHRbUbXOStr7sJqrTIZ/Ak1KCv29eFj7r9NaoHiSXdLofOdM7F3?=
 =?us-ascii?Q?jgyqqE9Pu4qQdtsQVwu9hxw6N0WFFg+E+zrutJUx7qfdQYp1H3YsA6wnD5Wx?=
 =?us-ascii?Q?AtO3OEwaHdpYnXo8dC9Vop5X?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7444805AE6186C40933C8489E07D2EF8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294b7cfe-3bbe-466a-ea7b-08d913f6c0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 21:01:16.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Z/ObJcYSWTYmI24g72ADcVovKaEuZxlwcbptuNL6qQKOFdJ7W4gp+EClU3sLowxgm/SOiBDjD3qb9Czrg7G7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1309
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100144
X-Proofpoint-GUID: eIFwCES94S_Agei69HDhXFRThSErXFg9
X-Proofpoint-ORIG-GUID: eIFwCES94S_Agei69HDhXFRThSErXFg9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [210510 15:57]:
> On Mon, May 10, 2021 at 07:50:22PM +0000, Liam Howlett wrote:
> > Both __do_munmap() and exit_mmap() unlock a range of VMAs using almost
> > identical code blocks.  Replace both blocks by a static inline function=
.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>=20
> > +static inline void unlock_range(struct vm_area_struct *start, unsigned=
 long limit)
>=20
> Seems like an unnecessary >80 column line ...
>=20
> static inline
> void unlock_range(struct vm_area_struct *start, unsigned long limit)
>=20

Sorry about that, checkpatch also did not see this.  I will send a v2.=
