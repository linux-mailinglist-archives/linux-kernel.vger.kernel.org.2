Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF823AFD46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFVGwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:52:01 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:59227 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVGv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624344584; x=1655880584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FCvuiNnP85JjR8KSwCR3j1c7u/SldEY+M55oNdUb5wk=;
  b=zEsaPrk8SZYmgHlTr5Tvx0Y3GpgRNsB4+NuuhYiCIlXqtuFNkUVxTBeN
   gbypRHiifVZgzMV5MObIM/DFWEr8yCzmE3JcaLQ4Fnjb/50P5BM4CILLu
   iIXr6CRTDEImcZVUPy8KSRHxDUOTVUS+c8Ihh/m2kr19grzxY4GFFWo9B
   GbuZRawXZM3v6Xw8UfmXqCO4iwC/V8W0vnZ58o+OWnl/K1KaasOqfkyZq
   Yf2BIjyCZlVoxHaFW2F5PqOdQeh8hkKm1O4lLaL2bOO+HsDX1ZzGxWnZC
   GvGTp7+nKiqSS7vK0vEIC8c5jSzedyuSWB9ssUrrlYVQ96rZe3bY5pN1K
   w==;
IronPort-SDR: usf5bUuiAp271Gs9hWc5qTrzAjuKM1hDeguQGFmswB4PvVIj6sqVt24UtzT+iHkRGli3DlOFCQ
 jbCmGZ9gv8KgCKBbgRDu12UzZ6930lPDUoQ0pKhdM9Lu4dPGUXmjUr/WGW0zcRlmC8duBToRWY
 Z5mK1+VJIYypy5eAH5K5nmG8U1ngjFQTTbR0e1Q+EjqNrYNGkTqM3wX9PKmQzrHTNh9ItwB8y5
 7S23KkROGw/BFZQ3c0O0JqyFTvsXdoTEvFnoPgnxvUmtNeSGvAansQI7u6GaVTNX5QUq0b2g34
 dlQ=
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="33331538"
X-IronPort-AV: E=Sophos;i="5.83,291,1616425200"; 
   d="scan'208";a="33331538"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:49:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZruUYYKME6Ep21yFHhtB+XeTRmtxSUPoAn+rbOKHhzNE4iRKxaBZxlDbg4uEPYSHQgpMOFo5lZjQppsTx0tUMUanotRVVHHirRDUdrZSzxhoPuhEWjaiB12ee3e5ul3bjKGjVGrz4mMXxXfyWp1NL84T7c9kGodMf5ZwdR08xOCiJZytfamrCpYG5bf6m6+ey7ABBrXEI8eHGKvQbrSwq80y1oZsqHm/rJeegSP71SK9KbwGUInkSG3Vv8DBZtrualr+wKegiLMFynciJSE4y/ZMwSkRCPyYqUJofVMf+aV7ra7jcmy9glXWhcun9K1VSTvLmbKxNAHAm5Jt2g21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w6h1kBOX6IFyNM46NdNDWo69A/2VewUOp5dm6B66C4=;
 b=iviZMr6eowF6jprlFXGGwh0qiN2LLJixjYkfdUuXf79ZKRtGQII769Lq9yaNe9Uu+m8Mxn6sdOIgM6hk63ZxEaif2bQKeMyZ8yqWgsv1F5MiKzo82RS2VZ0cmEMPOr2d7XERtvTjkeMSTmFhxP8WQW4ULgqwkmqWr56VOpQdP9ZijIsdODSHpmVDvGq9w6ef81i6TKKGSz55bcFrF8YS0f4cTkNVIBOGKG2b3Gfl/cmFKS/0YbyB7KFoB4pIJVknM82Q5Cy9+89ZPY9JwYW9afSzJ+KmB54ZJvQ1G//7RX9vicptMKzRXgAjznu42zOBsgmd9tWAmN2u0UHwkxl4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w6h1kBOX6IFyNM46NdNDWo69A/2VewUOp5dm6B66C4=;
 b=R/KzxjhRXoDw7lbnNKEv655yQrOKKjLgeG9yQbqk6crJKxyBhQXgrpbo9gK1kqKjSXhas3VR4em9ZvLJvjKa2wvTTTHRElMTKz0D8KxswRAV9/CQZ2lzdtJp6owp/MVevC7jd0RBKDGFvLjiUuXUeA0XGgrc/7st/v14S1Ark6s=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OS0PR01MB6148.jpnprd01.prod.outlook.com (2603:1096:604:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 06:49:34 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::70e1:11ff:3bd1:b440]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::70e1:11ff:3bd1:b440%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 06:49:34 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2IspgAAJjxoAAIq+F+AARwywABYd9iwABIB9liw==
Date:   Tue, 22 Jun 2021 06:49:34 +0000
Message-ID: <OSBPR01MB21836F532CA384C7378C1284EB099@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>,<20210616125452.GE801071@lothringen>
In-Reply-To: <20210616125452.GE801071@lothringen>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-06-22T06:49:33.346Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 832946e6-7c19-4e69-de8f-08d93549e50a
x-ms-traffictypediagnostic: OS0PR01MB6148:
x-microsoft-antispam-prvs: <OS0PR01MB61480B795A2F90DA1FE8DC01EB099@OS0PR01MB6148.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCXQcgCzcBhv0ndADPueXWMbtufc7wKWRbNCj+zKJCXiCCKwNcDSAwWzIg0P6w7nOFsTitJnC9LLs5J9oxKuqpX+R0jY++CcR6OGiz8hpQCZpBsWlu5ZfejaxuL90aIrb9p/D10gcEOfz0+6g5TjU8T9ftF02+bh8Tw/Pj27R2b6mGAZUG37+/w5PLPceuFdG9SOxcpMZkjYQSd6GBv5Bw44rYjE/R5IcrN2k/Smlew5udKM8OyQdGRZcQ9S1rYacJgIu8DYQ1mlgJMM0kPOZQr7S8X6TZF/bQNXtSK1iynZ9/3bCpRfSIVOc108oXfIxWhSpvw7gk49jOHe3cBYjEKVs25VQajCaIu0N7lPG9BJA89Tc9fXTRRdafakPaThSgo8j9rmCaFkoNANHsS1tvkY8LJfw7Fwl+mcjDdOXYbTHWO+dO9TiedDtivdP/y3W2U5dva9cAqF4TFuI5yhQVYtOUe5RR5PS8v2+i16Cca/P10dMViJ7W/ZqUxwIhjaGOzczlTH2sepNI1+kqbN2XHQDOx5FgC9FJ5vtcSUdVcL9xXZEa03juYMsf8Jc1CzN/tJ65FYr1b35qyC4cfJmklIV5PKHkRvHRNg4MLqPJVey+zcRLpAhBnnil4u/vZsOVAEvIVvQioPDWfMeJ8stQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(85182001)(5660300002)(2906002)(52536014)(8676002)(7416002)(4326008)(71200400001)(186003)(38100700002)(33656002)(86362001)(122000001)(26005)(83380400001)(66446008)(6506007)(66946007)(76116006)(54906003)(7696005)(8936002)(110136005)(316002)(66476007)(9686003)(66556008)(64756008)(55016002)(478600001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?a1JnaVNwSUdPVGdiUlJzTUtLSVgrbk1LL3ZSa20rQkxLYitpd280di9E?=
 =?iso-2022-jp?B?VmJ2RmI4bmVMWWNiZVAyUjZieGhFdGZCRXNvZ24xQStsNy82a2h6MDRX?=
 =?iso-2022-jp?B?eWlwUUdsTS9iQXR5RFJqZHIzNlBEZm9XYVNmOGNpWmh0SG1JRlpOYUJS?=
 =?iso-2022-jp?B?Nnd0SmczWGR1c1h5aTAxaXlBSkoyTkdJbllrcmRSWW15Y2xBVGZpQnZW?=
 =?iso-2022-jp?B?cDkyTko5ODBxbG9EN2Rsb3QwTk8zV2RLSlU5WFhnbFBONHRVcmxsSEVi?=
 =?iso-2022-jp?B?bkwydlMxUEszdmVuYjROVWE5NlJLTWxsNEZtbFZhV0Z6RFNzRDJ6K1E4?=
 =?iso-2022-jp?B?YWxpVHhoUHdxTEI3ZFVHK2FFZHpvRDV5N0toejhobTQwY2N1VDBJYThX?=
 =?iso-2022-jp?B?WlJFbTdyQUErQk9SVmY4NGNQUXJkRVZyNDllU1B2bmdvMzM5Q2ZRdGoz?=
 =?iso-2022-jp?B?TExQdDl0MTYrcTBZRTViSFpYSit4QjB1SWJOcVdKaDVXWDVCTnAzbXJi?=
 =?iso-2022-jp?B?dXIxRVVGVEFzWFVuazNZenVOYU1maUp3Tk15ekdMRkpVOXUwUU9BaUMr?=
 =?iso-2022-jp?B?WVlCRXZvdkl6MHlqYXpjN2JnNXVTSGhmTVR3R0Z6SE1EOHJyOVZTajE1?=
 =?iso-2022-jp?B?TlJjSjJpQWtDNXNkT2liYXhzN0RQUUh6ZjJVdmtwNTN2aEQvRVVYT0lx?=
 =?iso-2022-jp?B?K1B5MG9yYTd1VjRjWCtjNkxHeGZCZExqZ2h2MlJLVUhSbDVBOTAyamdJ?=
 =?iso-2022-jp?B?clBQZDhHRTRnNnlvN0tmRDlMRnlwaVlEQzRXL2VQNmgweU10RnhLNmhz?=
 =?iso-2022-jp?B?SGwxdGJaeGk2eXJpdzY1bjlGaGZram9DQTlZdnVnVzIvbHJCSkJQNVBM?=
 =?iso-2022-jp?B?dWIzLyszNkI4YzZRZlFxSURaaEFtdFRoZkFrWkhkRHZsRGRFMUFwRVhs?=
 =?iso-2022-jp?B?NVdJZ2NJT1VOdzdENlBWbTQrR1B4RHRveExQcWdBTVV1WEdNVVhyV3M5?=
 =?iso-2022-jp?B?MytzWUZhYzdTZjZ6aWwzQjVhblFybTV2eCs1dU0rbC90U1FPUTBBLzdY?=
 =?iso-2022-jp?B?VFFBOHRzVlVNY3FMNG9sMFBTZmo3WFBaWk1MbzlEZXFrNTBzcVpnZy9N?=
 =?iso-2022-jp?B?WHg4dkFycU43Zy9UK05UQWZEaWp4UEdNMytPRmxKNCtTSHRGUTJZbTZG?=
 =?iso-2022-jp?B?R1ZTVG1zbjN5UTA1SnZrV0Z2OFF5dEtVZXVIYkdCSlZpeUhjUGptN0xx?=
 =?iso-2022-jp?B?dFU2VzBIbFN2WDQ3MzUvNFFxTVhkd3oyTzlRdko5S1Yva2plek4rbXpw?=
 =?iso-2022-jp?B?Ri8zZmRKTUk2ZVFnTHVwQVcybjUrY2oyTmJvcTc2RDU1aksvc2JLZUVR?=
 =?iso-2022-jp?B?NmNQQ3F2bnFmR3lSMFVXZEtWQVMxQkErejlId1RqUWthUVVXSFlhYnQv?=
 =?iso-2022-jp?B?K2RlVy9zR1ZMemNkRHRGY1ZoUXN2K1VBRjlWaWwwYmU1dThmdStna29X?=
 =?iso-2022-jp?B?RnBkQVNEN1pIelEzbGJVVDgzT1JKcTNxbHBmWDdteVFlM2NQU09hL1lt?=
 =?iso-2022-jp?B?OUsxT1FtRkg2VTZZNnZXMTJXTk9jTkR6eGcvendSb201YlA0cm9Rc3Z2?=
 =?iso-2022-jp?B?UUY4UEtsZ1M4R2Q5Z21rSkNzZitrTzdTcmtiVTJKekN2NU5CQjhRV1pz?=
 =?iso-2022-jp?B?SmpuUnduVUFRbVJ0T2JpNTlCMFFQOXdTOEV0VlEwRjdqdTZkWFNBTkVB?=
 =?iso-2022-jp?B?YnN2RE11RU1NSGx4UEt3OGpwZElidTJjamkzTkorakthOFM4VlAvUEs5?=
 =?iso-2022-jp?B?bUcxZ3RHMFNXY2VSbUl6R1Vqd2dMMlJTOGxFcEl5OXNmbTViVWhMUnBh?=
 =?iso-2022-jp?B?Tm8wM0JuaGRkL3dJL1ZRMktGRjUwPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832946e6-7c19-4e69-de8f-08d93549e50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 06:49:34.0885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Llta93uQnncsq0ewYCiZNUfcLo5ZJ95GFi0mNaxRU3/24qbykykXVpKPXRidN4WJ6JGznef/B0xwFItyHEKyhl5ezHjomsWjF8xtqCvpUDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic, Peter, and Mel=0A=
=0A=
> If necessary I guess we can do something like the below, which=0A=
> would only add the overhead where it's required:=0A=
> =0A=
> diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.=
h=0A=
> index 6c9f19a33865..ce3c58286062 100644=0A=
> --- a/include/linux/sched/cputime.h=0A=
> +++ b/include/linux/sched/cputime.h=0A=
> @@ -18,15 +18,16 @@=0A=
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */=0A=
>  =0A=
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN=0A=
> -extern void task_cputime(struct task_struct *t,=0A=
> +extern bool task_cputime(struct task_struct *t,=0A=
>  			 u64 *utime, u64 *stime);=0A=
>  extern u64 task_gtime(struct task_struct *t);=0A=
>  #else=0A=
> -static inline void task_cputime(struct task_struct *t,=0A=
> +static inline bool task_cputime(struct task_struct *t,=0A=
>  				u64 *utime, u64 *stime)=0A=
>  {=0A=
>  	*utime =3D t->utime;=0A=
>  	*stime =3D t->stime;=0A=
> +	return false;=0A=
>  }=0A=
>  =0A=
>  static inline u64 task_gtime(struct task_struct *t)=0A=
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c=0A=
> index 872e481d5098..9392aea1804e 100644=0A=
> --- a/kernel/sched/cputime.c=0A=
> +++ b/kernel/sched/cputime.c=0A=
> @@ -615,7 +615,8 @@ void task_cputime_adjusted(struct task_struct *p, u64=
 *ut, u64 *st)=0A=
>  		.sum_exec_runtime =3D p->se.sum_exec_runtime,=0A=
>  	};=0A=
>  =0A=
> -	task_cputime(p, &cputime.utime, &cputime.stime);=0A=
> +	if (task_cputime(p, &cputime.utime, &cputime.stime))=0A=
> +		cputime.sum_exec_runtime =3D task_sched_runtime(p);=0A=
>  	cputime_adjust(&cputime, &p->prev_cputime, ut, st);=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(task_cputime_adjusted);=0A=
> @@ -828,19 +829,21 @@ u64 task_gtime(struct task_struct *t)=0A=
>   * add up the pending nohz execution time since the last=0A=
>   * cputime snapshot.=0A=
>   */=0A=
> -void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)=0A=
> +bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)=0A=
>  {=0A=
>  	struct vtime *vtime =3D &t->vtime;=0A=
>  	unsigned int seq;=0A=
>  	u64 delta;=0A=
> +	int ret;=0A=
>  =0A=
>  	if (!vtime_accounting_enabled()) {=0A=
>  		*utime =3D t->utime;=0A=
>  		*stime =3D t->stime;=0A=
> -		return;=0A=
> +		return false;=0A=
>  	}=0A=
>  =0A=
>  	do {=0A=
> +		ret =3D false;=0A=
>  		seq =3D read_seqcount_begin(&vtime->seqcount);=0A=
>  =0A=
>  		*utime =3D t->utime;=0A=
> @@ -850,6 +853,7 @@ void task_cputime(struct task_struct *t, u64 *utime, =
u64 *stime)=0A=
>  		if (vtime->state < VTIME_SYS)=0A=
>  			continue;=0A=
>  =0A=
> +		ret =3D true;=0A=
>  		delta =3D vtime_delta(vtime);=0A=
>  =0A=
>  		/*=0A=
> @@ -861,6 +865,8 @@ void task_cputime(struct task_struct *t, u64 *utime, =
u64 *stime)=0A=
>  		else=0A=
>  			*utime +=3D vtime->utime + delta;=0A=
>  	} while (read_seqcount_retry(&vtime->seqcount, seq));=0A=
> +=0A=
> +	return ret;=0A=
>  }=0A=
>  =0A=
>  static int vtime_state_fetch(struct vtime *vtime, int cpu)=0A=
=0A=
I tested this and confirmed that it gives accurate values.=0A=
Also, task_sched_runtime () is done only on nohz_full CPU, so I think=0A=
it's a better idea than before.=0A=
I hope you will incorporate this fix into your mainline.=0A=
=0A=
Thanks.=0A=
Hitomi Hasegawa=0A=
