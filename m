Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB532ABF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447749AbhCBU6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:58:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:50864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1580523AbhCBSEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:04:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614707013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1odR/9HIGhwlY9C1AyzEeD9zVtoOxcaXyC3jT9R5QA=;
        b=mhn55k0DONsD3wIp8Y4XJ+X3wOcLKsU59xYYRmNFqFD+QjAosw1o2FIWwtx5jlg+NpN1V2
        ouNrtZEnOxpvriwCNjlJy7wqODo8p4hk0mPHctHPbURfVHoNkPcwQjIEI/MOqW3MjEvirA
        0NUxQFMzmWUtvo7yPaIJ1/xeVtbPxME=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3B66AD87;
        Tue,  2 Mar 2021 17:43:33 +0000 (UTC)
Date:   Tue, 2 Mar 2021 18:43:23 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/cpuacct: Fix charge cpuacct.usage_sys
 incorrently.
Message-ID: <YD55OxQrJ54PWgs+@blackbook>
References: <20200420070453.76815-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dFxZORNm+VieO2OP"
Content-Disposition: inline
In-Reply-To: <20200420070453.76815-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dFxZORNm+VieO2OP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

(Sorry for necroposting, found this upstream reference only now.)

On Mon, Apr 20, 2020 at 03:04:53PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
>  /* Time spent by the tasks of the CPU accounting group executing in ... */
> @@ -339,7 +340,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  {
>  	struct cpuacct *ca;
>  	int index = CPUACCT_STAT_SYSTEM;
> -	struct pt_regs *regs = task_pt_regs(tsk);
> +	struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
I've read the discussion in [1] but I don't think this approach is
correct either (and I don't know what is better :-/).

I only have a qualitative proof:

host:~ # uname -r
5.10.16-1-default

host:~ # systemd-run -p CPUAccounting=yes sh -c 'time sh -c "i=0 ; while [ \"\$i\" -lt 10000 ] ; do i=\$((\$i+1)) ; cat /proc/slabinfo >/dev/null ; done" ; sleep inf'
Running as unit: run-r101b9f53efcb4d2a9bfb65feb6f120ca.service

host:~ # cat /sys/fs/cgroup/cpuacct/system.slice/run-r101b9f53efcb4d2a9bfb65feb6f120ca.service/cpuacct.usage{,_user,_sys}
16138535165
14332580468
1805954697

(See that sys/user ~ 0.1)

host:~ # journalctl -u run-r101b9f53efcb4d2a9bfb65feb6f120ca.service
-- Logs begin at Tue 2021-03-02 18:06:41 CET, end at Tue 2021-03-02 18:27:45 CET. --
Mar 02 18:27:29 host systemd[1]: Started /usr/bin/sh -c time sh -c "i=0 ; while [ \"\$i\" -lt 10000 ] ; do i=\$((\$i+1)) ; cat /proc/slabinfo >/dev/null ; done" ; sleep inf.
Mar 02 18:27:45 host sh[19117]: real        0m15.543s
Mar 02 18:27:45 host sh[19117]: user        0m10.752s
Mar 02 18:27:45 host sh[19117]: sys        0m5.379s

(See that sys/user ~ 0.5)

host:~ # cat /sys/fs/cgroup/cpuacct/system.slice/run-r101b9f53efcb4d2a9bfb65feb6f120ca.service/cpuacct.stat
user 415
system 1209

(See that sys/user ~ 3.0 :-o)

The expectation is that significant amount of the loop is spent in
kernel (dumping slabinfo). I can't tell which of the ratios fits the
reality best but the cpuacct.usage_sys still seems too low.


Michal

[1] https://lore.kernel.org/lkml/20200416141833.50663-1-songmuchun@bytedance.com/

--dFxZORNm+VieO2OP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmA+eTUACgkQia1+riC5
qShN+Q//e89E9MA7Ku6PURFKldbhEMpFwuI48vsYuDg1b7OwMtWqk0kpOfhSjjKD
N0nP0aMALG1fl9oISUDBzth4CGOzmo28LIlao/f0LGLC+ThJyM48oCEFP44C3VUt
hJv4UqEIVHTW7DCuH+lLhU/Tbvwn5TJZoSYdQDwHWsfVlPpO7Ov3mwqlqQlAsr/s
nXW+uaz3rjWq8n1L/Q0RK1jbChCLHftF0YG7EBP/5SC0CjN7vnyIIZQQMat8K8qi
cbnum0nW4yInY/XBQsUTU13Htk1DB5/c/fqpQurkcp32b8VYMWoV4FrhEhcHSrgD
9XWAA/mvRvzjWIHItgtzQcmBQTz1Kkh+4kjDwHT5Xsl12HCxhPXslkoS4lHIKafu
pN3THfUofKeyvRENqcmttDxzWJ74iVSYgs3zmz6nmhpfs2k5HwKF2UEiUeUMLwUd
IMdb0rDVD5QhH7JoJ+j8MZQB5nrwrrESdwzV3NCptmxUnyZxarra4fxEM1Cds0Cj
wbZlu6KYSrNlwcIG77P03nsTOKWFHKq/CDITvHvCQK1hJYilmW+MPC2DFcLfciRq
cFvcn24Mcg6BRBrTvbr5rnhc4mB+MF48K2MckXr+2mk98g1u2JlTYQ2XYj4IgQwq
egBnSR90ckz9QD/FSGxJ3ob1CDdmY9DAixP21GbSVKBy6Brfa6A=
=xqAD
-----END PGP SIGNATURE-----

--dFxZORNm+VieO2OP--
