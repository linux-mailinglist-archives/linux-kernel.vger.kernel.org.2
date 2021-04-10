Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA4835B053
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhDJUQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 16:16:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38160 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhDJUQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 16:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618085747; x=1649621747;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=7/Gioj+Qb+JXfNu/DSykvMXC0YHNahP+LGcWWlkPb3k=;
  b=c4IDB07G/pJCuP0GrC6ih0LE3lJhllv3EyMQ4U89gd0wRIotMwnJTu6p
   aQmugv5M3wFgL6gGWFRL2MjTKj9x37dGqt8cPQANAJkgQ4YGZepCQqLUk
   wUksTrkJB2K+ZjkEVso2ik5KfIIciF2kZKGJtjsHiV3NF8sujbQIl8XeV
   QL+ARTGmWBErFKIQEUB1wcptR/L0KDnGTGuy3E5yG6so0lKTVUqmeC3eF
   AJOriihdm2fluC73Vly960wSPyH6XT3SinwUoF/U8myL2r+hcWMpp+Ior
   U9laA3kW/94eGmtOqgHu7PjxStp3k+Izl3FWFlqlUIqkXWXZC/Gwd54ft
   g==;
IronPort-SDR: lP/a/bTKRNbvbZvzkdDKqhxvQy5jq2WwXC3fYjjfmzQwZPSs/+0aiB+CmMCQDtxhi1+nlYCgVa
 DQDm6lUwc/kBM+1jmBu27BfUkUIgK0bmd24GvYGGFsbFEm3qdC7lEjbW9NORdWcs2WOGXsUD4t
 fGB+WPhxFXbnBq1eN/N7vGUTkXwi+F08XVQ1qpA/sl2CrB03sLJAA35q6x2XnZRDW+nRQCD14P
 tsSLXOQguQwI7Q+TK/WPFTEg8wfJCXtupcxMbgFdQ2iP6ZIxctcfEsweukWzBcRZEa18cTENvd
 ErY=
X-IronPort-AV: E=Sophos;i="5.82,212,1613404800"; 
   d="scan'208";a="164388711"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 04:15:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT5EOwO3+oafKjwLyOiX82BG0AjDyKmHnoud4/UVYuklwXChNoF+wHy3d4RL5Yj2XrvpzDDb1bLnT7gvzCAaHCw0HMf9OtgqwPHs9axI3qlARtV5x6APLwtjT/WUQUaGF+Iztp/a0LFaznzICQDcAGYbVMSNKCqEWTBFeNrxFOa71Rr8KjLHOflOdHlLwqPC9HEl4FMThwtoexN9m7XYuwceuk8QF5RHS5Ag9VOZgFp6b9zI1HzR9Vd8N42cUbihMa29h7HPlK9uxKJm7N5ZWp9hLIao7UOjfktyxobTH1Hx2IO0SR1XXWZqeDo4v8pP25AKPq5nvHz8hFDjtiKLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmlHPmxwfc19XfBSUPzYUnUV9Z0XPLjvQmB8+6lAUsI=;
 b=OyfJHAbFBmOIzLWdzfeHjyMnk3k1vjexy6wj5qzj2OW/sAcvtIQ3hI7L3o788EAFqz1KPzQynHAVYKqbGEPcC7BV+LB3owXUSOqmdVGGh6w4X16inMZkTFZgef1Zw6Wp737xX/UmD4eYxj6TAFqs91tlmOXH4AY+4mlm55HjdxoDucy47PlU99TyiZ7S2QVXxqgCE2MNc014qqBs1EulnYYK+oCP9NSu8BxEqD2LNcpRcgkbDHjP7Ecb3K5irnI623KCKhO5XrTzWau8+H0Q+UARY5ZuobQBtzs+7xMNAL2zgEgmEACRAOBS71WE3tF2aXRXqRgPaEY8pymW9dqvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmlHPmxwfc19XfBSUPzYUnUV9Z0XPLjvQmB8+6lAUsI=;
 b=XDplf2bA4CIA0k8sBAnMOWwxAygQS0Yx0FQWEFCpIoNdp5i7bhvbfNeNdtDv3Ix7FEcHVnop+dYDg4u2EOGVLP3VHmdJa9q77JKVn4Wkam6LBJJwmIbaRhT9LuA01F0t8UXYKMIi5vXaci9SINMdJnixfaFNjipg3iS3EElibLY=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6379.namprd04.prod.outlook.com (2603:10b6:5:1ea::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Sat, 10 Apr 2021 20:15:42 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 20:15:42 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] nvme trailing whitespace cleanup
Thread-Topic: [PATCH 0/3] nvme trailing whitespace cleanup
Thread-Index: AQHXLkZH32ZQIJNvtUCw0O/hdeI8pQ==
Date:   Sat, 10 Apr 2021 20:15:42 +0000
Message-ID: <20210410201445.53061-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1d2d5b-ec33-40c2-5e95-08d8fc5d6aa3
x-ms-traffictypediagnostic: DM6PR04MB6379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6379B0812AD47FDD83D5ED5FF2729@DM6PR04MB6379.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34JK4wJVdGhCb++suVG1KMZBgIpO/lxAGIIT/qSrIy83K92TaMleh+I48xW5ggDSiy+mG8fJaPj+UXwQSc5kUxQeVpXRXfb0lktI7dgBFb7tfaGc5eh1TrLV3S2LNMASaiKZRHZzOGUnWkRjEQS1mIXLXPAlttRY2T/teFmYN1HfBjhPuz6slbnN+LKTVMt0+Z569Abh2EsYqVfFVS5usLjL2Nav5jvOKkjukYjhAsUfJdrLGhdSLKrZidGIh4Wf6bRFA0wfz+8JTgeRvKF5kpIzXqjFOlRtLVE163XLtZBwYY/k8Oap4wvC8TQvhn9Xn+HM+tqSprsDsFeGYtXeuSwXblsqKMe5sYGhws3OsYbTnTnrhVFHWyve1fL1rHBlXk3TNiTWN6mkIrpu9LphXA6Hqi2Z6Sxa3XLc6sjR8mffVIku846y0nKeiHgM4afQ9RBJASfOs2w7BiqkX0HSksbkIczwwK8spAIr1/rfGSM3Qw09Bt60NDM0eRma2QyKpdS6iKfzofw1Gn1bVX5d3awajS/Hk3nb5Xs0xXQhiKAh4IXpjQme1dBIjBQPc86EjQnmbOdnfb2kfIz1Two9rVJqjkZNEIIbCbj5uKIBbjI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(66476007)(8936002)(64756008)(4744005)(66556008)(66446008)(66946007)(1076003)(76116006)(91956017)(71200400001)(5660300002)(2906002)(86362001)(36756003)(38100700002)(316002)(4326008)(8676002)(6512007)(26005)(186003)(2616005)(83380400001)(6486002)(110136005)(54906003)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zWtul3Txv03Z138Y0VgT0AdZkXXTnNJJPRwoJ8YSRtnuNkekwHXL/UQLGA?=
 =?iso-8859-1?Q?vUUFXZLhhdRA0Bl4dWq6Y0L5ao75bwLaR7b1i1eY8FU2dKDNOuppe4VP7j?=
 =?iso-8859-1?Q?rTxBavgR8XEH7btlcO7j0qtBNtttBGxxRvcbyurFJhtP3fJ8hEg5VE7bs6?=
 =?iso-8859-1?Q?OszQ47Vkgdt+VWD1qDJeTux03c0/P5Gh0I/l4ihzQdWG4qoritFQPYKXIp?=
 =?iso-8859-1?Q?ez6dOaB1Xe4hkzk8gcYRJtVIvb5r+icTsPtKj5ImMXtUCROyb+bCtYkRdg?=
 =?iso-8859-1?Q?FSuRIHtnAsx/DcUxPeY/hRH6h4DUfPd4hS6adLr1SN1hmiz0bQOz6V0rvc?=
 =?iso-8859-1?Q?Jrv5jGledvbGHgwdaeW0L1jBg3lIUF5ZjF7DGDL5gfvQ5wcvB6Xu7u7kQu?=
 =?iso-8859-1?Q?ZGomwy2UeYogniYmOQdzSjK2GxIa0w8isxWy25Rq6VuQMCFBpjuhsvU0Db?=
 =?iso-8859-1?Q?iZMujnSMGPCjX0Kt907Ke1uByNolZaNOOVDakDeFodo5qhrpik+6i9P+0d?=
 =?iso-8859-1?Q?R8ok8YQt3rYWJzfuXsZjIJdmTSgJfe/bNskS6RfZuDEKYVViVv9tU5DqpK?=
 =?iso-8859-1?Q?LhGYHNSJnkg5TlkOgC0ZEokRkYRoFQV1pSnICwoRxEQ3pN+KyoGnjNoiMs?=
 =?iso-8859-1?Q?inSgfhBCOlLL6eGuZ3RMzlZ8gjZQjbX7jZ9TPvIzkuez+5nu9fmo5AFDPE?=
 =?iso-8859-1?Q?ncio28mVlsY8TFFq/FA+tiEuPINp2gEU9Gt+jyqY/EafdOnHik9HoRvgO1?=
 =?iso-8859-1?Q?UOcTi6U1+XmMkYye6+Ej0GBSjtaM0Glo2CJE8JjMa0QcTGNgsP2n7l0MdV?=
 =?iso-8859-1?Q?aOk0QoXzxOMCapiZbMBl4OTaYDxbdSRy8JJB0sFDoCq5C/sD2VsJpFoOSl?=
 =?iso-8859-1?Q?YvzzW76UeNWl9mO9COrGpJRhe3hYnPcYCEgEdIuZ34/+seWFR89ToQ+i9C?=
 =?iso-8859-1?Q?+PKH/BPLtcqb/IKpQdn34zJk7JTvKrXpkzs2ogEcBYr5r9jepbCQiCEBfP?=
 =?iso-8859-1?Q?Cr3doECKk9RgHYi1phNnwxOrBwphzws0UYewglJC0ZkyUu75skCh4DbVIl?=
 =?iso-8859-1?Q?G9RHQUErOVGKvb7vC0k7PluH3mFgzjWj155Ki6KhwSEwhcfKWrJ+jn4FBc?=
 =?iso-8859-1?Q?lELRCBZL9oTrU8rXJK5kdTEv2MxSikK2ZGPx+NSIhM9eih2zDJkwnLIDKa?=
 =?iso-8859-1?Q?oqS1o1UuE+hoEkQHjQb4kAz3aibAOSImSAqMnAe2Anr0VwZHh1J6BDXR5z?=
 =?iso-8859-1?Q?rk8Nm7WDjhA/rVFqTNPU4GUsXY4kCMX44iCYg055/H2TJ0lFOeTgFTJcsM?=
 =?iso-8859-1?Q?iFo1NmtpiFQfDTpNTZV4HpVcU7WARQsoI7YuMPTRpBtGcAbYH6Z6sIsQGF?=
 =?iso-8859-1?Q?Y5PWyF4G00?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1d2d5b-ec33-40c2-5e95-08d8fc5d6aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 20:15:42.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQTh29XnX6FbxZOLXDLZPg1PkTo7vyU7u05bsY+GXvLPLgj7Qwhloo9giaVhaeK3OYPI7ChwbmiSYS3nX6ewQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello nvme peeps,

This series removes all the trailing whitespace I could find using:
git grep '[[:blank:]]$' drivers/nvme

So this should remove all the existing trailing whitespace in
drivers/nvme/*


Kind regards,
Niklas


Niklas Cassel (3):
  nvme-pci: remove single trailing whitespace
  nvme-multipath: remove single trailing whitespace
  nvme: remove single trailing whitespace

 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 2 +-
 drivers/nvme/host/pci.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.30.2
