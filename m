Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F234288EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhJKIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:38:15 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36374 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235010AbhJKIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:38:14 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B4bHvn013082;
        Mon, 11 Oct 2021 01:36:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=GYZXBqLwz6RTSsTBrDv2+lQ/RtKZHi/Keb/uHxvD5/g=;
 b=fzMghIFazEBZXp1D/sbF1mpaN0Kr/F0hcLC4g6iosRNu8gaiJRRSm3vSV14v8srvxhoa
 xnmBhI/JH6CjHnRfQhPR6cIU1Jdti7rOro25CurYmyxlwpTCZmvx0ZAS3NwKxp5Ygd73
 Y7N3iYAKimZ8xWF4CJjRSvJncb/sbr5aZR4XaxwL2PpL+xgLGTD/B8GGsc0i/Z5NLEIl
 dJ9v5ipQsoa3ffGIxIzyWmznKNit4Vg33rLx32KeSrteEd+lN2ioCSLMzU76ch7LVdmN
 ai0AUnNA74KRQ0qSHJPnVZHtsyuAzCQI4PbqTIR8KFzhr8cBCbUf3mZKgenuW9kZQKSa AA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3bkwk5tmmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 01:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZldRvCR665vt9DVSmeYwcjNm9s9fm096rPduduaY7hznmTWL1le5dVjSPNZvvzAcljuH3RFFVsuYXNsIBNHbdMLDtuRBu6PTzQsHUWPq5aYPejgG1hPrCf50mwWAMesoPIrSNuOe2GJRLbcykRlZ1vIwgXuIUQSw+BDq+2OB8YU+SfofnwgJARzeWA5Ydtb/Cp25vj5oUxCw9b9ohZ0qA+1RDnFh+ThIjzEx/EE7wdVQVAXByau3dirEWoMqFGNI8JJA6VQkjGHnFIIPVRxL9vBHYmm3qIUcSeYt7r/4mWyWUamDAduj3qhMKnKFRLuuuBiZ5cKkPapJPtJAWOLtxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYZXBqLwz6RTSsTBrDv2+lQ/RtKZHi/Keb/uHxvD5/g=;
 b=NOOX5s5e/adrbiYmmqRUtfhx2D32aNY72GcOk0Phc2tfJ8ffgwMguS6T7W+FxUgY50q2nox7NmNozsAnztPcHHcsNPovsZaNFkhBiPR9DaPLNtKhsiCy+uhRc8ea9gOzidm4+evqP+o1Hm2CBuMPxVIaqvqiIYzCO4khBVWmEQE7knEvUqaq9MW98bCkaWImCNTaYc0biNeq+RyvPqmwyFmWNquRdwfMCY/uiLpjuvU0D3ySLt97JDYkHIugnU8cmbHGWUznpQ5/1A3r0wilN+cHFESZwG7KiMPl//Ck59jYahm3CGqVqnZWqZbXiokI/MwVi8twvaoP47mdfcVQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYZXBqLwz6RTSsTBrDv2+lQ/RtKZHi/Keb/uHxvD5/g=;
 b=qhNlurKE35kjTCr/R3QPCfEo00+rHXumrwcGR3rGmL7IZ6crmcXw8zKP54jWah5zbTedlidqWqPao7wkDReC1DmH83+uSh6pop2bkCFqc8DfWbwawgHWGHugv/LTQFOGgbSkHoM2Ib3aoiPJkIVoq/ZDr+fT1quQC99uA/SR5z8=
Received: from MN2PR07MB7006.namprd07.prod.outlook.com (2603:10b6:208:1a4::18)
 by BL0PR07MB8116.namprd07.prod.outlook.com (2603:10b6:208:1ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 08:36:09 +0000
Received: from MN2PR07MB7006.namprd07.prod.outlook.com
 ([fe80::ec1d:951e:982:dabe]) by MN2PR07MB7006.namprd07.prod.outlook.com
 ([fe80::ec1d:951e:982:dabe%4]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:36:09 +0000
From:   Dhananjay Vilasrao Kangude <dkangude@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH v2] dt-bindings: ufshc: cdns: convert bindings for Cadence
 UFS host controller
Thread-Topic: [PATCH v2] dt-bindings: ufshc: cdns: convert bindings for
 Cadence UFS host controller
Thread-Index: AQHXn8XWQx/1YA1850ygYIrSCUw23quY9BeAgAKwEFCAMhATkA==
Date:   Mon, 11 Oct 2021 08:36:08 +0000
Message-ID: <MN2PR07MB7006B3FBB7FFEF18EF60EDC5CDB59@MN2PR07MB7006.namprd07.prod.outlook.com>
References: <20210826185135.26599-2-dkangude@cadence.com>
 <20210902063754.9509-1-dkangude@cadence.com>
 <20210902063754.9509-2-dkangude@cadence.com>
 <YTe1c7sxlL9HGxv7@robh.at.kernel.org>
 <MN2PR07MB700644C1A937C2078804FFC2CDD59@MN2PR07MB7006.namprd07.prod.outlook.com>
In-Reply-To: <MN2PR07MB700644C1A937C2078804FFC2CDD59@MN2PR07MB7006.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGthbmd1ZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00NTdkZmVjZi0yYTZlLTExZWMtYWVlZC1mODk0YzJiMGE1YzZcYW1lLXRlc3RcNDU3ZGZlZDAtMmE2ZS0xMWVjLWFlZWQtZjg5NGMyYjBhNWM2Ym9keS50eHQiIHN6PSI5MDc3IiB0PSIxMzI3ODQxNDk2NTM1NjI1NTMiIGg9IktJcEI3UndsMjEycWtVSmpsSjRsU1Jadi9JQT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c92c69f-9095-498e-f274-08d98c922c8b
x-ms-traffictypediagnostic: BL0PR07MB8116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR07MB8116282F0877E0893EC84294CDB59@BL0PR07MB8116.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0spum65vviL+vzLkl8r5KCWT3NkoYvHoH7fr90kp7vEKj2eLpJFEsDcoW2A+BJ6S7Ql5Gcx8kOtIceQs+lc7B2UiLq1i5a9BPDtDyf5R9oovSMLigOcdbmNqsePmf5NB4q7gLSUAE3TrJXmHS76TpuGrFWlWufKgKC+y1uEnhQABLz+TUcXTzJTrZ34kNesNWTcSqXpQyc+yVXl21zDR6aHrHFsPqdExSdBinKxzVw09IW3BFWxp/1VDUoZaMsCyOjL+qKBGzwYpdShZoLLpjmaL78p0eKCO4ICah+wn/UZEP68BunZLmfMd2ZP509b4T6jSD+TW8cwTxQ/a7469zO8ZwUaKe+BdDxcHl7r11/ELt6XvgYVhgg1Koq6JzC+v5tml3dF5YonjKkUm08b0bwaz8UxJb3I2bqbvIP16U252T1sY1OA8Fy0pZ8JensGEjh0mlBXlAf7YyPthqQBMEpC+UEi50ITYnN3lAc0HE7ShTvs7WiapT6xyY+1Qqh4780A2+woIU0VHIHyfhttZrhg2kiCYZ9eVR4XHZMiTDnchxqgYoWASzKeHaB3JK9i+rimwgMDsN19itU7pdyLvCNlwVFdJEM9ETPTqwfvRS5WjORTAOci1it88ktV/zmBxANdvPJaeveshcF/o4SOsbUf5zD61sk+OMYmbsfOGo1KAn0Sz6JnLR1J08+VF9QLEwTRMmq1GZ7R2vAjwXfZ73mBJo8C/JtxcDVjV60Ufo4AXn5YEVXOnfIh5v0qp0Ypkwn5F8af5VCStk+yyJwml/E7Mo5EU49AJWuZh1HWYkSoqRgubRxt488wXBb6AeoAtCOLH/xCO6Ho0UIIok10dEARtt0v9Z3s573+ISw08Mi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB7006.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(83380400001)(52536014)(6916009)(66446008)(66556008)(38100700002)(64756008)(2906002)(316002)(55016002)(66476007)(66946007)(76116006)(86362001)(33656002)(122000001)(9686003)(54906003)(508600001)(8676002)(5660300002)(4326008)(26005)(8936002)(186003)(6506007)(53546011)(7696005)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M8chTDIfMp96itsNo8xmLWJE876/sqPPy3k0ydSRX6RW9y18hy7QrXTjrstU?=
 =?us-ascii?Q?JF+nBErMYzPoM4IT/To2A7gk5pxLg2fuob44rYbULhuapqjGFWdD3j6fiu1c?=
 =?us-ascii?Q?euXw16JmuEczF1m87gzOne8jLlMYruZkx/KAXCVhvIoKVaOrO1OKpCw4gugV?=
 =?us-ascii?Q?WA3zrs2wSWMnbCh8raREytAO8i32vuJsqE0j2BSmVGlAaOwhieCUJ1Of7PM9?=
 =?us-ascii?Q?qWY0at6Qn83qqaeRwcYbZL6FPQewU+gEDA1WTfsVj3Cdx3YwHN0xXed/QcZT?=
 =?us-ascii?Q?6AyWY7NJGde5YszLMx66XPNtrkIcs1F3hGHuJ2N4xkBElwEo5bijFVZKc3cF?=
 =?us-ascii?Q?cAjUM7QXtMTydS7P/mVbQoJxxDw/7SOPYziprk4RBFIlKdDvZj19DjATABn3?=
 =?us-ascii?Q?iBVcuVaeA/Af+Dc8Wy43OvzwUgeqRFOtFVQuCSTYYu0EROtDdjAkfoQN6mK3?=
 =?us-ascii?Q?vYPG8gQyRVkUdueiTV0uicDN6GEIfJj2/z5P1BVjqmfF+J0C1kzigrwQmNjX?=
 =?us-ascii?Q?uXYs4SFMOtMO15hblRaQxsKo+ugVtxSwku/4Nb9wdVLWOquy4fvwnZB6ryIj?=
 =?us-ascii?Q?d3aw3a9hfOEsguZuKqAMAnQJDqLSLAfUiEPqyB+fFh8kR0OZrNmK5h1fIdLZ?=
 =?us-ascii?Q?4JbE0TB+qmzQ/V7fm5LQSB28mSmhXVzbO2wUiIPMMkwalwb+mW/91dZh5Dh3?=
 =?us-ascii?Q?nLCZHDErbdFQ7um2V5TeyUi5iXgyIev6xXcIcvz50to3JuiqLx0DrElvAGsU?=
 =?us-ascii?Q?xCgLhp2KgNLeCI7M/AC1rxSHov1aYGQ4JZj3CpbfBJSWRjpK9XcYl18N5dRu?=
 =?us-ascii?Q?rtGbWJKHTAw17Zn1wiHjNvU3zvo1CMmLnUTMcU929miPZrnRqa81tE18XzT4?=
 =?us-ascii?Q?es6IqFb0Yv67y3sn42RV3XtJT9EGo3px9sJY1AKZqjy3clym0lyG/VCv/0q0?=
 =?us-ascii?Q?qmew+r00RxacMZ2+k+PLwelT7PFfx2M1A+xQH2aUmfnEFzDCq4BWDd1PpDJh?=
 =?us-ascii?Q?rP73BMoUoRFA7o/3NAWWajymUNJxFAOrR7XcYx80+Z5rx+1GPaewh5SF0SI/?=
 =?us-ascii?Q?Zzt201pJf6Q6FbB0R3Q2JsVIH0Um6S2fhF/eIpYEzo5JQAzumpEkr7XE9F48?=
 =?us-ascii?Q?kftdmbD/oD2P2+alI6i1UDH459ybbaFYB1Y9+qhTtXCcJReTATpUXAV4bxce?=
 =?us-ascii?Q?JkpZg56qBt2MMzMc3FYdFc3miZ/9MvzvBBbUKDiBX16yIhGv1ok+sXzMTkoW?=
 =?us-ascii?Q?QXOEUZ9iUwRai9TSaRKt9uNAsoWDSoRPayl7wf+5hy6qxqcAe4U6LDEYMnXi?=
 =?us-ascii?Q?PntK+VyEjwPodmZPXvkip7w9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB7006.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c92c69f-9095-498e-f274-08d98c922c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 08:36:08.9172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSYndwwp2WrxiPYgVE/jLcmFAXELP730lHBm9h45do5ejm6d/t6Jyzt5MG3VLltAa9QNq4bB8y5TIeUEZBoeTe5xWa8Ey9xGXXZG/QgNx54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8116
X-Proofpoint-GUID: oWLLs5LuM628zAw2nJv3o_vlUayTYXnk
X-Proofpoint-ORIG-GUID: oWLLs5LuM628zAw2nJv3o_vlUayTYXnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
     This is with respect to your comment on the right type for property fr=
eq-table-hz.
I have tried different combinations but it seems not compatible with proper=
ty.
The param freq-table-hz have multiple pair of frequencies in <Min Max> form=
at which
needed to decide operating frequencies in the same order of clocks property=
.

I would appreciate if you provide some suggestion for correct type.

Thanks
Dhananjay

> -----Original Message-----
> From: Dhananjay Vilasrao Kangude
> Sent: Thursday, September 9, 2021 5:38 PM
> To: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Milind Para=
b
> <mparab@cadence.com>; vigneshr@ti.com; kishon@ti.com
> Subject: RE: [PATCH v2] dt-bindings: ufshc: cdns: convert bindings for
> Cadence UFS host controller
>=20
>=20
> > On Thu, Sep 02, 2021 at 08:37:54AM +0200, Dhananjay Kangude wrote:
> > > 1.Converted bindings into yaml format for Cadence UFS host
> > > controller 2.Modified reference to cdns,ufshc.txt tp cdns,ufshc.yaml
> > > 3.Removed power,domain property from ti,j721e-ufs.yaml as it is not
> > > required
> >
> > Maybe not required, but should be allowed which is still not the case.
>=20
> I got it. I will add the power,domain property as an optional in ufs and =
retain
> ti,j721-ufs.yaml in original form.
> > >
> > > Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> > > ---
> > >  .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
> > >  .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80
> > ++++++++++++++++++++
> > >  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml      |    3 +-
> > >  3 files changed, 81 insertions(+), 34 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> > > b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> > > deleted file mode 100644
> > > index 02347b0..0000000
> > > --- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> > > +++ /dev/null
> > > @@ -1,32 +0,0 @@
> > > -* Cadence Universal Flash Storage (UFS) Controller
> > > -
> > > -UFS nodes are defined to describe on-chip UFS host controllers.
> > > -Each UFS controller instance should have its own node.
> > > -Please see the ufshcd-pltfrm.txt for a list of all available propert=
ies.
> > > -
> > > -Required properties:
> > > -- compatible	: Compatible list, contains one of the following
> controllers:
> > > -			"cdns,ufshc" - Generic CDNS HCI,
> > > -			"cdns,ufshc-m31-16nm" - CDNS UFS HC + M31 16nm
> > PHY
> > > -		  complemented with the JEDEC version:
> > > -			"jedec,ufs-2.0"
> > > -
> > > -- reg		: Address and length of the UFS register set.
> > > -- interrupts	: One interrupt mapping.
> > > -- freq-table-hz	: Clock frequency table.
> > > -		  See the ufshcd-pltfrm.txt for details.
> > > -- clocks	: List of phandle and clock specifier pairs.
> > > -- clock-names	: List of clock input name strings sorted in the same
> > > -		  order as the clocks property. "core_clk" is mandatory.
> > > -		  Depending on a type of a PHY,
> > > -		  the "phy_clk" clock can also be added, if needed.
> > > -
> > > -Example:
> > > -	ufs@fd030000 {
> > > -		compatible =3D "cdns,ufshc", "jedec,ufs-2.0";
> > > -		reg =3D <0xfd030000 0x10000>;
> > > -		interrupts =3D <0 1 IRQ_TYPE_LEVEL_HIGH>;
> > > -		freq-table-hz =3D <0 0>, <0 0>;
> > > -		clocks =3D <&ufs_core_clk>, <&ufs_phy_clk>;
> > > -		clock-names =3D "core_clk", "phy_clk";
> > > -	};
> > > diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> > > b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> > > new file mode 100644
> > > index 0000000..4509ae0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> > > @@ -0,0 +1,80 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +https://urldefense.com/v3/__http://devicetree.org/schemas/ufs/cdns,
> > > +uf
> > >
> >
> +shc.yaml*__;Iw!!EHscmS1ygiU1lA!VP17yEajmecovQs1IfNiRJklavtRgx16eZXg0
> > b
> > > +G5re3EAQrSfmirkkVpagqs5mE$
> > > +$schema:
> > > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core
> > > +.y
> > >
> >
> +aml*__;Iw!!EHscmS1ygiU1lA!VP17yEajmecovQs1IfNiRJklavtRgx16eZXg0bG5r
> > e3
> > > +EAQrSfmirkkVpEHrPgh4$
> > > +
> > > +title: Cadence Universal Flash Storage (UFS) Controller
> > > +
> > > +maintainers:
> > > +  - Dhananjay Kangude <dkangude@cadence.com>
> > > +
> > > +description:
> > > +  UFS nodes are defined to describe on-chip Cadence UFS host
> controllers.
> > > +  Each UFS controller instance should have its own node.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - cdns,ufshc
> > > +              - cdns,ufshc-m31-16nm
> > > +          - const: jedec,ufs-2.0
> > > +      - items:
> > > +          - const: jedec,ufs-2.0
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: UFS controller register set
> >
> > Not a useful description. Just 'maxItems: 1'.
>=20
> I agree. I will change the property details.
> >
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    items:
> > > +      - description: Description of core_clk
> > > +      - description: Description of phy_clk
> > > +      - description: Description of ref_clk
> >
> > 'Description of core_clk'?
> OK. I will change it.
> > ref_clk was not documented. Okay to add, but mention why in the commit
> > msg.
> The ref_clk is used by ufs spec to decide ufs device reference clock and =
it is
> part of ufs framework.
> Usually SoC vendors fix this value by using this property used by core
> framework.
> The details are already mentioned in
> Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> > > +
> > > +  clock-names:
> > > +    minItems: 1
> > > +    items:
> > > +      - const: core_clk
> > > +      - const: phy_clk
> > > +      - const: ref_clk
> > > +
> > > +  freq-table-hz:
> > > +    $ref: /schemas/types.yaml#/definitions/uint64-matrix
> >
> > Not the right type.
>=20
> I have tried with different ref as single array but it seems not compatib=
le.
> The freq-table-hz property need the values in 2D array format.
> for example:
> freq-table-hz =3D <250000000 250000000>, <19200000 19200000>, <19200000
> 19200000>;
>=20
> Could you suggest what type suits the requirement. Thanks.
> >
> > > +    description:
> > > +      Clock frequency table.
> > > +      See the ufshcd-pltfrm.txt for details.
> > > +
> > > +  dma-coherent: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - freq-table-hz
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +additionalProperties: false
> > > +unevaluatedProperties: false
> >
> > Don't need both. Just additionalProperties.
>=20
> I got it. I will change in next version.
> >
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    ufs: ufs@fd030000 {
> > > +         compatible =3D "cdns,ufshc", "jedec,ufs-2.0";
> > > +         reg =3D <0xfd030000 0x10000>;
> > > +         interrupts =3D <0 1 IRQ_TYPE_LEVEL_HIGH>;
> > > +         freq-table-hz =3D <0 0>;
> > > +         clocks =3D <&ufs_core_clk>;
> > > +         clock-names =3D "core_clk";
> > > +    };
> > > +
> > > diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > > b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > > index 4d13e6b..b8f73dd 100644
> > > --- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > > +++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > > @@ -50,7 +50,7 @@ patternProperties:
> > >      type: object
> > >      description: |
> > >        Cadence UFS controller node must be the child node. Refer
> > > -      Documentation/devicetree/bindings/ufs/cdns,ufshc.txt for bindi=
ng
> > > +      Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml for
> > > + binding
> > >        documentation of child node
> > >
> > >  additionalProperties: false
> > > @@ -81,7 +81,6 @@ examples:
> > >                  reg =3D <0x0 0x4000 0x0 0x10000>;
> > >                  interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > >                  freq-table-hz =3D <19200000 19200000>;
> > > -                power-domains =3D <&k3_pds 277>;
> > >                  clocks =3D <&k3_clks 277 1>;
> > >                  assigned-clocks =3D <&k3_clks 277 1>;
> > >                  assigned-clock-parents =3D <&k3_clks 277 4>;
> > > --
> > > 1.7.1
> > >
> > >
