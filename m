Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A024F375FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhEGF24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:28:56 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:15525 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGF2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4619; q=dns/txt; s=iport;
  t=1620365270; x=1621574870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IV7X+BewdDeytCfP2vPP4XISWeOXCTKgm5ZlkIyGDVY=;
  b=VLFwsSZJmbBSVcMtIjfasW9vK7EJiynofiPzaXANOZGCAq4ympBZ/w91
   9TUvtHsL26eTYTEomicSieJMQxMTp62YgaIBhZDRgBO37ed77wtxYHsz0
   bSfmLLKftkcvGZJHsAgTY2onG9LLo/Ivdw09zJxoeI6SAnPDRCi7bhbBm
   I=;
X-IPAS-Result: =?us-ascii?q?A0AYAADHzpRgmIsNJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UMHAQELAYFSUX5aNjELiAEDhFlgiHeZVYEugSUDVAsBAQENAQEgEgIEAQGBF?=
 =?us-ascii?q?gGDOQKCAwIlNAkOAgQBAQEDAgMBAQEBAQUBAQECAQYEFAEBAQEBAQEBaIVQD?=
 =?us-ascii?q?YZEAQEBAwE6BgEBNwEECwIBCA4DAgIBAQEeEDIdCAIEDgUIgmkBglUDDiEBn?=
 =?us-ascii?q?GwCih94gTSBAYIGAQEGBASFHhiCEwmBOgGCeIpmJxyBSUKBFUOCXz6EQgKDS?=
 =?us-ascii?q?4IJIoJLUygTAZcBpzUKI4JunUoQg1SLD5ZDtBcghF0CBAIEBQIOAQEGgVQ4g?=
 =?us-ascii?q?VtwFYMkCUcXAg6OHxmDPhmKXXMCNgIGCgEBAwl8iwMBgQ8BAQ?=
IronPort-PHdr: A9a23:YMh5QRx6x5NSE1XXCzPBngc9DxPP853uMwIV44ZhgLVLIeyv/JXna
 UrY4/glzFrERp7S5P8Mje3K+7vhVmoN7dfk0jgCfZVAWgVDhZAQmAotU9SIBU3yMLjhaClpV
 MhHXUVuqne8N0UdEc3iZlrU93u16zNaGhj2OQdvYOrvHYuHhMWs3Of08JrWMG11
IronPort-HdrOrdr: A9a23:UGWNfaGUb7WGvN7OpLqFPZHXdLJyesId70hD6qkvc31om52j+f
 xGws516fatskdvZJkh8erwX5VoMkmsi6KdhrNhfItKPTOW9ldASbsD0WKM+UyaJ8STzJ856U
 4kSdkDNDSSNyk7sS+Z2njDLz9I+rDum8rE6Za8vhVQpENRGtxdBmxCe2Cm+zhNNXF77O0CZe
 OhD6R81l6dUEVSSv7+KmgOXuDFqdGOvonhewQ6Cxku7xTLpS+06ZbheiLonSs2Yndq+/MP4G
 LFmwv26uGIqPeg0CLR0GfV8tB/hMbh8N1eH8aB4/JlaAkEyzzYIbiJaYfy+wzdk9vfrmrCV+
 O8+ivICv4Dr085uFvF+ScFlTOQiwrGoEWSuGNwyUGT0fARAghKUfaoQeliA0fkA41KhqAg7E
 sD5RPri7NHSRzHhyjz/N7OSlVjkVe1u2MrlaoJg2VYSpZ2Us4dkWUzxjIfLH47JlOx1GnnKp
 gZMCjW3ocbTbpbVQGQgoBL+q3iYp0eJGbzfqEygL3d79ENpgEN86Ix/r1pop4vzuNOd6V5
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,279,1613433600"; 
   d="scan'208";a="690772884"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 May 2021 05:27:49 +0000
Received: from mail.cisco.com (xbe-rcd-006.cisco.com [173.37.102.21])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 1475RmQf030337
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 May 2021 05:27:48 GMT
Received: from xfe-rcd-001.cisco.com (173.37.227.249) by xbe-rcd-006.cisco.com
 (173.37.102.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Fri, 7 May 2021
 00:27:48 -0500
Received: from xfe-aln-005.cisco.com (173.37.135.125) by xfe-rcd-001.cisco.com
 (173.37.227.249) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Fri, 7 May 2021
 00:27:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-005.cisco.com (173.37.135.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Fri, 7 May 2021 00:27:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHBrvJKgRed/G0u54u0Q+ZiNGGUw5DDP81eN0hH36aSj5Yh3TuTi+QIv+GNTTf7O2QCWOANnJLbk1N5fD5Tc/hVPjiGkN5xEYx3CrxGly/0D1en5gJ4omgzEggIcd2Sn0QqsoRA4De3lOmekfR1y9B6fjn/EUVa06fTmO6iw7avWPQl9WVDR37pWnU+jsJppyK2ZdPtbdu7I3vlFhqX2EyMJoESzODgbcht+qkgE9ampquZh9Fshb6CtV6bK95//vZeS79HDiyMHx9w7cXb9kuZTQ4ByLiwf9ytQ/uuvKDjmVs08JtATGcAK/oEo40hAkaDmkc5CtP9ZmCINO1aucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mMgLNL6nVFjg/hYZGN81w8K/yEwHnaGdY3/LPox0W4=;
 b=VypEOINe+j0dTGWFE3SEH0lZpVA1F+/DIOLkg2c6M0QYEiNVp7zehFbmJKpHnpCGzYFjzPjqm9J9WG/7xVUjtWgny6x0+hS+rQEHdHNPv1Efn9dWdauwg5C/6ZIl4127gUxTFI93qTa1TGYMwH4V3GjqxvRqpjvFDys4wYyFrpel0G+xK0MsEaQBiqAqoan0j9r9A+KHKsayNfBgITaYuMxqzO5Fbzz6Wti6DWUuZDI+GQqQu18yXEuxY68U7OM4V4AZtiXsg1rQH5+2XcHPdHMTsjWhYybNBMoRLpenuJYWARkKu+KX+E4CGN38DmOf+wI/k8fjEXkKz25m1+GBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mMgLNL6nVFjg/hYZGN81w8K/yEwHnaGdY3/LPox0W4=;
 b=Hdt7aJmUvRuEpaaM3/bW3cwF1w9GKujm2KriZ6DHRgP8dS5sNVgXkdBJABsjTgPN5uKQ4vQbasirSPZ/g8HoNCMvjXGT3doV6rgAOUKQ0s+1l4roug0Bq46b0jqgciI7DyRKvCfrAXPgyzBE4g7x/if5TTv6rD0WdI6aaG33hDA=
Received: from DM6PR11MB4025.namprd11.prod.outlook.com (2603:10b6:5:197::31)
 by DM6PR11MB3612.namprd11.prod.outlook.com (2603:10b6:5:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 05:27:47 +0000
Received: from DM6PR11MB4025.namprd11.prod.outlook.com
 ([fe80::1010:a537:8253:4025]) by DM6PR11MB4025.namprd11.prod.outlook.com
 ([fe80::1010:a537:8253:4025%6]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 05:27:47 +0000
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
Subject: Re: [PATCH v4 3/3] perf parse-events: add bison --file-prefix-map
 option
Thread-Topic: [PATCH v4 3/3] perf parse-events: add bison --file-prefix-map
 option
Thread-Index: AQHXQoqtlG0Dh8LlO0uNFVFTEV+QKqrXfQNK
Date:   Fri, 7 May 2021 05:27:47 +0000
Message-ID: <DM6PR11MB40250B31B839685B06D8A686D9579@DM6PR11MB4025.namprd11.prod.outlook.com>
References: <20210430133350.20504-1-dzagorui@cisco.com>
 <20210430133350.20504-3-dzagorui@cisco.com>,<YJQH/mlPbtdc2aih@krava>
In-Reply-To: <YJQH/mlPbtdc2aih@krava>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c6f3cf9-a9f2-4b67-8e0f-08d91118d963
x-ms-traffictypediagnostic: DM6PR11MB3612:
x-microsoft-antispam-prvs: <DM6PR11MB3612437E404A39A2C4250C0CD9579@DM6PR11MB3612.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzlNAd6OFYmpVGnCKPDADaBK2LnDsbxSd/aLtxzLdbO7WxmQs5QxLpu7XPuDnkunzB3+QwRt57uxGP3EaxtlMEFTNZpKMdC6gD+TdGkZc7YIZfxlUH5LhCjOSyO6uWBOZa98BZAEtSkPoQ72X83r1c5hErlEEW0gj80DKF3ZsW42ZxBHBEvIwBGkDMJLsf3le9ns2b1lyw6/v/rm6qhuaiuGZQixxS0PvNSfu/PDkls5DBEomhnK8+/Mpv04XGe5gL1NIe+7i4SZ/0jsA2XJkzJpp2rXctX+rYT/v2P4/1IPSh9zwuHIY1E/w+ncUOxnT5tT3uWa0WsFHkw5G1ls3O9IiI++3GIxgMGolQe1/oJrZzCPX4vofIHeYA5WC1q8q1hx+GHFjrZ3SNBE0gQ3wsHfJ5J57qd+MRytum+JRTup941sfeEiMmF7CENfsD4deKKUGyEOH666Bjo01ovdLdfN2pj/Svx7TG6vCQMVZ+RIHgZgo0DPkdOvGFPyq3UeZOE0gTi+5OkJP2L0StOmwU2/eZBUK3ENB3ntKN7lLa2W42p4V+VDeUZIhre8B4hKseRQPBr9igPbHcamgCCWNro/icB73CC4wqzkyqMSWv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(71200400001)(33656002)(6916009)(4326008)(9686003)(2906002)(8936002)(38100700002)(8676002)(186003)(6506007)(5660300002)(26005)(478600001)(7696005)(316002)(91956017)(83380400001)(53546011)(66476007)(122000001)(54906003)(55016002)(66556008)(66446008)(64756008)(86362001)(76116006)(66946007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Hz7hPfs3vhG5PIyvIhLFuExRIosKVBx9Tcq7PlsyDWfu4sdlaAaxIHJ83S4W?=
 =?us-ascii?Q?ayf7vSOPBdBVtDpRTOgKPXRFKja027sJhQARVRc+iQjb0M6y4/InnPrGvnSG?=
 =?us-ascii?Q?rB3FCaG7cmRRZN6D33mppqHkASClKCbnf3ireBhvB14gaMkTYEH4GUEJB5Lk?=
 =?us-ascii?Q?OO5EdU0a5eZtl7msSwN952WKNAIvAuAsCty4WSjzjsmimBKVE2Tok+poRdI2?=
 =?us-ascii?Q?0gXde/3H4AZPFaKjblC30Sd8J/kAgricQdUiFQS5zztPHWjoqQRvD3olTNfE?=
 =?us-ascii?Q?GryQ9lOCyzHr63I5cr+XfBtZ7kvNlFwpURykB3+Xz4MM2Ebo1Ne75XeyW7gU?=
 =?us-ascii?Q?1ssg+PdiZ+7qKL8GQrR7ZWl7D+dZY2j6mQkN8UX2ltt7p0krdnEqLc1qMUle?=
 =?us-ascii?Q?g3/eBFY0NJxLRoVuV4+28QYuoEQYwkAh6DGH5P+4D7RgsPdK3Y4iwCb7m/mj?=
 =?us-ascii?Q?ockoWMzO4d6fpw9RKighBVilL/v7ykM3wan2ylPa2f2ySDj6zcEY1KrF19fC?=
 =?us-ascii?Q?1mbjQ5bKA4feCk5Zlj3IUAkayRaNaGiKGKjRnkCSoJoHN/uJ/zY6Cspufnlp?=
 =?us-ascii?Q?GueycX4AoIAOKq96HLyj+ZTGpnSGqL/w/8s9MkRmRzIOtptIoQGFK96hI/Oe?=
 =?us-ascii?Q?9IeYsqL3tSpeAqIntv/NkmuDpf3dfejFiLvNRS1TrcG96fjqcxHmUbFtto7G?=
 =?us-ascii?Q?Rxl3MK5WYeuDjS+T0OniW53rdMUCthMxYWoG9sbUD9fQnyvsUVCVF0L23KgB?=
 =?us-ascii?Q?rpyuq73xFX4r4Q+Cid+hUxMG34At8SH77jJb2a5YFWZyh7DtgRssVWvIRd2v?=
 =?us-ascii?Q?nZrD91HzzOf73Hl0v4PBykVg3Jjs5SaP3Hn6p4yeg2agpBXCNQWAjd8pdOwf?=
 =?us-ascii?Q?veOh8T/43G2xneVivAUCJs4qdxrXnr49IM9W85Chd7c+5horGQLCb6PG/orm?=
 =?us-ascii?Q?3Cp3Uiz5CHjyA7XbVLAHYQ3B7nT44sluXhzqRGjknDmzHjXsg2Q5vT+J0pEj?=
 =?us-ascii?Q?AsgB0/uWDHg/DLYOe6HrBTF/hfCWnsrXuScx2wTb2v4v37PkdHFVni+1S26g?=
 =?us-ascii?Q?DMsAlOIbGd5/oZ4YAdux4LKwS+fGTxhur4eNTy6e2sqpqkH+KXew/RIfBoKC?=
 =?us-ascii?Q?L/IhhDA5eE6gzywstRjWjuTyLZa+eQkPEi/V2CIA9TQ29n0KTCvfo6bPOtVA?=
 =?us-ascii?Q?dazuww7MyqlOLsDCNnqjC1MWri/AGKcLlOV1apTfUWGIt0zMu4m51ff09hUa?=
 =?us-ascii?Q?yCRo5F4QrhuSGqot6VVBfVDkRyfcKiv8HK0j5+3efqAFoOSOE34pQTz96x23?=
 =?us-ascii?Q?tAo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6f3cf9-a9f2-4b67-8e0f-08d91118d963
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 05:27:47.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRMunV/RcmeYbfGw4o48i5OOxfDmIT8zX2gzid04VlP9UEYbJ1EtZpM23ii575uRUynPQu+P1/J5WC37OcTcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3612
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.21, xbe-rcd-006.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm on system with:
>
> [root@kvm-02-guest15 perf]# bison --version
> bison (GNU Bison) 3.7.6
>
> but I don't see BISON_FILE_PREFIX_MAP set
>
> [root@kvm-02-guest15 perf]# cat .config-detected | grep BISON_FILE_PREFIX=
_MAP
> [root@kvm-02-guest15 perf]#

I forgot to mention that BISON_FILE_PREFIX_MAP is needed only if we build p=
erf with O=3D .
Most probably that is why you don't see BISON_FILE_PREFIX_MAP. I'll mention=
 this in commit
message.

Thanks,
Denys

________________________________________
From: Jiri Olsa <jolsa@redhat.com>
Sent: 06 May 2021 18:15
To: Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)
Cc: linux-kernel@vger.kernel.org; peterz@infradead.org; mingo@redhat.com; a=
cme@kernel.org; mark.rutland@arm.com; alexander.shishkin@linux.intel.com; n=
amhyung@kernel.org
Subject: Re: [PATCH v4 3/3] perf parse-events: add bison --file-prefix-map =
option

On Fri, Apr 30, 2021 at 06:33:50AM -0700, Denys Zagorui wrote:
> bison stores full paths in generated files and those paths are stored in
> resulting perf binary. Starting from v3.7.1. those paths can be remapped
> by using --file-prefix-map option. So use this option if it possible to
> make perf binary more reproducible.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/Makefile.config | 9 +++++++++
>  tools/perf/util/Build      | 6 +++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
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

I'm on system with:

[root@kvm-02-guest15 perf]# bison --version
bison (GNU Bison) 3.7.6

but I don't see BISON_FILE_PREFIX_MAP set

[root@kvm-02-guest15 perf]# cat .config-detected | grep BISON_FILE_PREFIX_M=
AP
[root@kvm-02-guest15 perf]#

jirka

> +
>  # Treat warnings as errors unless directed not to
>  ifneq ($(WERROR),0)
>    CORE_CFLAGS +=3D -Werror
> @@ -1208,3 +1214,6 @@ $(call detected_var,LIBDIR)
>  $(call detected_var,GTK_CFLAGS)
>  $(call detected_var,PERL_EMBED_CCOPTS)
>  $(call detected_var,PYTHON_EMBED_CCOPTS)
> +ifneq ($(BISON_FILE_PREFIX_MAP),)
> +$(call detected_var,BISON_FILE_PREFIX_MAP)
> +endif
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e3e12f9d4733..33476b1d28d5 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -204,7 +204,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse=
-events-flex.h: util/parse-
>
>  $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: u=
til/parse-events.y
>       $(call rule_mkdir)
> -     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $=
(BISON_FILE_PREFIX_MAP) \
>               -o $(OUTPUT)util/parse-events-bison.c -p parse_events_
>
>  $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPU=
T)util/expr-bison.c
> @@ -214,7 +214,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: =
util/expr.l $(OUTPUT)util/e
>
>  $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
>       $(call rule_mkdir)
> -     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $=
(BISON_FILE_PREFIX_MAP) \
>               -o $(OUTPUT)util/expr-bison.c -p expr_
>
>  $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)u=
til/pmu-bison.c
> @@ -224,7 +224,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: ut=
il/pmu.l $(OUTPUT)util/pmu-
>
>  $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
>       $(call rule_mkdir)
> -     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +     $(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $=
(BISON_FILE_PREFIX_MAP) \
>               -o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
>
>  FLEX_GE_26 :=3D $(shell expr $(shell $(FLEX) --version | sed -e  's/flex=
 \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\=3D 26)
> --
> 2.26.2.Cisco
>

