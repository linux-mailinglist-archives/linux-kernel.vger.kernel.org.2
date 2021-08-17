Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E903EED71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbhHQN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:29:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41140 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbhHQN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:29:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 017EE21EC1;
        Tue, 17 Aug 2021 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629206920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AM1Yfu/VA+CFkoJtGcJlyq5LfmzZYcy4W2EX0iByKN0=;
        b=KGYaGeIemSEKhL5b+qZxzE7WqR5Uuahi1g+aM+42jiSovjiki3IPCcylbm+T3gDt9+pEij
        0SlDXlQHS/HBqUr4ji9k3VlF79SQjuzQvdKjB1ieWagRVXS80mVI4Zy3WIS9t7QpOPOps3
        W8UJtOlBbL/5Ph4VYN8h2PfUqqLsxOg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 76736132AB;
        Tue, 17 Aug 2021 13:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id RVl2G4e5G2HXQQAAGKfGzw
        (envelope-from <jgross@suse.com>); Tue, 17 Aug 2021 13:28:39 +0000
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
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <fcc8c2f1-f33f-96fa-8fc7-1e6e2e6a3936@suse.com>
Date:   Tue, 17 Aug 2021 15:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fd603d12-1897-1f5f-17fa-b5ac643bc334@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nchmaQkHf2Jc5jvFBRkxkf7Z2wH0GxIcM"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nchmaQkHf2Jc5jvFBRkxkf7Z2wH0GxIcM
Content-Type: multipart/mixed; boundary="tHFOW1luDj43gk5xj4meJfqDp6ADSdDXm";
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
Message-ID: <fcc8c2f1-f33f-96fa-8fc7-1e6e2e6a3936@suse.com>
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YRTLO0eQOEChETId@zn.tnic> <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
 <fd603d12-1897-1f5f-17fa-b5ac643bc334@linux.intel.com>
In-Reply-To: <fd603d12-1897-1f5f-17fa-b5ac643bc334@linux.intel.com>

--tHFOW1luDj43gk5xj4meJfqDp6ADSdDXm
Content-Type: multipart/mixed;
 boundary="------------AC7EFD19D87D3EB8A3ABE1E5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------AC7EFD19D87D3EB8A3ABE1E5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 17.08.21 15:16, Kuppuswamy, Sathyanarayanan wrote:
>=20
>=20
> On 8/17/21 5:50 AM, Juergen Gross wrote:
>> On 12.08.21 09:18, Borislav Petkov wrote:
>>> On Wed, Aug 04, 2021 at 11:13:18AM -0700, Kuppuswamy Sathyanarayanan =

>>> wrote:
>>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>>
>>>> CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
>>>> other VM guest types, features supported under CONFIG_PARAVIRT
>>>> are self sufficient. CONFIG_PARAVIRT mainly provides support for
>>>> TLB flush operations and time related operations.
>>>>
>>>> For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
>>>> most of its requirement except the need of HLT and SAFE_HLT
>>>> paravirt calls, which is currently defined under
>>>> COFNIG_PARAVIRT_XXL.
>>>>
>>>> Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
>>>> like platforms, move HLT and SAFE_HLT paravirt calls under
>>>> CONFIG_PARAVIRT.
>>>>
>>>> Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
>>>> break any functionality for current users of CONFIG_PARAVIRT.
>>>>
>>>> Co-developed-by: Kuppuswamy Sathyanarayanan=20
>>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan=20
>>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>>> ---
>>>
>>> You need to do this before sending your patches:
>>>
>>> ./scripts/get_maintainer.pl /tmp/tdx.01
>>> Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE=20
>>> (32-BIT AND 64-BIT),commit_signer:1/6=3D17%)
>>> Ingo Molnar <mingo@redhat.com> (maintainer:X86 ARCHITECTURE (32-BIT=20
>>> AND 64-BIT))
>>> Borislav Petkov <bp@alien8.de> (maintainer:X86 ARCHITECTURE (32-BIT=20
>>> AND 64-BIT),commit_signer:6/6=3D100%)
>>> x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
>>> "H. Peter Anvin" <hpa@zytor.com> (reviewer:X86 ARCHITECTURE (32-BIT=20
>>> AND 64-BIT))
>>> Juergen Gross <jgross@suse.com> (supporter:PARAVIRT_OPS=20
>>> INTERFACE,commit_signer:5/6=3D83%,authored:5/6=3D83%,added_lines:15/1=
6=3D94%,removed_lines:38/39=3D97%)=20
>>>
>>> Deep Shah <sdeep@vmware.com> (supporter:PARAVIRT_OPS INTERFACE)
>>> "VMware, Inc." <pv-drivers@vmware.com> (supporter:PARAVIRT_OPS=20
>>> INTERFACE)
>>> ...
>>>
>>> and CC also the supporters - I'm pretty sure at least Juergen would l=
ike
>>> to be kept up-to-date on pv changes. I'll CC him and the others now a=
nd
>>> leave in the whole diff but make sure you do that in the future pleas=
e.
>>>
>>>> =C2=A0 arch/x86/include/asm/irqflags.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 40=20
>>>> +++++++++++++++------------
>>>> =C2=A0 arch/x86/include/asm/paravirt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 20 +++++++-------
>>>> =C2=A0 arch/x86/include/asm/paravirt_types.h |=C2=A0 3 +-
>>>> =C2=A0 arch/x86/kernel/paravirt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++-
>>>> =C2=A0 4 files changed, 36 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/irqflags.h=20
>>>> b/arch/x86/include/asm/irqflags.h
>>>> index c5ce9845c999..f3bb33b1715d 100644
>>>> --- a/arch/x86/include/asm/irqflags.h
>>>> +++ b/arch/x86/include/asm/irqflags.h
>>>> @@ -59,6 +59,28 @@ static inline __cpuidle void native_halt(void)
>>>> =C2=A0 #endif
>>>> +#ifndef CONFIG_PARAVIRT
>>>> +#ifndef __ASSEMBLY__
>>>> +/*
>>>> + * Used in the idle loop; sti takes one instruction cycle
>>>> + * to complete:
>>>> + */
>>>> +static inline __cpuidle void arch_safe_halt(void)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 native_safe_halt();
>>>> +}
>>>> +
>>>> +/*
>>>> + * Used when interrupts are already enabled or to
>>>> + * shutdown the processor:
>>>> + */
>>>> +static inline __cpuidle void halt(void)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 native_halt();
>>>> +}
>>>> +#endif /* __ASSEMBLY__ */
>>>> +#endif /* CONFIG_PARAVIRT */
>>>> +
>>>> =C2=A0 #ifdef CONFIG_PARAVIRT_XXL
>>>> =C2=A0 #include <asm/paravirt.h>
>>
>> Did you test this with CONFIG_PARAVIRT enabled and CONFIG_PARAVIRT_XXL=

>> disabled?
>>
>> I'm asking because in this case I don't see where halt() and
>> arch_safe_halt() would be defined in case someone is including
>> asm/irqflags.h and not asm/paravirt.h.
>=20
> We have tested both cases and did not hit any issues.
>=20
> 1. CONFIG_PARAVIRT=3Dy and=C2=A0 CONFIG_PARAVIRT_XXL=3Dy
> 2. CONFIG_PARAVIRT=3Dy and=C2=A0 CONFIG_PARAVIRT_XXL=3Dn

I guess you have been lucky and all users of arch_safe_halt() and halt()
are directly or indirectly including asm/paravirt.h by other means.

There might be configs where this is not true, though.

In any case I believe you should fix your patch to let asm/irqflags.h
include asm/paravirt.h for the CONFIG_PARAVIRT case.


Juergen

--------------AC7EFD19D87D3EB8A3ABE1E5
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

--------------AC7EFD19D87D3EB8A3ABE1E5--

--tHFOW1luDj43gk5xj4meJfqDp6ADSdDXm--

--nchmaQkHf2Jc5jvFBRkxkf7Z2wH0GxIcM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmEbuYYFAwAAAAAACgkQsN6d1ii/Ey++
8ggAjrz3PuztnDTAh2P8Gm60P+SQZlvEvafIfAcHpnVlEr2t2MLN41N1kRSAcLJ7/iyvFkB/6Ozp
cthN416EIsiU3ytazjkXV408oL/eo1Rubgfd/enAA/yJD/FMETLr9HxQMYhFXzdOl2NipTpqUJLc
YzfiPfLCx2RhCeBcUfPG7XIsobXuHI0WzOHmm1hHMTVqu/9DVTy64ETKJj8wqLZ7hdwyTEMShRQR
wOwOcfac9QkXRabS2G8J8S2p742LUZIpfDK7YFHEKvR7FBzRsWwi5y1Rd7vr3IxUvKrtufl+yYYf
95BxHjWbWxG0rLwcTjnXSDOKJWRXZZGzatp0lTlCIg==
=uUqV
-----END PGP SIGNATURE-----

--nchmaQkHf2Jc5jvFBRkxkf7Z2wH0GxIcM--
