Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9673CC49B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 18:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhGQQz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 12:55:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17786 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhGQQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 12:55:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16HGgwOf028435;
        Sat, 17 Jul 2021 16:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SQbqWIsx01zCC23yld86SjNB/j6I/oxEznqOZ/uhISc=;
 b=UWfLNXJ644PWQGV79C+eKb0t34GWZSQD+54MCToXRZyHXPVmwJNKyQdTGhSG0EsU8h3W
 742vRSuwnf72AcsBxXWO+ZLXVchg49re9D5ZpQMymhwAAhuaMfCnUx/ZlZN1A5ZzsZN6
 CXylQxhxkDZBdvlFViknXhOTKTpuCWfn9xCohYhpbTy1Hylm/3fkXV83K2Qt50PR6nxx
 TGFRS+UY+7t3ZbxoLiEwez5l8Vxq9aNn6A5+PgTtEeIU8SXtPTcVo6/OgZFyaI8FBVlh
 vsjW0fcFvh71RSMPAgNI6drTQ1s7ud1yL5yO+68mvflFAKDN+YYnXquSo/48oaWbLpT1 pA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SQbqWIsx01zCC23yld86SjNB/j6I/oxEznqOZ/uhISc=;
 b=Tlb+dHCzSMMbjpGHx4LO6oid5KzWmS+63rejDX8dfsL1HxPQAjs2kc/YPch/NLosGQ43
 5XJsiNl2lKo++R/+B9mIEXVufNDgxoGK7ET0PLjF8Xe2xF7LXVhlzEvd3Mofb1mRePXQ
 lpj/U7mgvWCEpd1bzPUjONFekHX0XDf5ED2V788nCBsFkBl2vA2NBcR+o0GvfB89fQ2K
 YaEJ6KEHVSBc18xtmwi5cMloNQ6XH7U07tO/JQQAjp8sWmtpMQrnoKAbYYJOhorRHkt1
 UOjYyS/IalQwW77YpwdSQSY48P28XYo6a1yl6suSLtZDF8yh3m24NGbsZkxQwwg2Mh4T hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39uptrrk7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jul 2021 16:52:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16HGotiA145872;
        Sat, 17 Jul 2021 16:52:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 39uq11j0cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Jul 2021 16:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc4bBBUb7l0NlEKUnZ/tHY4b78tKtu1lWs3vGwpgv37nVWmv5wvY4uy4fbt4a5YuQwuFlgjni4RXjId0oxcYgGdwLOCjxyqde2UXdHmLFjNYOQ4/fGS+QauxmBjOgfjQiII/gyXJqFT0xUPoIG7C+eiwwLC4T1e6+gwAyWlwE9/LCnv7N7vnXdMokLKBcMavTpo9Hpi5BZhP1LbkdbfSnhlP7as3z/cFzleDreNoGND1MPhwAziGn0Cc2W01AtgrHv1zrwL1mROAtwXOyouLeqOnxlIU4pnN9J4U7A59lqeBRq65h9z6pFGfs0l2olkfYCTWGzRCQiXK+fZxrJS6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQbqWIsx01zCC23yld86SjNB/j6I/oxEznqOZ/uhISc=;
 b=LRbugVH3fa5xZlvusr7YRmaVznHB/dWlf7LX2WyiRFhIUGuikwM6HMHTZsnwgBylRLopqY29yLtk6UEmB4i17QPlGGrrxBuz68L4QvEvJoyX/xghkgTJIn4dT1DDfGpthJ46CTOT2J4nnmLLAfw5D3XC7bHoxfIapLA8nnP/0Th6ghoOqXKc4X8NEp+rLAKY+/+9/+PJnxTPzrov37jN0kddxjzW75gN5jY7YIWCSd9j2EBOl95/uCeUSbSK9J3PgmuJGPXiqGxj8XZy3uLpzehlSUm4BZscv9Rwxv9tMkz9h0JClaETQ4/kib87WzKjWb5o7bT0r45KP1lKWtDgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQbqWIsx01zCC23yld86SjNB/j6I/oxEznqOZ/uhISc=;
 b=V8OMvQRRXBRuYXQIaz8Aud9bJoqGTqYqfjNPlr1RGjH3/E0qHjkPWuwO0VZs59Eaj0Ld91CzgqA5cr5qzrvJd5m4pPYYB3e5aFDtbksXSJx/hTcgeCzUU1GUJJYw0r+/pf0jXWzV6bnrRipnh5Vgpq57bqwvF+u5VG1c49ima2E=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sat, 17 Jul
 2021 16:51:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 16:51:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Thread-Topic: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Thread-Index: AQHXeeYCjeFzOpspFUa2lky1xLSwtatF6D4AgAAHHICAAAJ6gIAAKoGAgAAzoICAAAkHAIABC1OA
Date:   Sat, 17 Jul 2021 16:51:58 +0000
Message-ID: <F5824BF9-1F6F-4882-A6D9-0943DCFF55DA@oracle.com>
References: <20210715215753.4a314e97@rorschach.local.home>
 <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
 <20210716143705.56001390@oasis.local.home>
 <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
 <20210716171805.55aed9de@oasis.local.home>
 <26A9CF5A-0724-4D4B-BC59-09849EC33326@oracle.com>
 <20210716205510.7f565b98@oasis.local.home>
In-Reply-To: <20210716205510.7f565b98@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef15f503-4dca-4734-0a06-08d9494330f4
x-ms-traffictypediagnostic: BY5PR10MB4257:
x-microsoft-antispam-prvs: <BY5PR10MB4257E48583A2E97CDC5315BA93109@BY5PR10MB4257.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: txm9+WZnAIQt3F0tmLH+ijUR2+sQ5mZZgJhxBCIuUpfTHeF2bdO22zZb+gbA2C2O6FAAVu3w1J/DK+U1I820XRZwm/4jU/gBuxKSQFTkCpmaKZ6SR2uveBq6brpklcWaKoQo5USGQXw58mwTrlRFHeUYJVN2YMYaO18B1lk4hVxZzzSnDNR9LZYDzG/NrbfZls2l+2CN4l33fZF/uBmBoa9xEilN88N3Ilx3znIDsw/N0PVV4bJw1jGEVSmqBL0TjxJmSU5QUD1SYq/CBJlbADLVFxbcTqu6N32hiYzMvR7xYCnMBK3CHxRBlD4NMw0poazUr4v6okS0hTbsUOrjEHy211HuhZJWEeYsr/HCdi6PlhFXK8LOQmh4heDlkI9JHWW+EnaGDMLhaV2Gm7Bp4BX21iQawf1kOkbq/JEq379+0zzImTsVlzW5WZyJkk8jd0Pv1QeT/wUu2ygbCnvHQFLAC19e0IV8WdAkwumVUtLGiX+g24o6CXkEcNR3wo+LF754wvFySUdevB2zvd+sQcleetmFP8G3dXRGKdmccMDkUtWdIkFbzF2SotzXL76N1Q0ImTuXRO6t+9WUFMJB0Oo6YvfWG2bWKHTSZGgJ5KSzFO5uelHJv9olx6h5NL/4Whdqx7yvlb3nLCy8gSnWC+oHN5hYKfjcSpHWllcbnFNaYPXO/pzbYjO4FTZepuHfL25U5qOz4m76VuKF8IM6B7xYx3SNXRDsc31df0k0hP/QMtqStKy8sffQJCP4cvmH8zbSB/R6tptgKzVj1oaZXkBC1nWLq3uNXVHFjH5gOYMO/axTTEAIuu7W1BPaOiTQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(8676002)(5660300002)(38100700002)(64756008)(110136005)(33656002)(122000001)(6486002)(66556008)(76116006)(2616005)(66476007)(66946007)(36756003)(54906003)(316002)(91956017)(66446008)(478600001)(71200400001)(4326008)(2906002)(966005)(8936002)(83380400001)(26005)(53546011)(6506007)(186003)(86362001)(6512007)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SNrwv//huDQ9YgM+VA12VZFnUI1ox5F+rtkjWRnnxQHYdOy2BNp5FwTQPDoe?=
 =?us-ascii?Q?4IYbeA02LBUOA9zzD/oAv2YXx49X8lvm2geZqPHGyrrYWbuc1WescUwn0njA?=
 =?us-ascii?Q?XRF9J/XOekiA6CmrZYzsKvM+dK86eaj8yllNzjGQ2edtFrx6UvwJ4Il4h1bZ?=
 =?us-ascii?Q?UAbzmp3PdBS1dpvzaScLqNGxCMUHLCIZXz2FERW/CM4v6EYhB5aRJceiJ7ER?=
 =?us-ascii?Q?BRuJSPUC9X5lP9u3roNCYWwMA+QH819P+GNB9+ExxUYyUHUwD+edsUXY1jy1?=
 =?us-ascii?Q?3smEJpLSsrfl/pOW4Hhkip02RkvFagzloy7Q5o1enCRuqbmqnLKN0CArBTCp?=
 =?us-ascii?Q?GOa0bPpaEIROBApkBk4cXnU2yUXSuuChF0bLwZCyi+90RaMY37QahJ2JgEU7?=
 =?us-ascii?Q?TwP88LxRYB7StHnks0I9aI5XOziNvEa0NiZbPSikfyCqo9c/cRfRaKudjPyb?=
 =?us-ascii?Q?62pzCny4J5+i0uBzoIYV31u+5VkM7IYGkNqL/lx6jT9AZPCN26u9AjkZlFnx?=
 =?us-ascii?Q?C4mtl45Oa4R+udlz91MycK8OUD8RPcYXz2QN/8Qyez7FykXePaHAv4db/UOl?=
 =?us-ascii?Q?5YXyH+jsmGYsFn+wxr34GVbGGJN+yLnTy5k/b5M6WncHPq+tqZTwfbx9O5Xm?=
 =?us-ascii?Q?sZFQRu2q/n6YRQsu4cAhySuOlYEQ3XQOG8CPu6xEOjmzGH4iAEP/+hAvuCia?=
 =?us-ascii?Q?Z33HBE0GrNsRhP3Cg8T/KOL+1sYZSpLTa6Y2jvNQof8QmTngluIqbnTLryEJ?=
 =?us-ascii?Q?FFLKtEsT1/EAPlG5wjSMsfs7wZOVuCzzW/G8k1XtKsAZntclbci27/bMZmES?=
 =?us-ascii?Q?DJfJjrVbUMT5arzysva/N7+dOpIPtRnVNBjgPfZj4SveGBUTN69l4v+aKLaN?=
 =?us-ascii?Q?e/L5TtdIY3pqFyQeQRkqLe0JYxt5ivUz6g7q7qUf02kWf6ZgrmlozYhll/L8?=
 =?us-ascii?Q?DDDQhOO0H91N8RxND4Znky/lIhUn2GQvgWQDfhukLNpQZXNHVNskK3+GJSAt?=
 =?us-ascii?Q?d7Xfr8ZHwuNQABAsIEqIVaOuelHk1COCUMmgsMJfQBgzGPuVuBhz7Po2feeF?=
 =?us-ascii?Q?aqZywSinUctiXi/KJNzSRgGVt+fYkXurV/QCipHK6QVsUO3dh0vQMuXddM6y?=
 =?us-ascii?Q?S7ItDsyC16EMXsi3XuTSHgR2e3/CSaNbt0A9z+dW1VhSGYDtqv13Q2Xf71mp?=
 =?us-ascii?Q?jHLuBOFFFRzgd564B41fqC7i91h2c28gxbJWNRa+aQXdwICHTyxfha9Asg7S?=
 =?us-ascii?Q?WeNMvoZfJ8kLHeb5VvwNAbaN1wEytQLAivlwPuq3i2J8nwYhB32tb97f+i8O?=
 =?us-ascii?Q?N6UdRIAJ6WqrzrDkplnYp8+0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8A9E6AA9EE5A346BCFFB745E4BE0755@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef15f503-4dca-4734-0a06-08d9494330f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2021 16:51:58.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzS0F+zC7EvraMeTyJoXap08mmxGi9cNWwR6ICEPPffn7cMVstDyOOilI6QYnkM+BxDioWgc+XwtY3W0v2umtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4257
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10048 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107170101
X-Proofpoint-ORIG-GUID: pNPbs3G_gBZmcopOnptECa6GxprQxGqH
X-Proofpoint-GUID: pNPbs3G_gBZmcopOnptECa6GxprQxGqH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 16, 2021, at 8:55 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> How about this. I'll just give you the patch and you can apply it to
> your tree. I updated it with documentation, and use memcpy instead of
> strncpy() as it is replacing memcpy() and strncpy() will cause people
> to question the code (as Linus has).
>=20
> Here's my latest patch. Feel free to apply it to your tree.

Thanks. I can carry whichever version of this patch that both you
and Linus are happy with. I will apply my changes to use __string_len()
on top of it, and send the whole mess when v5.15 opens in a couple
months.


> Hopefully
> it wont conflict with other work I'm doing. But if it does, we'll work
> it out. I don't have any code that relies on it.
>=20
> -- Steve
>=20
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Subject: [PATCH] tracing: Add trace_event helper macros __string_len() an=
d
> __assign_str_len()
>=20
> There's a few cases that a string that is to be recorded in a trace event=
,
> does not have a terminating 'nul' character, and instead, the tracepoint
> passes in the length of the string to record.
>=20
> Add two helper macros to the trace event code that lets this work easier,
> than tricks with "%.*s" logic.
>=20
>  __string_len() which is similar to __string() for declaration, but takes=
 a
>                 length argument.
>=20
>  __assign_str_len() which is similar to __assign_str() for assiging the
>                 string, but it too takes a length argument.
>=20
> Note, the TRACE_EVENT() macro will allocate the location on the ring
> buffer to 'len + 1', that will be used to store the string into. It is a
> requirement that the 'len' used for this is a most the length of the
> string being recorded.
>=20
> This string can still use __get_str() just like strings created with
> __string() can use to retrieve the string.
>=20
> Link: https://lore.kernel.org/linux-nfs/20210513105018.7539996a@gandalf.l=
ocal.home/
>=20
> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> include/trace/trace_events.h               | 22 ++++++++++++++++++
> samples/trace_events/trace-events-sample.h | 27 ++++++++++++++++++++++
> 2 files changed, 49 insertions(+)
>=20
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index acc17194c160..08810a463880 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -102,6 +102,9 @@ TRACE_MAKE_SYSTEM_STR();
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
>=20
> @@ -197,6 +200,9 @@ TRACE_MAKE_SYSTEM_STR();
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
> @@ -459,6 +465,9 @@ static struct trace_event_functions trace_event_type_=
funcs_##call =3D {	\
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
> @@ -507,6 +516,9 @@ static struct trace_event_fields trace_event_fields_#=
#call[] =3D {	\
> #define __string(item, src) __dynamic_array(char, item,			\
> 		    strlen((src) ? (const char *)(src) : "(null)") + 1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, (len) +=
 1)
> +
> /*
>  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
>  * num_possible_cpus().
> @@ -670,10 +682,20 @@ static inline notrace int trace_event_get_offsets_#=
#call(		\
> #undef __string
> #define __string(item, src) __dynamic_array(char, item, -1)
>=20
> +#undef __string_len
> +#define __string_len(item, src, len) __dynamic_array(char, item, -1)
> +
> #undef __assign_str
> #define __assign_str(dst, src)						\
> 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
>=20
> +#undef __assign_str_len
> +#define __assign_str_len(dst, src, len)					\
> +	do {								\
> +		memcpy(__get_str(dst), (src), (len));			\
> +		__get_str(dst)[len] =3D '\0';				\
> +	} while(0)
> +
> #undef __bitmask
> #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
>=20
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_e=
vents/trace-events-sample.h
> index 13a35f7cbe66..e61471ab7d14 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -141,6 +141,33 @@
>  *         In most cases, the __assign_str() macro will take the same
>  *         parameters as the __string() macro had to declare the string.
>  *
> + *   __string_len: This is a helper to a __dynamic_array, but it underst=
ands
> + *	   that the array has characters in it, and with the combined
> + *         use of __assign_str_len(), it will allocate 'len' + 1 bytes
> + *         in the ring buffer and add a '\0' to the string. This is
> + *         useful if the string being saved has no terminating '\0' byte=
.
> + *         It requires that the length of the string is known as it acts
> + *         like a memcpy().
> + *
> + *         Declared with:
> + *
> + *         __string_len(foo, bar, len)
> + *
> + *         To assign this string, use the helper macro __assign_str_len(=
).
> + *
> + *         __assign_str(foo, bar, len);
> + *
> + *         Then len + 1 is allocated to the ring buffer, and a nul termi=
nating
> + *         byte is added. This is similar to:
> + *
> + *         memcpy(__get_str(foo), bar, len);
> + *         __get_str(foo)[len] =3D 0;
> + *
> + *        The advantage of using this over __dynamic_array, is that it
> + *        takes care of allocating the extra byte on the ring buffer
> + *        for the '\0' terminating byte, and __get_str(foo) can be used
> + *        in the TP_printk().
> + *
>  *   __bitmask: This is another kind of __dynamic_array, but it expects
>  *         an array of longs, and the number of bits to parse. It takes
>  *         two parameters (name, nr_bits), where name is the name of the
> --=20
> 2.31.1
>=20

--
Chuck Lever



