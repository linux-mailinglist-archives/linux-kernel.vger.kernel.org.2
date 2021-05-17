Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E613839EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbhEQQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:32:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34280 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343799AbhEQQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:32:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HGSf3A128962;
        Mon, 17 May 2021 16:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SHeZESCuoE8efIl3MYR+rVkrt5vdP40XjLEnDZnZqT4=;
 b=u+WB/X+QOw3sFYdYqzFRisJaNThNduQ1Zqs+JxEVblwca86kQTqNzj8Q1+IseMEAAOiS
 TqQipUhXlVUyH1n5Q3UD4iY+/6fNdRYlPE3DaHOQ1QK/gU7ayS0kqx0MiKCBhuEb/YCM
 Shppaz4KJQUn+0QNzBxaLjrOlWFQNHqvzy1m8pLfOKJPmmwGnaHZKn6fEcYi2CJgpJ2X
 1EBuSkpbgViFd5DVdR77joIi68r46o0FtklcPcfiXlH0fnjZo1m6U2u2NgKUfW8D34ta
 +0e7Jl+aLpGMIyKdLLjlSYqPTMXPjWRu/Aau9ededpWnSAOOMmSSc+zrvXdZThyUwyLD iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38j68mbsdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 16:30:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HGJrGY091219;
        Mon, 17 May 2021 16:30:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 38j64632n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 16:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkb5ceie6sxZ+Zvm4CKmcGc/3Q1pMyUvLKr+u2Qchb53t5oI7HIGGWTQpxp09wKowboBuWhh3CJ1ClMzT+d2VwLGIoFaJ1ltm82wYiDHESPs/FnK1rm5OMcAOsFE2CvZNVjKClPM5LnZWUKJntRf06DQ3Vc27HgAOlFzDb+Tm3+jtv9CqbDsd8BZNQ7ZjFEWd8abJaISNCvgGN2t2sRyRtjPSA6MqKEjdXA3xKF4ghK121UyX+aqWN16C4wuOSACV5kuXgcI1C3xdZAEXufzo4ocH22d0fHDzOaPoWHUc64BjlwSR5zOHDy3TmPCQvxfcYUe6V/KlSVOfG9ifC0oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHeZESCuoE8efIl3MYR+rVkrt5vdP40XjLEnDZnZqT4=;
 b=USSVFiaU/jzdsLfzS67MVewoUlgUjbdkTC4GBMA/7WyknHDT1WY670dZlJ+gVv8/XRhUFoUr9d8KcyzojZGMCxwN05mHV1RPe/YqGt5lTHJWbwEagRy8SM0EH/pHAMtR8tuU+6qxvON5isXfe+YJLpsWcp1C4qvvD0VPj/Z3rYVDfcCnnSp8cPHOjraqZ8I6JKy6K2ly5ZcM+OFpq32DyaAWsMjIazPHc1BBqe9pMZczBvoDd3qfn26m/01eph0iw8CGZ6dLbDPD+ciLbzCwqZkU9PrXKBUjYE3DZKWF2wj4f2nqmeUwCnjqEVeuPgBQg33A2oQiGhMZgoSebyBjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHeZESCuoE8efIl3MYR+rVkrt5vdP40XjLEnDZnZqT4=;
 b=xxxp3LhJZiGsTJLcKcNCm3jhaP7toxThFc90U3ObPg/4k7KyD9tNGCohkBlecNbXwLbNwJYFCCpf2mCsdRf11MhQMvRTp8DLrHXy+o3BqzR1vRhDYP3WEQNISPOl+DnXRt3PD5OQxVVyO7GUBx2sv7zMPv/iFzfuuXbXtyw6iNQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 16:30:53 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 16:30:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: RCU tests for Maple Tree
Thread-Topic: RCU tests for Maple Tree
Thread-Index: AQHXSzMGIvrnY1Kh8EiA60B+RMV7eKrn3ZYA
Date:   Mon, 17 May 2021 16:30:53 +0000
Message-ID: <20210517163048.7zcg2435lsvg25ef@revolver>
References: <20210517154048.GA2013926@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210517154048.GA2013926@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29eb4249-a138-4320-994b-08d91951240f
x-ms-traffictypediagnostic: MWHPR10MB1310:
x-microsoft-antispam-prvs: <MWHPR10MB1310815454840AEA8049CCD0FD2D9@MWHPR10MB1310.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAewTuAfAiB5GZT3BenO4t9cFlEQPfkZmb7jq8FCdeWAORfaKW+NuKVCQk+8BrC43WqjdumXjwDqsv5EvRfXKRsN3H//lsbk/dgadB6v0gRzn2KxkCV2KtUH4Uch/DntQ5zKWft1NwSrpn9EWQZkLHMGaL9XSjYF+RwcrJ+Jcpy0ORn7TD3Uf9mnDXWkrF2QCnydPMEWKJid9mDFX1nWE11xXr59vK4lFofrfjtfyKBkMyqRNZmR1KYyqhc1Ur3a4qiNqjqiaV/dTmKTy9mgsAxQr/i/caflgFC1cP0uE4GrY34vgMObV4E1qyVKGGN4ucEn0fCw27bU8Szwye1YY6MQahSr1uu8gJ+xLzoauV/Xo8CyQaRtxE4MxsdvShVRhL7jR2rb08cCHpVcdLjslOnk5Uny4C7zc1CrNlJdLL+nzHOcH/Y5w1uUxD0b7NTsnSdk738WvgaYfNqqBiyg0RR3WSJ2f8IVfz4q327voo63phlGxcnSBUBD9sQvFHqZSxBhrVfOJGdcOXhb3bJZZvEP7Go87T8vWfW+g/epuUIj+iLhGAOUuqHu2sRXxGlRPbZ30Q+xI6htT4/ZMwjkCyWqPlepheU1kvGKG5VEwgo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(346002)(366004)(396003)(376002)(39860400002)(6916009)(66446008)(54906003)(66556008)(66476007)(91956017)(66946007)(76116006)(64756008)(2906002)(1076003)(6486002)(6512007)(9686003)(6506007)(4326008)(186003)(33716001)(316002)(5660300002)(8676002)(86362001)(83380400001)(71200400001)(26005)(44832011)(8936002)(38100700002)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+9hBchvcbhdjtHSIVccOh2Hsz4NogeLFjYjGNyCI20DDrEpAXc4sXp23hjhn?=
 =?us-ascii?Q?h+7sLz/PEOJn8FJBLz7cEPCb+cl1W1q2QWVaIZI96/pLw/5jqXXZDl2OtB3S?=
 =?us-ascii?Q?11ceuSaMTyHcItYgmKkJB/19jS/PKVwljp2ZHsvS1n/X/TrFngz0LbbOURvQ?=
 =?us-ascii?Q?0gb2w3jJO8higdgbiEEe9HeWVqFodeGkMRBuYqgTTIJq8QOtpJ17CEqZEj3V?=
 =?us-ascii?Q?eH6out8qs3fZCHK2GbdI6fCa40rHAxzTEogrXY6VZQac9A83k8Fd7kBFw0R7?=
 =?us-ascii?Q?euy4/Utmq3d0xMZSDoQTuIwOZOGmpO4t27HXizxHUEdsnThX0CaypHN9psXJ?=
 =?us-ascii?Q?OztwnYMzimokjz1Lhwfhp+mGCQPFMj3d13KNsVpMKqvOCn9qaLiA2BZjblXC?=
 =?us-ascii?Q?N5RNk38TLDQW4UCgKcIT3GdJj+pIIdYcKCDOCAs3IasGBG7DzujDt9HNrv9V?=
 =?us-ascii?Q?5FjWtB8bW8lc6yMWe6nCeWvsICxkRu6B5btqCan/VKbgJc9znq7V9i1Iyk/J?=
 =?us-ascii?Q?q5xycZpCeeCb2eGPveDILx/QhY+q8AGskyz7kz+tytH2TlDckCuyBVhYrvyD?=
 =?us-ascii?Q?Ep5IW8Ss2nvFOmGXLLouEa8hdUkvbVngBKFsaPHRdoXewML+OxeV5471II/n?=
 =?us-ascii?Q?IHpTqX0UPX5XjEttPQJZFawKq/LBxyiof5caFQ7o9wi+BqYoMHLi/0M1YhWG?=
 =?us-ascii?Q?GfkYusijumt3sBNXDkKfUxouQEtStXIgMM0k3DuTkWJ/K8ubDbEnJdPIZ3up?=
 =?us-ascii?Q?xOdg/Mq4bOGDmJwlD8lMDcWfCAXQncWYzjayypOG2dl2H4Pj0gahL83pQ79n?=
 =?us-ascii?Q?/CM83H8nHdP6E2+7lxyPRjYUypAFDqzIoAdXi5exAVOOXsfjjRCjw6eAuP7m?=
 =?us-ascii?Q?xtHgFfi27fKwj2UsuwhEcBlM4HlbbM4I/3b2qFgX9tMw9EA7JrEa1snkXwOl?=
 =?us-ascii?Q?e4IC10sHUBXfOHBjBNh/3l/hLU0l7sL074eh5955yyEVZOZxF75WuRnIBmNF?=
 =?us-ascii?Q?FNTcx+Y7PVOek4xd/pVCsX4vE+DroHskAwy4qo9qeoDJQG+DY9NPkIhNr1eo?=
 =?us-ascii?Q?421N66Pd/hvg71oe/QPQxXClK/tOFPjBJN7Op1eKqHE+AcSrQ4AcnuoNJwRh?=
 =?us-ascii?Q?Dv7fJGIyorPRtyQ4aQpPlzXtfr9m2AYCkeF5hgxKHIXAqYyDB8lAC+dfr6C4?=
 =?us-ascii?Q?QQf7h9Mg2W02VnTTnfueXvFUAYJxL0mJHDBfYMP+8FAFPwUrrES3cKDiLEZw?=
 =?us-ascii?Q?qCcYReaL5hVPlufZR9Baz9UJE1B0beTQ9EA7PZF2U4uOJ9EoP/L0qQ1R6Xc8?=
 =?us-ascii?Q?sQJepJ2Z5vUfVf6ciV1IwOIH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9059787834A9C441B729FBE8F099A312@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29eb4249-a138-4320-994b-08d91951240f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 16:30:53.6893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJMmf3Nb8qvnppZH0mQok1uqQirL6E9LLYqaDidLkJ9CIVwxCgU1VvUjmEHH9alj1o+/RDTfZjMfi+ywc0NA9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1310
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=918 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170112
X-Proofpoint-ORIG-GUID: 8iaoZRC-iFvOMPFajjNDcgQKeAbOXWiA
X-Proofpoint-GUID: 8iaoZRC-iFvOMPFajjNDcgQKeAbOXWiA
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105170113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [210517 11:40]:
> Hello, Liam!
>=20
> Apologies for my being so slow here, but just wanted to double-check my
> understanding of this code.
>=20
> There appear to be two tests that execute from run_check_rcu():
>=20
> o	rcu_loop().  This appears to have RCU readers scanning the tree
> 	while an updater is adding a single range.  (Or replacing it,
> 	as the case might be.)
>=20
> o	rcu_val().  This appears to have RCU readers repeatedly reading a
> 	given value while an updater is adding/replacing a single range.
> 	The test complains if no one sees the new value.
>=20
> These tests appear to be the only use of threads, though perhaps the
> test harness has some way of creating threads that I missed.
>=20
> Are there other tests that I should be looking for?

No, those are the only ones I'm running with threads right now.  I think
all RCU tests are run from check_rcu() iirc.  This did yield results of
failures that had to be addressed so I'm somewhat confident that it's
actually working.

From your wording I'm gathering I need to increase this by a lot more
test cases?

Thanks,
Liam=
