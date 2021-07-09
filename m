Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489EB3C1C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 02:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGIA3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 20:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhGIA3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 20:29:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1BAC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 17:27:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so5090087pjh.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=kGUDF61kH7DuKZ9RNXka80YbVY+lTdsyFO1WYdrvzWw=;
        b=wYMT0y5pftXlm42ofM/k5HL7GVLczsZ/CKpg++6+mXmjARsgGdDsHwSjjXQbPiqWih
         E7Q+MiBJAIX41DXE5qm0jR8zcKFW/9KBolGwoQ+qpcziw8gydXHRqWRSEeFzeXlSB6k+
         s4mc8r2N3h8vEv3iRRgyHMiGKudGuITJ4erphjRDkHuXtvwdCsgq1Wmdw9njoZrIQq9h
         p+UE3aL4dhvVSCJLiJDn4Up2sXw7y06srHC7+0y45YoZTmYe/Vl3JfEf31ZcSWLflLNI
         L3ZomiVtTkzgWrc+IOraMqu2s9aBB9k5nW2xdowPNPc1HDcCT0dUXwEy1JBl49hrQpcM
         wfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=kGUDF61kH7DuKZ9RNXka80YbVY+lTdsyFO1WYdrvzWw=;
        b=Rqqozi6JhqgIXLjTk7ngdC36qpxuOE+Ww07hw+zzJfXzcMZHjgq1hZ8+a+kcoeDcsu
         Nkaa2l6TdsBBzVydBTDtQoQ3ei7HYIdnPcA2EQ02vkoMGw4bc4LO6CKl+FnXjo+BCZWH
         iNyx8+FV9AKQpeZOUcsB+H+R5Fpj1KPf6b8MR5mMox6m5epXs1unYp3xcl+/qechlIhS
         D489lySjkmi1AEdJHcJqpaFAPcCx/uoba+XW/HmGyA8gNdakvWpx/SvyTcYYQi3+wHxj
         XoG+AzwWVQ1Rad2YXb97E70PYoySFGtYxBl2fuWoasRQMxNxTZSYn/NGi1vavueUbu0L
         nLEw==
X-Gm-Message-State: AOAM532v/VD1zMdboRCDRONDwdWdt+UJOuSC+HkKZCELYYqWw0MgYP8B
        b0bNPlpyq5PP7OIIBibU+ZdIEg==
X-Google-Smtp-Source: ABdhPJwdz9geUWM9jxrc5l+YNr1Ebckl9l1sXse3W1hOWbs8iUeg6/elAtYObCaRypwAlF6HVmE4kA==
X-Received: by 2002:a17:90a:aa8a:: with SMTP id l10mr34849991pjq.227.1625790431170;
        Thu, 08 Jul 2021 17:27:11 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id a31sm4796676pgm.73.2021.07.08.17.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 17:27:10 -0700 (PDT)
Date:   Thu, 8 Jul 2021 17:27:07 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     gregkh@linuxfoundation.org, Carlos Bilbao <bilbao@vt.edu>,
        alexander.deucher@amd.com, davem@davemloft.net,
        mchehab+huawei@kernel.org, kuba@kernel.org,
        James.Bottomley@hansenpartnership.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Follow the indentation coding standard on
 printks
Message-ID: <20210708172707.7c4a5d5f@hermes.local>
In-Reply-To: <2148456.iZASKD2KPV@daneel.sf-tec.de>
References: <2784471.e9J7NaK4W3@iron-maiden>
        <2148456.iZASKD2KPV@daneel.sf-tec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/osUijuuKOZk+rhcif3qc0dd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/osUijuuKOZk+rhcif3qc0dd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Jul 2021 23:25:37 +0200
Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> Am Donnerstag, 8. Juli 2021, 15:10:01 CEST schrieb Carlos Bilbao:
> > Fix indentation of printks that start at the beginning of the line. Cha=
nge
> > this for the right number of space characters, or tabs if the file uses
> > them. =20
>=20
> > diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c

Does anyone still have Linux ATM devices?


--Sig_/osUijuuKOZk+rhcif3qc0dd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAmDnl9sACgkQgKd/YJXN
5H44YBAAnkAyswyrE/rskVunJmbFn2UtmB7idcIWZNhNmp7BkEhyEYyzCVcAx6bM
bnk6ClVxxIJpdvdvlYcnloA6+MOWcYRXDeL2slbmTsm+B4WP0hoFqDot0y3SW9xo
Y9XTyebLLT+x6xCBE8S+VeaIiIgHDmPiHCyB5XWxYulwcuQ38d3+vi0joRMBF1S7
I6LJ/gQqQCzrjSOnuEFASNOwbVdGUz73UFz1N9FqInsU8w0ihdMHOdeheB73Ib/R
GeEg58853dmIrwAZsejSbk9sgD+vMYpa4giHCyJgbus75SUCK9m246O/bnljf/oC
3rGruoeFAHLvvHk530CMNy4QvyByXOKN8arPItYfXxaHIosjhy8x824fPpknRrnL
emIlOQksSmma+MtUVCZmasKeEBcuWTXIrl1bRcnWtFBr72v/JEi5bH0Pu+z0kVNS
lK46OJwWZy3dE1bkOyiYLIgIEPek9bqpmRsqqy9zDb8597wYjeK+qHZa83j75O0a
vY0j6IvQmxAbmTehfgfjIeXS55x71981Y2wevmBk+8M7FB1oqKTjRefjIs2FbiMl
nSdtBWPqTioCTDE4LR59IbeKOyVf09K1yKvl98BOQReRwPSVGzQ6KrJGMBDAoxbJ
a5gx6B8wcJZjSGw6ydVDm18zrQ8wY1S/cbXvzlTDzXNl1vW9EE8=
=ELNb
-----END PGP SIGNATURE-----

--Sig_/osUijuuKOZk+rhcif3qc0dd--
