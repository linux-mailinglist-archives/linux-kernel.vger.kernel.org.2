Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7334032AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345360AbhIHCgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:36:22 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:59136 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235776AbhIHCgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:36:19 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1882Q3pb025006;
        Wed, 8 Sep 2021 02:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=RSKlBzoq1jEohPd2W2BSpMPFMibMQ59TsNKw0S9Uhpo=;
 b=SPWmGZz99xcjBizJqTsd1cpvQ8um1Qk5qkPZtpWQ72m1LilLknftH+BgZQvyfT66wTnk
 9qKn0romZOEkZ27TnNQrEvCTMiDtMv11n6MSEAqSfFr7BsW3kl85lS/QxFGkZwzKjgV4
 /SA6AxWYtAEHcyPVmNeMKIPtjjeA3oqVJF7s7DzoEUIaT9+Y5jBXUEsCzQPWzrjSdyew
 2SVwMijyYTqtvbUqD0nZaKsT/THHf2GHZ0s9OOy5oiAid2VMjHnHAOFjGa54YFoEP4uP
 SPOQ6syoljLMzH6U61JcRjiqXM9m/Nyxv8YjcHXd1JvrawxABLKpejbK4+rVHwaQz5eb 1A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-0064b401.pphosted.com with ESMTP id 3axcmtg92c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 02:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdBoZ7lhWvSSJxxwyJG1g1v2Ic0lCZ9/Apco6vf8hVLeV8o2/AXE0X1cYRr5+Fy3ihe3GR2ObUt8oVcE2fCmJhis0pe3+VNr81/R6Ob32NmAaDCHU8hPT0JLplrA5Q1Hv/wIkCVd9tbVowDXANElTauDGRjQFZ/02L/DsLhQruWqleFypb5e7CGTliMYav1XcSIRvzZYE7rje/0rFhf30DJ0qPL9GaaN/BDiLhjSned2slaWiSkw2L62Cb8euXAjVZDncjl//mDBFrjh1uiKGsZy7GENF/lLoMfAu+M+ZYgh9HyXxflC/IQzIyqcjnpZUfurf1Nw7d23NDb4ydx+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RSKlBzoq1jEohPd2W2BSpMPFMibMQ59TsNKw0S9Uhpo=;
 b=EAmitcHCJVj0J6cwICWaMopYRbobYUGI+l1XGOsEPy4q0CuQ2KdhQZZ3z4wdGoSVzn7BQSyPgqGLoppq3HA7AdMLurln6V/iDs9ZAiUTFFEOwwCY1icwSI0N18drcn5cK8DNfo94lBA29TwJz0y91alDQqfe4Dpf85rH3DXaWXnaJfVI7TmsWCms6qS2Ouiib/yFZ5+uaef5eIevvf9aliTtpUzYTi9WMIypaQhOfJvI90VHG+9w7mmAD5aJJBexYteVSRh9IJIifoBkZbmCx0BWI+gfqAN7U9zjS0RonkdX34pQI+kADsmke1l7jWW1hRS5Ea0K/dTWG87q+dgHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 02:34:46 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::19db:ee0e:abd0:df6d%8]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 02:34:46 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "bristot@redhat.com" <bristot@redhat.com>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in
 start_per_cpu_kthreads()
Thread-Topic: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in
 start_per_cpu_kthreads()
Thread-Index: AQHXng/wEiXsIqQmAkaGQHjRJAFSz6uZYmMAgAAVa30=
Date:   Wed, 8 Sep 2021 02:34:46 +0000
Message-ID: <BL1PR11MB5478CF84562E63476BB1472AFFD49@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210831022919.27630-1-qiang.zhang@windriver.com>
 <20210907211714.696cca61@rorschach.local.home>
In-Reply-To: <20210907211714.696cca61@rorschach.local.home>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c98794eb-7ab2-474f-17ee-08d972713938
x-ms-traffictypediagnostic: BL1PR11MB5478:
x-microsoft-antispam-prvs: <BL1PR11MB54784B00B6239B140F05CA21FFD49@BL1PR11MB5478.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27MxHriWm63233V5U0yEN7RNQE47aVt2Yx2qwB5KB1DOfb6zTjgBshlDIJ3rwF+Z7zc8JR95KW1gvKgBCnO+ie49RnT2UeZkxDSYyiD6YboWxreLzirt/ZdYtpzDYhirNh8tQ+/X5CoVCB0xNb8OoGH3WlvlAhldFwWyJrywx3WR7ifunE8bqYUzFzHGfy88Aa/cV9pwh3danD176loE368T6xC8qaNlnVetH/KkLi8T18EMcB1Ysf1QxhxwAkMVNLjunED2rExpyyDs2VogmfJxKDgwEDB4+Zj7eIwGn8yN9DPhAnqhM0PR5zm+osGK6/Gi/J+n0UCdzbxUUuj/nP5NjFNjKZif1qKzqZOods4LIiikfqBb6HNMJv4k0FXVSq0oplMXDVuhWm4cE8tz/3LS8yXqfC0Dhh0Ee7LFMgIteD1Wggt912/wQIK8yvKBEM3ioNRc0/naLPNXMXBOECduaxuQ2js5xbozjRInKzIEuZtLqDxH3Gmfn5btP8k5liv3Y1CXoCzBcUpwDrNU2MiJ4+DdBBOKOpEAPvy0Lpv6BZbs3Tk2kh2GBRcSWgw/bDkv0ezqXR1h+ULCQcwQ0hK+D7OkCOQGHSInH+g+fenXNxuyi+Wzw+NDhjMqO8KVHIDrg8pwdeRWs2xhHZwBdTJux68Z3lVgxiRALdsqiNI5Pu+FMw1CJxwK1HWZsPdhN39xzZJRjYnmOVURzabJgLtgY8ZtntpYq6j6bBNrzQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39850400004)(136003)(346002)(396003)(33656002)(8676002)(2906002)(4744005)(54906003)(53546011)(52536014)(316002)(122000001)(55016002)(83380400001)(5660300002)(38100700002)(66946007)(6506007)(7696005)(86362001)(8936002)(9686003)(71200400001)(478600001)(26005)(6916009)(38070700005)(91956017)(186003)(64756008)(66556008)(4326008)(76116006)(66446008)(66476007)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WctGETJ61iigU54zIbbqUikWqiSdKvveamT30rFUfUIQHnxBPmua3BmqRGV/?=
 =?us-ascii?Q?Xg+4Cg8BME2HqZoL68BflljEJfxfR5+nbmdWI4D3Z7eYFxv0A3MWZH8kHTQ6?=
 =?us-ascii?Q?SLqrqbHvZgiA2AgpJWC2y6Lon9szdalsJ4usbiksTkxQXvWrt29Oo93E/twc?=
 =?us-ascii?Q?z092QWf3zyPG8EDle97DWJN3+IMb9BIU0VCcKbC7HNC/5bto4XGgZX8AEEko?=
 =?us-ascii?Q?AzJTJy0nZH5WHYNfqf0fWZCy1C/ZMuE4maQaEqKpEJuIo4/NGQIweFZPZQA1?=
 =?us-ascii?Q?hHEIOVoklX1rM7dnovZrGnVWTVE4AkuHzJOJ2kTSPcEH4cjV4B7GviXtxCgN?=
 =?us-ascii?Q?qpbw7dMFUO6D9voNJ/V4pu3dkebYmQ/VMgZn3O5PrnSapn5Fg3ZUaWaClu5/?=
 =?us-ascii?Q?xuxrOsgWfNgwbPk4VDec8WN4XPAe2xtb9hzj/Le+umwlb8WOWLsggm5Ih+Ho?=
 =?us-ascii?Q?IvrAvqztAOTLhJD3dJbjVLxPpsvLYPW4lB/RrgjvtfSlXJ9Gx8s7EqCYvWWr?=
 =?us-ascii?Q?qp21lOEc44vnhfHOrZnX4qvNKXHuoMT2IPs5PrAM/vVt/POUPslxSNqN0BFe?=
 =?us-ascii?Q?+UKpih2kmmpxL9Yo8YcPJMYofM+1H2wyd2UtM5G2RKt0mz60Wo8POd+uKa80?=
 =?us-ascii?Q?vp3+dpmWrxCUokV6LE78RB4qlowE8IALNsTPQPxCzitepQ7J0oPPX5F/sq54?=
 =?us-ascii?Q?6DFQUbpwyD/QrK68JhekQNdTwmb4OhOR7K+6AuBNzoyIHBqPQQ8O7A/famoV?=
 =?us-ascii?Q?rHC8DhHr1uWO8LMWUuhiLvuf15ZquPbi7mmqdy0AAxwozyRd71Vz04g1lOwx?=
 =?us-ascii?Q?J/90HdSrCvm+SHcYP0Gq013jh8PAibZd5GyHiQ/n1rNVnD1IRCLoKg7cHJdC?=
 =?us-ascii?Q?QLkMEJEyAn1cSVGm9yTb+IRzl6OQM4oohz6MNTdgj9WM+0wylVnTqnmNfWfM?=
 =?us-ascii?Q?ueDtDSkKFpq3gRe2R4zuG8TgtyTiofqS4ejj5EOvULwfzGQBkLSWEYDJNCSe?=
 =?us-ascii?Q?vIHAWaRmkK4RvR1pYogwrF6hHUcD2yy50B8tLJF8WVesazrMxdGhKIjVfxs3?=
 =?us-ascii?Q?WNG9AmGmg5TCKOmUVzq3Au4n9jIQShLsQfmeJHylJcIEMVbAOoTCOjMxOSAh?=
 =?us-ascii?Q?us2chPfaKCKx/tQCB4UMEuhd7KFY+siTxWAWJg/+GSV6zGG+bP/OXLEXtXrg?=
 =?us-ascii?Q?dsT9DMvMv9DH25X+XLD5Ir0TEYNu7xObAaWhsjIG8zxBQu0XQk0ZXBVj5HZV?=
 =?us-ascii?Q?0kJ3LWHmevyAIELzkdzxWfeTO7AzwNc/1Vmx9f39bfK876ECHxr1px50KdkF?=
 =?us-ascii?Q?Pnk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98794eb-7ab2-474f-17ee-08d972713938
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 02:34:46.5130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyG/V0EgjkdlGANyL/CyJhv+W9Oe5N59662R+b77YANWuBgBLHbQ2rwSmPlp1lCLEpO6LIQPw41QHXMlsXI0W/QirVzVdw4Am5ILdHl6FpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5478
X-Proofpoint-ORIG-GUID: KbdTirhsStdF7-zXFDQYUHfq-7kpvL2e
X-Proofpoint-GUID: KbdTirhsStdF7-zXFDQYUHfq-7kpvL2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-07_08,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=885
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Steven Rostedt <rostedt@goodmis.org>=0A=
Sent: Wednesday, 8 September 2021 09:17=0A=
To: Zhang, Qiang=0A=
Cc: bristot@redhat.com; bristot@kernel.org; mingo@redhat.com; linux-kernel@=
vger.kernel.org=0A=
Subject: Re: [PATCH v2] trace/osnoise: Fix missed cpus_read_unlock() in sta=
rt_per_cpu_kthreads()=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Tue, 31 Aug 2021 10:29:19 +0800=0A=
qiang.zhang@windriver.com wrote:=0A=
=0A=
> From: "Qiang.Zhang" <qiang.zhang@windriver.com>=0A=
>=0A=
> When start_kthread() return error, the cpus_read_unlock() need=0A=
> to be called.=0A=
>=0A=
> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")=0A=
> Cc: <stable@vger.kernel.org> # v5.14+=0A=
=0A=
>FYI, no need to add the "# v5.14+", as it also breaks my scripts. The=0A=
>"Fixes:" tag is now used to know what stable releases it needs to be=0A=
>applied to (if any).=0A=
>=0A=
Thanks Steve=0A=
I will resend v3.=0A=
 =0A=
=0A=
>Daniel, that goes for you too, as you suggested it ;-)=0A=
>=0A=
>-- Steve=0A=
