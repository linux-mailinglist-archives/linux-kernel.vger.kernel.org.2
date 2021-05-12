Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2420A37BEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhELNwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:52:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhELNwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:52:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620827486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MEJNxZP+iGai9nZC1XI0af0aqqEjUYgkALCVmI/n8qk=;
        b=OSXq/90EjtmHJvXuzo6fk+0J88zbEYeTdgxihiF1yxguffymS++ecgU03lJq6g7lm0l4Hf
        bXO37kano/5ifbd6GkfjaZnFREmS1KZFRrV7XOzTzfja6swNHSu46bX8F2OXRzvMe5l7dA
        JNzEqVCMeBBUItcy/i4t1NaXge+Qi3Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7879B1AE;
        Wed, 12 May 2021 13:51:25 +0000 (UTC)
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
 <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
 <YJvVwXqGZWrXWPvP@hirez.programming.kicks-ass.net>
 <f1ae9d97-a23e-d902-4ddb-6ec7b5d8cb91@linux.intel.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <28f5b8c2-2307-45b0-19b4-0737df8f06f3@suse.com>
Date:   Wed, 12 May 2021 15:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f1ae9d97-a23e-d902-4ddb-6ec7b5d8cb91@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gF47iky4U4GLtfMpxVKXoignDIzlKvWcb"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gF47iky4U4GLtfMpxVKXoignDIzlKvWcb
Content-Type: multipart/mixed; boundary="Upxhfjc0vDqRLtnXmVS3oXVg0XWuAG0aE";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Tony Luck <tony.luck@intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Raj Ashok <ashok.raj@intel.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org
Message-ID: <28f5b8c2-2307-45b0-19b4-0737df8f06f3@suse.com>
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic> <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
 <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
 <41463493-48bb-0e69-dcb2-3072e2ddf208@suse.com>
 <YJvVwXqGZWrXWPvP@hirez.programming.kicks-ass.net>
 <f1ae9d97-a23e-d902-4ddb-6ec7b5d8cb91@linux.intel.com>
In-Reply-To: <f1ae9d97-a23e-d902-4ddb-6ec7b5d8cb91@linux.intel.com>

--Upxhfjc0vDqRLtnXmVS3oXVg0XWuAG0aE
Content-Type: multipart/mixed;
 boundary="------------46ABD9ABE2D6886B65590250"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------46ABD9ABE2D6886B65590250
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12.05.21 15:24, Andi Kleen wrote:
>=20
> On 5/12/2021 6:18 AM, Peter Zijlstra wrote:
>> On Mon, May 10, 2021 at 05:56:05PM +0200, Juergen Gross wrote:
>>
>>> No. We have PARAVIRT_XXL for Xen PV guests, and we have PARAVIRT for
>>> other hypervisor's guests, supporting basically the TLB flush operati=
ons
>>> and time related operations only. Adding the halt related operations =
to
>>> PARAVIRT wouldn't break anything.
>> Also, I don't think anything modern should actually ever hit any of th=
e
>> HLT instructions, most everything should end up at an MWAIT.
>>
>> Still, do we wants to give arch_safe_halt() and halt() the
>> PVOP_ALT_VCALL0() treatment?
>=20
>  From performance reasons it's pointless to patch. HLT (and MWAIT) are =

> so slow anyways that using patching or an indirect pointer is completel=
y=20
> in the noise. So I would use whatever is cleanest in the code.

This would probably be x86_platform_ops.hyper hooks.


Juergen

--------------46ABD9ABE2D6886B65590250
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

--------------46ABD9ABE2D6886B65590250--

--Upxhfjc0vDqRLtnXmVS3oXVg0XWuAG0aE--

--gF47iky4U4GLtfMpxVKXoignDIzlKvWcb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmCb3VwFAwAAAAAACgkQsN6d1ii/Ey9G
vgf6AhV/og0F1lyDd7777GGldhgPIJ8kZ7zQuHT8Q+AjTUhYBGmWfl5GWt0Ph5ojb+BqvTmW9wVd
tNl9YKebsN2zy/vbmmImL6NuTkKj9ISB9dyBnQMWOARj6hNeFcbiat7FTxSTMz+hqQp4Ibst0/xE
LdJ9gxvJz1FvptIfJvMbHwM+xzoxo44txFQRMBiRNBfoSQ2yofQ2PCCG369VAjcLHfWCBo4WuJ9G
qPLHRF36hKRjpxCNxtBI7HaapDEcxFrmHYJLLWXmqRSUW1L8ABc0QDshGQLTyowzWC6GwOEc5eyb
uZWHowq04a36GlRG0Gi1FDotZbOLfCDjtvMdTdQQyQ==
=ZBbo
-----END PGP SIGNATURE-----

--gF47iky4U4GLtfMpxVKXoignDIzlKvWcb--
