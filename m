Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64D3EECD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhHQMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:51:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhHQMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:51:22 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 121DA1FF3C;
        Tue, 17 Aug 2021 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629204649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eVKY8te2qX6x3hOu/5NH27UXGyWhDT0gQUuvlSw+fe4=;
        b=HpTkaznueMlGqIDcFwtAS31/K1wg8MPlgxk1h61iE8wUEqiovZIY4+D9dmP/dEnr+TpnIQ
        GLL56AV2LgA9ssIkbwlbBCwA+g/uNrPWjjRwqdssgE0G5mOr49Jn37UrmUuO489GQrBp0q
        l6Vxzp4yuOJ9cU4loEXHzf/9W4RDFYw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 840CF136BD;
        Tue, 17 Aug 2021 12:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iCnOHqiwG2GFOAAAGKfGzw
        (envelope-from <jgross@suse.com>); Tue, 17 Aug 2021 12:50:48 +0000
To:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
 <YRTLO0eQOEChETId@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
Message-ID: <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
Date:   Tue, 17 Aug 2021 14:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRTLO0eQOEChETId@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DoVWBTuFNc16vBqHEhWLIUVc6TJhrBXCt"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DoVWBTuFNc16vBqHEhWLIUVc6TJhrBXCt
Content-Type: multipart/mixed; boundary="T7R9XNbCG5R9WfDROjZnK92MyENX0KhdF";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
Message-ID: <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YRTLO0eQOEChETId@zn.tnic>
In-Reply-To: <YRTLO0eQOEChETId@zn.tnic>

--T7R9XNbCG5R9WfDROjZnK92MyENX0KhdF
Content-Type: multipart/mixed;
 boundary="------------291295DA05027265755CEFC3"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------291295DA05027265755CEFC3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12.08.21 09:18, Borislav Petkov wrote:
> On Wed, Aug 04, 2021 at 11:13:18AM -0700, Kuppuswamy Sathyanarayanan wr=
ote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
>> other VM guest types, features supported under CONFIG_PARAVIRT
>> are self sufficient. CONFIG_PARAVIRT mainly provides support for
>> TLB flush operations and time related operations.
>>
>> For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
>> most of its requirement except the need of HLT and SAFE_HLT
>> paravirt calls, which is currently defined under
>> COFNIG_PARAVIRT_XXL.
>>
>> Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
>> like platforms, move HLT and SAFE_HLT paravirt calls under
>> CONFIG_PARAVIRT.
>>
>> Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
>> break any functionality for current users of CONFIG_PARAVIRT.
>>
>> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswam=
y@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@=
linux.intel.com>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>=20
> You need to do this before sending your patches:
>=20
> ./scripts/get_maintainer.pl /tmp/tdx.01
> Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE (32-B=
IT AND 64-BIT),commit_signer:1/6=3D17%)
> Ingo Molnar <mingo@redhat.com> (maintainer:X86 ARCHITECTURE (32-BIT AND=
 64-BIT))
> Borislav Petkov <bp@alien8.de> (maintainer:X86 ARCHITECTURE (32-BIT AND=
 64-BIT),commit_signer:6/6=3D100%)
> x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
> "H. Peter Anvin" <hpa@zytor.com> (reviewer:X86 ARCHITECTURE (32-BIT AND=
 64-BIT))
> Juergen Gross <jgross@suse.com> (supporter:PARAVIRT_OPS INTERFACE,commi=
t_signer:5/6=3D83%,authored:5/6=3D83%,added_lines:15/16=3D94%,removed_lin=
es:38/39=3D97%)
> Deep Shah <sdeep@vmware.com> (supporter:PARAVIRT_OPS INTERFACE)
> "VMware, Inc." <pv-drivers@vmware.com> (supporter:PARAVIRT_OPS INTERFAC=
E)
> ...
>=20
> and CC also the supporters - I'm pretty sure at least Juergen would lik=
e
> to be kept up-to-date on pv changes. I'll CC him and the others now and=

> leave in the whole diff but make sure you do that in the future please.=

>=20
>>   arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++----------=
--
>>   arch/x86/include/asm/paravirt.h       | 20 +++++++-------
>>   arch/x86/include/asm/paravirt_types.h |  3 +-
>>   arch/x86/kernel/paravirt.c            |  4 ++-
>>   4 files changed, 36 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/ir=
qflags.h
>> index c5ce9845c999..f3bb33b1715d 100644
>> --- a/arch/x86/include/asm/irqflags.h
>> +++ b/arch/x86/include/asm/irqflags.h
>> @@ -59,6 +59,28 @@ static inline __cpuidle void native_halt(void)
>>  =20
>>   #endif
>>  =20
>> +#ifndef CONFIG_PARAVIRT
>> +#ifndef __ASSEMBLY__
>> +/*
>> + * Used in the idle loop; sti takes one instruction cycle
>> + * to complete:
>> + */
>> +static inline __cpuidle void arch_safe_halt(void)
>> +{
>> +	native_safe_halt();
>> +}
>> +
>> +/*
>> + * Used when interrupts are already enabled or to
>> + * shutdown the processor:
>> + */
>> +static inline __cpuidle void halt(void)
>> +{
>> +	native_halt();
>> +}
>> +#endif /* __ASSEMBLY__ */
>> +#endif /* CONFIG_PARAVIRT */
>> +
>>   #ifdef CONFIG_PARAVIRT_XXL
>>   #include <asm/paravirt.h>

Did you test this with CONFIG_PARAVIRT enabled and CONFIG_PARAVIRT_XXL
disabled?

I'm asking because in this case I don't see where halt() and
arch_safe_halt() would be defined in case someone is including
asm/irqflags.h and not asm/paravirt.h.

>>   #else
>> @@ -80,24 +102,6 @@ static __always_inline void arch_local_irq_enable(=
void)
>>   	native_irq_enable();
>>   }
>>  =20
>> -/*
>> - * Used in the idle loop; sti takes one instruction cycle
>> - * to complete:
>> - */
>> -static inline __cpuidle void arch_safe_halt(void)
>> -{
>> -	native_safe_halt();
>> -}
>> -
>> -/*
>> - * Used when interrupts are already enabled or to
>> - * shutdown the processor:
>> - */
>> -static inline __cpuidle void halt(void)
>> -{
>> -	native_halt();
>> -}
>> -
>>   /*
>>    * For spinlocks, etc:
>>    */
>> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/pa=
ravirt.h
>> index da3a1ac82be5..d323a626c7a8 100644
>> --- a/arch/x86/include/asm/paravirt.h
>> +++ b/arch/x86/include/asm/paravirt.h
>> @@ -97,6 +97,16 @@ static inline void paravirt_arch_exit_mmap(struct m=
m_struct *mm)
>>   	PVOP_VCALL1(mmu.exit_mmap, mm);
>>   }
>>  =20
>> +static inline void arch_safe_halt(void)
>> +{
>> +	PVOP_VCALL0(irq.safe_halt);
>> +}
>> +
>> +static inline void halt(void)
>> +{
>> +	PVOP_VCALL0(irq.halt);
>> +}
>> +
>>   #ifdef CONFIG_PARAVIRT_XXL
>>   static inline void load_sp0(unsigned long sp0)
>>   {
>> @@ -162,16 +172,6 @@ static inline void __write_cr4(unsigned long x)
>>   	PVOP_VCALL1(cpu.write_cr4, x);
>>   }
>>  =20
>> -static inline void arch_safe_halt(void)
>> -{
>> -	PVOP_VCALL0(irq.safe_halt);
>> -}
>> -
>> -static inline void halt(void)
>> -{
>> -	PVOP_VCALL0(irq.halt);
>> -}
>> -
>>   static inline void wbinvd(void)
>>   {
>>   	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
>> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/=
asm/paravirt_types.h
>> index d9d6b0203ec4..40082847f314 100644
>> --- a/arch/x86/include/asm/paravirt_types.h
>> +++ b/arch/x86/include/asm/paravirt_types.h
>> @@ -150,10 +150,9 @@ struct pv_irq_ops {
>>   	struct paravirt_callee_save save_fl;
>>   	struct paravirt_callee_save irq_disable;
>>   	struct paravirt_callee_save irq_enable;
>> -
>> +#endif
>>   	void (*safe_halt)(void);
>>   	void (*halt)(void);
>> -#endif
>>   } __no_randomize_layout;
>>  =20
>>   struct pv_mmu_ops {
>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>> index 04cafc057bed..124e0f6c5d1c 100644
>> --- a/arch/x86/kernel/paravirt.c
>> +++ b/arch/x86/kernel/paravirt.c
>> @@ -283,9 +283,11 @@ struct paravirt_patch_template pv_ops =3D {
>>   	.irq.save_fl		=3D __PV_IS_CALLEE_SAVE(native_save_fl),
>>   	.irq.irq_disable	=3D __PV_IS_CALLEE_SAVE(native_irq_disable),
>>   	.irq.irq_enable		=3D __PV_IS_CALLEE_SAVE(native_irq_enable),
>> +#endif /* CONFIG_PARAVIRT_XXL */
>> +
>> +	/* Irq HLT ops. */
>=20
> What's that comment for?

I agree, please drop it.


Juergen

--------------291295DA05027265755CEFC3
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

--------------291295DA05027265755CEFC3--

--T7R9XNbCG5R9WfDROjZnK92MyENX0KhdF--

--DoVWBTuFNc16vBqHEhWLIUVc6TJhrBXCt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmEbsKcFAwAAAAAACgkQsN6d1ii/Ey8p
IAf/QzPZNnWJSGao9NqdeJf/uPj6+9m/3UEjiiCVPpAhxOglSWK0xO/txlZz2Rc16ZAs8pnWNNXb
eZ3roT1pNLF4dC/zyDls9anLLIQL+HnYsc9jnHhrxmApK864pdsBTwM1tASFMaYOvd65BTVN2PYj
TlAkLrUynAaDuwgKY/4r9lUhegnSqRnGhRXoyobzVLafx9colHhe7H+cZ1l2mN6m2yXhOJArGwc/
zkFmpmyXZQTefSa0Cb3OqpgSt7Pnzi+QQwb0Nxl0WpZ54jrPRQrPMpT3m/6S+evWD4yIBA8cCRHf
g+93uAwP04FP6a1nBu8K9HHfSx8v6yNTw+JFccu49Q==
=mffu
-----END PGP SIGNATURE-----

--DoVWBTuFNc16vBqHEhWLIUVc6TJhrBXCt--
