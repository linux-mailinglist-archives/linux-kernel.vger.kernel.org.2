Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C423F46BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhHWIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:41:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40596 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbhHWIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:41:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C9C3D1FF86;
        Mon, 23 Aug 2021 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629708052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gubIoPPxpIyVQ8h3OB0Y0fmoj4ls2gzechz38BRCTaI=;
        b=QEqQL15rZ79ALIAb+4dp/xW0mFPmPFQg8NL0nF4tFb+awIkWeiFGEqJXEKV+VzPfKeh7kd
        wlL8OR0gk2v1Yt6kPJGg1wDD/EA5XuJrhSUTICVha+XEXTEyFSUmfq0etuyIsgpR1B1w1U
        MnXwUCkO9RQ/ZwjPGKi935K4ngyQLVs=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 55D3113A12;
        Mon, 23 Aug 2021 08:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 9QzaEhRfI2EWZgAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 23 Aug 2021 08:40:52 +0000
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
        rostedt@goodmis.org, dvyukov@google.com, elver@google.com
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
 <20210820193107.omvshmsqbpxufzkc@treble>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
Date:   Mon, 23 Aug 2021 10:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820193107.omvshmsqbpxufzkc@treble>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qsNSH97XrotVcJ8VdwzuG0l96GXoTnoj4"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qsNSH97XrotVcJ8VdwzuG0l96GXoTnoj4
Content-Type: multipart/mixed; boundary="v7O9DOxhYbMgJdmmM1ggRcf6MAvWYS29s";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
 boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
 rostedt@goodmis.org, dvyukov@google.com, elver@google.com
Message-ID: <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
 <20210820193107.omvshmsqbpxufzkc@treble>
In-Reply-To: <20210820193107.omvshmsqbpxufzkc@treble>

--v7O9DOxhYbMgJdmmM1ggRcf6MAvWYS29s
Content-Type: multipart/mixed;
 boundary="------------13BCEB8768998A12ACC48350"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------13BCEB8768998A12ACC48350
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 20.08.21 21:31, Josh Poimboeuf wrote:
> On Fri, Aug 20, 2021 at 12:22:28PM -0700, Josh Poimboeuf wrote:
>> On Thu, Jun 24, 2021 at 11:41:00AM +0200, Peter Zijlstra wrote:
>>> The asm_cpu_bringup_and_idle() function is required to push the retur=
n
>>> value on the stack in order to make ORC happy, but the only reason
>>> objtool doesn't complain is because of a happy accident.
>>>
>>> The thing is that asm_cpu_bringup_and_idle() doesn't return, so
>>> validate_branch() never terminates and falls through to the next
>>> function, which in the normal case is the hypercall_page. And that, a=
s
>>> it happens, is 4095 NOPs and a RET.
>>>
>>> Make asm_cpu_bringup_and_idle() terminate on it's own, by making the
>>> function it calls as a dead-end. This way we no longer rely on what
>>> code happens to come after.
>>>
>>> Fixes: c3881eb58d56 ("x86/xen: Make the secondary CPU idle tasks reli=
able")
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> Looks right.  Only problem is, with my assembler I get this:
>>
>>    arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable=
 instruction
>>
>> Because gas insists on jumping over the page of nops...
>>
>> 0000000000000000 <asm_cpu_bringup_and_idle>:
>>         0:	e8 00 00 00 00       	callq  5 <asm_cpu_bringup_and_idle+0x=
5>
>> 			1: R_X86_64_PLT32	cpu_bringup_and_idle-0x4
>>         5:	e9 f6 0f 00 00       	jmpq   1000 <xen_hypercall_set_trap_t=
able>
>>         a:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>>        11:	00 00 00 00
>>        15:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>>        1c:	00 00 00 00
>>        20:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>>        27:	00 00 00 00
>>        2b:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>>        32:	00 00 00 00
>>        36:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>>        3d:	00 00 00 00
>=20
> Here's a fix:
>=20
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] x86/xen: Move hypercall_page to top of the file
>=20
> Because hypercall_page is page-aligned, the assembler inexplicably adds=

> an unreachable jump from after the end of the previous code to the
> beginning of hypercall_page.
>=20
> That confuses objtool, understandably.  It also creates significant tex=
t
> fragmentation.  As a result, much of the object file is wasted text
> (nops).
>=20
> Move hypercall_page to the beginning of the file to both prevent the
> text fragmentation and avoid the dead jump instruction.
>=20
> $ size /tmp/head_64.before.o /tmp/head_64.after.o
>     text	   data	    bss	    dec	    hex	filename
>    10924	 307252	   4096	 322272	  4eae0	/tmp/head_64.before.o
>     6823	 307252	   4096	 318171	  4dadb	/tmp/head_64.after.o
>=20
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

> ---
>   arch/x86/xen/xen-head.S | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index cb6538ae2fe0..488944d6d430 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -20,6 +20,23 @@
>   #include <xen/interface/xen-mca.h>
>   #include <asm/xen/interface.h>
>  =20
> +.pushsection .text
> +	.balign PAGE_SIZE
> +SYM_CODE_START(hypercall_page)
> +	.rept (PAGE_SIZE / 32)
> +		UNWIND_HINT_FUNC
> +		.skip 31, 0x90
> +		ret
> +	.endr
> +
> +#define HYPERCALL(n) \
> +	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
> +	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
> +#include <asm/xen-hypercalls.h>
> +#undef HYPERCALL
> +SYM_CODE_END(hypercall_page)
> +.popsection
> +
>   #ifdef CONFIG_XEN_PV
>   	__INIT
>   SYM_CODE_START(startup_xen)
> @@ -64,23 +81,6 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
>   #endif
>   #endif
>  =20
> -.pushsection .text
> -	.balign PAGE_SIZE
> -SYM_CODE_START(hypercall_page)
> -	.rept (PAGE_SIZE / 32)
> -		UNWIND_HINT_FUNC
> -		.skip 31, 0x90
> -		ret
> -	.endr
> -
> -#define HYPERCALL(n) \
> -	.equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
> -	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
> -#include <asm/xen-hypercalls.h>
> -#undef HYPERCALL
> -SYM_CODE_END(hypercall_page)
> -.popsection
> -
>   	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
>   	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
>   	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
>=20


--------------13BCEB8768998A12ACC48350
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

--------------13BCEB8768998A12ACC48350--

--v7O9DOxhYbMgJdmmM1ggRcf6MAvWYS29s--

--qsNSH97XrotVcJ8VdwzuG0l96GXoTnoj4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmEjXxMFAwAAAAAACgkQsN6d1ii/Ey9k
wAf+I0EbSbW4XM2z7Anwbon908HxyRo+sWLVMlC37IIwiUW5qn0AScGL+3omLlogBr8Ndl88tapp
76V6fmGDACvC8i4wYx31yiCqN/pGn5BaCL0Kwo5IBgxMjOQsbgibzVtiDd8gYI9szSCrvXNZWnAz
UoXhyo1tbzNePv+uN0Qmg7tnyGUvH5SZFoxj5q2tOQPN5EPOBVoKgW+EzDBiaSB/rk/Zq2XVEO1s
p4ILeTgqtke9LMp2+NqktplIdJRh/aXwqMgkEEOGx5fKzGaeovkLL2LHlvLnhUMomfTBr7tFZhiH
KepWWtL6/vJDlHYN6RxruLcOOMlhtiHR3h3obFklDA==
=feKL
-----END PGP SIGNATURE-----

--qsNSH97XrotVcJ8VdwzuG0l96GXoTnoj4--
