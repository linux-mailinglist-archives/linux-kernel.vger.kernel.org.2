Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B35531E8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhBRKzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:55:10 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:43617
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232171AbhBRJhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:37:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0HwtwSj+nkG5ThDdLxYLZ+6Fekh53Kq838z+ZJlM0gR+sidtLQfeN2yEYoMYnCL3nP7SI04ARUgGIypMITYLOPH5rmCSnqcxAx25xe7rvMo4Ur7dsxXVuwBagqu1x/KDtHyGtmCgDIElnb+ZEHUKnDI3UYMUl/zByNtlW/g7BKHXNw1KigkwESo0WaBpVJl7kzTI7+0zftdAVO9prUVv/k+PgzU3wnlWLDzkL8TTOuZs5Q7KRdRBqWEVk4Qe1zRKowS8L4hT2Nw6gxThz7RaCcfJ5E/6LFACrijtmzK7XuRHRBO7otf6a+oikodLX5RZWbNfiLAtVoi1+ClIoNPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp008P04KeMI1tpC+8HfROBJN21FsWVgCw8OSwKnf+4=;
 b=V+kgtWpnOjfd3DldfcokQ7hi2C/a0BrIWhH5Gc37gjfMmKTJp4s4nyDo182KAizwO5HY/fXTdxJsd6B2AMszn1kMkiM/jQMyVP2Hk7VKYBwJ+dM/aYFCGS3j5LVrzYIT0rl5qvqh5ezDVt6N4G1UVTcwhNGx1yLnApIjCvggnOK5p+/yATkHzhXII1Sp6Pf749//i3k6shHFRUZDfqIsuD3Oz8r+ozCh+LSl2BcwEP05mDbFPt3zrKccZhfe5NXrIvLNV47Mp8wDIDj/sliEPLdumqqPuF4X8Wzuh/39bpGtow3EY/GY0YBvRg+3wtWIcbgJi81Qb2gLJEeYzPGVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp008P04KeMI1tpC+8HfROBJN21FsWVgCw8OSwKnf+4=;
 b=i0gOrRoQhm/aE0Ov5IQS1M55HAHaJUSiqdek9X9vW1BB6fN6BbZLMmKVnWE0ZKCM7QJ6tBkEEnj33DkQqi2o+Un3oO+Kyb1+8Yk5+9/QREsNZzxnn+5KKoDO49YFr8Kp/1XbzpUAuEYIFBPCScnD7yvhz8LyXBnlXYqWBhn6KZ8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BY3PR05MB7938.namprd05.prod.outlook.com (2603:10b6:a03:356::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Thu, 18 Feb
 2021 09:36:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3846.039; Thu, 18 Feb 2021
 09:36:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Topic: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Index: AQHXBc1y5qVzDt8tgEWjiyIQ8tCRyqpdp10A
Date:   Thu, 18 Feb 2021 09:36:09 +0000
Message-ID: <ACE814E2-5986-44AE-920C-1EA241D2E12D@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
 <20210218080929.GA335524@infradead.org>
In-Reply-To: <20210218080929.GA335524@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed177973-29c6-4dac-240e-08d8d3f09f7d
x-ms-traffictypediagnostic: BY3PR05MB7938:
x-microsoft-antispam-prvs: <BY3PR05MB79388B791667B89CCBA72078D0859@BY3PR05MB7938.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fsvzIanVZU0rBNswel3XtWUV9GbnDZxwtke9LNCzBBs/xAjpSNlitOtUpWdRJmSPY9GxhkhPhD1SCXFdW4aUwgn1Qg/M07c0iSC1AB+VFMAdKCx/Nj3WyWzos42xgEbYbOltGG+jkF5uwEnwPLJW9qit2i7DeEFIhPGdoQCXvpcAdbS7FfxivA1IEhtZswcbK1xLnPtnuYUOLgekdzJnEmPg9yT29wEtyztxhzOB1samH6VkpAAL17KfOh9HcvTCX/jaA/cFGfvvreZ+vBCwG8xK0SFaFSwqIE1oz07l9NbBaoIFi/ZJFAJFpooEXUoa9+zVnhT2ovNDAj1cy6A1zl4/NBVh8WH6u2JHX+XiMTwx78j3/CprrLcxqnvxVA9sASY0IzKfaC4eGU1t+Q2L172QKl8QCARfVul5Wql7Dzq39lXClkWyh3SMK2Qls6EXJhTAU46Jan0OMyFegOc6mYb0X48Zep8PMgF8suezzhYcLHVqzhuaEKkz3wNtlWmTfCnBUK9Ct3h04B6p2OQ7GdIeFGthjDhhpQoEgwz5mR89wFkWwVJz0AQbbw38r5A3o3k1llUR20RdKUqMviyRWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(66946007)(5660300002)(64756008)(66446008)(76116006)(26005)(66556008)(6486002)(478600001)(6506007)(4326008)(83380400001)(86362001)(186003)(53546011)(66476007)(8676002)(8936002)(2906002)(6512007)(36756003)(33656002)(2616005)(54906003)(316002)(71200400001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P75jZ/htZQclkxlORGkJAQUUBTd9+KqdAhZN1IWzA2g7dcbJRnnCnxHp+LKT?=
 =?us-ascii?Q?QPIxxtCzzgsZUjvDqlXVZeip+YAg/WrHd9uCkci2cfyJ/GDC4wre1Z/yfRsd?=
 =?us-ascii?Q?gxcNhks6RI/CKVrrjWKz66ruFBtopDCCilPem7bKqo1OxendAiucCcnSYLlr?=
 =?us-ascii?Q?98MCsjZ+cySgF47q0szhbBHTz2ztPrplq40Ti2HNaUyi6celWWZP1B2ZSY4y?=
 =?us-ascii?Q?tP75VjTZgNmd22F6pTOh7LYANUZGpqG2omUYuM8LYPVN+nQNZebNHpXkBuYF?=
 =?us-ascii?Q?V6sCut78jqTiOskWh0FnoKL7tBdqsG5ONqEPagTgFmcQbtMqtNedW9bn4db2?=
 =?us-ascii?Q?vKTtv/YOnxMYa5RxGRRE33r+KzyvDTy9nuMELhTskS3llmTGPV+wGdZUEoMF?=
 =?us-ascii?Q?3x29Mlhyzx6dOC0jwq1r0D45MtnZtLUtUjgrriIrkl8SoIr+7e/pb6Mul9iV?=
 =?us-ascii?Q?rgNXz7V+KktbBH+1Ml/B/GBgyNsfHkjFrZbOGHKO890co6gAUcLuCeSVEXKL?=
 =?us-ascii?Q?p2nBEHzoI2YILxF4B54T/Ux6NAS6I0IjL02Ekh5vSeLcgyxSFVX4Xv1oBYJk?=
 =?us-ascii?Q?rlJ6gyrOSVxxFF826bn0ZhFVDsRSRF0Z4q2cv75KW/sVdWoXrum9SRA3wiAp?=
 =?us-ascii?Q?btIFURtVdPZUJGnvWYUpWNYmWQu0OqX2ruOHu7yEIfmkkwt2hKgZbEbHuOxz?=
 =?us-ascii?Q?3mYb/mEhz+OiEnrT6oRh2uSEPNFw8YNNQAjL/Z2b/iRhL/vXkLEcfumXeOLQ?=
 =?us-ascii?Q?pCN3BhQiUNqT6gylSibiQfwx/rCVHKlP9cuM7CPsKj+iBZVOSxePfdVM7CEL?=
 =?us-ascii?Q?HVwMEOsI4SV/iz8BzLkFRcsFrooFuS6Wbglh7OG3XYsqgU4NrRP18JXaoHSm?=
 =?us-ascii?Q?B6IB8JtKhjJV2qHCGqd+iUBfo9THBonC2CL2AE4L+P7xXvMOPg0wex7MozwE?=
 =?us-ascii?Q?CgTFIRWZIsZqS2qlX9kwE6bB/c0TYbTBpuhlNAOcINrqAt+hDIGYq/D4jZ2z?=
 =?us-ascii?Q?1s6117vgqFkO5EY8AwzmSyrwr1Z5BW8T57hdbCxossRi0Y0XRP8Wwr1MGgth?=
 =?us-ascii?Q?slXRVz70mmI7c3Ijb6/tIVYhsmDofz+/ouj52rXmqhcHvPRxRMkBqFM1E167?=
 =?us-ascii?Q?RMOwTNdsySTuF4b2QgxgcBgNeRO82+U7yDZQMewHlem+nmacMIv3d8lnht5W?=
 =?us-ascii?Q?71RDLYaEtwC+fBS2Jo4tyDhu6ZUd8KrS/ghd5oQeFZSVHea4fsRUhvFZNt60?=
 =?us-ascii?Q?iyfx3hYndlOPjL/ZiNsV6v10o80meVFMRAtjaJ3HoPXzKppDZtho7pbG4fmF?=
 =?us-ascii?Q?b/OjTPGk8vUixXIcyJ71duxS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34AE548A48F62C40A2703D8ADB21474F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed177973-29c6-4dac-240e-08d8d3f09f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 09:36:09.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNaAd8s/c4dINxuXJirKoF+XweF4gnM2F2LkAx08NKpk3aMlqOHbFLkVMru9ja6KV5xYFjmyT4ZdGhUenGDJuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB7938
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 18, 2021, at 12:09 AM, Christoph Hellwig <hch@infradead.org> wrote=
:
>=20
> On Tue, Feb 09, 2021 at 02:16:46PM -0800, Nadav Amit wrote:
>> +/*
>> + * Flags to be used as scf_flags argument of smp_call_function_many_con=
d().
>> + */
>> +#define SCF_WAIT	(1U << 0)	/* Wait until function execution completed *=
/
>> +#define SCF_RUN_LOCAL	(1U << 1)	/* Run also locally if local cpu is set=
 in cpumask */
>=20
> Can you move the comments on top of the defines to avoid the crazy
> long lines?
>=20
>> +	if (cpu_online(this_cpu) && !oops_in_progress && !early_boot_irqs_disa=
bled)
>=20
> Another pointlessly overly long line, with various more following.
>=20
>> EXPORT_SYMBOL(on_each_cpu_cond_mask);
>=20
> This isn't used by any modular code, so maybe throw in a patch to drop
> the export?

I prefer to export on_each_cpu_cond_mask() and instead turn the users
(on_each_cpu(), on_each_cpu_mask() and on_each_cpu_cond()) into inline
functions in smp.h. Otherwise, the call-chain becomes longer for no reason.
Let me know if you object.

So I will add something like:

-- >8 --

Author: Nadav Amit <namit@vmware.com>
Date:   Tue Feb 16 11:04:30 2021 -0800

    smp: inline on_each_cpu_cond() and on_each_cpu_cond_mask()
   =20
    Suggested-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Nadav Amit <namit@vmware.com>

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f6284dcf..84a0b4828f66 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -50,30 +50,52 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
                             int wait);
=20
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func=
,
+                          void *info, bool wait, const struct cpumask *mas=
k);
+
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+
 /*
  * Call a function on all processors
  */
-void on_each_cpu(smp_call_func_t func, void *info, int wait);
+static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+       on_each_cpu_cond_mask(NULL, func, info, wait, cpu_online_mask);
+}
=20
-/*
- * Call a function on processors specified by mask, which might include
- * the local one.
+/**
+ * on_each_cpu_mask(): Run a function on processors specified by
+ * cpumask, which may include the local processor.
+ * @mask: The set of cpus to run on (only runs on online subset).
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
+ *
+ * If @wait is true, then returns once @func has returned.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.  The
+ * exception is that it may be used during early boot while
+ * early_boot_irqs_disabled is set.
  */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-               void *info, bool wait);
+static inline void on_each_cpu_mask(const struct cpumask *mask,
+                                   smp_call_func_t func, void *info, bool =
wait)
+{
+       on_each_cpu_cond_mask(NULL, func, info, wait, mask);
+}
=20
 /*
  * Call a function on each processor for which the supplied function
  * cond_func returns a positive value. This may include the local
- * processor.
+ * processor.  May be used during early boot while early_boot_irqs_disable=
d is
+ * set. Use local_irq_save/restore() instead of local_irq_disable/enable()=
.
  */
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-                     void *info, bool wait);
-
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func=
,
-                          void *info, bool wait, const struct cpumask *mas=
k);
-
-int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+static inline void on_each_cpu_cond(smp_cond_func_t cond_func,
+                                   smp_call_func_t func, void *info, bool =
wait)
+{
+       on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask)=
;
+}
=20
 #ifdef CONFIG_SMP
=20
diff --git a/kernel/smp.c b/kernel/smp.c
index 629f1f7b80db..a75f3d1dd1b7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -843,55 +843,6 @@ void __init smp_init(void)
        smp_cpus_done(setup_max_cpus);
 }
=20
-/*
- * Call a function on all processors.  May be used during early boot while
- * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
- * of local_irq_disable/enable().
- */
-void on_each_cpu(smp_call_func_t func, void *info, int wait)
-{
-       unsigned long flags;
-
-       preempt_disable();
-       smp_call_function(func, info, wait);
-       local_irq_save(flags);
-       func(info);
-       local_irq_restore(flags);
-       preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu);
-
-/**
- * on_each_cpu_mask(): Run a function on processors specified by
- * cpumask, which may include the local processor.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.  The
- * exception is that it may be used during early boot while
- * early_boot_irqs_disabled is set.
- */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-                       void *info, bool wait)
-{
-       unsigned int scf_flags;
-
-       scf_flags =3D SCF_RUN_LOCAL;
-       if (wait)
-               scf_flags |=3D SCF_WAIT;
-
-       preempt_disable();
-       smp_call_function_many_cond(mask, func, info, scf_flags, NULL);
-       preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu_mask);
-
 /*
  * on_each_cpu_cond(): Call a function on each processor for which
  * the supplied function cond_func returns true, optionally waiting
@@ -928,13 +879,6 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, =
smp_call_func_t func,
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
=20
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-                     void *info, bool wait)
-{
-       on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask)=
;
-}
-EXPORT_SYMBOL(on_each_cpu_cond);
-
 static void do_nothing(void *unused)
 {
 }

