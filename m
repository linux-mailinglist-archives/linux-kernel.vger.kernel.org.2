Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C8231D076
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBPSui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:50:38 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:3328
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230210AbhBPSuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:50:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2xI7ZAHhhzUt9do7b22pOhV7CQvd0E2sIRUzvOASjZ+CEHst8IYPusSXzwQp18JMHs0jglzi1ktiKbPJHWQvCJ8m+V2nljYOidFqZnf8W7+o7wPDLIoawEhh2RTp/bgJPuFBVQzUl+Z/V1w2od1JzsVXM5jxOLozqAyWx1mq2BIVnS+0JUurkj6GnjsICYVowVZvLLL2TSGk44z55eY8+ftQORywf+4hyGm0TPs8N4LdRdwNFZKgxjC8hp9UpDRCgX6afBVLGYP7dx8AxRChOXcznHHvVQG1+m1+J3clOQrUusz7d7kgF3O7khJK6UWnH3CCyq29CPZIAU9gWIGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36bvqtXyIgx+MIJ+btjBzQ4C0TeDBNKl++zvws8oipc=;
 b=nnC+XBRsdcjJSdd6m0o+pG9uU5pK8DSagnWm6aJxy9GCPzt67pSE0tCj4WUlvnl0lmqB/+WKLYpRh+s+sGrf9tG97nT6ygQGuDo5YIXKvwYyycN2ueeDWVMJO2denxqhAb9sNpm+5/w0YpAOM5qoRApKJEM3Yppf+bVO4QNyIAfngmiqIOqQfVXrXfQLGQrwxQRENrt4++C/EQpg/jrmb9seZ54+pf2lL2a2tt71p2KJx5Cej5LuNFcbSFkvdSTfuS1C5bQfdm+aAZzxiSr3FjBJc4LG/P04e/rc1lAGVZTvjMkqSNtqD2dQwTvIiPwSRvuo8kb2RDFlu/hAdTfAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36bvqtXyIgx+MIJ+btjBzQ4C0TeDBNKl++zvws8oipc=;
 b=Er3235m8eIoo/wk8S4zf0PjNJKSYBQChXN0cCV2FEl7xEoKogG0hRtWWABx47cwaVdRUTmaZYqVoGlI6vHcxAjjujTSZksfQ75IMyuECQ7dLouBJ0w5zvdSsKZ6qxt1vye2OrqHxGgsfNOh6h7iwT7Q3rTE4q7cl/WlkrLUVHA4=
Received: from (2603:10b6:a03:4a::18) by
 SJ0PR05MB7373.namprd05.prod.outlook.com (2603:10b6:a03:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.10; Tue, 16 Feb
 2021 18:49:29 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3846.039; Tue, 16 Feb 2021
 18:49:29 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Topic: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Index: AQHXBFvlshCJ6CO6YEWdmGpC4cHblapbIDAA
Date:   Tue, 16 Feb 2021 18:49:28 +0000
Message-ID: <AE387DFD-770B-47EB-AF85-4AB8950D8ABF@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
 <YCu0wleNK9a/rUWr@hirez.programming.kicks-ass.net>
In-Reply-To: <YCu0wleNK9a/rUWr@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc454222-f735-49ac-9757-08d8d2ab972b
x-ms-traffictypediagnostic: SJ0PR05MB7373:
x-microsoft-antispam-prvs: <SJ0PR05MB737323385484C05066299906D0879@SJ0PR05MB7373.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtu0AMBa/HY3k0rOiETYci95xelaY/T7d3y7Say1vvPL5A+5X37BJVMsv5yDe6lWX1z3UT1Q5i3P3OiZ7ZDJLKO3X6FrgjIVjnyGhIg99tb2TT4pAV+QzPLL3EoY81sFTzQTWJGw95urBohF6MqBafroo5l/BTZvHgGRqL2T6nQ8+Q8xVS79FkWdla3hsCKOD1eJMBQnKA42BBKNSp5bzkNvnl1L3TdTGBAiEdq4NVi4dv5sb+KSpMR+7vROSTOcuzT/DIjEMTFJDp+LJoH3+S+IEk7KQ5QeA8hqgGG40T7+m0nGmlHpc//blZkXxh3b6HBUdUBbWcgWBOOJu99DW4DJn2yljZy3xKgQ0ZqY4tdERFHwTX7v07Anqk6YdCx2wFMrvcQza9FWhD4BpoP82mRtJghmu3fixqDbSAl++ZinwsFNkYYRbwFS0WGHIAlqFNWerY0UEFLfkzHusyOadKG3g+lyjzfZOdmNgoQaofXcM9ju9ycGzNYMCHiOUNRoxg9/Nu3GBCRzCWKLoK7T+35JdUEQ6nvE1dm2D/Hc86pXCAq+lJHhj+DisqfRTzmytvFN730QNzL3MYM8nHVIww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(86362001)(316002)(54906003)(2906002)(33656002)(36756003)(53546011)(6506007)(66446008)(76116006)(2616005)(71200400001)(6916009)(26005)(66556008)(64756008)(186003)(4326008)(66476007)(6512007)(66946007)(478600001)(5660300002)(6486002)(8676002)(83380400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OgJGIHpcHsDcq4fAalz9LqbvpC8jE28Jfk2/f8oErv+BG72/mZixmglqQybS?=
 =?us-ascii?Q?clN4xOXGy3b3E06W0xjpepHMTk3+8aswMm8kr2KF7MPrOVdIbbOj3xyOrvrP?=
 =?us-ascii?Q?YNSgBmK4NwBlXnczwDEIKjUY5AZXvoe7Ifo4ang+uUGZ5a/7W0+SstUHcWk/?=
 =?us-ascii?Q?vvFt7HgqRIrDU6ucKi1AMPxDE5/vUrju0UYdKvZnPtFuOgDU8MrWDyRa7/ex?=
 =?us-ascii?Q?o/rk75U8TPIC5sbpg3aMRmsA9ZJsxd8TooFQpqYoPCUlYchSOOwSn7/ydOnz?=
 =?us-ascii?Q?9HFjP9YNkeC5dZD7PoaK0WLAJ0CCdjdSecz6w3n4raiPCT6gPKGIOV6bT5wN?=
 =?us-ascii?Q?DijXInHzfNrIft94yNsagpA2zRa/I3a9E+KfAt7EbkpYlSWhbl8jGTyQ70vU?=
 =?us-ascii?Q?HCMvip9fLbZFHH97Bp1/odz3SwXVeICeieOSyjNqIVBrSlYYBlhNIs0KNoWa?=
 =?us-ascii?Q?WuIJb+XEDjiZmiTprPCIgsykhUq/5A2ASqPFT4rJ0SLSfXtpnIhw+2YKHBao?=
 =?us-ascii?Q?KssqjyTbiLJ7WGsTAVUV9EV8u8iWrl0a/bi4yT1C6qfzh05/Ob55LKaNhalZ?=
 =?us-ascii?Q?DIpKo7Pu70jZhPPHn43ttNQSkgI6MSJFf2Vpv9z9o0EZcBjJIqL/nn5WYGic?=
 =?us-ascii?Q?uj57vDi4Dt2qs2b8fwzPOPkN4S3rWOKtM67Cb9eR20pAKc/W0EEvP8iA2OQS?=
 =?us-ascii?Q?ELahOhVSeK+tEac0mwApheZaTfToCQ7Ag/TgMrFgKTFW297nksqfq68B2iFc?=
 =?us-ascii?Q?+JCXqLEqR6JWzGAPi/5zzDTq3Sqnt6D2t40/Hon46BOhfslOEs7uJhSCmEt4?=
 =?us-ascii?Q?Tx3uh5GRMIEhLVMKk31PSNYPAri+WY1+nFklhZI8clR27sfdhhRSVNCzCVoQ?=
 =?us-ascii?Q?iGrIkH86A7WASYW86oQucwnjzbJ/TfesOU+kgKppo10r5DnVBxAKKKb/5hTE?=
 =?us-ascii?Q?2w6PlzLTp/YKGhOR2NZt0ldxl8ooCpTXzR005I8YLJGbTQlJSjxK9WAZdlZS?=
 =?us-ascii?Q?LhZWVSYARrAdQsc5hNOTwO9A9GsQMS/FqWBsC3O2b3hKoDWEhwWq2m0cBiRI?=
 =?us-ascii?Q?VN8atVxGWDNbUyq1hW06YalB7U2uDg0s9HmOvgzVZnAwajMCi5QFLH0c7Act?=
 =?us-ascii?Q?C6VOAaq/DBaegqXQ7QdooUfWKhjjJmd+/YPskYq1eblpXHD9nvkImgVpB+Gn?=
 =?us-ascii?Q?VHK6ivpPrKUaIHww0n5iEoO3sgdejamcK17jwviJw5Cl6twovrJum1QX7jBd?=
 =?us-ascii?Q?zhOHrX0uxJg4i/u6V/n3IO1jEfTfI6M5pdlkq3yaQZLRv6RXvoDieJkq1dqf?=
 =?us-ascii?Q?2AkPzN1H7+AIrR795HiiqhYX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D350F397853C244D86BE11D803007201@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc454222-f735-49ac-9757-08d8d2ab972b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 18:49:28.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOb3CEUMIOLfZmsNctUztzd3qhUxSI+m9a8mPpZt7put+GrSvLxHA8pfutr/Kp4FMYmglE+B0q4iq9QRNAWBjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 16, 2021, at 4:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Feb 09, 2021 at 02:16:46PM -0800, Nadav Amit wrote:
>> @@ -894,17 +911,12 @@ EXPORT_SYMBOL(on_each_cpu_mask);
>> void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t fu=
nc,
>> 			   void *info, bool wait, const struct cpumask *mask)
>> {
>> -	int cpu =3D get_cpu();
>> +	unsigned int scf_flags =3D SCF_RUN_LOCAL;
>>=20
>> -	smp_call_function_many_cond(mask, func, info, wait, cond_func);
>> -	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
>> -		unsigned long flags;
>> +	if (wait)
>> +		scf_flags |=3D SCF_WAIT;
>>=20
>> -		local_irq_save(flags);
>> -		func(info);
>> -		local_irq_restore(flags);
>> -	}
>> -	put_cpu();
>> +	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
>> }
>> EXPORT_SYMBOL(on_each_cpu_cond_mask);
>=20
> You lost the preempt_disable() there, I've added it back:
>=20
> ---
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -920,7 +920,9 @@ void on_each_cpu_cond_mask(smp_cond_func
> 	if (wait)
> 		scf_flags |=3D SCF_WAIT;
>=20
> +	preempt_disable();
> 	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
> +	preempt_enable();
> }
> EXPORT_SYMBOL(on_each_cpu_cond_mask);

Indeed. I will add lockdep_assert_preemption_disabled() to
smp_call_function_many_cond() to prevent this mistake from reoccurring.

