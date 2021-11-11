Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4074A44D266
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhKKHXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:23:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59576 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhKKHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:23:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 490E71FD39;
        Thu, 11 Nov 2021 07:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636615214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46U/oKk1TRvieSc552dwNQAJzTbYOme3TPvDOsMOoDM=;
        b=Ekqi9gmMYR+LB52LZfdwawXyl08uKkk48++Q1H2b+pDCVgAh8FqWawm+eS4IQTjx3edbgc
        B81YJT3HFPuqmxuk6Ih1gYE4wNLwIuK1FrtaWVy23tSkutJVwS8cnnk9a8Q5oCU7lr2ytp
        v7YzbJM5XS3N1ZxlFPpxcsje4HPgYbU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 085B313D46;
        Thu, 11 Nov 2021 07:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZRJGAC7EjGFALwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 11 Nov 2021 07:20:13 +0000
Subject: Re: [PATCH v2 11/23] x86,xen: Remove .fixup usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
References: <20211110100102.250793167@infradead.org>
 <20211110101325.545019822@infradead.org>
 <42933d6b-c6f4-7420-1d0f-7f5d6ec17d8e@suse.com>
 <YYumVx7qO3gY2tgD@hirez.programming.kicks-ass.net>
 <YYu/Mg8lSO9zX01z@hirez.programming.kicks-ass.net>
 <62c65309-b37e-4974-c4c1-733081357808@suse.com>
 <20211110161700.GC174703@worktop.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <bc749e58-74d3-47d8-4466-6863720444d1@suse.com>
Date:   Thu, 11 Nov 2021 08:20:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211110161700.GC174703@worktop.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Er4pCbbIePxs8mCRzSqBJAdcjq8ihlG88"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Er4pCbbIePxs8mCRzSqBJAdcjq8ihlG88
Content-Type: multipart/mixed; boundary="Qk4QXvgOZC2128QyqB9AinCKhwaN1BEDG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
 mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
 pbonzini@redhat.com, mbenes@suse.cz
Message-ID: <bc749e58-74d3-47d8-4466-6863720444d1@suse.com>
Subject: Re: [PATCH v2 11/23] x86,xen: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
 <20211110101325.545019822@infradead.org>
 <42933d6b-c6f4-7420-1d0f-7f5d6ec17d8e@suse.com>
 <YYumVx7qO3gY2tgD@hirez.programming.kicks-ass.net>
 <YYu/Mg8lSO9zX01z@hirez.programming.kicks-ass.net>
 <62c65309-b37e-4974-c4c1-733081357808@suse.com>
 <20211110161700.GC174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211110161700.GC174703@worktop.programming.kicks-ass.net>

--Qk4QXvgOZC2128QyqB9AinCKhwaN1BEDG
Content-Type: multipart/mixed;
 boundary="------------8597BEF94F362F68996D20DA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8597BEF94F362F68996D20DA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10.11.21 17:17, Peter Zijlstra wrote:
> On Wed, Nov 10, 2021 at 01:52:57PM +0100, Juergen Gross wrote:
>> On 10.11.21 13:46, Peter Zijlstra wrote:
>>> On Wed, Nov 10, 2021 at 12:00:39PM +0100, Peter Zijlstra wrote:
>>>> On Wed, Nov 10, 2021 at 11:35:37AM +0100, Juergen Gross wrote:
>>>
>>>>>> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAUL_REG, %[ret])
>>>>>
>>>>> I guess you didn't compile that? There is a typo: s/EFAUL/EFAULT/
>>>>
>>>> Damn.. I figure that must've gotten lost in the robot spam telling m=
e
>>>> clang can't do __cold on labels :/
>>>
>>> new patch at:
>>>
>>>     https://lkml.kernel.org/r/YYu/AteC/Wamqn46@hirez.programming.kick=
s-ass.net
>>>
>>
>> "not found"
>=20
> Argh.. msgid contains '/' and that doesn't really work with URLs.
>=20
> https://lore.kernel.org/lkml/YYu%2FAteC%2FWamqn46@hirez.programming.kic=
ks-ass.net/
>=20
> is the right url, in case you hand't yet found the actual email.

Looks good, you can add my:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

--------------8597BEF94F362F68996D20DA
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

--------------8597BEF94F362F68996D20DA--

--Qk4QXvgOZC2128QyqB9AinCKhwaN1BEDG--

--Er4pCbbIePxs8mCRzSqBJAdcjq8ihlG88
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmGMxC0FAwAAAAAACgkQsN6d1ii/Ey92
Qgf9H4/lJ3I0vpaK1RjojRPUDRGi1m41aIDobr5tHCH0/KVV2hpMivoW5G0NYRDY3845g+5Xxtqg
Ig3K8GxvbCTXvn75fZnvCSFaA6OcuNgwH91avwdwMM8hKmcL4TqX4lM4J/d98brGLuPcTK6d5/Ks
apK31aZ5BnN7X6i5pQ4vXyrOA9UdIT5/W4vYt2hxZxYVN2hPtALQRBG5V1Oeqg9C9gqnkt9tm+Y+
qzG9gn6BOZlJlCxJb75CHm4Um73d9JvYx7M2DFOWpRNx5d8KIALbQdzXhGd2c/XTipitBGQI5kKG
YBE1I0cUac4ovNZyj6MCZwxQ6GuNusP0hNwUY1i3KA==
=jG8K
-----END PGP SIGNATURE-----

--Er4pCbbIePxs8mCRzSqBJAdcjq8ihlG88--
