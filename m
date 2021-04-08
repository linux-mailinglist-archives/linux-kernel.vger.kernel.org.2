Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33619358B59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhDHR2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:28:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231716AbhDHR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:28:30 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138HO3VG022657;
        Thu, 8 Apr 2021 10:28:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Mu3e4iXaRj82TuD/sLVwyJR51hBhLppHxF5NVdlUt2U=;
 b=cL6iSzBwC2r5zYS/bhS8AEJ3aBsECaL51WensdmGtTisjLzBHZH83YQbbgZAF2av75kb
 P0tzNKuYkp7+0jkbgXQ0E9nB61qcA2TuGY/yMwoDr0LwHWRihFjB6BhOJcr21bRxhPQV
 RiVyjOe06ZZe9k4yCaKPdI7GQ5ODDnK1rC8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37sfkyq2ac-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 08 Apr 2021 10:28:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 10:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heU4nxGoBB+EDmRzF+Wy8lV3ibHL8rlfshBELzvSvY4S7vS7RFlcxSqpRAbaS3gVhxOEI2ppbP7I2Xz+W2bkIYPy0lCsXspPRxe/7dDp9MfGbHwWmg35ddDE9Bh00tGA6KF6uhAkN/zrST9FHyufO5kvdIf7Wg5TtRlOUcyLczCy3RSq/QPy/JYa70PzkzcHKLnEQXRF81n89bj8XjJPG+SwaFUDGzdxrN7clyyHJXqQu+cizrpudKqhnOdFKnbK3yngms9w8np8goFjRUuBf8W9lzzk+cbCwpDlD7RnGgXwZ6naz7qk4bw7S38CSiUyNijHbNbLEQDRxJRLF62hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu3e4iXaRj82TuD/sLVwyJR51hBhLppHxF5NVdlUt2U=;
 b=WRIG1QjrYk2m12FJubqORd/xmDghMKJHwPbPLwzBBVx2+6Nkwi6GQoR26V7nWbUEOZYvngQp9SAHXRgKtph1sutwwVWPz08AdVEQr+Gs5+qUCsiAUHj5n05XbnqnarnJ0wp1Zlmv9p5qGEj6lAq415Prl2wDWv77kPe3AILbtkyGulYEOFNb1K5nGeOfnyMujjSknlUhwffrao38NDV7ZG5eyTc/YayAhhvQR+H2kdIfnVZrXt2JnBr32smEozavl9sbmhRNwPqE+ObPt7jHM38Si5wxNMVuDd4IFcNLDMKlI1DXtOBanjWc2GPxva3bprFWpr/sw92Hn8DudNjdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2648.namprd15.prod.outlook.com (2603:10b6:a03:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 17:28:10 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Thu, 8 Apr 2021
 17:28:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Song Liu <song@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Topic: [PATCH v2 3/3] perf-stat: introduce config
 stat.bpf-counter-events
Thread-Index: AQHXK0YG4LdD7IbPc0ehmtAjm2+fxaqqg16AgABRlYCAAAtnAIAAAjCA
Date:   Thu, 8 Apr 2021 17:28:10 +0000
Message-ID: <0106D99A-5CBB-4CC4-B6F5-1B795E9B8274@fb.com>
References: <20210407003601.619158-1-song@kernel.org>
 <20210407003601.619158-4-song@kernel.org> <YG7tU/mVxQZLNCYL@krava>
 <FA667178-09F3-48C5-891C-9E44744276C0@fb.com> <YG87VLdSrhG0xSDj@krava>
In-Reply-To: <YG87VLdSrhG0xSDj@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:57e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fffa3f17-e79f-4779-b66e-08d8fab3ae97
x-ms-traffictypediagnostic: BYAPR15MB2648:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2648B59C82FA149569C5B3BFB3749@BYAPR15MB2648.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKB2xsDcR7vPYXkd78h863s78/j2Ix9jPT+twedvCyradE+XgWTlnz77BOFTV6BJ3u2XsKtw2O6Nvdsw5lpf4h3QWnTjJUmz1H8WFyGihnFKxmpFA92kI1NzY4doJksiy/DgIKZVv6bfOUbYddGkwWLaQ9UliN5iKNh2Z1ntnIbEZkKQ6mOltMYxiF3MXFMugKB4rc3VlPStqu/CCLDpBV41YknHMXwcuqb28Tuq4dqkb8RKN08Gu5p7EPeFIlR0SRylYq14BdumhmR9PgHGHAKXceS+yI7jBeq9UO90snmy4JEzBwl/DlSR7n1IO+XKMlrjIua3wDL75NF6hhc2CFwhG6GpNksSXlYe+5jMitej8BB5eEkY6syYarsVJfIJYgsEUhnHYW3gvnxRdAiocI5in8L8cdYDlq4rujVPz37NZYbXzhOiyvxSgiz/n7CnhVwHt9m0K3k1QuRT0mADTAUDBCRPR/t0WvxzfzYT6Whst0V3y2+erEJbpol8nh+JOTi893GIIA76drLEJb79KUVsjhDGQGr/lqGp/6VI4Mat6yMVYuG7NMkb1ywgcUDV3s4nM+1rdfjjWPBX93pRorMjj77Tx3NPj+Gd1IX3H2ITXFiu+/Bvu0XPEyfcKGdPFiqOadze/isNE/biJEYz4wovpk+M7PW9LoR5VqshOdxjBFathv01HwdESKD6VOwP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(346002)(366004)(53546011)(6506007)(316002)(6486002)(38100700001)(71200400001)(8676002)(4326008)(5660300002)(33656002)(478600001)(6916009)(2906002)(36756003)(86362001)(186003)(76116006)(66476007)(66446008)(8936002)(83380400001)(64756008)(66946007)(66556008)(2616005)(54906003)(91956017)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mi1z+GnI1ZILMc2tm1wm0ipQ4qp00WQTxb5G+SVFvQ+RP3yxQAiNPe42oWd0?=
 =?us-ascii?Q?ie3OeMWfdTNuwi5z2YiaxjyMjC6pMN9SiwJhDCX+XEeSsJtzGH77OIsj9BHx?=
 =?us-ascii?Q?BXnlkPnRakJGeYLyfY/KOfONMkmvU9BpJL1DqYXarHeSmx5Ln6MvarnmabS7?=
 =?us-ascii?Q?QCwX8TM1wTjgDVJ/7EPoY6tJnuvVuxGU4ZyQFR0+ZKJ6oIr2JzxaOZY89BM1?=
 =?us-ascii?Q?FePMY7D90hmtWTK8vIP3VeEad+//a+vkT/d5rlZlGZmebiK+Yi0Xzh1ABui9?=
 =?us-ascii?Q?3SqaxaRsrC6BvUfCEQHOOxmIpJf8moRGolmFyhcfkcQVLnty8FxHKnZLbdtU?=
 =?us-ascii?Q?ip92/Jd2LvMtNXYTxK815s5WOcwUSsxjKBiMVung7Ly2iv5685D7hu8i9FEp?=
 =?us-ascii?Q?XSICHMpxEFx4CxdtI8GO8IT7IcwJ5S4rx4SRSR3RvWn7Bo4W8yCeuoG4lb0G?=
 =?us-ascii?Q?E5ZxnB/jABhYXLtTd2momJaex0oParb75Aj/2EPIhBnHl71sBYafOUZovSGt?=
 =?us-ascii?Q?ike5WhjqyQlB+pzHJQuYp/Hvl8Z0HYrsFB9UoUVkalvA/Ouh+kr8E8H1/v23?=
 =?us-ascii?Q?mGhwRTosfCKFS7jg3JwM/tKgHt/VMQrlnYTseWT4T+VcfPhFU8RG2OALiqJ5?=
 =?us-ascii?Q?kB3WwaYSZeek6cWp7Hvbq2BeXwk02Bl16hQl7O+XXpcjffrNdRqCoOYQIgFU?=
 =?us-ascii?Q?3pmJBYsJWOvS9+82NnyfRQ8vRzdp/IzCezqoSEnSRYT4sjJW4hoRr/QVAyw7?=
 =?us-ascii?Q?5RkcAZsYxc6T+VwtUFNgUIC3o2Q8LamDXObYhN9GC5/7DsKRnJ8TYuBXtV7Z?=
 =?us-ascii?Q?zIA+6wfpkINlHSEeaAMr/MDisQPqjUs6QyOHc8iP8z5xF80pWnDbDXofEdBm?=
 =?us-ascii?Q?we6uCaQPdwpWDonG7Axgnx3t40ddZq85zOP9gL8n+dolu4hWKhrbyiypTtwM?=
 =?us-ascii?Q?w5Wgb8ZoTtCU8/BTYV/Mw2B9N01nkdejY1uNJQLFzfEY+ZLwyUqw+j54QzP8?=
 =?us-ascii?Q?/RVfK7N23jY4kWrCUt0eO8ZiwEawLAlinmKocC5sxI5UcBRiKtc2wFvSXz2T?=
 =?us-ascii?Q?9gnBQss70iO8b/fcCznkrDNpEopBvfwKGGs0hc6raSaRrecdcix8PECtEzu4?=
 =?us-ascii?Q?knWVFh1+i/sZGjSyGHdrIazAa82PUTVLfI8z5dkf1RIOGBJI9UZoxmxnGkiL?=
 =?us-ascii?Q?Oz58heEXhrkQDCgT3eww9nbAgL/wdffnxZL6p7sSkS1KF3WEJm4vt8BDVRJs?=
 =?us-ascii?Q?4EZnqkqiI499uDIJq8B/4m/Qm+RVa50mv2X6ZE1SjGiFNxMhVlT93rIxHXUF?=
 =?us-ascii?Q?dwbHufU4qJ3f4k1J7FZI1CrWKGgOG6EltBEgZzVZkR/3O4i8w3ja0ZfVKw8/?=
 =?us-ascii?Q?ukBYhto=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <735E5B5AA480794EB3573485AB796E7A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa3f17-e79f-4779-b66e-08d8fab3ae97
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 17:28:10.6924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: et73LiKNd/zuKSrpLHtnZk3kCwlum50N2EAj49F94BUOE17YIAjHV2J7O+X5E5B6K11GmLhBht79Eg9v2t3BTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2648
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ts1AfYiuQrxwSWWW71torUojFpsQJ0tO
X-Proofpoint-ORIG-GUID: ts1AfYiuQrxwSWWW71torUojFpsQJ0tO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104080116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2021, at 10:20 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Apr 08, 2021 at 04:39:33PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Apr 8, 2021, at 4:47 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Tue, Apr 06, 2021 at 05:36:01PM -0700, Song Liu wrote:
>>>> Currently, to use BPF to aggregate perf event counters, the user uses
>>>> --bpf-counters option. Enable "use bpf by default" events with a confi=
g
>>>> option, stat.bpf-counter-events. This is limited to hardware events in
>>>> evsel__hw_names.
>>>>=20
>>>> This also enables mixed BPF event and regular event in the same sesssi=
on.
>>>> For example:
>>>>=20
>>>>  perf config stat.bpf-counter-events=3Dinstructions
>>>>  perf stat -e instructions,cs
>>>>=20
>>>=20
>>> so if we are mixing events now, how about uing modifier for bpf counter=
s,
>>> instead of configuring .perfconfig list we could use:
>>>=20
>>> perf stat -e instructions:b,cs
>>>=20
>>> thoughts?
>>>=20
>>> the change below adds 'b' modifier and sets 'evsel::bpf_counter',
>>> feel free to use it
>>=20
>> I think we will need both 'b' modifier and .perfconfig configuration.=20
>> For systems with BPF-managed perf events running in the background,=20
>=20
> hum, I'm not sure I understand what that means.. you mean there
> are tools that run perf stat so you don't want to change them?

We have tools that do perf_event_open(). I will change them to use=20
BPF managed perf events for "cycles" and "instructions". Since these=20
tools are running 24/7, perf-stat on the system should use BPF managed
"cycles" and "instructions" by default.=20

>=20
>> .perfconfig makes sure perf-stat sessions will share PMCs with these=20
>> background monitoring tools. 'b' modifier, on the other hand, is useful
>> when the user knows there is opportunity to share the PMCs.=20
>>=20
>> Does this make sense?=20
>=20
> if there's reason for that then sure.. but let's not limit that just
> on HARDWARE events only.. there are RAW events with the same demand
> for this feature.. why don't we let user define any event for this?

I haven't found a good way to config RAW events. I guess RAW events=20
could use 'b' modifier?=20

Thanks,
Song=
