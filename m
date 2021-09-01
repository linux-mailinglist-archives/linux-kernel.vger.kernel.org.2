Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A813FD5CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbhIAIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:43:30 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:25719 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241623AbhIAIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:43:29 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2021 04:43:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630485754; x=1662021754;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=+CtD98KG/89PR8G0+Etdao56dZrQBpz3nzYVqK1eZY0=;
  b=W1wGXd8XYsLHBQf9m41A0XgCJ4zLBbIi1kTxawOn0cgo3kZ7v5DTKpqR
   DZoJfJPUouLfbN8isLMmMliCusGAx4U9LNw0cybINWrTeKpXSM9OF+BBj
   g8kypH4PN/zEIhGG+PqMiXcq9rf7bKlo/o2lJOI0JandTI3ocgUkmvJgI
   T01gNJYGwqSlivfawZR52d5sM3PIa4Vq1GFYJtkSXsfI1aWCw5Y4ZjyGQ
   a2HJQ7IKFmIxZgO5wq+lqYcHv6EjkRfAZfSLL9b8FbfG9wYiT87nDcPkR
   6WzDtktekZvKv6GkMWtYfSV+gAeOkAjuyI1Fj5B+ensVm0fNBsyEiqlba
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="46397076"
X-IronPort-AV: E=Sophos;i="5.84,368,1620658800"; 
   d="scan'208";a="46397076"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 17:35:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNcys+9fI62IDGevjyHpBaRJqV+KsLLnbry47ULqETs+LG/CkLHnUJ34VijHvn9SaRxK3vnIOxnbINCOjyuJ8if9dQQopjVq/yOlyJmrlT4TSb3OI6cTfgFbp/1+ipAU7/H9nZ88pqm88NexEEKiDiNjqGGf2ZHwAxArg+uMcxcrNZh15WyLBEPOw1u+8IWnDzeYJjNGEBrUBQhc7/mayqDbkhFShdKvbgJAmvGyPeWJit6Ebwz7uk65McmCfp1cmyZvJPRQLqkMAqAm4wTJ9n6lZYbUmYCv5svkFmNLoBqFSv061ezo9EQjqoiwuhbI/HzSj67FA/FjudljulyZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+CtD98KG/89PR8G0+Etdao56dZrQBpz3nzYVqK1eZY0=;
 b=od+d+6UQSa+U2q78/3bvCmNvTQiPt2U2WqTkZuQE5DfsbdTWNvBCKEw2r1pNchgzpJoXQeAUCKTW3yrszZQVtmwmNA5vUJNFeaTUU/l8uQBm0lIcy7rimaCUYPU3hoKCuN0QJagxE6luw9MguIh1UiB5vBFj6Q+5Q+/VPZJX0/R26iJU1k1w+ERh9nImHEonlB9cc3qvzlayQCdq/96svh8ijy7VtUKiX4tXVMcGaNuwmhRcQQwnvjEx4997MEVzIvdyQH//VOO5DsWBtYpSPVM9WweKleohuAkKc7YVC4UgA3+wDQ1RkjZKrskQ1CgG/YaZhU3tXR6dMOAdVkNvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CtD98KG/89PR8G0+Etdao56dZrQBpz3nzYVqK1eZY0=;
 b=pytP36zkFFpIQK6o8CxojK8DmUWYHa0v09QzZK8SmlzNV5/gzN7pdrfQRQOZWhOYQpnPrVLhZhijCTrP70bdfgOLENKH8Ox9c0lVt+x6BUTIh9ZRngG/qpN0XscQ+3zMLVuqwX/Hr7Q0AUtuPpRuIfYTguJRBI81KYnS6UOJHqU=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY1PR01MB1882.jpnprd01.prod.outlook.com (2603:1096:403:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 08:35:17 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b94b:d5ad:b6ff:956b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b94b:d5ad:b6ff:956b%4]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 08:35:16 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     "'james.morse@arm.com'" <james.morse@arm.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'soc@kernel.org'" <soc@kernel.org>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'arnd@arndb.de'" <arnd@arndb.de>,
        "'will@kernel.org'" <will@kernel.org>,
        "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'olof@lixom.net'" <olof@lixom.net>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About resctrl code rebase
Thread-Topic: RE: About resctrl code rebase
Thread-Index: AdefCe9QtjQubFftQH+oh+e+FXNxSg==
Date:   Wed, 1 Sep 2021 08:35:16 +0000
Message-ID: <TYAPR01MB6330CE3CB67CF8F602D44D098BCD9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9OGE0MmUzMDItYmViZC00Yzg0LTkwOTItM2Jl?=
 =?iso-2022-jp?B?ZWRlNDAyZjBhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMDktMDFUMDg6MTc6NDlaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cdc8ea5-7a04-4696-7ac1-08d96d236d03
x-ms-traffictypediagnostic: TY1PR01MB1882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB18828D33FA69E3CE60207BF98BCD9@TY1PR01MB1882.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2AnZaIFHSkJDiIN/oZdMVjBzRSGI8VvPYA+CnY7x5o4nQMpW7CAyoU45ftnasFONimCLwTXHuoUI9qo8+98/C2+cWrFnHp6vll8kMt3DaGxOinmPWLE2PmnA5WwfyupKBhSE6paHHxtBn1i0t9Z1/q1DOwKh8umNkWv4jgtjQP740WZqNUiR+eZ9Tu5qOX4N+yRzG8MjrP57CuPePLCTL0fGv6i1ZYIByuIAB/b95khnqaIxx9SgmUTyGL3xh9UTGfTB4Fh53c/i0zsKS2VXKlR89GI897P4zzatuFKnyYPW7pZzx1yloZWYXe1vEroquhg9Av865wAzDvBZWe6toLQkEx1mP1i+LpDOB/YWvnz6KlEzfStqAtO5+KdvhRNCCLTbOeLbdy0q2D/fkufPcbvuEJ3zK3KuGUlKN1sjY30MVTwSncFfhwufUUixYvXlxGyKoE+EqcE6ddLlLZbwxG4U6iWheVWXNs0cguY4ryVFNE0hQWmp/SOWLGEHdpKCscXmCV5TnAnLVaaJk0PpMtCSeSmA8imDgA16ChKrJiFph1ngLm6pzwcpEUJjT4HbnGNaGroR/4c1MQkASUhVIhOoeMYNClOrucsAiFyi0aulLZE/4pwml0I2XTDiX7QnPxR72F9ro8bjBpHZfCFOvXA86pIyo2wCnN7LgDGwNSp+r144v3FM1A9zUMG/oKM2MWfpLIsQP62BbbYoAwHEpSHGgZB+WRBGTXFkpRxK1tEQYzuoes3HfE/JcKBB1RWot0hiI1LZu/c7+5jDWxewmdDPYn/am6q+s0finZGSSMNRBSdQrg77+z5e/sm0dp1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(66446008)(55016002)(9686003)(64756008)(66556008)(66946007)(66476007)(5660300002)(76116006)(52536014)(3480700007)(316002)(4326008)(107886003)(8936002)(8676002)(85182001)(2906002)(33656002)(83380400001)(6916009)(478600001)(54906003)(186003)(966005)(26005)(86362001)(4744005)(71200400001)(6506007)(38100700002)(7696005)(122000001)(38070700005)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?M2tkR0wxSnBnMnkwTDU5SjVaR05UVHA5eHdoYzVONzVNOENsdWtuZ2ox?=
 =?iso-2022-jp?B?cU93MmU2QkMwWEo0SFE1MjJ2cTkxQXl3UHRZR2pEVkNVcDlNOE44eSsv?=
 =?iso-2022-jp?B?aUlsaDJzcndCV21JOWhKUmJIZXAxN1N6dkRSWmpYSEl5ZUo5c1M1V29v?=
 =?iso-2022-jp?B?SFYyR3lNQklqUUJHYllvK0d0TnN3dGo5cFFOSFQyRjkxT3FPUC9yVTFn?=
 =?iso-2022-jp?B?L013cjd1ajJoZzVKWEF6bnVKQ1N3NlhZS2U0YzJoaHI2WFR1NVFkVEZk?=
 =?iso-2022-jp?B?b1g2OWU1Mm50alltMGdKR3AwcHE1a0ZwYWNTTjNibFJRbS9YNCsyM2wx?=
 =?iso-2022-jp?B?bUwzUlBLa2Q3Ky8zUUhwZ3ZuY05xWXRZeEhvRmNrRVEvUjEyN0pOYTcy?=
 =?iso-2022-jp?B?L0dMNUd5K21GM1liR2ttcmlaSkZRRXlOQUtncEE0enRlYmp3RUV3YWI4?=
 =?iso-2022-jp?B?MkNTL1BWenlPdWovcEN2NmsrRE1USlRudmFjRVNKTlY3dXRZVUJ6bTA3?=
 =?iso-2022-jp?B?Qmk2ZGE1T1Y5cXFtWEtlUXgwSG9paTAzb3M2ZVpUMkhmYVBpSmkycy9N?=
 =?iso-2022-jp?B?aVE4MHltT3dpVzZBUTB2bUlSTTZQVDF0Q0RPR2lwSWt6YWE3dUM4amxm?=
 =?iso-2022-jp?B?U0hSVEZKR1RCd0JnSThqM3FJVzJmVXZyZU9ITGZCZkZCZ1BmM0NkTDNO?=
 =?iso-2022-jp?B?RjltcUJOa3pWWWprNHRybG9VdVh0TVJuRUEwN0ZsQm1JWHhQZVdTaGZ3?=
 =?iso-2022-jp?B?VFZTZ0Y3cHBFU1AvQ29RaGFxbXJMbUdLcXhEYlVOTkRUdkJJMXZzRmZX?=
 =?iso-2022-jp?B?NmJrdzgyZEUraUdEZmxobDNGNEZEUThORkhIalcwSWxOTlRtZ0x2dE5x?=
 =?iso-2022-jp?B?WlRwS3Y0WFh6bExVS2puY3NNQXV4TzlMVVMvd1hwVTZ0RzYzbHUxdU8v?=
 =?iso-2022-jp?B?MW9XWFR5cnFjVWlOUXZ6OFBNR1Q3R2crWms4UFJ3VmNlL2hoaytGL08x?=
 =?iso-2022-jp?B?bEtpNnRXV0w5NzRCSzNleFBBaExhTkEwd1BEZ1RqUXo2Y2RxUVViUCtL?=
 =?iso-2022-jp?B?dHZlRlZPQUlkNEU1Z0x0OERhYlcxUnRtYkd5QUJkL0pkN2dvZjgrOHdF?=
 =?iso-2022-jp?B?SDJHMjVGVmxhbStla0FzUS9ZMHViSHFFcWdCNXZoYmQ0SjVZUExtT0NB?=
 =?iso-2022-jp?B?ZXR2dXN5dzFzS0tHRFY1YmRYNVhkZjdyajV1TVZsaG9xZDNzRkZpYUhV?=
 =?iso-2022-jp?B?TFlMRUYveVVGdUhhSlZEeFFUZE5zQ0tkdlJncW5mWnMyNWgxdkowM0ZV?=
 =?iso-2022-jp?B?RFZzYmc2eTRieU1kUFV2T0NHamFzZnpVcDF3dGVNeDE5dVNSem16Z0ZO?=
 =?iso-2022-jp?B?V1BUNWZzTU52ZDR4dlAwU0lCZE41VWMzSVROYlhrSFNZdEd2VDdQTGZy?=
 =?iso-2022-jp?B?YTFLdTVQRmxjMTBUeFphUE5BSUtJOEdIUDZGU1dTUXRpSzZSMk5GNlN4?=
 =?iso-2022-jp?B?ZmlTbWgzbXVYYlRERUJwa3BEdFd1RFRZMGYvQkQvc0FkbGxRa0VFNjh1?=
 =?iso-2022-jp?B?dDBsc1k0RWwxVy9idjRJWHF6dWpLdTNSTkJYYm9CL3FJMGtLR3h1ZXVD?=
 =?iso-2022-jp?B?SG11UEJkMHpkZXd1NFdEMmNzSzZHOXpybmxBQzR4TmNqeDl2Vml4UEw0?=
 =?iso-2022-jp?B?eGwxb1d6ZmNXeXhoTXhmMmg4U2ttbE91bHZGZGo3eFZKOFR0cndUTGR6?=
 =?iso-2022-jp?B?bDJuOTVuQy9YTjR6S2FQb1oraGs4YXhLbFBOSDVGU0l6TkhhZ1l4WUti?=
 =?iso-2022-jp?B?UEc3MmMwMWFjRWpoanY2NVo4YnEzMlhwQ3g0R3MybzZZdFpsc0pWakNu?=
 =?iso-2022-jp?B?YTBrTVFSdTJjaFRscmhHWUtsSU5Cc1dmMW1VK2RuOU9yVUR2N2ZoR2JT?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdc8ea5-7a04-4696-7ac1-08d96d236d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 08:35:16.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmaeEIiIunMCeKXDCDVoH49A0pupo/dbxGvskYHTpBfAmJYC3ftMnxoVLzh1QbZiTVJuCac35K2O2D6izhN8EnFQLIk26c4B7AXMrpRRoQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James Morse

> As you known, Fujitsu is implementing a feature that add A64FX's cache=20
> control function into resctrl. Fujitsu will implement this feature base
> on your rebased code. I think the commit of refactoring arch/x86=20
> implementation of resctrl has been merged into the x86/cache branch.=20
> https://lore.kernel.org/lkml/162871088112.395.12879267279872673224.tip-bo=
t2@tip-bot2/=20

> I would like to know whether you have rebased these codes that move=20
> the common parts of multiple architectures to somewhere.=20
> And where is the rebase code?=20
> In addition, when will you release the latest MPAM patch?
I'm afraid that my message may not have reached you.
I look forward to hearing from you.

Best regards,
Tan Shaopeng
