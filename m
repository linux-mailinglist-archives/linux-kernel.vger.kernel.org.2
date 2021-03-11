Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E381336F47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhCKJwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhCKJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:51:52 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C30C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:51:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i15so2274996qvr.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 01:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=2Z5KFbpoZoKx3xPK/QW5i6Kd1QKjNeYD38tnwCHsyF8=;
        b=i1jBcHgUGSgigIMBO+DKplyCYBPD6kW8rwDbo65wSugoVcUXh0XsUUWt0pLSDVqu4U
         6GeZH6sGiQbKxcrTtzh68nvxB64U1a3WrvOZocEEruO35wpxS0+GKXgMQHbmi8fB9hUf
         PdE9upbBgCtWLAE7y59g/QkNAeBK868Il27eiEWRXyfUuNfPciUq8f67SZzvFUYepZks
         P66+r+VYAk+6620yeUi3mWyobwnwOirwLbUhuIAcvH6LVxsFurfj375E/vFMPykDZj4J
         hzXf22SKWGkYiOG1TCEy6c6+Z8xQRt7JsI1QdTh1NFnu62nzTY9cKmXaE3BTBgb9NsJG
         4Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=2Z5KFbpoZoKx3xPK/QW5i6Kd1QKjNeYD38tnwCHsyF8=;
        b=ZJ1MmTHpO9mp1ZZtdcP/UOSQHxOVooxZ7ELBiVdih9/Xb5H4CjBFgCQMJgt0jx5Ht0
         rVa33zqGRcCuV9/XT1sdEiWAmrSAgKeePGKsCy3fko4ny/bbAVYsd/qazr2vsLb3Bd8k
         MyjgUWZAo1S3Ff3I8bz/7n8iseksIXTX+5Rx7Jr+M6stwIKTFKCEV18QJpIs2dFWgmLG
         vXAcPGZAT4wX4zvWAzqObG8Ve/izTtLs+3YyBFSO6XaedkreTDe7R2Mxqw1VyUs+1boh
         2jobjJ743SwAM/5mtn1vEEuR6rhPay0z7Et/II9626igVIHQXxrBsocgl/Aze2ODBzzE
         I6kA==
X-Gm-Message-State: AOAM531XoGUfVtijYDNTRfSstMzB+RrAYVDRR4FZNQZS+OBxX0+OlHG0
        3lsAPoIttYpZNO6ekjyZi2DODw==
X-Google-Smtp-Source: ABdhPJwGb334duzGB4dbTv8VoBPxtR1DzgtLcfSaeSkCINGEyVHbn8TfuUmF8n4M7qC3yuVwjIg/+g==
X-Received: by 2002:a0c:cc8c:: with SMTP id f12mr6684470qvl.14.1615456311156;
        Thu, 11 Mar 2021 01:51:51 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61:2b0f:e860:4e22:d54f])
        by smtp.gmail.com with ESMTPSA id w197sm1462903qkb.89.2021.03.11.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 01:51:50 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 'make O=' indigestion with module signing
In-Reply-To: <860945.1615455241@warthog.procyon.org.uk>
References: <91190.1615444370@turing-police>
 <860945.1615455241@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1615456309_76436P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Mar 2021 04:51:49 -0500
Message-ID: <102790.1615456309@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1615456309_76436P
Content-Type: text/plain; charset=us-ascii

On Thu, 11 Mar 2021 09:34:01 +0000, David Howells said:
> Valdis Klētnieks <valdis.kletnieks@vt.edu> wrote:
>
> > What i *expected* was that multiple builds with different O= would each
> > generate themselves a unique signing key and put it in their own O= directory
> > and stay out of each other's way.
>
> Hmmm...  Works for me.  I use separate build dirs all the time.
>
> What version of the kernel are you using and what's the build command line -
> in particular the full O= option?

This is linux-next as of yesterday. For testing, I've been using:

LANG=C make O=/tmp/arm64 V=1 ARCH=arm64 ASFLAGS='-mcpu=all' CROSS_COMPILE=/opt/aarch64/bin/aarch64-linux-gnu- certs/

and it insists on trying to make the certs in /usr/src/linux-next rather than /tmp/arm64:

make -f /usr/src/linux-next/scripts/Makefile.build obj=certs \
single-build= \
need-builtin=1 need-modorder=1
  scripts/extract-cert /usr/src/linux-next/"certs/signing_key.pem" certs/signing_key.x509
At main.c:142:
- SSL error:0200100D:system library:fopen:Permission denied: ../crypto/bio/bss_file.c:69
- SSL error:2006D002:BIO routines:BIO_new_file:system lib: ../crypto/bio/bss_file.c:78
extract-cert: /usr/src/linux-next/certs/signing_key.pem: Permission denied
make[2]: *** [/usr/src/linux-next/certs/Makefile:106: certs/signing_key.x509] Error 1
make[1]: *** [/usr/src/linux-next/Makefile:1847: certs] Error 2
make[1]: Leaving directory '/tmp/arm64'
make: *** [Makefile:215: __sub-make] Error 2


Is it possible that it works for you because although you have
separate build dirs, it's still able to write to the source tree?


--==_Exmh_1615456309_76436P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYEnoNQdmEQWDXROgAQIeahAAk0hEOVyD2An8GEIm/htx8n04cbX8WF7O
j8OZk+N5OHOZ1RI/ORTvZiNDfz/tNjSv6W4ELTe481ozAs3N8syGNzTbKi4m615Q
9OLHfw5EwOc/KMydbedZveB1kS2y03dsBnsZU/lnuHQq4mPvnyvWIv5rEUIXtRf9
SGXxl1vIVxuBasmn30C8fShhDWf6W9dtGIGynQs7dhOOpFOpqh4Vyb/VYiRDVDCy
r/1LLQXgUgPIbcJSvAeOucte6wENNmEtYpf16T1vJZ0eoUK7MymD71Xhv/i48o2C
lDmflllLJb1XLGKeHC04Jp5jTsmvdcmmynjAhiU6pvziFMyas7JKbK3isS8B00JC
NvLk+f4v1g4CkG5ExryQe7Z9+pqVoUAQri+AmPFAUvALNycqJojOTxH3QOeZ+D/T
CMuSKeQoswcJm1BE/FmvyaGPzpwL7eS3YjZ5cV2Gi8Wz+kQVtQpakuIvH1TNnWC3
1qrsB1pyfe69uTfrtmdpaVTiQ+g1QtzDnWpbmSmrgUXvvhBmB3upjMQAQNG6KDqs
YVEG4eaIsSjsxV9lGyut2acbpgC/jR8EYSIrIH5Xl/UdI+FxhYQZ3rHg7gJknazv
GeYgcs1pB56dPEuTH281eVxD4goqZH6UA01gEj3MeXs8xWnVs0sXiq47pYEPGjmV
I3L/oA3HRXQ=
=b6qj
-----END PGP SIGNATURE-----

--==_Exmh_1615456309_76436P--
