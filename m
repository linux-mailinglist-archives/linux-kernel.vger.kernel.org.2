Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE43762E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhEGJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:34:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36162 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhEGJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:34:03 -0400
Received: from minint-m3g9p8n.europe.corp.microsoft.com (unknown [49.207.195.141])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1D7AF20B7178;
        Fri,  7 May 2021 02:33:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D7AF20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1620379984;
        bh=AAKa+WXf4npmVNkCzj93bcUly6WwXQf3/AhT89AJV4I=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=itdmyfZMW69Z6wXF5OzikjEijoDF3XyNkT70NpqBKspDAsMr2MWOe16JR+SACV2Mm
         RoGRWU+Niq/FS1QsY8sAHlgKeyODwqsSpQICsWpfv0xwUiS946aDL4VMkpngVxEbUT
         xrWHPGyfoVphcaZdwFjWQ1UgtAcQbc+oS2QV1rxU=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] optee: Disable shm cache when booting the crash kernel
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <CAHUa44FHo2_EUzFzHnakkm3o7H-Nn+k4hgqT2WNFezZO6D8mxA@mail.gmail.com>
Date:   Fri, 7 May 2021 15:02:58 +0530
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>, zajec5@gmail.com,
        Allen Pais <allen.lkml@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <14C574FD-AF31-4D10-9685-E59FDD248C2C@linux.microsoft.com>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210507035816.426585-1-tyhicks@linux.microsoft.com>
 <720CDF03-42F9-43C3-B3B3-999E4A5E2864@linux.microsoft.com>
 <CAHUa44FHo2_EUzFzHnakkm3o7H-Nn+k4hgqT2WNFezZO6D8mxA@mail.gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>=20
>>=20
>>> On 07-May-2021, at 9:28 AM, Tyler Hicks =
<tyhicks@linux.microsoft.com> wrote:
>>>=20
>>> The .shutdown hook is not called after a kernel crash when a kdump
>>> kernel is pre-loaded. A kexec into the kdump kernel takes place as
>>> quickly as possible without allowing drivers to clean up.
>>>=20
>>> That means that the OP-TEE shared memory cache, which was =
initialized by
>>> the kernel that crashed, is still in place when the kdump kernel is
>>> booted. As the kdump kernel is shutdown, the .shutdown hook is =
called,
>>> which calls optee_disable_shm_cache(), and OP-TEE's
>>> OPTEE_SMC_DISABLE_SHM_CACHE API returns virtual addresses that are =
not
>>> mapped for the kdump kernel since the cache was set up by the =
previous
>>> kernel. Trying to dereference the tee_shm pointer or otherwise =
translate
>>> the address results in a fault that cannot be handled:
>>>=20
>>> Unable to handle kernel paging request at virtual address =
ffff4317b9c09744
>>> Mem abort info:
>>>  ESR =3D 0x96000004
>>>  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>>>  SET =3D 0, FnV =3D 0
>>>  EA =3D 0, S1PTW =3D 0
>>> Data abort info:
>>>  ISV =3D 0, ISS =3D 0x00000004
>>>  CM =3D 0, WnR =3D 0
>>> swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000970b1e000
>>> [ffff4317b9c09744] pgd=3D0000000000000000, p4d=3D0000000000000000
>>> Internal error: Oops: 96000004 [#1] SMP
>>> Modules linked in: bnxt_en pcie_iproc_platform pcie_iproc diagbe(O)
>>> CPU: 4 PID: 1 Comm: systemd-shutdow Tainted: G           O      =
5.10.19.8 #1
>>> Hardware name: Redacted (DT)
>>> pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
>>> pc : tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
>>> lr : optee_disable_shm_cache =
(/usr/src/kernel/drivers/tee/optee/call.c:441)
>>> sp : ffff80001005bb70
>>> x29: ffff80001005bb70 x28: ffff608e74648e00
>>> x27: ffff80001005bb98 x26: dead000000000100
>>> x25: ffff80001005bbb8 x24: aaaaaaaaaaaaaaaa
>>> x23: ffff608e74cf8818 x22: ffff608e738be600
>>> x21: ffff80001005bbc8 x20: ffff608e738be638
>>> x19: ffff4317b9c09700 x18: ffffffffffffffff
>>> x17: 0000000000000041 x16: ffffba61b5171764
>>> x15: 0000000000000004 x14: 0000000000000fff
>>> x13: ffffba61b5c9dfc8 x12: 0000000000000003
>>> x11: 0000000000000000 x10: 0000000000000000
>>> x9 : ffffba61b5413824 x8 : 00000000ffff4317
>>> x7 : 0000000000000000 x6 : 0000000000000000
>>> x5 : 0000000000000000 x4 : 0000000000000000
>>> x3 : 0000000000000000 x2 : ffff4317b9c09700
>>> x1 : 00000000ffff4317 x0 : ffff4317b9c09700
>>> Call trace:
>>> tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
>>> optee_disable_shm_cache =
(/usr/src/kernel/drivers/tee/optee/call.c:441)
>>> optee_shutdown (/usr/src/kernel/drivers/tee/optee/core.c:636)
>>> platform_drv_shutdown (/usr/src/kernel/drivers/base/platform.c:800)
>>> device_shutdown (/usr/src/kernel/include/linux/device.h:758 =
/usr/src/kernel/drivers/base/core.c:4078)
>>> kernel_restart (/usr/src/kernel/kernel/reboot.c:221 =
/usr/src/kernel/kernel/reboot.c:248)
>>> __arm64_sys_reboot (/usr/src/kernel/kernel/reboot.c:349 =
/usr/src/kernel/kernel/reboot.c:312 /usr/src/kernel/kernel/reboot.c:312)
>>> do_el0_svc (/usr/src/kernel/arch/arm64/kernel/syscall.c:56 =
/usr/src/kernel/arch/arm64/kernel/syscall.c:158 =
/usr/src/kernel/arch/arm64/kernel/syscall.c:197)
>>> el0_svc (/usr/src/kernel/arch/arm64/kernel/entry-common.c:368)
>>> el0_sync_handler =
(/usr/src/kernel/arch/arm64/kernel/entry-common.c:428)
>>> el0_sync (/usr/src/kernel/arch/arm64/kernel/entry.S:671)
>>> Code: aa0003f3 b5000060 12800003 14000002 (b9404663)
>>>=20
>>> When booting the kdump kernel, drain the shared memory cache while =
being
>>> careful to not translate the addresses returned from
>>> OPTEE_SMC_DISABLE_SHM_CACHE. Once the invalid cache objects are =
drained
>>> and the cache is disabled, proceed with re-enabling the cache so =
that we
>>> aren't dealing with invalid addresses while shutting down the kdump
>>> kernel.
>>>=20
>>> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>>> ---
>>>=20
>>> This patch fixes a crash introduced by "optee: fix tee out of memory
>>> failure seen during kexec reboot"[1]. However, I don't think that =
the
>>> original two patch series[2] plus this patch is the full solution to
>>> properly handling OP-TEE shared memory across kexec.
>>>=20
>>> While testing this fix, I did about 10 kexec reboots and then =
triggered
>>> a kernel crash by writing 'c' to /proc/sysrq-trigger. The kdump =
kernel
>>> became unresponsive during boot while steadily streaming the =
following
>>> errors to the serial console:
>>>=20
>>> arm-smmu 64000000.mmu: Blocked unknown Stream ID 0x2000; boot with =
"arm-smmu.disable_bypass=3D0" to allow, but this may have security =
implications
>>> arm-smmu 64000000.mmu:     GFSR 0x00000002, GFSYNR0 0x00000002, =
GFSYNR1 0x00002000, GFSYNR2 0x00000000
>>>=20
>>> I suspect that this is related to the problems of OP-TEE shared =
memory
>>> handling across kexec. My current hunch is that while we've disabled =
the
>>> shared memory cache with this patch, we haven't unregistered all of =
the
>>> addresses that the previous kernel (which crashed) had registered =
with
>>> OP-TEE and that perhaps OP-TEE OS is still trying to make use those
>>> addresses?
>>>=20
>>> I'm still pretty early in investigating that assumption and
>>> I'm learning about OP-TEE as I go but I wanted to get this initial
>>> fix-of-the-fix out so that it was clear that the v2 of the series[2] =
is
>>> not complete.
>>>=20
>>> [1] =
https://lore.kernel.org/lkml/20210225090610.242623-2-allen.lkml@gmail.com/=

>>> [2] =
https://lore.kernel.org/lkml/20210225090610.242623-1-allen.lkml@gmail.com/=
#t
>>>=20
>>> drivers/tee/optee/call.c          | 11 ++++++++++-
>>> drivers/tee/optee/core.c          | 13 +++++++++++--
>>> drivers/tee/optee/optee_private.h |  2 +-
>>> 3 files changed, 22 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
>>> index 6132cc8d014c..799e84bec63d 100644
>>> --- a/drivers/tee/optee/call.c
>>> +++ b/drivers/tee/optee/call.c
>>> @@ -417,8 +417,10 @@ void optee_enable_shm_cache(struct optee =
*optee)
>>> * optee_disable_shm_cache() - Disables caching of some shared memory =
allocation
>>> *                          in OP-TEE
>>> * @optee:    main service struct
>>> + * @is_mapped:       true if the cached shared memory addresses =
were mapped by this
>>> + *           kernel, are safe to dereference, and should be freed
>>> */
>>> -void optee_disable_shm_cache(struct optee *optee)
>>> +void optee_disable_shm_cache(struct optee *optee, bool is_mapped)
>>> {
>>>      struct optee_call_waiter w;
>>>=20
>>> @@ -437,6 +439,13 @@ void optee_disable_shm_cache(struct optee =
*optee)
>>>              if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK) {
>>>                      struct tee_shm *shm;
>>>=20
>>=20
>> Thanks Tyler.
>> =46rom what I understand from my email exchange with Jens, I don=E2=80=99=
t
>> Think we want to touch optee_disable_shm_cache(), I could be wrong =
too,
>> @Jens, comments?
>=20
> Changing optee_disable_shm_cache() is fine. Bear in mind that there
> are other times where we can't recover from a kernel crash. For
> instance if a thread is executing in OP-TEE in secure world.

I agree. My bad, I meant, =E2=80=9Cwe don=E2=80=99t want to touch =
optee_disable_shm_cache()=E2=80=9D.
And precisely for the reason you have mentioned above.

Thanks.=
