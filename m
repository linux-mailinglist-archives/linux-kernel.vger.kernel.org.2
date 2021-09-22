Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F36414A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhIVNaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:30:22 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:57883 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbhIVNaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1632317330; bh=RodfW4bUHt8EGYhK9AjVjeL8HXHZ0mndLyop4t9ZHFI=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=oYBEnpJ4qpnibOMIW1R8++ExPPZau1G3C/caQu53DxW4iJDacHwLI9ixro1NtFKsS
         pDUO358tRLsmQrFM48D6JJCQ2TdA49UhD7qIggzGyU/9nq1k4xJ0YfaG1zEQR+4km/
         mttWL52IzGp+9Czw22C8mwA0rCBfTFSCE/IJadJ6Hs699Si1TuIJCGb5YDxm8mf3WE
         5X7caqvQDAewv6ZGjXFi6typUZnrc7jpduNfEbfqntm1mLSfOx5whzEMLwUkjYYngM
         Sa2DKQZTenYy2VTDpHBCSc90mRBCVj+Btxi631PokxxbHOQIAMzTRX11aam3aIwctK
         cw4Ns9f88LyqQ==
Received: from 192.168.1.9 (unknown [120.245.3.47])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 5D00DA401D7;
        Wed, 22 Sep 2021 13:28:40 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH RESEND 2/2] x86/mm: Randomize va with generic
 arch_pick_mmap_layout()
From:   Xiongwei Song <sxwjean@me.com>
In-Reply-To: <YUnvKV0Qf6zhiasz@hirez.programming.kicks-ass.net>
Date:   Wed, 22 Sep 2021 21:28:36 +0800
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>, adobriyan@gmail.com,
        oleg@redhat.com, sblbir@amazon.com, axboe@kernel.dk,
        laijs@linux.alibaba.com, dave.hansen@linux.intel.com,
        akpm@linux-foundation.org, arnd@arndb.de, davem@davemloft.net,
        keescook@chromium.org, kim.phillips@amd.com, yazen.ghannam@amd.com,
        dave@stgolabs.net, metze@samba.org, elver@google.com,
        ebiederm@xmission.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5C77677-F529-4C77-8155-CE8424F8B16B@me.com>
References: <20210921143414.70723-1-sxwjean@me.com>
 <20210921143414.70723-3-sxwjean@me.com>
 <YUnvKV0Qf6zhiasz@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-22_05:2021-09-22,2021-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=872 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2109220096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 21, 2021, at 10:41 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Tue, Sep 21, 2021 at 10:34:14PM +0800, sxwjean@me.com wrote:
>> diff --git a/arch/x86/include/asm/compat.h =
b/arch/x86/include/asm/compat.h
>> index 7516e4199b3c..c697e377644d 100644
>> --- a/arch/x86/include/asm/compat.h
>> +++ b/arch/x86/include/asm/compat.h
>> @@ -151,6 +151,11 @@ struct compat_shmid64_ds {
>> 	compat_ulong_t __unused5;
>> };
>>=20
>> +static inline int is_compat_task(void)
>> +{
>> +	return IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT);
>> +}
>> +
>=20
> This is still fundamentally broken for x86. x86 doesn't have compat
> tasks, the granularity is at syscall at best.

Hi Peter,

Thank you for pointing this out. I understand now a 64bit task can call =
a 32bit syscall.=20
Here we should use in_compat_syscall() to check if the kernel is in =
compat mode, right?

Regards,
Xiongwei=
