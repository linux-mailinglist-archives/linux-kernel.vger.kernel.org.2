Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29D835C380
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhDLKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:15:34 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:34050 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbhDLKN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6757; q=dns/txt; s=iport;
  t=1618222388; x=1619431988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OhhKVAF3yfnPiWffCMklqKk06yW/jRwH//DNcz5pce0=;
  b=l4QDJ9YPYdE4Yh4q/qHpBwhI6rqKs5sB8SHXNTSWYL5oTQKjNVJ7MxRd
   BaY5T1xu0u3fyqiepCdaXnOkdbugIrtQwDsAXoFEKBlpoW4N00aAxtrgJ
   FSUiHY2Ehon0hpAzZqQN+cs5VUsHzEbCW+vmx19TOxMdC/5k9xT/b6Em5
   8=;
X-IPAS-Result: =?us-ascii?q?A0ADAAAuHHRgmIENJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+BQEBAQELAYFSUX5aNjEKiAADhFlgiFUDmTuBLoElA1QLA?=
 =?us-ascii?q?QEBDQEBIBICBAEBgRYBgzkCgXcCJTQJDgIDAQEBAwIDAQEBAQEFAQEBAgEGB?=
 =?us-ascii?q?BQBAQEBAQEBAWiFUA2GRAEBAQECAToGAQE3AQQLAgEIDgMEAQEBHhAyHQgCB?=
 =?us-ascii?q?A4FCIJpAYJVAw4hAaEMAoofdYE0gQGCBAEBBoUKGIITCYE5AYJ1ilcnHIFJQ?=
 =?us-ascii?q?oETQ4JfPoRCAoNKgiuBaWIBUigTARMQgSiVG6cECiKCaYljkzyDTYE+iTqGE?=
 =?us-ascii?q?pAas0gghFYCBAIEBQIOAQEGgVQ4gVtwFYMkCUcXAg6OHxmDV4Zxg2hzAjYCB?=
 =?us-ascii?q?goBAQMJfIsGAYEOAQE?=
IronPort-PHdr: A9a23:9eO7BRJhKJ9w8hza9tmcuZMyDhhPgJ39IxIV55w7irlHbqWk+dH4M
 VfC4el25HfTUInb4u4CgO3T4OjsWm0FtJCGtn1KMJlBTAQMhshemQs8SNWEBkv2IL+PDWQ6E
 c1OWUUj8yS9Nk5YS9zza13bvju56jtBUhn6PBB+c+LyHIOahs+r1ue0rpvUZQgAhDe0bb5oa
 husqgCEvcgNiowkIaE0mXP0
IronPort-HdrOrdr: A9a23:6x2bNqGi3Uexu/E8pLqFmZXXdLJzesId70hD6mlYcjYQWtCEls
 yogfQQ3QL1jjFUY307hdWcIsC7IE/03aVepa0cJ62rUgWjgmunK4l+8ZDvqgePJwTXzcQY76
 tpdsFFZ+HYJVJxgd/mpCyxFNg9yNeKmZrY+tv25V0Fd3AMV4hL6QBlBgGHVmh/QwdbDZQ0fa
 DsmPZvjTymZHgRc4CHHXEDRefOvJnmk5jhbB4ACXccmUizpBmv76P3FAXd4wcGX1p0sPkf2E
 Xmsyi83KWstPmn1gTRvlWy0716kMbso+Ezf/CkpdMSLlzX+2OVTaRnH4aPpTUk5NyogWxa7O
 XkhzcFE4BN52jKfmezyCGdmzXI9Do18XftxRu5rBLY0LbEbQk3AcZAmo5VGyGxgyFL0b0Ms9
 Mo40uju5VaFh/GlijmjuK4Ki1CrFa+onYpjIco/hpieLYec7NYoMg++05YAf47bVrHwb0nC+
 VnAYXg4u9XezqhHgnkl1RoqebcOkgbL1OjeAwvq8aV2z9ZkDRS1E0D3vESmX8G6dYUV4REz/
 6sCNUqqJh+CustKY5tDuYIRsW6TkbXRwjXDW6UKVP7UIkaJnP2rYLt6rld3pDpRLU4iL8J3L
 jRWlJRsmA/P2j0D9eV4ZFN+hfRBEKwQCrq0cMbw5RioLXzSP7KPES4ORUTuvrlh89aLtzQWv
 61Np4TKeTkN3HSFYFA2BC7VIJVLXUYTc0Jqtc2U1+DuavwW8rXn92eVMyWCKvmED4iVG+6KG
 AERiLPKMJJ6V3uWnKQummWZ1rdPmjEub5gGqnT+OYejKIXMJdXjwQTgVOlosWCKThItL0qbF
 JzSYmXy5+TlC2TxyLl/m9pMh1SAgJ++7P7SU5HogcMLgfzarYMu9KWfGhIx3uZLhpjT8fbeT
 Qv42hfyOaSFdi91CoiA9WoPiaxlH0Ivk+HSJ8ah+me/8v/Y4g5CZwnQaR1Eg3OG3VO6F5XgV
 YGTDVBal7UFzvoh6ngsYcdA/vHccJgxC2xJ9RPlH7ZvUKAhM0mS3cBRQSyWcqPjQtGfUsOun
 RBt4skxJuJg3KGNHY2iuVQCiw8VE2nRJZ9SDmjSKoRsLbxYw10RXqNnlWh+mEOU1uv0V4TiG
 znJTCTYtfRDDNmyypl+5ev1k9ofWOAeE81TXZ2veRGZDj7k0c29/OXbayu1GbUUH8++6U2NT
 HIZiZ6GHIy+/m+yAOVlDGeFX8v25UpOajHAK4+dqzIs0ndW7GghOUIGeRZ841iM82ruugXUf
 iHcwvQNz/gDfg1sjbl60oNKW1xqHM+l+nv1wCg5G+k3GQnCf66GiUse5gLZ9Wd5XPjXfCGzd
 Fwis80p/K5NiH0ZsSdwa/aKz5FJRW7mx/9c8g47ZRVt7k1rr19At3SVibJzmhO2FEmN9jv/X
 luNphT8fTEIMtibsYScyVW8h4gk8mONlIitkjzDvUldV8ggnfHN7qykvb1gKtqBlfEqBr7OF
 GZ/SEY5fvDUieZ3bMRCq47Iw1tGQABwWUn+PnHe5zbCQ2see0G4UGzNWWldqRBDKeCArcdo3
 9Bkp61tv7SczC93g/evTF2eP0Tt2mmRN6/GwKKF6pD9cegNVGFn6ut54qygV7MOE+GQlVdgZ
 cAc0oaKtlHgH0lioY81yCpUKz5ok4/iTJlkHhav0+o3pLj+XvRGEFNLBbQjZpXVyRCK3Tgt7
 WxzcGIkHDmpCVf0ZbNFE1MbshDFtgZQI/wNTpvI6ErzcmV1rtqhD9CbhcoB3M9jz643/oO58
 bK5Mnv
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,216,1613433600"; 
   d="scan'208";a="719008823"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Apr 2021 10:13:06 +0000
Received: from mail.cisco.com (xbe-aln-003.cisco.com [173.36.7.18])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 13CAD3kP003137
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 12 Apr 2021 10:13:07 GMT
Received: from xfe-rcd-002.cisco.com (173.37.227.250) by xbe-aln-003.cisco.com
 (173.36.7.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Mon, 12 Apr 2021
 05:13:04 -0500
Received: from xfe-rcd-002.cisco.com (173.37.227.250) by xfe-rcd-002.cisco.com
 (173.37.227.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Mon, 12 Apr 2021
 05:13:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-002.cisco.com (173.37.227.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Mon, 12 Apr 2021 05:13:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxXobkMnpFAs3Bz1QXsgzhGv0QaLRyddDvaU1SA3crlc2NjVWPA978F97dNNb7BJ5dmkBI1vmXyvit9vQ3a/uOdLa8+wTt5n7EXjV/MESDVLhBhwF9k4O4OBEJxf5/SbiySSHht8INNyW/kz3/2xg4D4M7lEv8VIkC3+B9GM6f+jUcKw3IybFMtfZb+wNnGTqWCEqHcV7zMOSwMDrlBE7QanTnMH0dYQQWUh5jQYHM9qE0L3P8tZtXuCk/gYxzPj1B4XdrvlW/iqivnHywvjYp5ZGkROI2yfAvvpi0kKYEprXA/AEVzn6WVnVjkKyGSa2AvoyVAltij5NdrEOiBsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJmDzMaWgJ5AVGDfe+dJfhId2PyQJSSPAjACFpPfFDg=;
 b=dfPlCMoOP7tlR3ymNiZ2imCYknybYLnOHq9Tr0P0RfIesxYSlWOCbz9lFUoRVMlwKwY8yIbyDj6k+rYa+9ZoKuXvabEZLbCtsJEDHzuoZhZ+VQ1EiUWjAA3/STa5qGuS2D7uuFz29fCEPGaAozm5FN58Kg4vhICAMtAAcI921uHBSQmzhbyZzIbUK1tYZBIYoI8ZtCk3fhMcaAl+EHWVxLa9Qi8+f8A3RRwFzxRnwN33NZTBB6VXirDgOfe2JAjwRsccz6L8guZk1EA86xO3mmAEEptwLh5Ll3M15c7XScnfW5dO/3/mssEX95Cl09Oj4QM/hEIISpQ46amHOqa/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJmDzMaWgJ5AVGDfe+dJfhId2PyQJSSPAjACFpPfFDg=;
 b=yM2p8MfkgPbfkksDsQIjH9GYSs89J5KMZaH7ghG/bQF36fd9AS98UMeM9BZ3ZEXDO6MeC8oS94D5GdaynDaw5/Y2XjcJOHoQxpHNb+4qyZPcWZKGh/mtgaOXbsbwV0eXX69478SEzVYqCSG0gImEzBiMz/BeJ2QjQXsn3uQEbBk=
Received: from BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24)
 by BYAPR11MB3464.namprd11.prod.outlook.com (2603:10b6:a03:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 10:13:02 +0000
Received: from BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::6505:b3:4118:8336]) by BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::6505:b3:4118:8336%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 10:13:02 +0000
From:   "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3] perf: build reproducibility improvements
Thread-Topic: [PATCH v3] perf: build reproducibility improvements
Thread-Index: AQHXLUpNV2xHzZMFC0+D9RZWWX2tpaqwrO6U
Date:   Mon, 12 Apr 2021 10:13:02 +0000
Message-ID: <BY5PR11MB4024A363D492D6B444C661B0D9709@BY5PR11MB4024.namprd11.prod.outlook.com>
References: <20210408125135.8445-1-dzagorui@cisco.com>,<YHBgmopzUg4cMQhs@krava>
In-Reply-To: <YHBgmopzUg4cMQhs@krava>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 576cf4e0-d3b2-4fbd-76b6-08d8fd9b8e67
x-ms-traffictypediagnostic: BYAPR11MB3464:
x-microsoft-antispam-prvs: <BYAPR11MB346475CFC0F38C542E1F9490D9709@BYAPR11MB3464.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sPEyPc/LMRRM/+CWSW9ZDz1TtbNCnw2PpxeASKQ6mDnwNs2m3ZYGtj48EAiU/viBg9o/V3rBTeLYtrmOqZZ/TgIH/TWpAlHGmxRGnUl8G/dMN8dKoADkKGjRPGSIFpj3mThslC2oUVNsfhoObYUrU+ZqBqYXB09+5HxcMhOF7ECmCb2X+1wO4TMaElAjHEwT9NCRSw96bZYDdrmUmFZCgsZEu1yyGDFhtHtuuNXN4uI31LUeGr0zevzTMvqC2sHXl9GcHH2wbSmuP1PtazNCON4xTLlnpVsRmroZujlff5UiG64+ejR7GmJBOEs+gYJaXONDeBqn3OYCxr5DsEIjvDQnnNyE7l2sAvlyzKY0Mh7ZSS4Zr2Zf3A7C1BIsl9uSu1UXehfZmR9Vr9wEkzMuEM2wju1dril8MUkX/G8A0f3xv2wTFOfw8AVt0+AYwxsBeOI5Ibz1jsMCZCDbCkbPaxb93RgdeOtSwcOFN7FQz3e2yH8EqLnz83hloiUcG4x7oUUPHiuyXqZT/G3+s0ZzZD7OO5+f1MW4/ag812z2u6pMTCSkgIpgwzwd351jRFhRj+vtBGjpZjPVdaD95aQU+nypjqIGC9RLl7gHtsXhuhk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4024.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(7696005)(2906002)(71200400001)(54906003)(478600001)(6506007)(33656002)(53546011)(83380400001)(4326008)(86362001)(316002)(8676002)(91956017)(66946007)(9686003)(66556008)(38100700002)(5660300002)(186003)(76116006)(66446008)(6916009)(26005)(66476007)(64756008)(8936002)(52536014)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Sb3X78pFQzXH/2PW4gdU8ionMC9Y/RT55g/9Thr4tovdJ0DIwhoSr60BddM/?=
 =?us-ascii?Q?Fg2yxEilcbY5g9nsI0HLsl7VvVtF4xYE4V7cqMVG07Bm++CXfgpLZJ5AQKYq?=
 =?us-ascii?Q?1aId2V8DazZWEsWu4Ib/LkI7PBqOieCTGKxeDFVDdB3ReHTzDkyeSJ1y//CR?=
 =?us-ascii?Q?bh2hwVEBHLImqVJh5H3Rraist6Objbqu4W8iHMygzmJLf67VvJwirocGlHE1?=
 =?us-ascii?Q?PgkQcdhh0aRGAkS4nRqyx3/PbkWJASP4JjA+CJyMKTc8ekNG7p+7WH/5om+y?=
 =?us-ascii?Q?6KSG0CvybyVaSkT0os/tHkOGBnvpMK3RRZr69arBTZfzA4Swg4D4W4NrEKs2?=
 =?us-ascii?Q?SnJwG+puTmGDt3aVE2mdJ+VT3SGePjsWe/ggI6PCz3XHnyTj3JuvToIO7wWL?=
 =?us-ascii?Q?CpmsNcy85d+i9LMqrF7xSCuB03vrbJvqgJ0BZZYt4FcSOmEyyqAMTCMNgsC1?=
 =?us-ascii?Q?G4YhtJiBH6L7sHR28XeRpUpg2J3E+Ic8XwHWMytcoUSAnZ1EhTFAJnV89bKJ?=
 =?us-ascii?Q?F/0LbLYNELR+D3zD1LPnR0v+yEFw6JNHnbbUTUNtDyneKsDEOlO0g9bhCe+R?=
 =?us-ascii?Q?yiRDEAsglT0Qk9d8lIbmNJTTKodaKp03kd9VEcb0ubQ2TSiEprlUl1gH/5v7?=
 =?us-ascii?Q?T5WF+bV6W5z2nU5IVDkad814XnVmKwHsllDXLCp+w3vnTSeWqUi7CdTbiaIB?=
 =?us-ascii?Q?E3B8WniHD7KBV6jpoPwodkr600BVDdUJQ187h4mMXOn1pb9SaljGY4t0O8vl?=
 =?us-ascii?Q?HBetPbTx5I8go9XILAEbKXBeVGuk1EXjBi4JUqApXjhivyUubGpB0mPZpgOm?=
 =?us-ascii?Q?GudljQMgnoppy9FXJAotQQ98ah1CiX6Jy9g8s1PjauNS3C2baHYjbxixUN3N?=
 =?us-ascii?Q?kI9sRKZbvPa52IIb0WsZs4flZVWg1kjpFfaYBeLRAUQvfQQgxRTuP5+uHXzK?=
 =?us-ascii?Q?ZjwWEdX2Fh/BpC0853GYJTsn/25sjJJwhSBh92IUu9adTTP7pbqJqMBnApDE?=
 =?us-ascii?Q?jTOcEHncnEMfbKQ0WG5DJtjJEODGaW9J+aqP3sefXVXWPWaLAtcHFki+rcpI?=
 =?us-ascii?Q?HBMUA/yihU6JF3gcrP5cx+j1TGeZZZA3ThICYu3KHPZt0eSK59NBGdMRX3cm?=
 =?us-ascii?Q?ok9eqRFvguDGyJugPWNLhGJh1j0FMx0F7hn4FV0RbfpMhdgXMqjwg5uDGJbH?=
 =?us-ascii?Q?K4qUBvHS5HscsBgDvjwPR3RZ6+MHarc3lXlF+haCjd15RoMGW9AzhZDQ9Iya?=
 =?us-ascii?Q?uwddy6IDKRrdORF7As3vzEIm3PUDcPU0McEjaC2RxREUdPtZzzR7qf6V2Bf2?=
 =?us-ascii?Q?+N4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576cf4e0-d3b2-4fbd-76b6-08d8fd9b8e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 10:13:02.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUCA6jhmXXNNlaepIOaeKTLzsohhS39dkzpcAT9i8SXr58ILi9/bhQhR4eiebN1qLgS/KDwi+xoaHA6XsGcdoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3464
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.18, xbe-aln-003.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +int perf_src_doc(const char *exec_path, char **strp)
> > +{
> > +     FILE *file;
> > +     char *line =3D NULL;
> > +     size_t line_len =3D 0;
> > +     ssize_t nread;
> > +     int ret =3D -1;
> > +     char *config_detected =3D NULL;
> > +     static const char srcdir[] =3D "srcdir_SQ";
> > +
> > +     if (asprintf(&config_detected, "%s.config-detected", exec_path) <=
 0)
> > +             return -1;
> > +
> > +     file =3D fopen(config_detected, "r");
> > +     if (!file)
> > +             goto out;
> > +
> > +     while (!feof(file)) {
> > +             nread =3D getline(&line, &line_len, file);
> > +             if (nread < 0)
> > +                     break;
> > +
> > +             if (!strncmp(line, srcdir, sizeof(srcdir) - 1)) {
> > +
> > +                     if (line[nread - 1] =3D=3D '\n')
> > +                             line[nread - 1] =3D 0;
> > +
> > +                     if (asprintf(strp, "%s/Documentation", &line[size=
of(srcdir)]) !=3D -1)
> > +                             ret =3D 0;
> > +
> > +                     break;
> > +             }
> > +     }
> > +
> > +     fclose(file);
> > +out:
> > +     free(line);
> > +     free(config_detected);
> > +     return ret;
> > +}
>
> it's lot of tricky code because of one file, how about we compile
> tips.txt in perf binary directly? it might be even less code changes

I'm not sure about changes size, but anyway i agree that it makes more
sense to compile tips.txt in perf binary.

________________________________________
From: Jiri Olsa <jolsa@redhat.com>
Sent: 09 April 2021 17:11
To: Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)
Cc: linux-kernel@vger.kernel.org; peterz@infradead.org; mingo@redhat.com; a=
cme@kernel.org; mark.rutland@arm.com; alexander.shishkin@linux.intel.com; n=
amhyung@kernel.org
Subject: Re: [PATCH v3] perf: build reproducibility improvements

On Thu, Apr 08, 2021 at 05:51:35AM -0700, Denys Zagorui wrote:
> This patch helps to make perf build more reproducible
>
> It seems there is some need to have an ability to invoke
> perf from build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR contains an absolute path to kernel source directory.
> This path can be read from .config-detected that is stored in the
> same dir as perf executable.
>
> There is also python binding test where PYTHONPATH is used to store
> absolute path to python/perf.so library. This path can be
> also determined in runtime.
>
> bison stores full paths in generated files. This can be
> remapped by using --file-prefix-map option that is available
> starting from version 3.7.1.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/Build              |  1 -
>  tools/perf/Makefile.config    |  9 +++++
>  tools/perf/builtin-report.c   | 13 +++++++-
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 14 +++++++-
>  tools/perf/util/Build         |  6 ++--
>  tools/perf/util/util.c        | 62 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/util.h        |  5 +++
>  8 files changed, 105 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/Build b/tools/perf/Build
> index db61dbe2b543..56d0189f1029 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -45,7 +45,6 @@ CFLAGS_perf.o              +=3D -DPERF_HTML_PATH=3D"BUI=
LD_STR($(htmldir_SQ))"   \
>                             -DPREFIX=3D"BUILD_STR($(prefix_SQ))"
>  CFLAGS_builtin-trace.o          +=3D -DSTRACE_GROUPS_DIR=3D"BUILD_STR($(=
STRACE_GROUPS_DIR_SQ))"
>  CFLAGS_builtin-report.o         +=3D -DTIPDIR=3D"BUILD_STR($(tipdir_SQ))=
"
> -CFLAGS_builtin-report.o         +=3D -DDOCDIR=3D"BUILD_STR($(srcdir_SQ)/=
Documentation)"
>
>  perf-y +=3D util/
>  perf-y +=3D arch/
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d8e59d31399a..2035bae6d5c5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -195,6 +195,12 @@ ifeq ($(call get-executable,$(BISON)),)
>    dummy :=3D $(error Error: $(BISON) is missing on this system, please i=
nstall it)
>  endif
>
> +ifneq ($(OUTPUT),)
> +  ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's=
/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\=3D 371), 1)
> +    BISON_FILE_PREFIX_MAP :=3D --file-prefix-map=3D$(OUTPUT)=3D
> +  endif
> +endif

please move all the flex, tips and python changes into separate patches

SNIP

> index 98c6d474aa6f..930aa4c6264e 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,16 +8,28 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include "util/util.h"
>
>  int test__python_use(struct test *test __maybe_unused, int subtest __may=
be_unused)
>  {
>       char *cmd;
>       int ret;
> +     char *exec_path;
> +     char *pythonpath;
> +
> +     exec_path =3D perf_exe_path();
> +     if (exec_path =3D=3D NULL)
> +             return -1;
> +
> +     if (asprintf(&pythonpath, "%spython", exec_path) < 0)
> +             return -1;

please check if the pythonpath exists and don't use it if does not..
with perf from rpm and python perf.so module the path is already there
so we don't care

SNIP

> +
> +int perf_src_doc(const char *exec_path, char **strp)
> +{
> +     FILE *file;
> +     char *line =3D NULL;
> +     size_t line_len =3D 0;
> +     ssize_t nread;
> +     int ret =3D -1;
> +     char *config_detected =3D NULL;
> +     static const char srcdir[] =3D "srcdir_SQ";
> +
> +     if (asprintf(&config_detected, "%s.config-detected", exec_path) < 0=
)
> +             return -1;
> +
> +     file =3D fopen(config_detected, "r");
> +     if (!file)
> +             goto out;
> +
> +     while (!feof(file)) {
> +             nread =3D getline(&line, &line_len, file);
> +             if (nread < 0)
> +                     break;
> +
> +             if (!strncmp(line, srcdir, sizeof(srcdir) - 1)) {
> +
> +                     if (line[nread - 1] =3D=3D '\n')
> +                             line[nread - 1] =3D 0;
> +
> +                     if (asprintf(strp, "%s/Documentation", &line[sizeof=
(srcdir)]) !=3D -1)
> +                             ret =3D 0;
> +
> +                     break;
> +             }
> +     }
> +
> +     fclose(file);
> +out:
> +     free(line);
> +     free(config_detected);
> +     return ret;
> +}

it's lot of tricky code because of one file, how about we compile
tips.txt in perf binary directly? it might be even less code changes

thanks,
jirka

