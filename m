Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C23D6D31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhG0ETh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:19:37 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:42822 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhG0ETc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:19:32 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 16R4IHBd004864; Tue, 27 Jul 2021 13:18:17 +0900
X-Iguazu-Qid: 34trLrrEEcsCGVeFwG
X-Iguazu-QSIG: v=2; s=0; t=1627359496; q=34trLrrEEcsCGVeFwG; m=EZvghtAMN5NMfC+CjxsILqUTwETCUAm0LAMND/DDzvY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 16R4IBXG014714
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Jul 2021 13:18:11 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id EF17F1000A1;
        Tue, 27 Jul 2021 13:18:10 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 16R4I9Q8014443;
        Tue, 27 Jul 2021 13:18:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJX1imhLBwTVGWXOXLhczqlJL1yXFpkoViJkVYBCToBgC7LUjlr480Uub8thdS/Haq4YlZkKUmhL2W+uESBlQa7GvHV9tFgF6pvvHD23kLLP+pWdUJmKwnlTKuHrTqDBn2yw0COp6GCtJMoa7AEqSuHoqPHppvaSqCixcB/m7b1qXAwluCNs8DwPNpxItrlw2NhBp4ThdHGOkaRVhKve1SwCx6/QhqY3zxm+Q2XRzePJd0eesL9WzzQ7FTrvOYbC/TrVM3HPgsptBO9pFO6JoNNMkgweaJSsRH95NHZFeyIO3LpkfYkWUqcm1EdQ6J9gJOvLSkCpXkJXpIc1A/tZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT36JFkwkuq+g5iQYZ6YK+bIwf/8t01VoS10FS8QhWg=;
 b=M04bX1XayFonIjPeENLSGqjEwZjd/uWqaJBqJAPc+nBcHl0BrBgVUPnqvErR8ZzuD2OtVVOjrjK/aymvcthgIedo9koMdur7t5wOUhdvA16ui7OYuP/fp2yoby9/HdN+8ZcrZFi91FfsyVGOaNRItgOedBbh/MTjYspj0fNwYNR0Fitomq9HMcu3uFYGm2dIFDGh9E0O3G61cqPCq1m+F2vfY5cpWa3dv00O0gabMM1nZicKK/51N0m6x3gFZIrKyhOLOpVTEBOLMRxYLLllZqku6I0dahVonPLO5F7L0dTqjoRXE2F67VWLKIZqu85ShJJn3ZscLdULe+PBR1o0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <lukas.bulwahn@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <chenyu56@huawei.com>, <anitha.chrisanthus@intel.com>,
        <Jonathan.Cameron@huawei.com>, <miquel.raynal@bootlin.com>,
        <nagasure@xilinx.com>, <ulli.kroll@googlemail.com>,
        <dsaxena@plexity.net>, <mirela.rabulea@nxp.com>, <nm@ti.com>,
        <kristo@kernel.org>, <ssantosh@kernel.org>,
        <shubhrajyoti.datta@xilinx.com>, <wilken.gottwalt@posteo.net>,
        <vigneshr@ti.com>, <linus.walleij@linaro.org>,
        <brendanhiggins@google.com>, <qiangqing.zhang@nxp.com>,
        <joe@perches.com>, <ralf.ramsauer@oth-regensburg.de>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] MAINTAINERS: rectify entry for ARM/TOSHIBA
 VISCONTI ARCHITECTURE
Thread-Topic: [PATCH v3 1/8] MAINTAINERS: rectify entry for ARM/TOSHIBA
 VISCONTI ARCHITECTURE
Thread-Index: AQHXgirBMZYvC/L9GUyHdu6ivfCwaqtWOC4w
Date:   Tue, 27 Jul 2021 04:18:08 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62520BAEC54CC5D235489D6C92E99@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
 <20210726142943.27008-2-lukas.bulwahn@gmail.com>
In-Reply-To: <20210726142943.27008-2-lukas.bulwahn@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e25ac69b-16ac-4eaf-9378-08d950b589dc
x-ms-traffictypediagnostic: TYYPR01MB6652:
x-microsoft-antispam-prvs: <TYYPR01MB665243F599149E4611849EBD92E99@TYYPR01MB6652.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cb3C1T3m8DyGdJUL9ucQDqYRNdMSr0DUD8fmAViIxPgiRfFmMEgpj2y2jmFLoaaalIN0Q7H0bcnRLrAqRmmT5dAe9y6G+DV6h++PfIILUcSu0t7HxJuGbMY21vdVWaqBkjVbk5AWd9Mxle4j7qd1FGI/A+UujLkyA/0eNwQizUZmxGEk9HVi9DxEd5NCRy7jgJq296rj97HHcboI6aA95poelzTl8L5ADl1ZVaMGYyC7L1rGq4MeuebXwRbzQ9HEZi5dFdLVehIQid2d856CvRkQjzzLekpZUdB2V/RuUdTTevPlN3L3RIri3BvYsaNOz8uYEkvBmdzkzVIUUeOEnfEUYjx9v02Vthh6zz6x2J9u9bZ84jcYDWJjAx6EL93sXvij+wVQTcQ/iFy7h8VT+CgFc2NjVVENVsjR7026PSb9L6dpvIZ1PMvKdb6jb6MiR4UbLvWPQqnVsVnq85aF9yE60FvTXGtUUnt37gCeQkedp/81Icf9OKvn+2twbzmFfEuOrigzJL5SritkxQ2VjwyjQp1iCi5zTznI6Pal2+01m2YNrXMeNZvQa6OjTG1A6Pjz2nBCUpgNykgLNjUzKvZhJ8MHRiSGwF8hoqen08SQKE2ePyAb8mXevZR4ZsMlSiHg2qGI63hJhkxCHoT+ubDLrAEhvJOri6Ws5GsuLbNnnRonH2dSoxiMe5Pbs4wkBer1ZUQDIZNLpo3sdRDYFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(6506007)(66446008)(64756008)(76116006)(53546011)(186003)(7696005)(33656002)(66946007)(26005)(52536014)(110136005)(66476007)(5660300002)(71200400001)(66556008)(8936002)(9686003)(8676002)(54906003)(316002)(2906002)(478600001)(7416002)(86362001)(4326008)(122000001)(38100700002)(83380400001)(55016002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFlubzBwK0ZJUjJyMnFDTFZNdkFIVDhobG9EWE1PNnY5K1dkd3daOWRCK1Fo?=
 =?utf-8?B?aGZDRUhTTVlRcC91NzNYa2I1SUs5dEZwV0RseFRVQiszRFkra1ZibVgyQlFG?=
 =?utf-8?B?MzlHSkJ1WmNreERIRnQ3cUEyNXRzTC9qUVo0TDdxSkFpL2kwc3pYVUpWUmZN?=
 =?utf-8?B?cllvdm8vYU1HNklncVM1dkp6UGp1ajZ0WnQ0ZVdhTExPSTh5MmFPUjJjRG5R?=
 =?utf-8?B?eExiU2hrWGdJbTRIMGJCRDFRLzhnU0g2MFZmY0VUVE9QUG1ValNEMEpPcEFK?=
 =?utf-8?B?bjlOazBTeTJWZ2I3Y1Bob2ZSaXJqTTU0bDFVbkFQRUF2NWtFRUcvMDlRbFds?=
 =?utf-8?B?aVpTWGZBS2JCMHVaeE9oK1Q0K1FZVHQ0cGYyS1ZFZnRKOEx3aldCdE1sOHN6?=
 =?utf-8?B?WTNPREJ0OVE2aEVxSzl4aWZGY0lxbjl0ZGMzb3paUW1DUFFsRTJnOGF0M296?=
 =?utf-8?B?K2YzYmZWbUVjbkprQnQ0WGpGUU9vZGFoNHV2YXdIVzQ4RXA2U3ZqUGJGUFpP?=
 =?utf-8?B?NWExNTY4STNici9XUmdqdFBWcnBSSlhsVkJYV0crc0lLbTNXMFdJeURLZGta?=
 =?utf-8?B?SmtUL2NiTUpWeUNoK2NNcUl1aXJwdm5ZVDJVVlpOMHRiZ1F1S1pia2hRZXVk?=
 =?utf-8?B?RTBrd0ZlRTEzd0lKYzBzazh5STRpN0s5ZW1RR2lPWk81bVFSbW4xYUw5dTRM?=
 =?utf-8?B?eUtxZmRscUlkbVg2dVZWdHhwTmFhOWM5ZHRkclAwZCtFV3BaVTdhUlBjdllv?=
 =?utf-8?B?cUwyTnhHeElkSVFuUGtrS2lrbGVlWWsyQXRMenVaK3NaMVczRHRuSzNzNjA3?=
 =?utf-8?B?b3ZOZk96c2ZuVk5KUnFlc3g5U2I5cHplM3ZZV1BSUjI1eitSNWdNMUlOUVI3?=
 =?utf-8?B?OVRjV1FNZ2xFMkZPMnl6UkFWYmN3ZWF2VklpL1MwOW1sL3B5eW8rQ01USVd4?=
 =?utf-8?B?eW1wSXd4UVZoUm5jN2tlRGliUUhITlRWR09FZnhFcTJkR1BWd0hWWmJBRUhU?=
 =?utf-8?B?OHNBdElrL1FYR0FpblZyMllSQ0hCVTA1eXFnTzEvbC9OaUVVZXExUHJrVDRm?=
 =?utf-8?B?aXJjbm5qQ0tSMUFnZU0wajZJSG1Wd2NBSjJIR1FBT0Q3ZUR2dlhnTmZnNENM?=
 =?utf-8?B?N1Bkd0RIZUQ3WTFkV1oyZEJWUlJndDh6TmR2TWZQNVdheldNd08wRkpBazB6?=
 =?utf-8?B?ZXhLQzc2dWtwcmhXbFpoeHlUZVVvU256ckd1Z3ErNHV4bDI5MkUzWGlMUVdp?=
 =?utf-8?B?OEhraWFxSlhOMXE3Y01NK0UzSEYvdlkrOTFVYlJjdE5idloxR3FnMWt5UjBU?=
 =?utf-8?B?d2JUcFU4ZXIxWVQ4c0JYSmNkMnFlUWZ2QzgzYldDY3RHMmRHZ2s0ejNrdGFU?=
 =?utf-8?B?NGNGVkd0VEF1MEVTSmxQS2U1RzFLcGZtWFZRaDlTVFhoWGF3RHV1Zm1QWnlp?=
 =?utf-8?B?dGQySjlOdFpnYnQ0dWoxTXlmUmZmQ05ybGZxY1Byd1hLbm5zY3VDcE5Mb2Zp?=
 =?utf-8?B?WGw0cHBSTmdVOVpEVnlzUmZVWUtUUjZZOEY4cU5lK2NSaTBDR01FaW4rb3Ir?=
 =?utf-8?B?cTRUa0RXNEZQc3JEbnlEMktZZTU3ZDZ1RGV0WmU3VTFVanR5eGhZK2RzRVB4?=
 =?utf-8?B?Nm9neE1HT1JkdHNLbjNTWkdzYUVpZFBPT0p5dnFXS0xyRTFUZmVqOTZKRlNX?=
 =?utf-8?B?RjQ4b2pGTEgzRGQvZ0ptMVRJQWdsZ1IzcHZCNnhMNTQyZGg4NDRmVllCbzMz?=
 =?utf-8?Q?21kFM3HnvPm3lw9fXI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25ac69b-16ac-4eaf-9378-08d950b589dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 04:18:08.0727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyu9e63QNrUzSSSZcP9YuQ9ogL7A0wpAM2em0Cw6YSMxkQayqACcitX+WxhiiBzlc/shV2qvCNsz+XS0SNtjYdEpDwLNtfmYrPvIL/AOfDqRuSo80iEWw12m7T5cWaOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6652
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgQnVsd2Fo
biBbbWFpbHRvOmx1a2FzLmJ1bHdhaG5AZ21haWwuY29tXQ0KPiBTZW50OiBNb25kYXksIEp1bHkg
MjYsIDIwMjEgMTE6MzAgUE0NCj4gVG86IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp
5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD47IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+Ow0KPiBBbml0aGEg
Q2hyaXNhbnRodXMgPGFuaXRoYS5jaHJpc2FudGh1c0BpbnRlbC5jb20+OyBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+OyBNaXF1ZWwgUmF5bmFsDQo+IDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPjsgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVA
eGlsaW54LmNvbT47IEhhbnMgVWxsaSBLcm9sbA0KPiA8dWxsaS5rcm9sbEBnb29nbGVtYWlsLmNv
bT47IERlZXBhayBTYXhlbmEgPGRzYXhlbmFAcGxleGl0eS5uZXQ+OyBNaXJlbGEgUmFidWxlYSA8
bWlyZWxhLnJhYnVsZWFAbnhwLmNvbT47IE5pc2hhbnRoDQo+IE1lbm9uIDxubUB0aS5jb20+OyBU
ZXJvIEtyaXN0byA8a3Jpc3RvQGtlcm5lbC5vcmc+OyBTYW50b3NoIFNoaWxpbWthciA8c3NhbnRv
c2hAa2VybmVsLm9yZz47IFNodWJocmFqeW90aSBEYXR0YQ0KPiA8c2h1YmhyYWp5b3RpLmRhdHRh
QHhpbGlueC5jb20+OyBXaWxrZW4gR290dHdhbHQgPHdpbGtlbi5nb3R0d2FsdEBwb3N0ZW8ubmV0
PjsgVmlnbmVzaCBSYWdoYXZlbmRyYQ0KPiA8dmlnbmVzaHJAdGkuY29tPjsgTGludXMgV2FsbGVp
aiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQnJlbmRhbiBIaWdnaW5zIDxicmVuZGFuaGln
Z2luc0Bnb29nbGUuY29tPjsgSm9ha2ltDQo+IFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNv
bT47IEpvZSBQZXJjaGVzIDxqb2VAcGVyY2hlcy5jb20+OyBSYWxmIFJhbXNhdWVyIDxyYWxmLnJh
bXNhdWVyQG90aC1yZWdlbnNidXJnLmRlPjsNCj4ga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTHVrYXMgQnVsd2FobiA8bHVrYXMu
YnVsd2FobkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAxLzhdIE1BSU5UQUlORVJT
OiByZWN0aWZ5IGVudHJ5IGZvciBBUk0vVE9TSElCQSBWSVNDT05USSBBUkNISVRFQ1RVUkUNCj4g
DQo+IENvbW1pdCA4MzY4NjNhMDhjOTkgKCJNQUlOVEFJTkVSUzogQWRkIGluZm9ybWF0aW9uIGZv
ciBUb3NoaWJhIFZpc2NvbnRpIEFSTQ0KPiBTb0NzIikgcmVmZXJzIHRvIHRoZSBub24tZXhpc3Rp
bmcgZmlsZSB0b3NoaWJhLHRtcHY3NzAwLXBpbmN0cmwueWFtbCBpbg0KPiAuL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsLy4gQ29tbWl0IDE4MjVjMWZlMDA1Nw0KPiAo
InBpbmN0cmw6IEFkZCBEVCBiaW5kaW5ncyBmb3IgVG9zaGliYSBWaXNjb250aSBUTVBWNzcwMCBT
b0MiKSBvcmlnaW5hdGluZw0KPiBmcm9tIHRoZSBzYW1lIHBhdGNoIHNlcmllcyBob3dldmVyIGFk
ZHMgdGhlIGZpbGUNCj4gdG9zaGliYSx2aXNjb250aS1waW5jdHJsLnlhbWwgaW4gdGhhdCBkaXJl
Y3RvcnkgaW5zdGVhZC4NCj4gDQo+IFNvLCByZWZlciB0byB0b3NoaWJhLHZpc2NvbnRpLXBpbmN0
cmwueWFtbCBpbiB0aGUgQVJNL1RPU0hJQkEgVklTQ09OVEkNCj4gQVJDSElURUNUVVJFIHNlY3Rp
b24gaW5zdGVhZC4NCj4gDQo+IEZpeGVzOiA4MzY4NjNhMDhjOTkgKCJNQUlOVEFJTkVSUzogQWRk
IGluZm9ybWF0aW9uIGZvciBUb3NoaWJhIFZpc2NvbnRpIEFSTSBTb0NzIikNCj4gU2lnbmVkLW9m
Zi1ieTogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
TUFJTlRBSU5FUlMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KUmV2aWV3ZWQtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEu
aXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=

