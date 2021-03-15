Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5B33AE27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCOJCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:02:03 -0400
Received: from thsbbfxrt01p.thalesgroup.com ([192.54.144.131]:55614 "EHLO
        thsbbfxrt01p.thalesgroup.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhCOJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:01:58 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 05:01:58 EDT
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 4DzVcx25Zhz466m;
        Mon, 15 Mar 2021 09:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
        s=xrt20181201; t=1615798545;
        bh=CEcbGr+YCKnFXAfof14yzdOmyvXMYVWwN86bTpugi84=;
        h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Transfer-Encoding:MIME-Version:From;
        b=ez0wUFY3ZEWMwre815DtHVyvhPu/7mUJhykxep7ES3by+KWUklOx+j59h1MZDLgQM
         Dl2LBArZO7SwK7Xynhdq6X2VRr2in+e6HFmhd9AMPo9oX0gdKUT65mYNuJa7W6i8XV
         Yjw2GuMdZbpJl7wYi7YuwJUmt1vA+vs/+AbNtL3eHgBjrb+f3MAlbiWjElSmqNn3kd
         apFWRIfUCBpMiszczcO5zBAVZVcu1eE2UthqXHB3JKts5MwS3Pw3tesRKbnRMPWWjj
         7CAod++6LrG5fWQKt5Zd3whbf7c5TCAGcOgGttHsyG6nDTEXzBbrZrRg+a6wx5cFh6
         36k5v+uvYuWaQ==
From:   PLATTNER Christoph <christoph.plattner@thalesgroup.com>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "PLATTNER Christoph" <christoph.plattner@thalesgroup.com>
Subject: RE: [PATCH] powerpc/603: Fix protection of user pages mapped with
 PROT_NONE
Thread-Topic: [PATCH] powerpc/603: Fix protection of user pages mapped with
 PROT_NONE
Thread-Index: AQHW+GOl2yWYuEbTpkiT/C3KqD+6EaqDcGkAgAGQiOA=
Date:   Mon, 15 Mar 2021 08:55:39 +0000
Message-ID: <921d9e7e-6680-4f83-8652-a88ebb64650f@THSDC1IRIMBX11P.iris.infra.thales>
References: <4a0c6e3bb8f0c162457bf54d9bc6fd8d7b55129f.1612160907.git.christophe.leroy@csgroup.eu>
 <161571587047.138988.3119931595106306211.b4-ty@ellerman.id.au>
In-Reply-To: <161571587047.138988.3119931595106306211.b4-ty@ellerman.id.au>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-pmwin-version: 4.0.3, Antivirus-Engine: 3.80.1, Antivirus-Data: 5.82
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for maintenance and for following this request.

Regards
Christoph

-----Original Message-----
From: Michael Ellerman <patch-notifications@ellerman.id.au>=20
Sent: Sonntag, 14. M=E4rz 2021 11:01
To: Michael Ellerman <mpe@ellerman.id.au>; Paul Mackerras <paulus@samba.org=
>; Benjamin Herrenschmidt <benh@kernel.crashing.org>; PLATTNER Christoph <c=
hristoph.plattner@thalesgroup.com>; Christophe Leroy <christophe.leroy@csgr=
oup.eu>
Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/603: Fix protection of user pages mapped with =
PROT_NONE

On Mon, 1 Feb 2021 06:29:50 +0000 (UTC), Christophe Leroy wrote:
> On book3s/32, page protection is defined by the PP bits in the PTE=20
> which provide the following protection depending on the access keys=20
> defined in the matching segment register:
> - PP 00 means RW with key 0 and N/A with key 1.
> - PP 01 means RW with key 0 and RO with key 1.
> - PP 10 means RW with both key 0 and key 1.
> - PP 11 means RO with both key 0 and key 1.
>=20
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/603: Fix protection of user pages mapped with PROT_NONE
      https://git.kernel.org/powerpc/c/c119565a15a628efdfa51352f9f6c5186e50=
6a1c

cheers
