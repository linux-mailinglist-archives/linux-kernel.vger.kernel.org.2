Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B754E32FCCF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhCFTe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:34:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231386AbhCFTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:34:48 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126JPP9c026085;
        Sat, 6 Mar 2021 11:33:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3KSGfPIOb3DjKwpNpQIW1hRkSvHQg37wbYKyEQdqgr8=;
 b=d8sJWlGAIVRzSS5ZYaagqBTVdnVUnmjiUd5s55zWobjnhfjL+v8rcKhnfeFNqxQTH1lC
 9RIn56s84iTceInNUn3zQ1tEB1Dp4H2wZWBZwujUMMVes/Vktu808zIgMek/Qq24QHv9
 pWfmEQX0LfJblEjPavKxX9CAAKukXIC2ia4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3746nmscks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 11:33:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Mar 2021 11:33:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZEpb8Mtket8cbE0fClK6Q/nPET0Iydx8XdRdxHIeWeNm4w3xemw1Y3qn/tUaeUyvmri7GNBfG1CMbhIE4me5orqVDME953ZWdCvQMiOiE6NZ+SLiwAxYTl+J8fH/584L5W164LxlyzKz0s9hbEtSoj7mqtMe3hE855UMVLEM3fIcKQY3LJKQlHm5jtNL6TSt1Gg8iCDp8rN8OdjM6bRwRtWJRq0axp0hR+S+VjE6tQc+AvHAYmK3w40lOWLE8VkCxOszB5JrnFWLzbOD3DkySZaMTKHyeGpIHJJ3hLKhQFttlboZBmdL+xQ8QDu3LgHPwhwbq8/vEj38GwaAWD6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KSGfPIOb3DjKwpNpQIW1hRkSvHQg37wbYKyEQdqgr8=;
 b=ZL0M3r2dtdDqvRw2toyDqKY91m+jUPL75tLMB2txus6mQAwFTYdtHJi8mBGXOVgcXcb/Lr6o0jwosWVqyjp2OC3Hnc8E66vysfrnuGb4wsxbbhGS/KB92ULRuX1xqB6/yodi9AodYjiLBDx4ILr1L+NfN5BzI9faWVNtFbuzqqKuipsubmM56+iBZWjyus6e2om8w4iduDv86sLbnlCT1iP/cWe6TOlgFpS47yZyZne6KKuFuSfRIlp3ngofziKFeWUBasXlhZEQEJrWE4uuB139+eCHlvNJio/c+wYhNaUl5nL/3znoZpMLMUjtnqgv4bcE08Iuugr8jmuvqRWZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB4290.namprd15.prod.outlook.com (2603:10b6:a03:1f9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 19:33:25 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3912.026; Sat, 6 Mar 2021
 19:33:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf tool: Enable warnings when compiling BPF
 programs
Thread-Topic: [PATCH 2/3] perf tool: Enable warnings when compiling BPF
 programs
Thread-Index: AQHXEl/yDf1ttVb3w0OqFW7jvbXg7ap3WmUA
Date:   Sat, 6 Mar 2021 19:33:25 +0000
Message-ID: <6C9737D8-F6A5-4CE5-AB52-82B94A7538BC@fb.com>
References: <20210306080840.3785816-1-irogers@google.com>
 <20210306080840.3785816-2-irogers@google.com>
In-Reply-To: <20210306080840.3785816-2-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:ace9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63d3f985-d593-4cf0-717d-08d8e0d6b609
x-ms-traffictypediagnostic: BY5PR15MB4290:
x-microsoft-antispam-prvs: <BY5PR15MB4290A6288C5511338E880822B3959@BY5PR15MB4290.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:202;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQI0eA1ka8aqDG7lrNG7KRGlIhHfsSMLLvt1jWc6rh0FvqJsELllfbifqGT82SWwP0wdxgv2oy/Ig7CR3DR67v3jn/t1/lbUavNDFm//5Pi7gQfw8k+4avFSebi5h8am1XKxqaC4JhAyKq/PZz/RxiwKemFbZjUlaurJX0wOQLE3tS5IQeabEAJzsFt5URO26jfE4XRjDOG9YiVnKtNhSAfozJmNw1i6UBeN/qmhUAYmwbIpQyGFx5M1nlTwHBpQQXFJo/CjXWfTs6gwHJvnNCWvsO6vGpJCozbj/AbOl5Cg7aQQ60ynp39+OkNDW6tWlt+h883SgiBH5VHOJTGzSvexfhiiyWnAQ4dXJ6dgC9xS+zHp3mS0nJHtt42M6MrkqOloE10XBNGwLIQ474mQ7+sVEdGSCStzUz7AYdD0PIQWSDwAkgpa/gQbdn3Fzvvx9CSaDF1N45DEaF+PwBeknZZ5wlyItHhcEFfrUx/YamCn5ypp+v9m+xLdAaaD24aX2PTDiSEmaGNaKwapf3NrWfHZ/voR5DSChHYj7MZafm8/ZZ5zcATMwa4lDPBsoEGRDo8YisLmo0tOFOlUYyZs2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(54906003)(66556008)(86362001)(36756003)(4326008)(8676002)(66476007)(66446008)(64756008)(6486002)(76116006)(5660300002)(6506007)(83380400001)(66946007)(91956017)(4744005)(6512007)(316002)(186003)(478600001)(71200400001)(6916009)(7416002)(8936002)(2616005)(53546011)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IGnKhmGv84SiUuJ87SvNUrRXLp77Yo71/Tx9DSA3La7V3uRf7K2IsORH2NHD?=
 =?us-ascii?Q?010XyeaUlNLmxGBtfd6nYKjQ4g+ElLmkX4FWc8EUWA88t4xEYyF56msez5pp?=
 =?us-ascii?Q?b5b7hZSPaQb5cJB16K3vanC9ccmwIQqfjN6dblFXQfSvK1M4TkmUaPDg84eD?=
 =?us-ascii?Q?NpLRpaeWNC1aERNKX5YQ+ju8xHNE0d4hPcl1TyQ3BcyKok5hHAP9hHm6oSUi?=
 =?us-ascii?Q?VOrDSfL7NWcvasSk/TsB+5IJr4BFV4bV4x/heiggloQYEIedChMgrlW5jFHw?=
 =?us-ascii?Q?aDC0kkAu1KU8xt1eHdRiZiVpS87LYdip7BB/qoESo7GE3BH4M+wDSRsUNari?=
 =?us-ascii?Q?n/xcJ5n+wQMOv6XNpbbsk40VXIMXdCovVDhaRh7VJn4a3f9r3oM+vmkgaCnN?=
 =?us-ascii?Q?ncWz3+AxqQ7xpc0epdBptr0pPx1V5op12P3mnKwqaXF0zXluToHjBjuBpKq0?=
 =?us-ascii?Q?zJe2CwOGaf4B9CCyu1m3DXaCVM7TNqRUFSmXEd3WeDah30ORxgy75cEAyJ6K?=
 =?us-ascii?Q?sRO/+BqKOcL14KhlGTl41+UoK0B2pA4SmgdRZeYg81NLi55gZMaJ9GarjQ94?=
 =?us-ascii?Q?cY2FBYKH58ah+lGujQBCwdZJw38MPvY2asSBJQhj65JmNSdB9u9Tb5S5oeHg?=
 =?us-ascii?Q?SlSQiJx0wc7K+cc7ZyAZE7vx6VsiJE2hY8kaTi6+9k5ZHIOoCFEoh2VvuJ9m?=
 =?us-ascii?Q?5QUfrhj8kZySHLhJv0RypdCPrv7mSc+cCztrPNwEyv0XBin4lbK5v0LAL8Vo?=
 =?us-ascii?Q?20bIFUieZynElp6F2rh5VBwYMRChWePb+ZKAbbrPTlcTUHrHmj0qriiRH9y4?=
 =?us-ascii?Q?eb4yslJWTZqcMWDj90DRVFxSRaDDsoxT7oJGViDjf8N1bdDRt4QsLjw3JQCZ?=
 =?us-ascii?Q?qwk99frhhS/Y7r1zHXA0ILG28pIdeoiN3au7Ns2LZIXGyzgaYintICAIVn8w?=
 =?us-ascii?Q?eE9CEiPZJNo9bpt5G6+qFT+1qVueAoRmrxiWgX4QDnNsai5w2dXzXxe9NWF3?=
 =?us-ascii?Q?BxfWHjeJ6CiOltsiS9nVj5HX+uJBF1/CErnbT3ZEvBEvrKhKW+XiGZA+Lxx7?=
 =?us-ascii?Q?npC+5KgX2Nbb9JR1szbwDPp/mCND6twclnPS+MZtVDJVCPcw9Y7IN2HdmBF3?=
 =?us-ascii?Q?Hbi94tjPZ5ohyeE+fQnhvQ4iax5olvKynZouRFOqKcIdUBtCif4096xkxJ4I?=
 =?us-ascii?Q?qGtLHQKYwFEDCyBUTNyUvw0b7jG44uLsAyX7CaIyUxBnFt9cvYkEs8AG9LmG?=
 =?us-ascii?Q?EKkrC/hc3kUvcB8ZZvgB6HlZCIm26mByLlIbvXfMwMd41kcajkAAFs+Iy3Zt?=
 =?us-ascii?Q?zXcW/HgFCmHot6UPrZIJUDSbDjPNCnctCRx+2VakdGGNyteDBEvEpeKoQKWo?=
 =?us-ascii?Q?M1WaYNY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CC7B3458829234893B2AD8F20C20009@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d3f985-d593-4cf0-717d-08d8e0d6b609
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 19:33:25.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RumluD3OuJwj7VWHXPwVDHo73wlyV9qJZR7RXM//FyisHZwBJ0Aha80uoiSz9nzUAT9wpdyzXlaSko6gPzWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4290
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-06_08:2021-03-03,2021-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103060121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 6, 2021, at 12:08 AM, Ian Rogers <irogers@google.com> wrote:
>=20
> Add -Wall -Werror when compiling BPF skeletons.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> tools/perf/Makefile.perf | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5345ac70cd83..f43d2551f3de 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1029,7 +1029,7 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
> 		OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
>=20
> $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT=
)
> -	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf $(BPF_INCLUDE) \
> +	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) =
\
> 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
>=20
> $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> --=20
> 2.30.1.766.gb4fecdf3b7-goog
>=20

