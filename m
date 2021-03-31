Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD135081D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhCaUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:19:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236400AbhCaUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:18:53 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VKHbR2023329;
        Wed, 31 Mar 2021 13:18:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jFrDH39UV+FGtzUY29/0kf3ASOblHS+Ox1aymo80k4M=;
 b=AZ1/uSjirznQHJjbTdeH6jppmyQmYPqdMPl+dOKNFtMVRGhggXpnVjPAJN2iDugesksD
 KiLkczgZdiPg+aXycrYIRI/FF7VGXzXp8p5FECriiC+FWVGY0Hvev2pKhcONUUUN840e
 d9f0NnYcPDihze8TPjcrW6MCJYundEy8jYA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37mydw0798-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Mar 2021 13:18:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 13:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3EpC+5bceWbLFKeejiE7lPDTatHnb5MbM6ZIM5cOikg/IbP6JB0zqGM0UWrzTkNztmCxmUcfEXHAHTUCnKaSjALXQxsVvU1kz0VJf+wSPAhJHqU95EYrbWYaLl5euooiH46fA5SnWBBCk6Mp3LWJOCL4H2wrl6jMg9nGyT41YvCAmisEHcAdbvy3SjZaOuMcgcgb9IRsLD7PRlC7LkwYvK57+SI0T7BPKhyWxoGaJ+R83DiAjNidN0Cs+WVafOqCZX1lOFIyCZM/bw2PunlTTTDbOMaBZGkWlH/gaRwfLHjK4+BesoazO+EcGaX5DS37V3w1iIJxRjLkz3ji15mKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFrDH39UV+FGtzUY29/0kf3ASOblHS+Ox1aymo80k4M=;
 b=WKOTAgFz9qwu3ce+W2JwAm57XpG2l0BbbIyOng6k8A4WEXKNjYcPFMEgN5weZK9/BZ//JPbczbNVZCNBjN+fEg/OXGkUuc1cTAqHI8huR/keoFaGbtI0vrwx+CMeeB/RBEIWBT0ayHtyv2RPqIYO3mVvd+jXmXgmIKJdab4uOC8uWEoqleHTO/W1IWkOKIVAJwRlefzw9FwhUU60K3EaYwdkreX8e4R2ZJ29RCvFRCh2nHRqimDExYKxNerldJ1X/Ng4chQdJ4GeuYqSXtvGMv31ZqZGQdVkl7ueedPcrwPhvril5dPWaeJA36B9VW/LCb1jBnf3bQBfvitmGugtTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3572.namprd15.prod.outlook.com (2603:10b6:a03:1b2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 20:18:30 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.039; Wed, 31 Mar 2021
 20:18:30 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Hillf Danton <hdanton@sina.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] possible deadlock in register_for_each_vma
Thread-Topic: [syzbot] possible deadlock in register_for_each_vma
Thread-Index: AQHXJk8+gFf2nq41rkuAl1i4paB7sqqeiWkA
Date:   Wed, 31 Mar 2021 20:18:30 +0000
Message-ID: <16A6542C-1D75-4E88-8A98-2FF0E3F245FC@fb.com>
References: <00000000000030aca605be6e0102@google.com>
 <20210327042150.7460-1-hdanton@sina.com>
 <20210328025217.7312-1-hdanton@sina.com> <20210331165918.GA10434@redhat.com>
In-Reply-To: <20210331165918.GA10434@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:64e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1416546-6756-44bc-2a51-08d8f48226d6
x-ms-traffictypediagnostic: BY5PR15MB3572:
x-microsoft-antispam-prvs: <BY5PR15MB3572F5EBFC50059719CBF196B37C9@BY5PR15MB3572.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQhHAPhimMcPUfhEVhtDMpszmFJx6rvMNuUpBQfUvbdT2ibfbEzd1MTKWXlEe6/pLMQAELXlHrs3OgZ8rdhvI/0hj0sKV8ENSJTt/UP+SrT+wTYX91x02DsDepDtqzkQA7epo8IcJee4dguBV7DmKJlxhUMI1qxxPaLpcnwrH/r9BEtGH+xN3JtDafahKmh+eeYfbjoOy/Ms5okxDVn0j9an8e7tkgYX9gYi3nLXiNxzedBCqtzJh1T2gub3aJVViFfmhGCvutK8zivFx+2c84n+my/Sjv8mbre6nY3wtT74SAiruzTYjYp2ksmcVZtwAK4T/qC3xXTGITCmNZx6yywemCEUhl1FKxsTjOfZKUL5Exqz4Fgaq/2OOii/GphEfW9H9xXHkGYIgrBE3NyUbhXJK2oX/YzbiRVrKbaWj1MqAjqyWMKPy1iF53Nfon3aEdhehPpH/ObjsVwlE7P8dvlgXEY98+urLEWSd9+u3Myq1LV7Ucihy2//QbQe2ocofD56uJclfoRIOfwhkiBamhTnH2ofqX9XijrcvMqrORpMXvxoCbbdhGHCAJ2g1y9GEYjv+oqRrZyu3CR0Un1IddV5NMXS0+txfyoU3y3wlcKpPiRcGVYy5usgM8+pUgVG96lYldUzeBhBWlZS4TgAfOz+bcLk2mHm74F/xVDrOb8mBC80VAIHh4XVtNppKhlP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39850400004)(478600001)(66446008)(66476007)(91956017)(6916009)(64756008)(2906002)(66556008)(66946007)(54906003)(71200400001)(8936002)(38100700001)(186003)(8676002)(76116006)(316002)(53546011)(33656002)(2616005)(86362001)(4326008)(5660300002)(6506007)(36756003)(83380400001)(6486002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GkB8dBqKr5rE4o/hdCENCziXFe4ZWTLzB5l+lY0fpB/Alwh1KyF+kRtEi9oF?=
 =?us-ascii?Q?4jvEy0JCUhCXoIbkh8meOVumynZ67Jb8MmG1fkXs3+s0txRrJ+GiUqph++Vl?=
 =?us-ascii?Q?u/0fAClwFmBrGt+l5kpIzoPeN69jYFxOTRvDxOtVFtfRh6mXf+GHiOw1XFd4?=
 =?us-ascii?Q?60O3JCtMgnOKPv8qYFdy4R4+6yPk6ea0ZHrmL0Njtw2jFnCetkwGs5hIdVrk?=
 =?us-ascii?Q?zeDkWwhpsBb/wBhmG8oIZ8ZKXhbdihds5WefS9YhNKBigf+XlBieYlqYuUi+?=
 =?us-ascii?Q?Kk9wh08sY/pnYxBk6EEcYq1F/a4OSuBZL0mSGQk5zpq+YgGzNCXLT5AJXAXM?=
 =?us-ascii?Q?hdnjdwNOv6xW4eucnEgiG+AAVhyszauCGksU7zXXNatSAXh+zUaPUSeWjXxa?=
 =?us-ascii?Q?h+/XH/Gu34yxxkmS02N+k7c7hpkmTq8Pskjii/kMy2p0z3CdW11Vzxy7aFuG?=
 =?us-ascii?Q?IBhe+Xr0GGFUgqtIXoeDHIU74UtXCuH2nii6mfcOy/5Bz6FyG4xhrWbTsOqp?=
 =?us-ascii?Q?NcBdiviwUoLxgxEfrSFCiesjqYVW7Po0OTyRH3AI6RJK8HnOzuZR1KtF8FZB?=
 =?us-ascii?Q?5Ul5lSs+gHXFqKFQSFCDkTFVRrraBQwhCnfEhOFhexWhUmA99bxT37AMrjFz?=
 =?us-ascii?Q?eKlkWpIE8KXHp9zTIN1JO+i6Cv8Ecau7QGf7LlwvzjP8/un/9ukI38VAC4E3?=
 =?us-ascii?Q?bND8599+viZPr6uR/dWNtC2T1+Thei2C4HQSoVp3QQzNnVfRMJ7IZmDDiyTV?=
 =?us-ascii?Q?LZ4i29sYD9vj1JAmBcyynfwdGu9oq3AREsucCDbzlYbsMpiPeqoxQdnnyldM?=
 =?us-ascii?Q?ZoAvUGkTbC5tmceaf03J0rPgVtCSGDKkH84am82hFGd5kygTIDzRwRRqRzPh?=
 =?us-ascii?Q?qrsdmIRrBDCwJKJZQrMWC/1328xpUIqNw9gC6Oa8z68AtRlh94vF6DMf7dK4?=
 =?us-ascii?Q?bBzC403cp4VI4ByyHwDfHqqrJFpO46sxZ5Lk5Tv3YX7I0RFgDFOkfv3x/Xq9?=
 =?us-ascii?Q?qyJgHci1hlWnb3/fP+KVi/1IF3I6PwfB+j+tQoJibA0b+8zwHm/2lstkkvjJ?=
 =?us-ascii?Q?qoJhlTCFzWmJDETS5DSyp9dLKn04MTlgFUuPGqTtpZ7/d7fqpNYzhRwHrdiK?=
 =?us-ascii?Q?CKA0VqsIs18yhZ4JHf6uVS9xrvfdZT3IJfxQTWOIq8brznqooeuorQNOAIj1?=
 =?us-ascii?Q?zrVh3B6Z5DEOd1qBhqA01wtnPsx1MCZrsuGjNOGlC3ihlWjVdrVQiAScv8oX?=
 =?us-ascii?Q?MJrM7SKSb9EgP2tWIybboHhkIqdvFP2n05ORd3Jcl3vdJvuOPiiXJQXfPIt0?=
 =?us-ascii?Q?nqhcOY67Xz//ySA9dRVjahQUbSurM7sIDMkTSdE1pl0QJfia4j5qA5OuoDGb?=
 =?us-ascii?Q?p/QjV08=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EFCFEC95886A7343B8CB7F57D2BC6065@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1416546-6756-44bc-2a51-08d8f48226d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 20:18:30.4802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVeMhkpPdmYRUi/9hdtNTAUjscJ3+J/q6XsZzJqQTYxT11ftKQgpQtCJLIXBpz2U0ENq0+Z43xaiJgn4V4WEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3572
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: LU3MDyBJKePbX-d7HbaQ8M5kfyM43RPA
X-Proofpoint-GUID: LU3MDyBJKePbX-d7HbaQ8M5kfyM43RPA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_10:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 31, 2021, at 9:59 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 03/28, Hillf Danton wrote:
>>=20
>> On Sat, 27 Mar 2021 18:53:08 Oleg Nesterov wrote:
>>> Hi Hillf,
>>>=20
>>> it seems that you already understand the problem ;) I don't.
>>=20
>> It is simpler than you thought - I always blindly believe what syzbot
>> reported is true before it turns out false as I am not smarter than it.
>> Feel free to laugh loud.
>=20
> I am not going to laugh. I too think that lockdep is more clever than me.
>=20
>>> Could you explain in details how double __register is possible ? and ho=
w
>>=20
>> Taking another look at the report over five minutes may help more?
>=20
> No. I spent much, much more time time and I still can't understand your
> patch which adds UPROBE_REGISTERING. Quite possibly your patch is fine,
> just I am not smart enough.
>=20
> And I am a bit surprised you refused to help me.
>=20
>>> it connects to this lockdep report?
>>=20
>> Feel free to show the report is false and ignore my noise.
>=20
> Well, this particular report looks correct but false-positive to me,
> _free_event() is not possible, but I can be easily wrong and we need
> to shut up lockdep anyway...
>=20
>=20
> -------------------------------------------------------------------------=
------
> Add more CC's. So, we have the following trace
>=20
> 	-> #0 (dup_mmap_sem){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:2936 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3059 [inline]
>        validate_chain kernel/locking/lockdep.c:3674 [inline]
>        __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
>        lock_acquire kernel/locking/lockdep.c:5510 [inline]
>        lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
>        percpu_down_write+0x95/0x440 kernel/locking/percpu-rwsem.c:217
>        register_for_each_vma+0x2c/0xc10 kernel/events/uprobes.c:1040
>        __uprobe_register+0x5c2/0x850 kernel/events/uprobes.c:1181
>        trace_uprobe_enable kernel/trace/trace_uprobe.c:1065 [inline]
>        probe_event_enable+0x357/0xa00 kernel/trace/trace_uprobe.c:1134
>        trace_uprobe_register+0x443/0x880 kernel/trace/trace_uprobe.c:1461
>        perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
>        perf_trace_event_init+0x549/0xa20 kernel/trace/trace_event_perf.c:=
204
>        perf_uprobe_init+0x16f/0x210 kernel/trace/trace_event_perf.c:336
>        perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9754
>        perf_try_init_event+0x12a/0x560 kernel/events/core.c:11071
>        perf_init_event kernel/events/core.c:11123 [inline]
>        perf_event_alloc.part.0+0xe3b/0x3960 kernel/events/core.c:11403
>        perf_event_alloc kernel/events/core.c:11785 [inline]
>        __do_sys_perf_event_open+0x647/0x2e60 kernel/events/core.c:11883
>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
>=20
> which shows that this path takes
>=20
> 	event_mutex -> uprobe.register_rwsem -> dup_mmap_sem -> mm.mmap_lock
>=20
> Not good. If nothing else, perf_mmap_close() path can take event_mutex un=
der
> mm.mmap_lock, so lockdep complains correctly.
>=20
> But why does perf_uprobe_init() take event_mutex? The comment mentions
> uprobe_buffer_enable().
>=20
> If this is the only reason, then why uprobe_buffer_enable/disable abuse
> event_mutex?
>=20
> IOW, can something like the stupid patch below work? (Just in case... yes
> it is very suboptimal, I am just trying to understand the problem).
>=20
> Song, Namhyung, Peter, what do you think?
>=20
> Oleg.

I think the following patch works well. I haven't tested it though.=20

Thanks,
Song


>=20
> --- x/kernel/trace/trace_event_perf.c
> +++ x/kernel/trace/trace_event_perf.c
> @@ -327,16 +327,9 @@ int perf_uprobe_init(struct perf_event *p_event,
> 		goto out;
> 	}
>=20
> -	/*
> -	 * local trace_uprobe need to hold event_mutex to call
> -	 * uprobe_buffer_enable() and uprobe_buffer_disable().
> -	 * event_mutex is not required for local trace_kprobes.
> -	 */
> -	mutex_lock(&event_mutex);
> 	ret =3D perf_trace_event_init(tp_event, p_event);
> 	if (ret)
> 		destroy_local_trace_uprobe(tp_event);
> -	mutex_unlock(&event_mutex);
> out:
> 	kfree(path);
> 	return ret;
> --- x/kernel/trace/trace_uprobe.c
> +++ x/kernel/trace/trace_uprobe.c
> @@ -857,6 +857,7 @@ struct uprobe_cpu_buffer {
> };
> static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
> static int uprobe_buffer_refcnt;
> +static DEFINE_MUTEX(uprobe_buffer_mutex);
>=20
> static int uprobe_buffer_init(void)
> {
> @@ -894,13 +895,13 @@ static int uprobe_buffer_enable(void)
> {
> 	int ret =3D 0;
>=20
> -	BUG_ON(!mutex_is_locked(&event_mutex));
> -
> +	mutex_lock(&uprobe_buffer_mutex);
> 	if (uprobe_buffer_refcnt++ =3D=3D 0) {
> 		ret =3D uprobe_buffer_init();
> 		if (ret < 0)
> 			uprobe_buffer_refcnt--;
> 	}
> +	mutex_unlock(&uprobe_buffer_mutex);
>=20
> 	return ret;
> }
> @@ -909,8 +910,7 @@ static void uprobe_buffer_disable(void)
> {
> 	int cpu;
>=20
> -	BUG_ON(!mutex_is_locked(&event_mutex));
> -
> +	mutex_lock(&uprobe_buffer_mutex);
> 	if (--uprobe_buffer_refcnt =3D=3D 0) {
> 		for_each_possible_cpu(cpu)
> 			free_page((unsigned long)per_cpu_ptr(uprobe_cpu_buffer,
> @@ -919,6 +919,7 @@ static void uprobe_buffer_disable(void)
> 		free_percpu(uprobe_cpu_buffer);
> 		uprobe_cpu_buffer =3D NULL;
> 	}
> +	mutex_unlock(&uprobe_buffer_mutex);
> }
>=20
> static struct uprobe_cpu_buffer *uprobe_buffer_get(void)
>=20

