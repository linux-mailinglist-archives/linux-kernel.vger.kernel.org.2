Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27F03730CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhEDTbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:31:39 -0400
Received: from smtpout2.vodafonemail.de ([145.253.239.133]:34006 "EHLO
        smtpout2.vodafonemail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhEDTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:31:38 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2021 15:31:37 EDT
Received: from smtp.vodafone.de (smtpa07.fra-mediabeam.com [10.2.0.38])
        by smtpout2.vodafonemail.de (Postfix) with ESMTP id C777C120B8D
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 21:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-smtpout-mb-15sep; t=1620156144;
        bh=dpukU8GguUO6xvcNrar3i7J3K9bMQJqkS5L6BNfPCBg=;
        h=From:To:Subject:Date;
        b=Mbnohlt25E8wZkPJcjxq1sTIidYCE9TVJ7TXeoT95TjosOo6ncXgQJIsVbQg1u1x8
         aCgqKdI6xgNBFpI+wC7Eot8l5/YGUjs3JUywIYgxKyJJ/BGup0ygj912v2tuqgWo5N
         sQXlPZDo94j8zAYXd4J20DfBtq0yVEay2nYeN+eE=
Received: from H270 (p5b38f6a1.dip0.t-ipconnect.de [91.56.246.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 7F787140272
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 19:22:24 +0000 (UTC)
Message-ID: <6C7CD73845304CDE98F6DB165904B571@H270>
From:   "Stefan Kanthak" <kanthak@arcor.de>
To:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] vsscanf() in lib/vsprintf.c
Date:   Tue, 4 May 2021 21:19:47 +0200
Organization: Me, myself & IT
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_2F4E_01D7412B.363FA9A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6002.18197
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.24158
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 4236
X-purgate-ID: 155817::1620156144-0000067D-C9F8850F/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_2F4E_01D7412B.363FA9A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi @ll,

both <https://www.kernel.org/doc/htmldocs/kernel-api/API-sscanf.html>
and <https://www.kernel.org/doc/htmldocs/kernel-api/API-vsscanf.html>
are rather terse and fail to specify the supported arguments and their
conversion specifiers/modifiers.

<https://www.kernel.org/doc/htmldocs/kernel-api/libc.html#id-1.4.3>
tells OTOH:

| The behaviour of these functions may vary slightly from those
| defined by ANSI, and these deviations are noted in the text.

There is but no text (see above) despite multiple deviations from
ANSI C 

<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/lib/vsprintf.c?h=v5.12>

|  /* '%*[' not yet supported, invalid format */
...
|  /*
|   * Warning: This implementation of the '[' conversion specifier
|   * deviates from its glibc counterpart in the following ways:
...

More deviations (just from reading the source):

1. no support for %p
2. no support for conversion modifiers j and t
3. no support for multibyte characters and strings, i.e. %<width>c
   and %<width>s may split UTF-8 codepoints
4. accepts %[<width>]<modifier>[c|s], but ignores all conversion
   modifiers
5. treats %<width><modifier>% (and combinations) as %%
6. accepts %<width><modifier>n (and combinations)
7. doesn't scan the input for %[...]n
8. uses simple_strto[u]l for the conversion modifier z, i.e. assigns
   uint32_t to size_t, resulting in truncation

Is this intended?
If not: patch to fix 5. and 6. and simplify the qualifier handling
        attached 

Stefan Kanthak
------=_NextPart_000_2F4E_01D7412B.363FA9A0
Content-Type: application/octet-stream;
	name="vsprintf.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vsprintf.patch"

--- -/lib/vsprintf.c=0A=
+++ +/lib/vsprintf.c=0A=
@@ -3287,17 +3287,25 @@=0A=
 			str =3D skip_spaces(str);=0A=
 		}=0A=
 =0A=
+		if (!*fmt)=0A=
+			break;=0A=
+=0A=
 		/* anything that is not a conversion must match exactly */=0A=
-		if (*fmt !=3D '%' && *fmt) {=0A=
+		if (*fmt !=3D '%') {=0A=
 			if (*fmt++ !=3D *str++)=0A=
 				break;=0A=
 			continue;=0A=
 		}=0A=
 =0A=
-		if (!*fmt)=0A=
-			break;=0A=
 =0A=
+		/* %% must match % */=0A=
+		if (*fmt =3D=3D '%') {=0A=
+			if (*fmt++ !=3D *str++)=0A=
+				break;=0A=
+			continue;=0A=
+		}=0A=
+=0A=
 		/* skip this conversion.=0A=
 		 * advance both strings to next white space=0A=
 		 */=0A=
@@ -3315,6 +3323,13 @@=0A=
 			continue;=0A=
 		}=0A=
 =0A=
+		if (*fmt =3D=3D 'n') {=0A=
+			/* return number of characters read so far */=0A=
+			*va_arg(args, int *) =3D str - buf;=0A=
+			++fmt;=0A=
+			continue;=0A=
+		}=0A=
+=0A=
 		/* get field width */=0A=
 		field_width =3D -1;=0A=
 		if (isdigit(*fmt)) {=0A=
@@ -3325,30 +3340,18 @@=0A=
 =0A=
 		/* get conversion qualifier */=0A=
 		qualifier =3D -1;=0A=
-		if (*fmt =3D=3D 'h' || _tolower(*fmt) =3D=3D 'l' ||=0A=
-		    *fmt =3D=3D 'z') {=0A=
+		if (*fmt =3D=3D 'z' || *fmt =3D=3D 'L')=0A=
 			qualifier =3D *fmt++;=0A=
+		else if (*fmt =3D=3D 'h' || *fmt =3D=3D 'l') {=0A=
 			if (unlikely(qualifier =3D=3D *fmt)) {=0A=
-				if (qualifier =3D=3D 'h') {=0A=
-					qualifier =3D 'H';=0A=
-					fmt++;=0A=
-				} else if (qualifier =3D=3D 'l') {=0A=
-					qualifier =3D 'L';=0A=
-					fmt++;=0A=
-				}=0A=
+				qualifier =3D _toupper(qualifier);=0A=
+				fmt++;=0A=
 			}=0A=
 		}=0A=
 =0A=
 		if (!*fmt)=0A=
 			break;=0A=
 =0A=
-		if (*fmt =3D=3D 'n') {=0A=
-			/* return number of characters read so far */=0A=
-			*va_arg(args, int *) =3D str - buf;=0A=
-			++fmt;=0A=
-			continue;=0A=
-		}=0A=
-=0A=
 		if (!*str)=0A=
 			break;=0A=
 =0A=
@@ -3450,11 +3453,6 @@=0A=
 			fallthrough;=0A=
 		case 'u':=0A=
 			break;=0A=
-		case '%':=0A=
-			/* looking for '%' in str */=0A=
-			if (*str++ !=3D '%')=0A=
-				return num;=0A=
-			continue;=0A=
 		default:=0A=
 			/* invalid format; stop here */=0A=
 			return num;=0A=

------=_NextPart_000_2F4E_01D7412B.363FA9A0--

