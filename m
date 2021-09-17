Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12A40F32D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhIQHZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:25:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59560 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhIQHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:25:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A63B2229C;
        Fri, 17 Sep 2021 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631863475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bE5NUshZqGoJZC75jbTVmSF6zC94Ejk6ktxVeD+/QPI=;
        b=t+OPqhofgpuu6n7IulctcNx7szquc6WpryAnO3B5vZgJ/d+Aosci9UoDvozF9Ssr4IaM4l
        f0n1bOn3TsIv8uM1gPpIko2518MrAjpqngC1gHiGhqKP7HwBFDsw+LSWnQ42VFsBVTZueX
        ics88Z9Dd292erTQPnBJafYqgQC1ESo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC7B113A7D;
        Fri, 17 Sep 2021 07:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sHSCM7JCRGG8FAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 17 Sep 2021 07:24:34 +0000
Subject: Re: [PATCH] xen/x86: fix PV trap handling on secondary processors
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <34898e9c-5883-a978-98ee-b81b22d8caed@suse.com>
 <823f4ef4-f9e5-68cb-d6e9-d079483c1e21@oracle.com>
 <0afce6e8-3c8a-e5ae-cd54-0fd598276506@suse.com>
 <62ccf5b7-b903-e604-d113-67c7633278cd@suse.com>
 <2c4549c8-bdeb-3584-95c4-7076b7cf79bb@suse.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <35835650-bbbb-7dbd-061b-693f39f9453e@suse.com>
Date:   Fri, 17 Sep 2021 09:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2c4549c8-bdeb-3584-95c4-7076b7cf79bb@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M2XcnizTokna6hopAL0dWC5lqtlHkp8ZI"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M2XcnizTokna6hopAL0dWC5lqtlHkp8ZI
Content-Type: multipart/mixed; boundary="5rydOrmp7qY4iIJ4s8W5Quk59Tk3u8ZFr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <35835650-bbbb-7dbd-061b-693f39f9453e@suse.com>
Subject: Re: [PATCH] xen/x86: fix PV trap handling on secondary processors
References: <34898e9c-5883-a978-98ee-b81b22d8caed@suse.com>
 <823f4ef4-f9e5-68cb-d6e9-d079483c1e21@oracle.com>
 <0afce6e8-3c8a-e5ae-cd54-0fd598276506@suse.com>
 <62ccf5b7-b903-e604-d113-67c7633278cd@suse.com>
 <2c4549c8-bdeb-3584-95c4-7076b7cf79bb@suse.com>
In-Reply-To: <2c4549c8-bdeb-3584-95c4-7076b7cf79bb@suse.com>

--5rydOrmp7qY4iIJ4s8W5Quk59Tk3u8ZFr
Content-Type: multipart/mixed;
 boundary="------------BA95EA9CD276B930AE413EB4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BA95EA9CD276B930AE413EB4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 17.09.21 08:50, Jan Beulich wrote:
> On 17.09.2021 08:47, Juergen Gross wrote:
>> On 17.09.21 08:40, Jan Beulich wrote:
>>> On 17.09.2021 03:34, Boris Ostrovsky wrote:
>>>>
>>>> On 9/16/21 11:04 AM, Jan Beulich wrote:
>>>>>    {
>>>>>    	const struct desc_ptr *desc =3D this_cpu_ptr(&idt_desc);
>>>>> +	unsigned i, count =3D (desc->size + 1) / sizeof(gate_desc);
>>>>>   =20
>>>>> -	xen_convert_trap_info(desc, traps);
>>>>
>>>>
>>>> Can you instead add a boolean parameter to xen_convert_trap_info() t=
o indicate whether to skip empty entries? That will avoid (almost) duplic=
ating the code.
>>>
>>> I can, sure, but I specifically didn't, as the result is going to be =
less
>>> readable imo. Instead I was considering to fold xen_convert_trap_info=
()
>>> into its only remaining caller. Yet if you're convinced adding the
>>> parameter is the way to do, I will go that route. But please confirm.=

>>
>> I don't think the result will be very hard to read. All you need is th=
e
>> new parameter and extending the if statement in xen_convert_trap_info(=
)
>> to increment out always if no entry is to be skipped.
>=20
> And skip writing the sentinel.

Maybe it would be even better then to let xen_convert_trap_info() return
the number of entries written and to write the sentinel in
xen_load_idt() instead, as this is the only place where it is needed.


Juergen

--------------BA95EA9CD276B930AE413EB4
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

--------------BA95EA9CD276B930AE413EB4--

--5rydOrmp7qY4iIJ4s8W5Quk59Tk3u8ZFr--

--M2XcnizTokna6hopAL0dWC5lqtlHkp8ZI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmFEQrIFAwAAAAAACgkQsN6d1ii/Ey+F
VwgAhC2MWq8hSJIV5LTI9ri7tMI+XMDRGUllT1Z2+ymA5o5GtMO5meoDH5HsfwE4tZPMxNh79S9M
IKf3EydS546e7TC1ZF5RB3u0PFlbZyNL0H0pM2OpuF7jSGOagUt7hMbzF+uG6OYNsNJvgQSc+/Bw
8L31sExVIhUmNJ6yl5Nxelm1ZYMtSBEQfiIy3t9RVop2kmHLxgzfU0xexIQPc/eXDhTvrXLqwj+V
dd/c0yXCOnLD7lqWTXmHFbp9a6/SFoyWqxwvMmzTeqCv6pQX1QtSQwh27Q28SQdIdBwVMy7A3INS
F3dedrJD1Cxz9+p9ET8oJoanBRZGDQwqVCzbO+WZ0g==
=caFE
-----END PGP SIGNATURE-----

--M2XcnizTokna6hopAL0dWC5lqtlHkp8ZI--
