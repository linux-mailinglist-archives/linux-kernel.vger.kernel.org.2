Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86B3AD9E2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhFSMBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:01:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45306 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhFSMBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:01:21 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E40B221AFF;
        Sat, 19 Jun 2021 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624103949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ygMKXtbKGIOms+b+DHupY+FQ90wkoRfU5+jmWw7lTo=;
        b=ePtYXYptgzm0L/ejYraZ+39iaFAv14JdyI7YlJmJI1t1WVx+NYLmxZqzrCHW9EbUxY6BLx
        fatoHja7RtzBhmFsyeXKXSVaa4CVNQFl30uRWbFLeUgefGNNR1pgIEYK7ro7SPxmTTxbdW
        iDLDEOlPGCedRvBPE+yURzz+TxbxAYM=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 73D0E118DD;
        Sat, 19 Jun 2021 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624103949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ygMKXtbKGIOms+b+DHupY+FQ90wkoRfU5+jmWw7lTo=;
        b=ePtYXYptgzm0L/ejYraZ+39iaFAv14JdyI7YlJmJI1t1WVx+NYLmxZqzrCHW9EbUxY6BLx
        fatoHja7RtzBhmFsyeXKXSVaa4CVNQFl30uRWbFLeUgefGNNR1pgIEYK7ro7SPxmTTxbdW
        iDLDEOlPGCedRvBPE+yURzz+TxbxAYM=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id iGS2GQ3czWAAfQAALh3uQQ
        (envelope-from <jgross@suse.com>); Sat, 19 Jun 2021 11:59:09 +0000
Subject: Re: [PATCH v3 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-3-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <57b35f69-54c7-1dd5-599b-4099d3a9a671@suse.com>
Date:   Sat, 19 Jun 2021 13:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210618225755.662725-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XMyekJod5hhiZmmsjsNqi7tgQ0ubVORqw"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XMyekJod5hhiZmmsjsNqi7tgQ0ubVORqw
Content-Type: multipart/mixed; boundary="XyYdaX6MCF4wfsL1bwUopQ9DyT5Wj4sKu";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>
Cc: Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
 Tony Luck <tony.luck@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Andi Kleen <ak@linux.intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <57b35f69-54c7-1dd5-599b-4099d3a9a671@suse.com>
Subject: Re: [PATCH v3 02/11] x86/tdx: Introduce INTEL_TDX_GUEST config option
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210618225755.662725-3-sathyanarayanan.kuppuswamy@linux.intel.com>

--XyYdaX6MCF4wfsL1bwUopQ9DyT5Wj4sKu
Content-Type: multipart/mixed;
 boundary="------------9FBA6AC4E7D1C535B3C8E9E3"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9FBA6AC4E7D1C535B3C8E9E3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 19.06.21 00:57, Kuppuswamy Sathyanarayanan wrote:
> Add INTEL_TDX_GUEST config option to selectively compile
> TDX guest support.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@l=
inux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/Kconfig | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0045e1b44190..ff79263aebd1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -876,6 +876,21 @@ config ACRN_GUEST
>   	  IOT with small footprint and real-time features. More details can =
be
>   	  found in https://projectacrn.org/.
>  =20
> +config INTEL_TDX_GUEST
> +	bool "Intel Trusted Domain eXtensions Guest Support"
> +	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
> +	depends on SECURITY
> +	select PARAVIRT_XL

PARAVIRT_XL? Didn't you drop that?


Juergen

--------------9FBA6AC4E7D1C535B3C8E9E3
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

--------------9FBA6AC4E7D1C535B3C8E9E3--

--XyYdaX6MCF4wfsL1bwUopQ9DyT5Wj4sKu--

--XMyekJod5hhiZmmsjsNqi7tgQ0ubVORqw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmDN3AwFAwAAAAAACgkQsN6d1ii/Ey8J
3wf/fKmlzXDrRkeKyYqKqRjwJL/j9dGmz09t8yFAa0ihoU2eRGVpSQXhDm3CFWlXL2z0RrOjvfk0
rS/EIBk9s4pkM5BVqLN1/S82d3C8AGGK73JitfgFV0yD4AZcjXNdSD/vsz0gJK8WxFGGIbt0QQb8
AAvI3ykgFG33hhOzAouz5D345/1b6q9vsNYMUfm79gJyADKVuh9EXR14yfbHjozDlDb21gmDEJ6p
XCaE3BxZiRHeWg8MReSIr2ZTjUw/gHpZFt5NLc63CnTqcTpZhYWd376Un/wQaTjxVzDt1wYyh2/4
XiWMUgdQzkvM3NpWVTqVmis8plTQTiHiVT9UNYl1hA==
=Jyrw
-----END PGP SIGNATURE-----

--XMyekJod5hhiZmmsjsNqi7tgQ0ubVORqw--
