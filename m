Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4A40A97E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhINInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:43:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35430 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhINInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:43:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A6401FDC4;
        Tue, 14 Sep 2021 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631608921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPouFTvUSxde8wBIN4mbuwBIT5eFtCgb2f3gPa9oKwA=;
        b=fFpbWhGXaIJcgrTvJMcAfJA2LoW1SmE4HLDBdYBLf/w1tNW+AKkRq+ZjHvSdd7GQu0+Dzk
        +eQc4mRGCsTtvMA2MDmE8kMPPznh0XifF83067GBKTF8uC710IdG8GoDQ4uxFbGsFTH3GW
        aHTOX19CdE9lIVjWUG158jaRkclxXek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 291DD13E4F;
        Tue, 14 Sep 2021 08:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sMF6CFlgQGE4KgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Sep 2021 08:42:01 +0000
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
References: <YT9I+Xs9wOPVCIVd@mail-itl>
 <923de2f5-3d33-4c02-acec-739fdaf2ae05@suse.com>
 <YUBeUZdduCAbOQJN@linux.ibm.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Linux 5.13+ as Xen dom0 crashes on Ryzen CPU (ucode loading
 related?)
Message-ID: <3680dfc8-d7a4-7b10-0070-eb476f55bcc3@suse.com>
Date:   Tue, 14 Sep 2021 10:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YUBeUZdduCAbOQJN@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ilb5mPSY6AWHgPesUzx2TavFJnFwZ81vl"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ilb5mPSY6AWHgPesUzx2TavFJnFwZ81vl
Content-Type: multipart/mixed; boundary="ae01mqCaNnJ5aUgKVDKNJmIxZNb4zZNYO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 xen-devel <xen-devel@lists.xenproject.org>
Message-ID: <3680dfc8-d7a4-7b10-0070-eb476f55bcc3@suse.com>
Subject: Re: Linux 5.13+ as Xen dom0 crashes on Ryzen CPU (ucode loading
 related?)
References: <YT9I+Xs9wOPVCIVd@mail-itl>
 <923de2f5-3d33-4c02-acec-739fdaf2ae05@suse.com>
 <YUBeUZdduCAbOQJN@linux.ibm.com>
In-Reply-To: <YUBeUZdduCAbOQJN@linux.ibm.com>

--ae01mqCaNnJ5aUgKVDKNJmIxZNb4zZNYO
Content-Type: multipart/mixed;
 boundary="------------E3D07A4408E216413FF53383"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E3D07A4408E216413FF53383
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 14.09.21 10:33, Mike Rapoport wrote:
> On Tue, Sep 14, 2021 at 09:14:38AM +0200, Juergen Gross wrote:
>> On 13.09.21 14:50, Marek Marczykowski-G=C3=B3recki wrote:
>>> Hi,
>>>
>>> Since 5.13, the Xen (PV) dom0 crashes on boot, before even printing t=
he
>>> kernel version.
>>> Test environment:
>>>    - Xen 4.14.2
>>>    - AMD Ryzen 5 4500U (reported also on AMD Ryzen 7 4750U)
>>>    - Linux 5.13.13, confirmed also on 5.14
>>>
>>> The crash happens only if the initramfs has earlycpio with microcode.=

>>> I don't have a serial console, but I've got a photo with crash messag=
e
>>> (from Xen, Linux doesn't managed to print anything):
>>> https://user-images.githubusercontent.com/726704/133084966-5038f37e-0=
01b-4688-9f90-83d09be3dc2d.jpg
>>>
>>> Transcription of some of it:
>>>
>>>       mapping kernel into physical memory
>>>       about to get started
>>>       (XEN) Pagetable walk from ffffffff82810888:
>>>       (XEN)  L4[0x1ff] =3D 0000000332815067 0000000000002815
>>>       (XEN)  L3[0x1fe] =3D 0000000332816067 0000000000002816
>>>       (XEN)  L2[0x014] =3D 0000000334018067 0000000000004018
>>>       (XEN)  L1[0x010] =3D 0000000332810067 0000000000002810
>>>       (XEN) domain_crash_sync called from entry.S: fault at ffff82d04=
033e790 x86_64/entry.S#domain_crash_page_fault
>>>       (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
>>>       (XEN) ----[ Xen-4.14.2  x86_64  debug=3Dn  Not tainted ]----
>>>       (XEN) CPU:    0
>>>       (XEN) RIP:    e033:[<0000000000000000>]
>>
>> The domain's run state seems to be completely clobbered.
>>
>> Did you try to boot the kernel with "earlyprintk=3Dxen" to get some id=
ea
>> how far it progressed?
>>
>> I could imagine that doing the early reservations after the call of
>> e820__memory_setup() is problematic, as Xen PV guests have a hook in
>> this function performing some rather extended actions.
>=20
> Right, among them it may relocate initrd:
>=20
> https://elixir.bootlin.com/linux/latest/source/arch/x86/xen/setup.c#L87=
2
>  =20
> and this may cause the reported crash.
>=20
>> I'm not sure the call of early_reserve_memory() can be moved just befo=
re
>> the e820__memory_setup() call. If this is possibel it should be done
>> IMO, if not then the reservations which have been at the start of
>> setup_arch() might need to go there again.
>=20
> early_reserve_memory() can be moved to the beginning of setup_arch().

IMO this should be the preferred fix. I will write a patch to do that.

> Anther possibility is to move initrd relocation out of xen_setup_memory=
()
> and maybe even integrate it somehow in reserve_initrd().

This would be rather complicated as xen_setup_memory() is changing the
memory map from one large memory chunk to match the memory map of the
host in case the system is running as dom0 (the need to do so has
historical reasons, changing that is no option). The initrd needs to be
moved in case it is using memory which is conflicting with the new
layout.


Juergen

--------------E3D07A4408E216413FF53383
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

--------------E3D07A4408E216413FF53383--

--ae01mqCaNnJ5aUgKVDKNJmIxZNb4zZNYO--

--ilb5mPSY6AWHgPesUzx2TavFJnFwZ81vl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmFAYFgFAwAAAAAACgkQsN6d1ii/Ey+h
mQgAi/OAAYr7BdRGH/RZDoPLz7fsoqtr0Mu7XgC5fjwZt8HlagWMA75VQaiH18wANcinlvINcwfM
0aqkBGugG9t+NBr4byO5C9UBLj/c3OYQzy0BYO9atduWdrBHxf2kYky0DAiHF+t8oh8uTBFj1pbt
os5URpuzOF2Cr4WU9GVOI6wW1ledwm5mw8PxLJ7kepTj1G5aPicatKBPOw3Xm0VbVzCMvyOx8ym5
eEa9alqxM9OjjEViu8Erxd7SfgKaAstQ5VQp03CHqVSUkKTHhy+qdpkyb0UNW9o+suV+FxJSYxSz
o7u7gAGZlb1GXF7h/ceHtWsxp5qjRx+EKfH8S2ucGA==
=bzrN
-----END PGP SIGNATURE-----

--ilb5mPSY6AWHgPesUzx2TavFJnFwZ81vl--
