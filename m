Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAB379332
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhEJP52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:57:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231953AbhEJP5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:57:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620662167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cApuLUjoLlkqS05hp7WeKGa0gsDcjZToA7i927RlZ1w=;
        b=Ziq2h0OfHFlQLl5NEKSNYks7vSxpVAhSutHlpJhEVRe8bekZDu5+bvOQbnUtEdrhV41lia
        PqrTVq1MaH1VI7TkAapKoXb1199Gglqh2RkDqz+V4T7RPvNSF7NGQwMkJ4RPOWicYXn/QH
        O09j+bXNzKoy+rq+vn5dhoD2tZwlkVw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51A90B013;
        Mon, 10 May 2021 15:56:07 +0000 (UTC)
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
To:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic> <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
 <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
Date:   Mon, 10 May 2021 17:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BqL4eMzTkoBzKW3U0nEwZbGI48AP58x2K"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BqL4eMzTkoBzKW3U0nEwZbGI48AP58x2K
Content-Type: multipart/mixed; boundary="FAVt0Lh0HaoOPaPwWOmPTVmjxqL2Rt4PR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Tony Luck <tony.luck@intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Raj Ashok <ashok.raj@intel.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org
Message-ID: <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic> <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
 <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
In-Reply-To: <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>

--FAVt0Lh0HaoOPaPwWOmPTVmjxqL2Rt4PR
Content-Type: multipart/mixed;
 boundary="------------0BB53C064B28DE2E43033EC9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0BB53C064B28DE2E43033EC9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10.05.21 17:52, Andi Kleen wrote:
> \
>>>> CONFIG_PARAVIRT_XL will be used by TDX that needs couple of paravirt=

>>>> calls that were hidden under CONFIG_PARAVIRT_XXL, but the rest of th=
e
>>>> config would be a bloat for TDX.
>>>
>>> Used how? Why is it bloat for TDX?
>>
>> Is there any major downside to move the halt related pvops functions
>> from CONFIG_PARAVIRT_XXL to CONFIG_PARAVIRT?
>=20
> I think the main motivation is to get rid of all the page table related=
=20
> hooks for modern configurations. These are the bulk of the annotations =

> and=C2=A0 cause bloat and worse code. Shadow page tables are really obs=
cure=20
> these days and very few people still need them and it's totally=20
> reasonable to build even widely used distribution kernels without them.=
=20
> On contrast most of the other hooks are comparatively few and also on=20
> comparatively slow paths, so don't really matter too much.
>=20
> I think it would be ok to have a CONFIG_PARAVIRT that does not have pag=
e=20
> table support, and a separate config option for those (that could be=20
> eventually deprecated).
>=20
> But that would break existing .configs for those shadow stack users,=20
> that's why I think Kirill did it the other way around.

No. We have PARAVIRT_XXL for Xen PV guests, and we have PARAVIRT for
other hypervisor's guests, supporting basically the TLB flush operations
and time related operations only. Adding the halt related operations to
PARAVIRT wouldn't break anything.


Juergen


--------------0BB53C064B28DE2E43033EC9
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
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

--------------0BB53C064B28DE2E43033EC9--

--FAVt0Lh0HaoOPaPwWOmPTVmjxqL2Rt4PR--

--BqL4eMzTkoBzKW3U0nEwZbGI48AP58x2K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmCZV5UFAwAAAAAACgkQsN6d1ii/Ey/1
uQf7BNfOJZj2IN/pCuemmKhJ397XJBkUNKRvRjlgAV5X8kKIdPfBmUa8jt5Gp3exB32oSWI+WKEi
fMmFLuOQhypMnfjJMpbM577eW0PU/fAQWvBm6PUIgPtgFwqnrhXe0DBCquczsjAgNG/GjnN2NvfD
HE5FIKIKM2o4SPmNkgR2fMT+tzJc6JXPHm++YdeVW0I1piHtYgqrpB3O7n+7HxlqvPCJ3nPm4Pci
56YPO8TmlwxO/V2qHLqykwc8km5WD6188dpFEp+ajTnHhXRtPYbQdcCRvl1+kzkjDWAyWsHQS1XV
cBFMF6G1ifUJCjigCPAEd9goEozmjisi4Q25uyyPng==
=fFvd
-----END PGP SIGNATURE-----

--BqL4eMzTkoBzKW3U0nEwZbGI48AP58x2K--
