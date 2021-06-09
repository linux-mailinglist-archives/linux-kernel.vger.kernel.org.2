Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2746E3A0E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhFIINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237352AbhFIINA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:13:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2383461361;
        Wed,  9 Jun 2021 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623226266;
        bh=yUArdIH6Ub7Ul+8sCqp3WCqTWkCgAxiZVdxMV7n0QJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GiXAU6dJCofyZyAUXNCzHuzDOZ26FTcRumjpkCpysqlK9K9GeBQ5JqdPVNuMeUPqU
         XVNGStkrQn0/qxF2JGuy+FsNsL97qDZo7wg/+Q1n0Vppp0VYGbeD8Pjr0vfbTSeGxl
         09TqP5Lqlzxc719ZXA6e8sEUJVa7/DWK2SmvoK+fX4avt7X3xkDJiZ+9lgNnfVBSJx
         BJGn10Dgh+3ZgIcYd4Zvtqy32yQiFN/HxRref+OelPrsjz7XxryF79dml+V+zwtqCT
         zF0iaUv4JD2e5IwVa22PJpvcMiVBCBS0OhNo23cF9MP4TCbtABtz452lhQx5sV42JH
         c5NBhZ/iKfl5w==
Date:   Wed, 9 Jun 2021 10:11:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <n@nfraprado.net>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        ~lkcamp/patches@lists.sr.ht
Subject: Re: [RFC PATCH 1/2] docs: automarkup.py: Add literal markup of
 known constants
Message-ID: <20210609101102.2a97b2dd@coco.lan>
In-Reply-To: <20210609014308.234027-2-n@nfraprado.net>
References: <20210609014308.234027-1-n@nfraprado.net>
        <20210609014308.234027-2-n@nfraprado.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue,  8 Jun 2021 22:43:07 -0300
N=C3=ADcolas F. R. A. Prado <n@nfraprado.net> escreveu:

> There are some known constants that are used throughout the
> documentation, like NULL and error codes, and which are better formatted
> as literals by Sphinx. Make these words automatically literals.
>=20
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <n@nfraprado.net>
> ---
>  Documentation/sphinx/automarkup.py | 45 ++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/au=
tomarkup.py
> index acf5473002f3..eb219783d9e3 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -72,6 +72,40 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcn=
tl', 'mmap',
>                'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
>                'socket' ]
> =20
> +#
> +# Words that are automatically converted to literals
> +#
> +Literals =3D [ 'NULL', 'ULONG_MAX', 'LONG_MAX', 'EPERM', 'ENOENT', 'ESRC=
H',
> +            'EINTR', 'EIO', 'ENXIO', 'E2BIG', 'ENOEXEC', 'EBADF', 'ECHIL=
D',
> +            'EAGAIN', 'ENOMEM', 'EACCES', 'EFAULT', 'ENOTBLK', 'EBUSY',
> +            'EEXIST', 'EXDEV', 'ENODEV', 'ENOTDIR', 'EISDIR', 'EINVAL',
> +            'ENFILE', 'EMFILE', 'ENOTTY', 'ETXTBSY', 'EFBIG', 'ENOSPC',
> +            'ESPIPE', 'EROFS', 'EMLINK', 'EPIPE', 'EDOM', 'ERANGE', 'EDE=
ADLK',
> +            'ENAMETOOLONG', 'ENOLCK', 'ENOSYS', 'ENOTEMPTY', 'ELOOP',
> +            'EWOULDBLOCK', 'ENOMSG', 'EIDRM', 'ECHRNG', 'EL2NSYNC', 'EL3=
HLT',
> +            'EL3RST', 'ELNRNG', 'EUNATCH', 'ENOCSI', 'EL2HLT', 'EBADE', =
'EBADR',
> +            'EXFULL', 'ENOANO', 'EBADRQC', 'EBADSLT', 'EDEADLOCK', 'EBFO=
NT',
> +            'ENOSTR', 'ENODATA', 'ETIME', 'ENOSR', 'ENONET', 'ENOPKG',
> +            'EREMOTE', 'ENOLINK', 'EADV', 'ESRMNT', 'ECOMM', 'EPROTO',
> +            'EMULTIHOP', 'EDOTDOT', 'EBADMSG', 'EOVERFLOW', 'ENOTUNIQ',
> +            'EBADFD', 'EREMCHG', 'ELIBACC', 'ELIBBAD', 'ELIBSCN', 'ELIBM=
AX',
> +            'ELIBEXEC', 'EILSEQ', 'ERESTART', 'ESTRPIPE', 'EUSERS', 'ENO=
TSOCK',
> +            'EDESTADDRREQ', 'EMSGSIZE', 'EPROTOTYPE', 'ENOPROTOOPT',
> +            'EPROTONOSUPPORT', 'ESOCKTNOSUPPORT', 'EOPNOTSUPP', 'EPFNOSU=
PPORT',
> +            'EAFNOSUPPORT', 'EADDRINUSE', 'EADDRNOTAVAIL', 'ENETDOWN',
> +            'ENETUNREACH', 'ENETRESET', 'ECONNABORTED', 'ECONNRESET', 'E=
NOBUFS',
> +            'EISCONN', 'ENOTCONN', 'ESHUTDOWN', 'ETOOMANYREFS', 'ETIMEDO=
UT',
> +            'ECONNREFUSED', 'EHOSTDOWN', 'EHOSTUNREACH', 'EALREADY',
> +            'EINPROGRESS', 'ESTALE', 'EUCLEAN', 'ENOTNAM', 'ENAVAIL', 'E=
ISNAM',
> +            'EREMOTEIO', 'EDQUOT', 'ENOMEDIUM', 'EMEDIUMTYPE', 'ECANCELE=
D',
> +            'ENOKEY', 'EKEYEXPIRED', 'EKEYREVOKED', 'EKEYREJECTED',
> +            'EOWNERDEAD', 'ENOTRECOVERABLE', 'ERFKILL', 'EHWPOISON' ]

There are some arch-specific error codes missing there:

	ECANCELLED
	EINIT
	EMAXERRNO
	ENOSYM
	EPROCLIM
	EREFUSED
	EREMDEV
	EREMOTERELEASE
	ERREMOTE

It sounds a nightmare to maintain this by hand, as a list of used
constants will only grow. IMO, an explicit list should be kept only to
with the absolute minimum, e.g. for highly-used constants that aren't
error codes nor FOO_BAR. The only case that occurs to me that fits=20
on this rule is 'NULL'.

As I said on patch 0/2, IMO the error codes should be parsed from the
relevant errno files:

	./arch/powerpc/include/uapi/asm/errno.h
	./arch/parisc/include/uapi/asm/errno.h
	./arch/sparc/include/uapi/asm/errno.h
	./arch/alpha/include/uapi/asm/errno.h
	./arch/mips/include/uapi/asm/errno.h
	./arch/mips/include/asm/errno.h
	./include/uapi/asm-generic/errno-base.h
	./include/uapi/asm-generic/errno.h
	./include/linux/errno.h

Also, as pointed on patch 0/2 too, I would automatically parse all=20
uppercase with a _ on it, as all of them look constants on my eyes=20
(but only after checking at the references dictionary if they aren't
a cross-reference to a macro).

> +
> +#
> +# Any of the words in Literals, optionally prefixed with a '-'
> +#
> +RE_literal =3D re.compile(r'-?\b(' + str(r'|'.join(Literals)) + r')\b')

see my notes about "\b" on patch 0/2.

Regards,
Mauro
