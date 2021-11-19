Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75379456D44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhKSKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:30:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34408 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSKan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:30:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D972F1FD38;
        Fri, 19 Nov 2021 10:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637317660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6eCp1Ki2R16atpMcyacQdMlX3+DmOGOXg/392jMpR8=;
        b=SwBGweD9Io4a3bgB8pnPKSVJyQ4tImf6rmrQfe+S36cGbxJ3CKLga1EdsmoevN90tnPVSI
        pRs8UlCcHwUUhcv8RQuxn5kwc92EvLTxFa5pf3jS4nmLkeRF3CdE9ERlTvDlE0dz0bCpw0
        i8L2gGHoSbCBgXstaqDwMbjtRjt+nG4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D25313DD5;
        Fri, 19 Nov 2021 10:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WDlpERx8l2FRDwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 19 Nov 2021 10:27:40 +0000
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <CAJhGHyBRcAg33DxxGGpbnT+O7CGKp6Ktr3PtCZ0j50oTJ4fgrg@mail.gmail.com>
 <20211119102048.hjm46edvhryjgluy@box.shutemov.name>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <42361b9b-da86-dce2-eb17-fe36c9329347@suse.com>
Date:   Fri, 19 Nov 2021 11:27:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211119102048.hjm46edvhryjgluy@box.shutemov.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mDUSDCKFf5hnvoHtKqJ1bvgDAOfKlbLmM"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mDUSDCKFf5hnvoHtKqJ1bvgDAOfKlbLmM
Content-Type: multipart/mixed; boundary="h57Uybr4nq8Mp8UkVlZO54tFnF7w7BV2H";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Deep Shah <sdeep@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>
Message-ID: <42361b9b-da86-dce2-eb17-fe36c9329347@suse.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <CAJhGHyBRcAg33DxxGGpbnT+O7CGKp6Ktr3PtCZ0j50oTJ4fgrg@mail.gmail.com>
 <20211119102048.hjm46edvhryjgluy@box.shutemov.name>
In-Reply-To: <20211119102048.hjm46edvhryjgluy@box.shutemov.name>

--h57Uybr4nq8Mp8UkVlZO54tFnF7w7BV2H
Content-Type: multipart/mixed;
 boundary="------------FF60BD8B4DF8F80DFE2BA712"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------FF60BD8B4DF8F80DFE2BA712
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 19.11.21 11:20, Kirill A. Shutemov wrote:
> On Fri, Nov 19, 2021 at 03:51:44PM +0800, Lai Jiangshan wrote:
>> On Thu, Nov 18, 2021 at 7:14 AM Kirill A. Shutemov <kirill@shutemov.na=
me> wrote:
>>>
>>> TDX is going to use CONFIG_PARAVIRT_XXL, but kernel fails to compile =
if
>>> XEN_PV is not enabled:
>>>
>>>          ld.lld: error: undefined symbol: xen_iret
>>>
>>> It happens because INTERRUPT_RETURN defined to use xen_iret if
>>> CONFIG_PARAVIRT_XXL enabled regardless of CONFIG_XEN_PV.
>>>
>>> The issue is not visible in the current kernel because CONFIG_XEN_PV =
is
>>> the only user of CONFIG_PARAVIRT_XXL and there's no way to enable the=
m
>>> separately.
>>>
>>> Rework code to define INTERRUPT_RETURN based on CONFIG_XEN_PV, not
>>> CONFIG_PARAVIRT_XXL.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Deep Shah <sdeep@vmware.com>
>>> Cc: "VMware, Inc." <pv-drivers@vmware.com>
>>> ---
>>>   arch/x86/include/asm/irqflags.h | 7 +++++--
>>>   arch/x86/include/asm/paravirt.h | 5 -----
>>>   2 files changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/i=
rqflags.h
>>> index b794b6da3214..3b8ddcb7be76 100644
>>> --- a/arch/x86/include/asm/irqflags.h
>>> +++ b/arch/x86/include/asm/irqflags.h
>>> @@ -118,8 +118,6 @@ static __always_inline unsigned long arch_local_i=
rq_save(void)
>>>   #define SAVE_FLAGS             pushfq; popq %rax
>>>   #endif
>>>
>>> -#define INTERRUPT_RETURN       jmp native_iret
>>> -
>>>   #endif
>>>
>>>   #endif /* __ASSEMBLY__ */
>>> @@ -147,8 +145,13 @@ static __always_inline void arch_local_irq_resto=
re(unsigned long flags)
>>>   #ifdef CONFIG_X86_64
>>>   #ifdef CONFIG_XEN_PV
>>>   #define SWAPGS ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
>>> +#define INTERRUPT_RETURN                                            =
   \
>>> +       ANNOTATE_RETPOLINE_SAFE;                                     =
   \
>>> +       ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",             =
   \
>>> +               X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;=
")
>>
>> It is part of what CONFIG_PARAVIRT_XXL was designed for to enable
>> pv-aware INTERRUPT_RETURN.
>=20
> That's very vague statement.
>=20
> Could you elaborate on what is wrong with proposed fix?
>=20
>> I would prefer xen_iret is defined as a weak symbol unconditionally.
>> Like:
>>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index e38a4cf795d9..c0953f1b4559 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -635,6 +635,7 @@ SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
>>          jnz     native_irq_return_ldt
>>   #endif
>>
>> +SYM_INNER_LABEL(xen_iret, SYM_L_WEAK) /* placeholder */
>>   SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
>>          /*
>>           * This may fault.  Non-paranoid faults on return to userspac=
e are
>>
>> It will work when !CONFIG_XEN_PV
>=20
> It pollutes namespace for no particular reason. I don't see it justifie=
d.
>=20

I agree. IMO weak symbols should be avoided if easily possible, and the
patch here shows that it IS possible without any problem.


Juergen

--------------FF60BD8B4DF8F80DFE2BA712
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

--------------FF60BD8B4DF8F80DFE2BA712--

--h57Uybr4nq8Mp8UkVlZO54tFnF7w7BV2H--

--mDUSDCKFf5hnvoHtKqJ1bvgDAOfKlbLmM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmGXfBsFAwAAAAAACgkQsN6d1ii/Ey+k
6gf/ViY/BOFpKf5KBuqmEbAXfQ7vYKRUxEmCsI1A+a5ZMxJiIYFJhBSsSUdMZcjz3syW3zuozmHN
DXU7je5/1vvLsixWXbD5xRIkLCs3omACMOVAm5RlQtRAzxA+IdpuljlbrP1q2sVylR3uoneQTneq
Hce/5ue2/bXzqtfQ3OO3KFUPUgI0ClGYyzwjoosmqCVdyuOwQv+Xd+ppgnB5h/iGPoUyMYKuJWLH
Q+RmDQBIjSKUXv2wn3sU1jsN9OgxAfUloLK/YTeg8lrxS96cCwR+IWfJxN1am0hDsAIAIZE5iUmP
nx1hIBsW4jtjVmBk7l2FeBDxyBcpKEtlG/iBZG4aIQ==
=4t1t
-----END PGP SIGNATURE-----

--mDUSDCKFf5hnvoHtKqJ1bvgDAOfKlbLmM--
