Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821373B9B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhGBEVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:21:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229596AbhGBEVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:21:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1624I7cr025073;
        Thu, 1 Jul 2021 21:18:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=J+6lOF8k62oXqjvbyYQNiuDSht+/3U+Yf7cqwHzAWZw=;
 b=gGoXwxCEIzO7xwSinRy4UVGUiEkx/ydMRCAQa1hyllssGadJWvruUP3HvcE90U/wkK+y
 6QqM3PtSof50jR53WHV/my39/Vv04zwmKONbDfRt/BBqG13f6FxXe5si3orQxmI8e1V+
 YkJIFkCZcCAfMKb+kuovdAlOMI+xf4YfJOQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 39gt4j3jec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Jul 2021 21:18:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Jul 2021 21:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjYRVRk0du2n+10tkKIe78YpgFZsbv6YaI0MUCfQlE3/hncRIw5wC1YlRYahVTUoYnbf73G/Dr9+4rryd8cpSemeL2tYZznlmu+29E/6jwWclOoS63a4MTIU+HUb2F/V3OQ507olABUtPMcN8hwVqTaUEuDOLyI96Va0sWyc6NYI0C7OK7pagqTENHxkXENv+Ducev4vWrhkjWi+f8YmQstJwb7oiKbMVS2cVDFC5K0CrFhKlix3HIZSCU4atdnk9m08pJozChxlgFbsK/URR8sIWv1LpUBuUAis/KXIraE0aE0Gps7OS3byr0DhWX0IHtOCylFwDPp8Aitg29M7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+6lOF8k62oXqjvbyYQNiuDSht+/3U+Yf7cqwHzAWZw=;
 b=ZMUHdgsLUASx+zU6yx1Va1kS4pYWsVssm7Re1PoylnNIwSkWRGH2KiVnF3J85F2RFLJsRqiR6rdbUWLNvH1+UpLgpI4NcrSmkzIf3T3P+4F8fgXpW3f+UO2Ambid6nIo/oryVrH+G6Wm/yd+ZxzEWw0Gk65uGKUaItpTjowJ9H5LUP3Febi96uewMzUdxhvh4Yi6QJj4QlXrX9dGiRquYP+iZEEx48i8DJX/xLWatCLZpiahet9hJxvgCTx4s2rhna+5wPmoqw5+Zc30FyoAmBuDbDJ0Y0GziX9/nOFCUC3NCypHb9XCDBNsWqxti82ZFyzkSrVIPS5xU8c7ZXS8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5063.namprd15.prod.outlook.com (2603:10b6:806:1de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 2 Jul
 2021 04:18:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6ca0:8d70:ac3:14a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6ca0:8d70:ac3:14a%2]) with mapi id 15.20.4287.022; Fri, 2 Jul 2021
 04:18:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Topic: [PATCH v5] perf stat: Enable BPF counter with --for-each-cgroup
Thread-Index: AQHXbr3WpzAoXyGkNUaOR2G95TFaWqsvFQSA
Date:   Fri, 2 Jul 2021 04:18:05 +0000
Message-ID: <8F0B4170-93A5-44FD-BC26-B8520628AF76@fb.com>
References: <20210701211227.1403788-1-namhyung@kernel.org>
In-Reply-To: <20210701211227.1403788-1-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [163.114.132.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bccf117-1f1e-4628-fe59-08d93d1063c5
x-ms-traffictypediagnostic: SA1PR15MB5063:
x-microsoft-antispam-prvs: <SA1PR15MB50630DA333ED99950E1B2D8EB31F9@SA1PR15MB5063.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOqle84uEmycMzGQ/VOtYCy7mylPQwWe1Pjw0JYNiDTPid2koeeKK2mGH3NY+6uaVOzCwAWETJS+y0bYDiMAQhJfX3vj6atMfmz9DnH2c7IeElEuXIN8QVKE/C/3QQ8Iu+b93eVyWFpTlWKAE4HMhOCB63uh64z4ViASrUQE/KXDNgTlV7sxwI5FLhkbpn1iJOOmlwlCIa4oju9EJGL5huAjBRi1NGT0WLQJxeGu1VUbxe4j4cJyhWHvZ8HPAFGqXEdI5r/K9iIMEFwMUie1dZ1Yh3CHC8cbhzcyFvWRw2ND1sFltdXcx6Slq/x7+mY2xHD5fjchv6mfI08zT4PhuzNNWZcdGoa0mzdLwCYmf52bXYR18cjUXOtO51tBpJZfBt8LneloZS9DDcY7Gv0mXoXwPThtOgLAMSvesDYYGjHPw0tHhodUEzZQ8HhaAhg6uu1vJqHL+O2WWmGTOW6Fkfv58qphlfBHWILaOEX025JXvo7nslvL0qhJAqZY+7BwfEwKsLZvXWchfQmP5VGksV1fK5yPC3kc6N9nOsbobng7UC80eZ/USiJPwzgSTaicRDC4A6EKQ/G/JnWhCIk116kZM7RyrgdU59T8B+xk9DMVgsuudiNLqiHTnHD6PANTHITDIoJVy4Q4lhN4oeVt8OeTxHRXVwk/6vJjC8oqiEo3MB66C1Tpo7qPR0h15BUz9Hlyh3m58oVzPH+Cg56VCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(83380400001)(8676002)(36756003)(6512007)(8936002)(86362001)(33656002)(66946007)(6486002)(6506007)(5660300002)(64756008)(2616005)(76116006)(26005)(316002)(71200400001)(6916009)(54906003)(186003)(4744005)(4326008)(478600001)(66476007)(53546011)(38100700002)(66446008)(122000001)(66556008)(91956017)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aFWh2oDueQntFfFUrwOMokvm2QjdHFxRfyQX1+WbKzSLQZsCWmE2ruPvYCkT?=
 =?us-ascii?Q?v8ccTVm17LHZA16qH3P/X8mN9YX9P3NZS3RburyEGSrZGx81GZxUO5RdJG5z?=
 =?us-ascii?Q?Ew4UHh+jkIUId06xtchWDmqjGN6xY/HA9AhYOZRO4LNQTuIEjQx/dv2qnDmM?=
 =?us-ascii?Q?dTzQmR0LENq+FT3pWC/o75CdHD1Hkxukk9KR/t9/CLgCJZ7/qbn1wlNPQTzI?=
 =?us-ascii?Q?KQgo+Os6z4EKsCCPilLK+qpw0yLVPC99/V+fLzhuegpyJK1NkjBNxwRP5GPE?=
 =?us-ascii?Q?BJJhEnwJbt4dBCdIiwh44sY8+ox3Iiy1guoJPF8iENNJXo9EXa+vVTw3d4NC?=
 =?us-ascii?Q?qT2Jl0iDLqLCsf36tN5MntzVcE8tpuAUhPfOn0ubRYHbdMKfDWUfznZG1q/W?=
 =?us-ascii?Q?hrppWnqNuNygubiHCKBg6f9GVVUb7G8ZRV8pFWORFhB8SmZq6e0/dHV7q5u0?=
 =?us-ascii?Q?kRawU8bnvOHrcwQkak4q67rFO2cZ3i58sFrQrN9GFuM26I+lFnkOPFpQwegw?=
 =?us-ascii?Q?OHzMh+rRBWllBgcm/2gaI0TTtnw/Us5pWU7V8UzSM/eAcgRrUUajRlik66U4?=
 =?us-ascii?Q?XkHGScqkTyttxZwhqbRLLwFbvaFrCwX7IvpRynhEEjBpiUPxs9DafVQGlNOu?=
 =?us-ascii?Q?b8iibLgGJsxlYAJIv/yO4PIefrBkEqXEYq2i7xe+tdNF4wy9KmIZgZy5Al/Z?=
 =?us-ascii?Q?HaoC0+CmeMdSjJy94aBiBjedhCU1CVBBTrCfA8/m5uQRZiYIB/TdWQ78ZBHL?=
 =?us-ascii?Q?36B8m4Zpib/Esum9mbkqlDN3Rzt4RwKnArnKrloSgWle7kAxXcxwzpWajMVt?=
 =?us-ascii?Q?BEWzb/1ktt/yPCJcwPdhTgMp6z4phOJxI3R4OHGnFUmw41ak84f3a3wyxHAx?=
 =?us-ascii?Q?Peoau5IKj07Zaalr2I21C3YDxsn1mW40UJIccqEsOm1JcMQ0N2VpT3sISQ4T?=
 =?us-ascii?Q?G97XLDGh89OnjvtN8J4ddPfJI7B2cy4t/xUY/WmfrFNB5WbEUo3q6u2k1msC?=
 =?us-ascii?Q?LxBXW+FPE4NQ8OvhFSFQaYa9q/Oyxe5b7I+8T1j7yY6dKESw2b7FksHiUkRw?=
 =?us-ascii?Q?EDDnJNjMqdIt9pQPjwsnDuo5WCFPq0/+p1NKGvWi/9ra/dRs5h7h5A9PG2Kf?=
 =?us-ascii?Q?4b8RVOTw6OVckQATodmJ+ICPYat0o+9lPve6TWgLYGhjYPnfIruckxcHG+Ys?=
 =?us-ascii?Q?GnheMS1hpbyHI8cwE2MXPxJgAlcQi22mVkQ9VBgxxUT2jjvN7JpWz2tic2/0?=
 =?us-ascii?Q?TiH8tHzEIod2hdTY8ikEUaSiaRxCP+sLXBT+86xtE33bdHRapMt61uQVc1uk?=
 =?us-ascii?Q?BfmM7VGBP1AbFt14br+UL+KP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3860E6C379245444B07A25A5321EEF0C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bccf117-1f1e-4628-fe59-08d93d1063c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 04:18:05.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1ILbCnfC4wySCiWx6twSUKFYtllTgyvqUwGyyoNX+VoydX9uyOW7u522vI3J9ESHfcgNa3tZAm7DSRYqiseGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5063
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: tr2zSKtTU_YVpdTlh2hvPVy9wTxXPYVH
X-Proofpoint-ORIG-GUID: tr2zSKtTU_YVpdTlh2hvPVy9wTxXPYVH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_15:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 1, 2021, at 2:12 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Recently bperf was added to use BPF to count perf events for various
> purposes.  This is an extension for the approach and targetting to
> cgroup usages.
>=20
> Unlike the other bperf, it doesn't share the events with other
> processes but it'd reduce unnecessary events (and the overhead of
> multiplexing) for each monitored cgroup within the perf session.
>=20
> When --for-each-cgroup is used with --bpf-counters, it will open
> cgroup-switches event per cpu internally and attach the new BPF
> program to read given perf_events and to aggregate the results for
> cgroups.  It's only called when task is switched to a task in a
> different cgroup.
>=20
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
