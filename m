Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A3374FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhEFHLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:11:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59678 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhEFHLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:11:42 -0400
Received: from minint-m3g9p8n.europe.corp.microsoft.com (unknown [49.207.195.141])
        by linux.microsoft.com (Postfix) with ESMTPSA id 70F7A20B7178;
        Thu,  6 May 2021 00:10:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70F7A20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620285045;
        bh=PD9SiN6yE0HEGCtL5cXmJaYf2RP4vpF1uy5fBLBdzpQ=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=P/CENEbftU+S9u4KQoeNhSwmblH6LnQ47l+CEGwFRiFIJoeUi00ByIDK7mOj667/x
         7fY0Nak/JJgyR+D/2BWGcg4/VnUp73jsUyRAECtiI/XzM86k35Ng20nltCCdCCvI4P
         iPKG2hsN5b1jKef7ae4y76R1XyjbCQCViIR+h6mE=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <CAHUa44EZprsEKbd_mzGhxQKQgu5XB5nLtREJh2j_9J3zPO4gNg@mail.gmail.com>
Date:   Thu, 6 May 2021 12:40:40 +0530
Cc:     Allen Pais <allen.lkml@gmail.com>, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51FC863B-96C5-47BA-8EBF-3D9FB6DE7DD2@linux.microsoft.com>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210225090610.242623-2-allen.lkml@gmail.com>
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
 <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
 <CAHUa44FyGOj5=Z80km_2T-avKiJpGVD8cWjTC3ZCX8csazP3rw@mail.gmail.com>
 <409F60D9-F0FB-4B69-B64B-CC6B3704038E@linux.microsoft.com>
 <CAHUa44EZprsEKbd_mzGhxQKQgu5XB5nLtREJh2j_9J3zPO4gNg@mail.gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
>>>>>> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with =
error -22
>>>>>>=20
>>>>>> tee_shm_release() is not invoked on dma shm buffer.
>>>>>>=20
>>>>>> Implement .shutdown() method to handle the release of the buffers
>>>>>> correctly.
>>>>>>=20
>>>>>> More info:
>>>>>> https://github.com/OP-TEE/optee_os/issues/3637
>>>>>>=20
>>>>>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>>>>>> ---
>>>>>> drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>>>>>> 1 file changed, 20 insertions(+)
>>>>>=20
>>>>> This looks good to me. Do you have a practical way of testing this =
on
>>>>> QEMU for instance?
>>>>>=20
>>>>=20
>>>> Jens,
>>>>=20
>>>>  I could not reproduce nor create a setup using QEMU, I could only
>>>> do it on a real h/w.
>>>>=20
>>>>  I have extensively tested the fix and I don't see any issues.
>>>=20
>>> I did a few test runs too, seems OK.
>>=20
>> I carried these changes and have not run into any issues with Kexec =
so far.
>> Last week, while trying out kdump, we ran into a crash(this is when =
the
>> Kdump kernel reboots).
>>=20
>> $echo c > /proc/sysrq-trigger
>>=20
>> Leads to:
>>=20
>> [   18.004831] Unable to handle kernel paging request at virtual =
address ffff0008dcef6758
>> [   18.013002] Mem abort info:
>> [   18.015885]   ESR =3D 0x96000005
>> [   18.019034]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> [   18.024516]   SET =3D 0, FnV =3D 0
>> [   18.027667]   EA =3D 0, S1PTW =3D 0
>> [   18.030905] Data abort info:
>> [   18.033877]   ISV =3D 0, ISS =3D 0x00000005
>> [   18.037835]   CM =3D 0, WnR =3D 0
>> [   18.040896] swapper pgtable: 4k pages, 48-bit VAs, =
pgdp=3D0000000970a78000
>> [   18.047811] [ffff0008dcef6758] pgd=3D000000097fbf9003, =
pud=3D0000000000000000
>> [   18.054819] Internal error: Oops: 96000005 [#1] SMP
>> [   18.059850] Modules linked in: bnxt_en pcie_iproc_platform =
pcie_iproc diagbe(O)
>> [   18.067395] CPU: 3 PID: 1 Comm: systemd-shutdow Tainted: G         =
  O      5.4.83-microsoft-standard #1
>> [   18.077174] Hardware name: Overlake (DT)
>> [   18.081219] pstate: 80400005 (Nzcv daif +PAN -UAO)
>> [   18.086170] pc : tee_shm_free+0x18/0x48
>> [   18.090126] lr : optee_disable_shm_cache+0xa4/0xf0
>> [   18.095066] sp : ffff80001005bb90
>> [   18.098484] x29: ffff80001005bb90 x28: ffff000037e20000
>> [   18.103962] x27: 0000000000000000 x26: ffff00003ed10490
>> [   18.109440] x25: ffffca760e975f90 x24: 0000000000000000
>> [   18.114918] x23: ffffca760ed79808 x22: ffff00003ec66e18
>> [   18.120396] x21: ffff80001005bc08 x20: 00000000b200000a
>> [   18.125874] x19: ffff0008dcef6700 x18: 0000000000000010
>> [   18.131352] x17: 0000000000000000 x16: 0000000000000000
>> [   18.136829] x15: ffffffffffffffff x14: ffffca760ed79808
>> [   18.142307] x13: ffff80009005b897 x12: ffff80001005b89f
>> [   18.147786] x11: ffffca760eda4000 x10: ffff80001005b820
>> [   18.153264] x9 : 00000000ffffffd0 x8 : ffffca760e59b2c0
>> [   18.158742] x7 : 0000000000000000 x6 : 0000000000000000
>> [   18.164220] x5 : 0000000000000000 x4 : 0000000000000000
>> [   18.169698] x3 : 0000000000000000 x2 : ffff0008dcef6700
>> [   18.175175] x1 : 00000000ffff0008 x0 : ffffca760e59ca04
>> [   18.180654] Call trace:
>> [   18.183176]  tee_shm_free+0x18/0x48
>> [   18.186773]  optee_disable_shm_cache+0xa4/0xf0
>> [   18.191356]  optee_shutdown+0x20/0x30
>> [   18.195135]  platform_drv_shutdown+0x2c/0x38
>> [   18.199538]  device_shutdown+0x180/0x298
>> [   18.203586]  kernel_restart_prepare+0x44/0x50
>> [   18.208078]  kernel_restart+0x20/0x68
>> [   18.211853]  __do_sys_reboot+0x104/0x258
>> [   18.215899]  __arm64_sys_reboot+0x2c/0x38
>> [   18.220035]  el0_svc_handler+0x90/0x138
>> [   18.223991]  el0_svc+0x8/0x208
>> [   18.227143] Code: f9000bf3 aa0003f3 aa1e03e0 d503201f (b9405a60)
>> [   18.233435] ---[ end trace 835d756cd66aa959 ]---
>> [   18.238621] Kernel panic - not syncing: Fatal exception
>> [   18.244014] Kernel Offset: 0x4a75fde00000 from 0xffff800010000000
>> [   18.250299] PHYS_OFFSET: 0xffff99c680000000
>> [   18.254613] CPU features: 0x0002,21806008
>> [   18.258747] Memory Limit: none
>> [   18.262310] ---[ end Kernel panic - not syncing: Fatal exception =
]=E2=80=94
>>=20
>> I see that before secure world returns =
OPTEE_SMC_RETURN_ENOTAVAIL(which
>> Should disable and clear all the cache) we run into the crash trying =
to free shm.
>>=20
>> Thoughts?
>=20
> It seems that the pointer is invalid, but the pointer doesn't look
> like garbage. Could the kernel have unmapped the memory area covering
> that address?
>=20

 Yes, I am not entirely sure if the kernel had the time to unmap the =
memory.
Right after triggering the crash the kdump kernel is booted and I see =
the following

[ 2.050145] optee: probing for conduit method.=20
[ 2.054743] optee: revision 3.6 (f84427aa)=20
[ 2.054821] optee: dynamic shared memory is enabled=20
[ 2.066186] optee: initialized driver=20

Could this be previous un-released maps causing corruption?

Thanks.=
