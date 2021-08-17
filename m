Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199A63EEDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbhHQNsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:48:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34634 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhHQNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:48:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BFEB20020;
        Tue, 17 Aug 2021 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629208046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5e/iG1J4hbENOd3u4P9P8vrRpvHF01H8HMHK33dj3Y=;
        b=hzsnYoGwbUfZSD3UHchtD/eGK/L1pgnp6kvnOPNjRt9C0kzs2LPXa1JVOwr8j07WZ5D0jX
        N4tAla8/1YrZE05lfzQAoUYmL7vriagnT4C0ciE5lAvdCej/IUpH5thGvM/PTLpt4hE3Ih
        GYu63AIcPcVyxxwAZ8J6n5SwUo2xajk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CD928132AB;
        Tue, 17 Aug 2021 13:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id CGQlMO29G2EkRgAAGKfGzw
        (envelope-from <jgross@suse.com>); Tue, 17 Aug 2021 13:47:25 +0000
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YRTLO0eQOEChETId@zn.tnic> <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
 <fd603d12-1897-1f5f-17fa-b5ac643bc334@linux.intel.com>
 <fcc8c2f1-f33f-96fa-8fc7-1e6e2e6a3936@suse.com>
 <ddb9c140-caf9-ef46-d5af-ac9a1283c5df@linux.intel.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <d700658f-8466-46c5-5fff-9e65a6a24720@suse.com>
Date:   Tue, 17 Aug 2021 15:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ddb9c140-caf9-ef46-d5af-ac9a1283c5df@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nmSfXcIKbnSqhrD9F1eyD7scvQt396Zzr"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nmSfXcIKbnSqhrD9F1eyD7scvQt396Zzr
Content-Type: multipart/mixed; boundary="uY2DV325w7YNF5NDLFO464KKYIVoJ4BTm";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
 Tony Luck <tony.luck@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Andi Kleen <ak@linux.intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Deep Shah <sdeep@vmware.com>,
 "VMware, Inc." <pv-drivers@vmware.com>
Message-ID: <d700658f-8466-46c5-5fff-9e65a6a24720@suse.com>
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YRTLO0eQOEChETId@zn.tnic> <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
 <fd603d12-1897-1f5f-17fa-b5ac643bc334@linux.intel.com>
 <fcc8c2f1-f33f-96fa-8fc7-1e6e2e6a3936@suse.com>
 <ddb9c140-caf9-ef46-d5af-ac9a1283c5df@linux.intel.com>
In-Reply-To: <ddb9c140-caf9-ef46-d5af-ac9a1283c5df@linux.intel.com>

--uY2DV325w7YNF5NDLFO464KKYIVoJ4BTm
Content-Type: multipart/mixed;
 boundary="------------C99DEDBF19A309B0F24C4100"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C99DEDBF19A309B0F24C4100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 17.08.21 15:39, Kuppuswamy, Sathyanarayanan wrote:
>=20
>=20
> On 8/17/21 6:28 AM, Juergen Gross wrote:
>> I guess you have been lucky and all users of arch_safe_halt() and halt=
()
>> are directly or indirectly including asm/paravirt.h by other means.
>>
>> There might be configs where this is not true, though.
>>
>> In any case I believe you should fix your patch to let asm/irqflags.h
>> include asm/paravirt.h for the CONFIG_PARAVIRT case.
>=20
> Ok. I will include it.
>=20
> #if defined(CONFIG_PARAVIRT) && !defined(CONFIG_PARAVIRT_XXL)
> #include <asm/paravirt.h>
> #endif
>=20

I don't see a reason to have two "#include <asm/paravirt.h>" lines in
one file. Why don't you use:

#ifdef CONFIG_PARAVIRT
#include <asm/paravirt.h>
#else
#ifndef __ASSEMBLY___
=2E..
#endif
#endif

#ifndef CONFIG_PARAVIRT_XXL
=2E..
#endif


Juergen

--------------C99DEDBF19A309B0F24C4100
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

--------------C99DEDBF19A309B0F24C4100--

--uY2DV325w7YNF5NDLFO464KKYIVoJ4BTm--

--nmSfXcIKbnSqhrD9F1eyD7scvQt396Zzr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmEbve0FAwAAAAAACgkQsN6d1ii/Ey+U
6Af7BjFMIYqUsuibicyqnCIW2dbxmuYcedG30VAe0nwyanZczok6qnfUJwVleCVwEAiaylYjDcWW
zgaBZXeF3qRgtZB8deS2JLQ58r6zK+VSzc6kmxBYs4WtuuglI9hsxjRjzBHeKiop2sc8wsQOH+00
sqsEbGiUUa+SLOhcQuJAFHKIGAEiKH1P3mpn8c1ntq0xURL575FQPgV3j7ewMtTrCHDg6rx9wpy/
nDnZhsLYBxIUqcJDi/GOB+OtG9RYXpyLRRWIygf3OlUlRUUes5WcDd1Pt87qNZuUefm9sr1z7xvL
Q0YgPaRv2X7EqhnnXPYwpih3S1A6f3sfplN9lA67eQ==
=RbjA
-----END PGP SIGNATURE-----

--nmSfXcIKbnSqhrD9F1eyD7scvQt396Zzr--
