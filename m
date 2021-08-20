Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85CA3F321D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhHTRRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhHTRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:17:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F950C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:16:38 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j9so5882689qvt.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Z4Jno17Dms0KLq7XjB4K7ABpOau2kQktK28CGQWNujk=;
        b=P217ffHHzJSqKDPRaest8rKYxztRBEh19rY67W2jt1mNF+4i7QSjZHw6jTbPxwKuPD
         lJHzVCcnl1xx8mtaV18SO8d98uVnMQxH8uVbJbIfyLcQSrY22XECiAVRGdVGNbVEHowO
         ysMA2RJQdDAxUUgUies/i1su9WY4zAknbNtiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Z4Jno17Dms0KLq7XjB4K7ABpOau2kQktK28CGQWNujk=;
        b=IrmwbinJZU1iCVI98ZidalvbwNQ4X3IkEforPKBN30jWhmY0OP7GTpdU+teavmyDT/
         0FXBzYmlcL0zjv9b+KbDO6BIteCGYBSgHe7oSVozrTe1mvpBqJLZdR3pnGTbltbyW2Ea
         kbuhSWrhBHTT+D2tlwUOteTsGiYvkwGXhjHcRJ197HebdRciHqRxOVVpe6MBTouZfBna
         2BnTQ2rF906SyDA3LWCXulvzhUFzYPHHv4VdkcQwFunCR1UyUtJ9Nm4nSYrSOjtyWhIo
         ZUGBRKRxQi8dNsATnrgFs4E1dCLZ4O42H6PMzDiY5y4Y3tbk7iazdGalLN3HZ/JbKmP+
         SFrA==
X-Gm-Message-State: AOAM532Y4wHHYJTzN31f03EOUwvqASwvvFjbp7UasGghTiHzQW8a9gQU
        YiJvmWer9UhWaqHcDToBu/cV9yrgeFfmiWbT
X-Google-Smtp-Source: ABdhPJxOvphabWwNY8w5Ev1Bg28SILqidAEs21uOf0bLvVmztye7qPmmPoqTivADjxwK7wIXyzX++A==
X-Received: by 2002:a05:6214:9ce:: with SMTP id dp14mr21172513qvb.42.1629479797514;
        Fri, 20 Aug 2021 10:16:37 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id x83sm3511343qkb.118.2021.08.20.10.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:16:37 -0700 (PDT)
Date:   Fri, 20 Aug 2021 13:16:33 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: PSA: lore.kernel.org/patchwork/project/lkml is going away
Message-ID: <20210820171633.43xhblvzuk4swxln@nitro.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kmba7i4hrxidurry"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmba7i4hrxidurry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello:

lore.kernel.org/patchwork is a read-only patchwork instance just for patches
sent to linux-kernel@vger.kernel.org ("LKML"). It's huge, resource-hungry, =
and
serves little actual purpose alongside public-inbox, with >99% of all traff=
ic
coming from bots.

This service will be discontinued and removed:

- we will stop delivery of new messages to the LKML patchwork effective=20
  Monday, August 23, 2021
- we will generate a one-time mapping of patchwork patch-id's to message-ids
- we will set up a simple redirector to preserve existing links, such that
  lore.kernel.org/patchwork/patch/{patchid} -> lore.kernel.org/r/{messageid}

To clarify, this does NOT in any way affect patchwork.kernel.org, which will
continue being maintained and supported, just the little-known and little-u=
sed
instance of patchwork at lore.kernel.org/patchwork/.

If you have any questions or concerns, please let me know.

-K

--kmba7i4hrxidurry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCYR/jcQAKCRC2xBzjVmSZ
bMvXAQCbju/LTzY3Ix8MjD0ToVp7PMnLzsozbsjwtrkhfTL9lAD/VzQHbodWSw3h
Dl61MOR2l6lT64BwGOlzXojOVCFy1AE=
=CqEa
-----END PGP SIGNATURE-----

--kmba7i4hrxidurry--
