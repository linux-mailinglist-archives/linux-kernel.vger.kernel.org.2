Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2923FB0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhH3F4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:56:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40158 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhH3Fz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:55:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0598220D1;
        Mon, 30 Aug 2021 05:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630302903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uTBj86RTI+FWUJfzsqYfYaZDS8DrU+QKyc70vkBKs70=;
        b=LweBlfx9ywszpv4JwQ21/z5ot32wPRvcv56JET/z83/js2pemiIGVjhiTviWqGmnvzlaIu
        4vhVZQZCk3hn67HFc+KzMgrIsMrD2z+Yz5Sgh+KVHUHvADbOPfgJj6KclZz/FzTk+jLVkd
        fcJxiWNt1TJgAsuMRnbz07T0iFzasbM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 38FCD1365C;
        Mon, 30 Aug 2021 05:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gBW7C7dyLGHkAwAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 30 Aug 2021 05:55:03 +0000
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
From:   Juergen Gross <jgross@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
        rostedt@goodmis.org, dvyukov@google.com, elver@google.com
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
 <20210820193107.omvshmsqbpxufzkc@treble>
 <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
Message-ID: <d27cd344-1323-803c-d26d-9aa851681b69@suse.com>
Date:   Mon, 30 Aug 2021 07:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R3w276Ku5DYLI3cc7w1fvDKGJnQXNQX8d"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R3w276Ku5DYLI3cc7w1fvDKGJnQXNQX8d
Content-Type: multipart/mixed; boundary="LKKdSb67ebz4m22FCw0tNCzSbIS3iUIMu";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
 boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
 rostedt@goodmis.org, dvyukov@google.com, elver@google.com
Message-ID: <d27cd344-1323-803c-d26d-9aa851681b69@suse.com>
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
 <20210820193107.omvshmsqbpxufzkc@treble>
 <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
In-Reply-To: <fc90e972-f81f-3706-b13a-988b16264650@suse.com>

--LKKdSb67ebz4m22FCw0tNCzSbIS3iUIMu
Content-Type: multipart/mixed;
 boundary="------------73F28B25A81701316A2B8CEE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------73F28B25A81701316A2B8CEE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 23.08.21 10:40, Juergen Gross wrote:
> On 20.08.21 21:31, Josh Poimboeuf wrote:
>> On Fri, Aug 20, 2021 at 12:22:28PM -0700, Josh Poimboeuf wrote:
>>> On Thu, Jun 24, 2021 at 11:41:00AM +0200, Peter Zijlstra wrote:
>>>> The asm_cpu_bringup_and_idle() function is required to push the retu=
rn
>>>> value on the stack in order to make ORC happy, but the only reason
>>>> objtool doesn't complain is because of a happy accident.
>>>>
>>>> The thing is that asm_cpu_bringup_and_idle() doesn't return, so
>>>> validate_branch() never terminates and falls through to the next
>>>> function, which in the normal case is the hypercall_page. And that, =
as
>>>> it happens, is 4095 NOPs and a RET.
>>>>
>>>> Make asm_cpu_bringup_and_idle() terminate on it's own, by making the=

>>>> function it calls as a dead-end. This way we no longer rely on what
>>>> code happens to come after.
>>>>
>>>> Fixes: c3881eb58d56 ("x86/xen: Make the secondary CPU idle tasks=20
>>>> reliable")
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>
>>> Looks right.=C2=A0 Only problem is, with my assembler I get this:
>>>
>>> =C2=A0=C2=A0 arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: =

>>> unreachable instruction
>>>
>>> Because gas insists on jumping over the page of nops...
>>>
>>> 0000000000000000 <asm_cpu_bringup_and_idle>:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0 e8 00=
 00 00 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cal=
lq=C2=A0 5=20
>>> <asm_cpu_bringup_and_idle+0x5>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:=
 R_X86_64_PLT32=C2=A0=C2=A0=C2=A0 cpu_bringup_and_idle-0x4
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5:=C2=A0=C2=A0=C2=A0 e9 f6=
 0f 00 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jmp=
q=C2=A0=C2=A0 1000=20
>>> <xen_hypercall_set_trap_table>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a:=C2=A0=C2=A0=C2=A0 66 66=
 2e 0f 1f 84 00=C2=A0=C2=A0=C2=A0=C2=A0 data16 nopw %cs:0x0(%rax,%rax,1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11:=C2=A0=C2=A0=C2=A0 00 00 00 0=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15:=C2=A0=C2=A0=C2=A0 66 66 2e 0=
f 1f 84 00=C2=A0=C2=A0=C2=A0=C2=A0 data16 nopw %cs:0x0(%rax,%rax,1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1c:=C2=A0=C2=A0=C2=A0 00 00 00 0=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20:=C2=A0=C2=A0=C2=A0 66 66 2e 0=
f 1f 84 00=C2=A0=C2=A0=C2=A0=C2=A0 data16 nopw %cs:0x0(%rax,%rax,1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27:=C2=A0=C2=A0=C2=A0 00 00 00 0=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2b:=C2=A0=C2=A0=C2=A0 66 66 2e 0=
f 1f 84 00=C2=A0=C2=A0=C2=A0=C2=A0 data16 nopw %cs:0x0(%rax,%rax,1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32:=C2=A0=C2=A0=C2=A0 00 00 00 0=
0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36:=C2=A0=C2=A0=C2=A0 66 66 2e 0=
f 1f 84 00=C2=A0=C2=A0=C2=A0=C2=A0 data16 nopw %cs:0x0(%rax,%rax,1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3d:=C2=A0=C2=A0=C2=A0 00 00 00 0=
0
>>
>> Here's a fix:
>>
>> From: Josh Poimboeuf <jpoimboe@redhat.com>
>> Subject: [PATCH] x86/xen: Move hypercall_page to top of the file
>>
>> Because hypercall_page is page-aligned, the assembler inexplicably add=
s
>> an unreachable jump from after the end of the previous code to the
>> beginning of hypercall_page.
>>
>> That confuses objtool, understandably.=C2=A0 It also creates significa=
nt text
>> fragmentation.=C2=A0 As a result, much of the object file is wasted te=
xt
>> (nops).
>>
>> Move hypercall_page to the beginning of the file to both prevent the
>> text fragmentation and avoid the dead jump instruction.
>>
>> $ size /tmp/head_64.before.o /tmp/head_64.after.o
>> =C2=A0=C2=A0=C2=A0 text=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hex=C2=A0=C2=A0=C2=
=A0 filename
>> =C2=A0=C2=A0 10924=C2=A0=C2=A0=C2=A0=C2=A0 307252=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4096=C2=A0=C2=A0=C2=A0=C2=A0 322272=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 4eae0   =20
>> /tmp/head_64.before.o
>> =C2=A0=C2=A0=C2=A0 6823=C2=A0=C2=A0=C2=A0=C2=A0 307252=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 4096=C2=A0=C2=A0=C2=A0=C2=A0 318171=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 4dadb   =20
>> /tmp/head_64.after.o
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com
>=20
> Reviewed-by: Juergen Gross <jgross@suse.com>

Umm, will this be carried through the tip tree, or shall I take it in
the xen tree?


Juergen

>=20
>=20
> Juergen
>=20
>> ---
>> =C2=A0 arch/x86/xen/xen-head.S | 34 +++++++++++++++++-----------------=

>> =C2=A0 1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
>> index cb6538ae2fe0..488944d6d430 100644
>> --- a/arch/x86/xen/xen-head.S
>> +++ b/arch/x86/xen/xen-head.S
>> @@ -20,6 +20,23 @@
>> =C2=A0 #include <xen/interface/xen-mca.h>
>> =C2=A0 #include <asm/xen/interface.h>
>> +.pushsection .text
>> +=C2=A0=C2=A0=C2=A0 .balign PAGE_SIZE
>> +SYM_CODE_START(hypercall_page)
>> +=C2=A0=C2=A0=C2=A0 .rept (PAGE_SIZE / 32)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UNWIND_HINT_FUNC
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .skip 31, 0x90
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret
>> +=C2=A0=C2=A0=C2=A0 .endr
>> +
>> +#define HYPERCALL(n) \
>> +=C2=A0=C2=A0=C2=A0 .equ xen_hypercall_##n, hypercall_page + __HYPERVI=
SOR_##n * 32; \
>> +=C2=A0=C2=A0=C2=A0 .type xen_hypercall_##n, @function; .size xen_hype=
rcall_##n, 32
>> +#include <asm/xen-hypercalls.h>
>> +#undef HYPERCALL
>> +SYM_CODE_END(hypercall_page)
>> +.popsection
>> +
>> =C2=A0 #ifdef CONFIG_XEN_PV
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __INIT
>> =C2=A0 SYM_CODE_START(startup_xen)
>> @@ -64,23 +81,6 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
>> =C2=A0 #endif
>> =C2=A0 #endif
>> -.pushsection .text
>> -=C2=A0=C2=A0=C2=A0 .balign PAGE_SIZE
>> -SYM_CODE_START(hypercall_page)
>> -=C2=A0=C2=A0=C2=A0 .rept (PAGE_SIZE / 32)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UNWIND_HINT_FUNC
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .skip 31, 0x90
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret
>> -=C2=A0=C2=A0=C2=A0 .endr
>> -
>> -#define HYPERCALL(n) \
>> -=C2=A0=C2=A0=C2=A0 .equ xen_hypercall_##n, hypercall_page + __HYPERVI=
SOR_##n * 32; \
>> -=C2=A0=C2=A0=C2=A0 .type xen_hypercall_##n, @function; .size xen_hype=
rcall_##n, 32
>> -#include <asm/xen-hypercalls.h>
>> -#undef HYPERCALL
>> -SYM_CODE_END(hypercall_page)
>> -.popsection
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .asciz "linux")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,=
=C2=A0 .asciz "2.6")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,=C2=
=A0=C2=A0=C2=A0 .asciz "xen-3.0")
>>
>=20


--------------73F28B25A81701316A2B8CEE
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------73F28B25A81701316A2B8CEE--

--LKKdSb67ebz4m22FCw0tNCzSbIS3iUIMu--

--R3w276Ku5DYLI3cc7w1fvDKGJnQXNQX8d
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmEscrYFAwAAAAAACgkQsN6d1ii/Ey/f
kgf+KNTlxDdbT+9e5LBxbl6PB+6Ur6uhP2RFg6cU6bskWNZ5CxsTGO0aj7OohR/BqZ2vIxV09Q1T
ZQjPQd2CGAnBo9B7KouYJfPvSS7Ti8Xz0S/cqPamYCJsCHeohm1fV9+DWLQ23qXNdgHWZLwj4wPq
WbyPx+2gNK0zc+aPAgA/s+eGk/rw20CDPb4Lp2cHQrcOeACgOINAqPhtew99E2v4qYbHKDYBG5mx
OoWKpCKKauTonA1JPsvvYlrBFX7b56NYOA/fDaL2uQYSpbTJmJk3E3P3livdWPLoqM78H2F/q0Ug
etPutAHMbkDVkyPA4ww1fxjmUiip0PECEe8ekbmDvg==
=X+LW
-----END PGP SIGNATURE-----

--R3w276Ku5DYLI3cc7w1fvDKGJnQXNQX8d--
