Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A053FB227
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhH3H46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:56:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35136 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhH3H45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:56:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA240220E1;
        Mon, 30 Aug 2021 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630310163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p3DmmI40BjoXM/1VKA1xuDudlcVcAvm18R/cecxtXGE=;
        b=ErVzovtoS3BdnEwHi4JAmHxf3c4aL95D7ytkAILLgxIseB4IF7wl38zOYS+haUVwDYWPLV
        S9Ic6/x2kFO5NaSWHYn2uzfEyQhZVU+OzEUEQw2I57VttOxhsrFckcZBTM902AhNgph+gp
        x2zVKjDW2BRSZ4dGJpJDUYufIg5zggo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4A31E13706;
        Mon, 30 Aug 2021 07:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id dnsmEBOPLGGYHQAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 30 Aug 2021 07:56:03 +0000
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
        rostedt@goodmis.org, dvyukov@google.com, elver@google.com
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
 <20210820193107.omvshmsqbpxufzkc@treble>
 <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
 <d27cd344-1323-803c-d26d-9aa851681b69@suse.com>
 <20210830074834.GE4353@worktop.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <5e879610-6cee-00ac-9959-75f667c1967c@suse.com>
Date:   Mon, 30 Aug 2021 09:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830074834.GE4353@worktop.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9oPAuSg6TUYeaodiPJgEfS2jNUh7SDXZw"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9oPAuSg6TUYeaodiPJgEfS2jNUh7SDXZw
Content-Type: multipart/mixed; boundary="H1KQvp9OOzephwUjJUgV5w5PALZcXowki";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, joro@8bytes.org, boris.ostrovsky@oracle.com,
 x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
 elver@google.com
Message-ID: <5e879610-6cee-00ac-9959-75f667c1967c@suse.com>
Subject: Re: [PATCH v2 01/24] x86/xen: Mark cpu_bringup_and_idle() as
 dead_end_function
References: <20210624094059.886075998@infradead.org>
 <20210624095147.693801717@infradead.org>
 <20210820192224.ytrr6ybuuwegbeov@treble>
 <20210820193107.omvshmsqbpxufzkc@treble>
 <fc90e972-f81f-3706-b13a-988b16264650@suse.com>
 <d27cd344-1323-803c-d26d-9aa851681b69@suse.com>
 <20210830074834.GE4353@worktop.programming.kicks-ass.net>
In-Reply-To: <20210830074834.GE4353@worktop.programming.kicks-ass.net>

--H1KQvp9OOzephwUjJUgV5w5PALZcXowki
Content-Type: multipart/mixed;
 boundary="------------523B7F03BFFD26995ED28A86"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------523B7F03BFFD26995ED28A86
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 30.08.21 09:48, Peter Zijlstra wrote:
> On Mon, Aug 30, 2021 at 07:55:02AM +0200, Juergen Gross wrote:
>>>> From: Josh Poimboeuf <jpoimboe@redhat.com>
>>>> Subject: [PATCH] x86/xen: Move hypercall_page to top of the file
>>>>
>>>> Because hypercall_page is page-aligned, the assembler inexplicably a=
dds
>>>> an unreachable jump from after the end of the previous code to the
>>>> beginning of hypercall_page.
>>>>
>>>> That confuses objtool, understandably.=C2=A0 It also creates signifi=
cant text
>>>> fragmentation.=C2=A0 As a result, much of the object file is wasted =
text
>>>> (nops).
>>>>
>>>> Move hypercall_page to the beginning of the file to both prevent the=

>>>> text fragmentation and avoid the dead jump instruction.
>>>>
>>>> $ size /tmp/head_64.before.o /tmp/head_64.after.o
>>>>  =C2=A0=C2=A0=C2=A0 text=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hex=C2=A0=C2=A0=
=C2=A0 filename
>>>>  =C2=A0=C2=A0 10924=C2=A0=C2=A0=C2=A0=C2=A0 307252=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 4096=C2=A0=C2=A0=C2=A0=C2=A0 322272=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 4eae0
>>>> /tmp/head_64.before.o
>>>>  =C2=A0=C2=A0=C2=A0 6823=C2=A0=C2=A0=C2=A0=C2=A0 307252=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 4096=C2=A0=C2=A0=C2=A0=C2=A0 318171=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 4dadb
>>>> /tmp/head_64.after.o
>>>>
>>>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com
>>>
>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>
>> Umm, will this be carried through the tip tree, or shall I take it in
>> the xen tree?
>=20
> I have it in the whole x86/objtool/paravirt series. I you want it in th=
e
> Xen tree, I'll be happy to drop it from there, although I hope to get
> all that merged this cycles somewhere.
>=20

Okay, I think it is better kept in your series then.


Juergen

--------------523B7F03BFFD26995ED28A86
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

--------------523B7F03BFFD26995ED28A86--

--H1KQvp9OOzephwUjJUgV5w5PALZcXowki--

--9oPAuSg6TUYeaodiPJgEfS2jNUh7SDXZw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmEsjxIFAwAAAAAACgkQsN6d1ii/Ey+o
pgf/WDzFz9r/cNpwoxEUevjjovsCHwmcJ8LNR4vK6+d0JrkY2NYoYd6GmZas/dlmVnmufIA3Nm5U
NHMUZXhk8Y60J0m2gJ38xsDTYlURKeKNnBqLJ2YihFt4KCZ8WjlP7hXsMIBM9Fd7h3pEjB+WaCMO
l7s58nM5Sx1MVYfb7/R+LTvDGhb4/UWKydTGo+i+l06BcqD0aZVb55s9OIsnum8b1MPXUReE2gnA
Ut9aacw0drAe+CuImHychlsj0kGjhoO9TGifRZ6rKnvvaqnoM/DI50YOJ4vpPRaFG7a94zeBGdYE
d5htRwDB0Eu8SdxLBqpCmuFkeVzfJ81fSWP3cM1iuQ==
=hEvr
-----END PGP SIGNATURE-----

--9oPAuSg6TUYeaodiPJgEfS2jNUh7SDXZw--
