Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3838C48F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhEUK0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:26:06 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:32965 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=980; q=dns/txt; s=iport;
  t=1621592672; x=1622802272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1M0MZ91MI5mA/N9mirTePd3EU+0TaqNq3Q/w0bsakvI=;
  b=lWGzKofPAb+Fz+QecTvdqbJg9unxD+Ba8Tzo38BBZjc1Ly9Fx9qTt2X8
   VOoSVJuYDOfK6AdCCrA5ABJVWUI33Cf7ZU1Oa6PGzffRRllL462HegHna
   dcR3FRYkOr6qtkJm/TohjyMAen6rXYCs3zLH3IvT+gsUN8gWF60YI5kgL
   I=;
X-IPAS-Result: =?us-ascii?q?A0AYAgAviadgl4cNJK1aHgEBCxIMQIFMC4FTUYFYNjELi?=
 =?us-ascii?q?AUDhTmIeZl5gS6BJQNUCwEBAQ0BAT8CBAEBgReDOAKBfgIlNAkOAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQUBAQUBAQECAQYEFAEBAQEBAQEBaIVoDYZFAQQBQAEBNwEECwIBC?=
 =?us-ascii?q?A44MiUCBA4NgmmCVgMOIQGeDQKKH3iBNIEBggcBAQYEBIU3GIITCYE6gnuKa?=
 =?us-ascii?q?CccgUlEgRVDgl8+aYNaAoNLgi2DdYJblBqKJ50wCiOCdJ1yEaVKhmuyZwIEA?=
 =?us-ascii?q?gQFAg4BAQaBVDmBW3AVgyRQFwIOjh8MDQmDTopdczgCBgoBAQMJfIdBAYEQA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:jXHQZBF7OAml1Zj7phvEDZ1Gfj4Y04WdBeZdwoAqh7JHbuKo+JGxd
 EDc5PA4iljPUM2b7v9fkOPZvujmXnBI+peOtn0OMfkuHx8IgMkbhUosVciCD0CoNvPmbyUmW
 s9FUQwt83SyK0MAHsH4ahXbqWGz6jhHHBL5OEJ1K+35F5SUgd6w0rW5+obYZENDgz/uCY4=
IronPort-Data: A9a23:P7rPFapPvkQoa/4IBnB52Hg6z4deBmLIZRIvgKrLsJaIsI4StFCzt
 garIBmPO6uMN2TyedgiOYrn9EJQvZHQyoJgTVRkpSgyEigR8uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkS5TE3oHJ9RGQ74nQLlbHILOCanoZqTNMEn970Eo+wr9h3OaEvPDga++zk
 YKqyyHgEAfNNw5cagr4PIra9XuDFNyr0N8plgRWicJj5TcypFFJZH4rHpxdGlOjKmVi8kFWc
 M6YpF2x1juxEx7AkbpJmJ6jGqEBaua60QRjFhO6VoD66iWuqBDe3Y46c9AeY2V9lg+Dmpdb2
 s4Rq4OhWR82a/ikdOQ1C3G0Egl3OalAvbTAO3X664qYzlbNdD3nxPAG4EMeZNJDvL0pRzgVs
 6VDdVjhbTjb7w6y6L6pQ+ZrnNkiBMLqJ4gY/HpnyFk1CN55GM2THvubu4MwMDEYoNloF6z5Z
 pMgNid2TQz/SRtBM0sNB8dr9AuvriCvL2IHwL6PnoIx6m3T3RF335DuPcDTd9jMQt9a9m6Ro
 m/W9mL1DwtcL9ye0jqG83SEgu7JgDO9WYQOGbn+/flv6HWWz3YQTgcLSV+yp/WRg1S7HdlYL
 iQ88yEroIAx+VatQ927WAe3yFaBvxgTXPJKHuE64R3Lwa3Riy6BC3QJVCxpadoorsY6SDUmk
 FiTkLvBAT1pra3QSn+H8LqQhS29NDJTLmIYYyIACwwf7LHLooY3lRvnVNtvEKepyNbyHFnNL
 yuipSw6gfAYitQGkv/99lHciDXqrZ/MJuIo2unJdmPixAFzRqS4XYatrnLJ9qpeM5eJVkbU6
 RDohPOiAPAy4YClzXLXGb9cTeDwv55pIxWH2gY+RclJGyCFvi/9I9wNvFmSMW80aq45lSnVj
 Fg/UO+7zLZXOHasBUOcS93sU5xwpUQM+CiMaxw5RtNKZp40fwid8WQ0DaJx44wPuBV3+U3cE
 c7GGSpJMZr8If83pNZRb7xNuYLHPghkmQvuqWnTlnxLK4ZygUJ5r59bbTNiichntcu5TPn9q
 L6zyuPTkUwECb2iCsUp2dBDcTjm0kTX9biv+5AIKYZv0yJNGXoqDLfq0Kg9dol+95m5Zc+Zo
 yHhCxMw9bYLvlWaeVTiQi0yM9vHAMcgxU/XyARxZD5ELVB4Ot3xhEreHrNqFYQaGBtLna8sE
 6ZdI53eahmNIxyekwkggVDGhNQKXHyWacimZkJJvBBXk0ZcejH0
IronPort-HdrOrdr: A9a23:PYjw8KkmkfcAsihBN8rrF/T3PajpDfP5imdD5ihNYBxZY6Wkfp
 +V/cjzhCWbtN9OYh4dcIi7Sda9qXO1z+8T3WBjB8bdYOCAghroEGgC1/qt/9SEIU3DH4FmpN
 xdmsRFebjN5B1B/LrHCWqDYpYdKbu8gdqVbI7lph8HJ2wHGsIQjTuRSDzrb3GeLzM2Y6bRYa
 Dsnvav0ADQAEj/AP7LYkUtbqzmnZnmhZjmaRkJC1oM8w+Vlw6l77b8Dlyxwgoeeykn+8ZgzU
 H11yjCoomzufCyzRHRk0XJ6Y5NpdfnwtxfQOSRl8kuLCn2gArAXvUiZ1TChkFxnAic0idsrD
 D+mWZnAy210QKJQoiBm2qo5+An6kd315at8y7CvZKpm72JeNtzMbswuWseSGqC16Ll1+sMjJ
 6iGAmixsdq5Fr77VfAzsmNWBdwmkWup30+1eYVknxESIMbLKRctIoF4SpuYdo99Q/Bmcsa+d
 NVfYvhDTdtACWnhnvizyVSKRyXLzwO9zK9Mwc/U+CuokxrdUFCvgIlLZYk7wI9HboGOu55Ds
 r/Q9ZVqI0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,313,1613433600"; 
   d="scan'208";a="715856964"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 21 May 2021 10:24:31 +0000
Received: from mail.cisco.com (xbe-aln-007.cisco.com [173.36.7.22])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 14LAOVuh014283
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 21 May 2021 10:24:31 GMT
Received: from xfe-rcd-005.cisco.com (173.37.227.253) by xbe-aln-007.cisco.com
 (173.36.7.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Fri, 21 May
 2021 05:24:30 -0500
Received: from xfe-aln-005.cisco.com (173.37.135.125) by xfe-rcd-005.cisco.com
 (173.37.227.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Fri, 21 May
 2021 05:24:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-005.cisco.com (173.37.135.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15
 via Frontend Transport; Fri, 21 May 2021 05:24:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bol8fqPfzBRy8m4mOntHvbdp+9MTK4hsSAOCWjz4Tv3Ah3ZXZkpM3wtz+SRC+TddeZGyiZyeLb2EzKiOIux1lEAM0kbJRRFpVFGnEqGIt19A6ZlCC0RKT3RihJY9hc2HVO17JUhUCdLLiKyWZC1wMLPQ1cLFakyiQs4sz0bh5zrWo5EJNBVMdDM0cqOURjKWES9LqfywwKoJf3cCFRLXFfMObCz6O3OeweysfuItI8QhTZ8ZQcxMTJF6eQB8t8TrJp6uihsjJdR5tNo/heyKzPq97cs4PCThuxAnzgng64UIr+jnRJNOnUueKK7P5eOkCy7y9iHhlaY1u8VcnThz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwG1yeZUPGbvIyNS8WaQIvvlss90zHn1xQAPcniUdaE=;
 b=Mc2AQRveyRDq1o6mdntqR5ddi3wBjVaRTKhJtjviBQcxLrlJsjJBIKPmxH59FBrBwLujeB6bdk7JJy0txlPFsNVfq8TN0UtvkZMB+4jk31zgM5kVAbul1LlNJKermG4aVfwRWo+MI9/RCd8Ny4IEmg+GCcFJKRpMRplS3e01sKfF1drKf45WrLaVuj1P7QTgkrPwFo6No9Ui/tPLLssfMsotmjOghM4P2aN85fhemXn/B5JEFsV1YGjSUyonyv5S59Y6cFkq+wr3ECU9OYm7XfwqIzPc4Vp0CXqYxUmTOeV1GVy89/bMRKAzZtNcOQhWi0Lmsruu2xqHn/p62gcD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwG1yeZUPGbvIyNS8WaQIvvlss90zHn1xQAPcniUdaE=;
 b=ofewaO+3+2homSLJC81VM7n6c+ui/XRaq/0kmJgNNA7YYeXJvuQkkOrJAA+UwXftsNbFNZ1TGQxPvtCRyAjJ5wHmvi9jC6Ym3K8cmO3hQVLvht4su5/s7jKl/IJvZeBnrJ0wepctsXMkbNOlhG08GT5YZ7cNoLe4Bqumi7zxucQ=
Received: from BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24)
 by SJ0PR11MB4878.namprd11.prod.outlook.com (2603:10b6:a03:2d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 10:24:29 +0000
Received: from BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de]) by BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de%6]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 10:24:29 +0000
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
Subject: Re: [PATCH v5 1/3] perf report: compile tips.txt in perf binary
Thread-Topic: [PATCH v5 1/3] perf report: compile tips.txt in perf binary
Thread-Index: AQHXTLJgj2yFOlZPtE2LzPWz23wBjKrtu4UW
Date:   Fri, 21 May 2021 10:24:28 +0000
Message-ID: <BY5PR11MB4024C5EB061A6B8BBFB485B4D9299@BY5PR11MB4024.namprd11.prod.outlook.com>
References: <20210517084604.2895-1-dzagorui@cisco.com>,<YKURoStYXwQ3FnxI@krava>
In-Reply-To: <YKURoStYXwQ3FnxI@krava>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 432c141c-5449-4767-31b1-08d91c429dd6
x-ms-traffictypediagnostic: SJ0PR11MB4878:
x-microsoft-antispam-prvs: <SJ0PR11MB487838696268E48BF264EF76D9299@SJ0PR11MB4878.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ocywHWrWloYNNkcdLlcJpfFOi9d9QkQQ+NwnrpJY/3JEhZcke2Od2asUXejeNn7bbub32GvRSF0wjz9NVQliuuHukTj7sed6Rel1gSrsPMprCtnDL2y0DcPBXGJwJANt+ZLiXs87/qdX+q6sDkWHYBhNjATpNoLGmdhw1mGGEWqu+ysWCprm3oJSBeG5UxvjABQiiC/3IBJYHkn/jvjvlBY+uajuiyCvnXtlfI1uHXmauHh+fCyHqY2i15EFb729pMF2KAJJWKH38txfNr3BS8bQD83MckyUOXpO66isv2CyKomoaUthe3ItlujCRRWhh7wT0uG9POYaagbpCz8CZTpmfg9n1Ka8yjdIyesW22cboyGe3fKvq0Ach/uQ/ZOfFIJwhXRxwM5+jFxD4lQjvm4iOwr9x6YT9ZgeCujSVYajn3eo6MdM8sJ3IwiIS6cyAPnBWkhrio4Nvrvpq9mH7r8kGBjMhTLJc1VjLw6rojy3od+/UBcjdiBwi0pnTtS2OUU3nUmwW5m7hIWlezlkP66N/+bYPvjUF87xm/2WYVJspLQ7MKScWBnPNx/blbXBsyGNQjRJWkzICjnheTWJFca4MkqgSlOzq/8vyRedHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4024.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39860400002)(376002)(396003)(6916009)(52536014)(478600001)(8676002)(186003)(4326008)(54906003)(316002)(9686003)(55016002)(91956017)(2906002)(86362001)(33656002)(66446008)(7696005)(66476007)(66556008)(64756008)(26005)(66946007)(122000001)(5660300002)(38100700002)(71200400001)(6506007)(4744005)(76116006)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gfJfOjU4tqOJ5L8eqY4QMWnm5z83hRiqV2rRyJJdFMluz+NIPpZKzN7Tch?=
 =?iso-8859-1?Q?tZiUvVKlSEOFFzUKGIVqfc6enMB3kcBwiROkbQcOJwBdPJ8vqPZNGcpuXJ?=
 =?iso-8859-1?Q?8j5Udqt6InMNl1aT3k9f4hpV2EB+Hdif1+K4vN7gdm1fW+ODxJ0LhOHlD3?=
 =?iso-8859-1?Q?SkSB5DvaHtFertml41v7xmSkvVlwCyrGhY58O6+D9bV65AaN5lwLSUjPpY?=
 =?iso-8859-1?Q?XGLLjKDot6LLSPI59dZKm5/8mhXy7gqT4vvP22pOMS+i9JMQcJytsLO6o2?=
 =?iso-8859-1?Q?LG6IbkHKqAfu5cOda4OzNzg72SHp8bj3Gt3/duK1wAIoE6Ahu1YjB8ObLc?=
 =?iso-8859-1?Q?4LzBwV1kH2UElqazbYztuO0cpTnEmZtVeH4fvPIs6tPU99aM+p26cTvg3b?=
 =?iso-8859-1?Q?m1MQYkE704fJ4kSdQFWLHq0q/LCqfRYmo0ixU69v3WdnK9UF1XE8A0scae?=
 =?iso-8859-1?Q?Dkt7Qi1tFn4ZwMImDok12MJLnS890eVceWI/Izvhd3fDPWhpcasB78pg3g?=
 =?iso-8859-1?Q?OWdz2jYLn28GIWOBbHSkdzyzRIdTpvdeBSLrPFbp3/RkC5L4jdt8/Gt1W9?=
 =?iso-8859-1?Q?++4M0wpKOcVDY5xOJBiY/W/wLOICyUl5xFUjHjl14mwoYg7EckRHmCWcug?=
 =?iso-8859-1?Q?+OTBP59UAdg5holDJAqZzg7q5o2G/T6ULCyuKlQ+sgtSTMsobaGv5bXixU?=
 =?iso-8859-1?Q?vSG1DbTbIwLEYAUS/v3CsS1/UUu78lC4kbC+0eYT4LFJZeG1mf14b8wiKt?=
 =?iso-8859-1?Q?4viSWb8WXwHgGeTmUj2e7IgI3CxUJ1HDUKxM9S2uMnP2uFrJX4cKbwINc0?=
 =?iso-8859-1?Q?EwMOh+h/nTnvQY2hSMIZaG9AjepqmDpDlV1FKlq1Bwmb0zFeM9aMD8DDdT?=
 =?iso-8859-1?Q?jz3+7FSFjhgIfBU55KIKZ+R221OFMDDuyn+EHFOk6og0gcpDqxaCJvFLKu?=
 =?iso-8859-1?Q?uIc1hG9Xk6IJCVGMaQv+8MG5T5tD8OGhTpBzVGhgdlgn4uvVSF2cJU9Lt+?=
 =?iso-8859-1?Q?VKpw3EBCDt3kx2/1iG3CsQ0OvOqug27eEMGH05zJpdaPYMxCUcnsdv3jzg?=
 =?iso-8859-1?Q?7RynSjx/dKb7dWM1g1g67QWtMUdebKKUE1oS+cG/d5TvKKUQuLIgaWzCLZ?=
 =?iso-8859-1?Q?EVHEarwZdeXQmRX3552sTz5IyYxGLWpCdyX0ZkhcWskRXiNvvRB8+rJIZR?=
 =?iso-8859-1?Q?6Q5pPrlCneegYQbE0bnLa9OKuSGykIRNLzbbOVOXz1jHVFOpT2hc1u1oOk?=
 =?iso-8859-1?Q?hnXGnlX9NDmhh766nK2x/GvuRTDiOCfA54Ej0fPlzeC9LwdteXGrU+0olW?=
 =?iso-8859-1?Q?oQjDgThkORwLkXdLGg+wi7DEZLZkcjd5IXN4A1ege5SdWDI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432c141c-5449-4767-31b1-08d91c429dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 10:24:28.9686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5e2J/tGr1eONbqtSm8aY+RMUpzQXIC8bx4fCROA7FwkB8kRsVD9N5DSp6qpsNtPdZpKiusXVHoOgK+zhAlc7bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4878
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.22, xbe-aln-007.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> that still does not solve that we set MAX_TIPS and have=0A=
> no way of checking that's still valid=0A=
> =0A=
> how about something like below (completely untested):=0A=
=0A=
Yes, looks good, i've tested it.=0A=
> =0A=
> =0A=
> static const char *perf_tip(void)=0A=
> {=0A=
>       char *start =3D _binary_Documentation_tips_txt_start;=0A=
>       char *tok, *tmp, *prev;=0A=
>       int pick, size;=0A=
>=0A=
>       size =3D _binary_Documentation_tips_txt_end - start;=0A=
>       pick =3D random() % size;=0A=
>=0A=
>       _binary_Documentation_tips_txt_start[size - 1] =3D 0;=0A=
>=0A=
>       for (tok =3D strtok_r(start, "\n", &tmp); tok;=0A=
>            tok =3D strtok_r(NULL, "\n", &tmp)) {=0A=
>               if (pick < (tok - start))=0A=
>                       return prev;=0A=
>               prev =3D tok;=0A=
>       }=0A=
>=0A=
>       return prev;=0A=
> }=0A=
> =0A=
> this way you wouldn't need array with MAX_TIPS defined=0A=
