Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0797A34B9C1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhC0WMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhC0WMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:12:10 -0400
Received: from mail.ionic.de (ionic.de [IPv6:2001:41d0:a:588b:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 991F4C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 15:12:10 -0700 (PDT)
Authentication-Results: root24.eu; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=ionic.de 
   (client-ip=217.92.117.31; helo=home.ionic.de; 
   envelope-from=ionic@ionic.de; receiver=<UNKNOWN>)
Received: from [192.168.0.46] (home.ionic.de [217.92.117.31])
        by mail.ionic.de (Postfix) with ESMTPSA id A1A684F0006D;
        Sat, 27 Mar 2021 22:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
        t=1616883129; bh=hEngPA3DyvZOApLfX4puVBNhb9RfcroMEYD4kgthFd8=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=A35AaA0fJhoNw8h13MnXfuoXsHhYeFO2aVaPFCBSHZhNJmdFJT63xzWSyMyulsMne
         RlwF22MYigrYMIJKzyMf3vy6Go3eWAwPCjkrVzI4HlM0EBvn4LQhU3Wqx6arZcdpQ0
         5mOHpi/BtcBLtEn9dM2ji+0w5aoiarpX4w9xhweU=
To:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210327120155.500-1-ionic@ionic.de>
 <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
From:   Mihai Moldovan <ionic@ionic.de>
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
Message-ID: <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
Date:   Sat, 27 Mar 2021 23:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UaidTUt0VWJaF8OBLQitMz5EXjxajBmYJ"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UaidTUt0VWJaF8OBLQitMz5EXjxajBmYJ
Content-Type: multipart/mixed; boundary="OFhuD4coUr9VTDiKeaEyCcLdMj9SAOWyf";
 protected-headers="v1"
From: Mihai Moldovan <ionic@ionic.de>
To: Randy Dunlap <rdunlap@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
References: <20210327120155.500-1-ionic@ionic.de>
 <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
In-Reply-To: <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>

--OFhuD4coUr9VTDiKeaEyCcLdMj9SAOWyf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

* On 3/27/21 4:58 PM, Randy Dunlap wrote:
> On 3/27/21 5:01 AM, Mihai Moldovan wrote:
>> +		if ((-1 =3D=3D index) && (index =3D=3D match_start))
>=20
> checkpatch doesn't complain about this (and I wonder how it's missed), =
but
> kernel style is (mostly) "constant goes on right hand side of compariso=
n",
> so
> 		if ((index =3D=3D -1) &&

I can naturally send a V2 with that swapped.

To my rationale: I made sure to use checkpatch, saw that it was accepted =
and
even went for a quick git grep -- '-1 =3D=3D', which likewise returned en=
ough
results for me to call this consistent with the current code style.

Maybe those matches were just frowned-upon, but forgotten-to-be-critized
examples of this pattern being used.



Mihai



--OFhuD4coUr9VTDiKeaEyCcLdMj9SAOWyf--

--UaidTUt0VWJaF8OBLQitMz5EXjxajBmYJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEbhHQj3UzgcdE8cg8H9Yu2W4lOocFAmBfrbgFAwAAAAAACgkQH9Yu2W4lOod3
eQ//T9OKsxHD9AlP2ZBdfD4c399lfWNqqUPGktmYGqKukEXipejMOhVh95kYSx6zhImL4hESIXTZ
/L53SvqbmT51bqVWojbxs744Ty0DBKpEq+inC3gDL4y97UFBxZIW7wKT2ioUQU5sSPnGvJA3kOv6
AppkEsqH979oBZeMcD9F79TvnpnC6FFh80PiScCzR6N1LHdZcHtyJiwqkFu4KNOj8cYtljXYanSr
u8NK2+NrJL6+o+ujwqB7ZaREAhIPei77V077yhk5uDnCWJzaVUxZzQ7JU/+1OmVqb1P45DsMSTPA
oWF343qGafRUgMB6F1OlCSlgEPnT6YSPExHJv2xJQfnOsyRKd26Kq+6GemNPHU15gTmzvO1gCElW
7FPYSaPjGCAd0Hq838Uuno/wotik7jE5Q7WIyaq2uMCLQ0OO6zVQl0gE/JzYlvBOeMF+GL7ZAvnq
8loqyPLBN4Xd0R0aPvfDFRxiK8/ZWemunCgLJK4jkz0IDXspyXjUhuZkGglIe24Nn+58WOfmBdD/
PvgbZZW41v5dPEzL+sIa6VHinMBS6CCfjgNfNNFsTFpLlMuyVIDfvffWRkqmTGHepU03M+ipdI/o
SjwYR8dcJWRmxDRwSmkLL1Ng/42ZeiqGpfv3mV/Zl9xBhPJyWevxprGpeSSpfknCVd/c1QgxJCWi
vUc=
=z5W4
-----END PGP SIGNATURE-----

--UaidTUt0VWJaF8OBLQitMz5EXjxajBmYJ--
