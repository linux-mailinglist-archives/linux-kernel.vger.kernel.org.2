Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76162412FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhIUIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:00:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33948 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhIUH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:59:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14B202209C;
        Tue, 21 Sep 2021 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632211109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCRoA5a4c/jtpKOQe0J4E/g6/W+lJjMnAbuFoXReAXI=;
        b=KPniQxBeYVqXHdwPFzuqyH0Io2uibebIpb0Gs1mmoYACl153OpRpCTaitlPwRQsk/fdpkP
        poel0PC2wlPdsIWDcVYIgV7FFMxhatiQoAXxWv+N2+c/oLJsrD8/DBX/m2ltid6v1DuPpc
        4rdcZ+yZriYWCh4gBPFrm8D7LAg7c5M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C75C513B9C;
        Tue, 21 Sep 2021 07:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lXReL6SQSWEnFQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 21 Sep 2021 07:58:28 +0000
Subject: Re: [PATCH] x86/xen: remove unneeded preempt_disable() from
 xen_irq_enable()
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210921070226.32021-1-jgross@suse.com>
 <99e6cf1d-ce6a-83e5-2e43-12f6c1a89f3f@suse.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <599f4e20-a25d-6cd0-ced5-f2deaf997535@suse.com>
Date:   Tue, 21 Sep 2021 09:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <99e6cf1d-ce6a-83e5-2e43-12f6c1a89f3f@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ITflTTCXoVwbmJMFHEzHN1ZWJTbRSWWbR"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITflTTCXoVwbmJMFHEzHN1ZWJTbRSWWbR
Content-Type: multipart/mixed; boundary="iFHxcl1T3XjGON5fVwYJ2lTk4ZzYTewBV";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <599f4e20-a25d-6cd0-ced5-f2deaf997535@suse.com>
Subject: Re: [PATCH] x86/xen: remove unneeded preempt_disable() from
 xen_irq_enable()
References: <20210921070226.32021-1-jgross@suse.com>
 <99e6cf1d-ce6a-83e5-2e43-12f6c1a89f3f@suse.com>
In-Reply-To: <99e6cf1d-ce6a-83e5-2e43-12f6c1a89f3f@suse.com>

--iFHxcl1T3XjGON5fVwYJ2lTk4ZzYTewBV
Content-Type: multipart/mixed;
 boundary="------------C1C4B23D13142A37EBB8A439"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C1C4B23D13142A37EBB8A439
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 21.09.21 09:53, Jan Beulich wrote:
> On 21.09.2021 09:02, Juergen Gross wrote:
>> --- a/arch/x86/xen/irq.c
>> +++ b/arch/x86/xen/irq.c
>> @@ -57,24 +57,20 @@ asmlinkage __visible void xen_irq_enable(void)
>>   {
>>   	struct vcpu_info *vcpu;
>>  =20
>> -	/*
>> -	 * We may be preempted as soon as vcpu->evtchn_upcall_mask is
>> -	 * cleared, so disable preemption to ensure we check for
>> -	 * events on the VCPU we are still running on.
>> -	 */
>> -	preempt_disable();
>> -
>>   	vcpu =3D this_cpu_read(xen_vcpu);
>>   	vcpu->evtchn_upcall_mask =3D 0;
>>  =20
>> -	/* Doesn't matter if we get preempted here, because any
>> -	   pending event will get dealt with anyway. */
>> +	/*
>> +	 * Now preemption could happen, but this is only possible if an even=
t
>> +	 * was handled, so missing an event due to preemption is not
>> +	 * possible at all.
>> +	 * The worst possible case is to be preempted and then check events
>> +	 * pending on the old vcpu, but this is not problematic.
>> +	 */
>=20
> I agree this isn't problematic from a functional perspective, but ...
>=20
>>   	barrier(); /* unmask then check (avoid races) */
>>   	if (unlikely(vcpu->evtchn_upcall_pending))
>>   		xen_force_evtchn_callback();
>=20
> ... is a stray call here cheaper than ...
>=20
>> -
>> -	preempt_enable();
>=20
> ... the preempt_{dis,en}able() pair?

The question is if a stray call in case of preemption (very unlikely)
is cheaper than the preempt_{dis|en}able() pair on each IRQ enabling.

I'm quite sure removing the preempt_*() calls will be a net benefit.


Juergen

--------------C1C4B23D13142A37EBB8A439
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

--------------C1C4B23D13142A37EBB8A439--

--iFHxcl1T3XjGON5fVwYJ2lTk4ZzYTewBV--

--ITflTTCXoVwbmJMFHEzHN1ZWJTbRSWWbR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmFJkKQFAwAAAAAACgkQsN6d1ii/Ey/J
iAf/UMWJ8ZejnJFFhH0R0qncPqdrq2o8IgBqB1Wjqiof3lHwTxqpRuJPG8kqIgh0zYM1EysHsKnG
PZ2pgSwO40rpY4Msi4vljJC3A4O3Nnwc3elgLLaPxy0Rg9ZVEdv0Wqx+XqqvxDGCbgrGEG2UvVAj
RJAfdFpeutt0AWYBHHZ9OY8MYNo6prUO3weBJw8hIipXBvBX9cxqDnwCpg9mlY2crB7BLXtjmcSu
vKqKMucn7dteqs7PEEWzhg9YmG3Lih01LbI1eQor9dPmDvPzgqGqZeVM8nZfv4Dg4ve7Mb1DQZxu
U8buqjJk0EFBc3fdNrIFMiJq/ypucfOAwt7A/mo3nA==
=fW4i
-----END PGP SIGNATURE-----

--ITflTTCXoVwbmJMFHEzHN1ZWJTbRSWWbR--
