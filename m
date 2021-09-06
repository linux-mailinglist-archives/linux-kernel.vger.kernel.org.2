Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68181401C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbhIFNSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:18:43 -0400
Received: from out1.migadu.com ([91.121.223.63]:47086 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241292AbhIFNSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:18:42 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630934256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdK/OKQjRqu41LxQa2u0kSJwdr75B35cEw6Nz7QmOio=;
        b=kGWt+kazIuFI2BNIdesfwoMcUoDn0rO5UIiU/BDe1DW03yxok2wWDUHYjpsS9UIivsiJ5Q
        me4NFMWN+5mOZ/yhxG44Mqvjb1+NMQ8PF+TZbeIxr1TzwEPNh48o9hKZyXtF1Qv3iJxAbm
        SYwMmRsZupOHMPVQbhJP+KctpqOzuN8=
Date:   Mon, 06 Sep 2021 13:17:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <5958c1dfcb2dd03a14e77cb4ab3d007f@linux.dev>
Subject: Re: [PATCH] trace_osnoise: rename main to trace_main to avoid
 Werror=main
To:     "Steven Rostedt" <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20210906075644.1b8ded67@rorschach.local.home>
References: <20210906075644.1b8ded67@rorschach.local.home>
 <20210906094003.948975-1-liu.yun@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven. Thank you for let me know.=0A=0A--=0AJackie Liu=0A=0A=0A=0ASep=
tember 6, 2021 7:56 PM, "Steven Rostedt" <rostedt@goodmis.org> =E5=86=99=
=E5=88=B0:=0A=0A> On Mon, 6 Sep 2021 17:40:03 +0800=0A> Jackie Liu <liu.y=
un@linux.dev> wrote:=0A> =0A>> From: Jackie Liu <liuyun01@kylinos.cn>=0A>=
> =0A>> kernel builds with -Werror=3Dmain, gcc report failed.=0A>> =0A>> =
Avoids warnings like:=0A>> kernel/trace/trace_osnoise.c:1515:8: error: =
=E2=80=98main=E2=80=99 is usually a function [-Werror=3Dmain]=0A> =0A> NA=
CK!=0A> =0A> It's a stupid warning, and likely a bug in the compiler.=0A>=
 =0A> There's nothing wrong with using "main" as a local variable. It wil=
l=0A> *never* conflict with the main main. Less so in the kernel, as the=
=0A> kernel doesn't even have a main!=0A> =0A> Do not send patches to fix=
 this "error".=0A> =0A> Not to mention, we already went through this disc=
ussion a month ago.=0A> =0A> https://lore.kernel.org/all/20210813224131.2=
5803-1-rdunlap@infradead.org=0A> =0A> -- Steve=0A> =0A>> Fixes: a955d7eac=
177 ("trace: Add timerlat tracer")=0A>> Cc: Steven Rostedt <rostedt@goodm=
is.org>=0A>> Cc: Ingo Molnar <mingo@redhat.com>=0A>> Signed-off-by: Jacki=
e Liu <liuyun01@kylinos.cn>=0A>> ---=0A>> kernel/trace/trace_osnoise.c | =
6 +++---=0A>> 1 file changed, 3 insertions(+), 3 deletions(-)=0A>> =0A>> =
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c=
=0A>> index b61eefe5ccf5..938e2791010a 100644=0A>> --- a/kernel/trace/tra=
ce_osnoise.c=0A>> +++ b/kernel/trace/trace_osnoise.c=0A>> @@ -1512,20 +15=
12,20 @@ static void stop_per_cpu_kthreads(void)=0A>> static int start_kt=
hread(unsigned int cpu)=0A>> {=0A>> struct task_struct *kthread;=0A>> - v=
oid *main =3D osnoise_main;=0A>> + void *trace_main =3D osnoise_main;=0A>=
> char comm[24];=0A>> =0A>> #ifdef CONFIG_TIMERLAT_TRACER=0A>> if (osnois=
e_data.timerlat_tracer) {=0A>> snprintf(comm, 24, "timerlat/%d", cpu);=0A=
>> - main =3D timerlat_main;=0A>> + trace_main =3D timerlat_main;=0A>> } =
else {=0A>> snprintf(comm, 24, "osnoise/%d", cpu);=0A>> }=0A>> #else=0A>>=
 snprintf(comm, 24, "osnoise/%d", cpu);=0A>> #endif=0A>> - kthread =3D kt=
hread_create_on_cpu(main, NULL, cpu, comm);=0A>> + kthread =3D kthread_cr=
eate_on_cpu(trace_main, NULL, cpu, comm);=0A>> =0A>> if (IS_ERR(kthread))=
 {=0A>> pr_err(BANNER "could not start sampling thread\n");
