Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F171B44BB54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhKJFmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhKJFms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:42:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E3C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 21:40:01 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g28so1247662pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 21:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cbEeQ6+qKUMBjET8rK9Wuk1vr0mbkjE2MajA0mYmGrI=;
        b=dQHvOR9kDzqZyKp9v+2RpxkDgkI2thdadDk2IzjkU0NSGHLJRuA8t1hOn8dOibSp2R
         zhNOBlSZ1aMpc9tyS0+fHNXcaPcKX/ErY3M4Rda446/3qQV4Tyi6V4Cq19W9mn5Cd+6J
         7PbCqKcOfVl9HkICgz0VuyoHfvjWGBLfoOkM2x01aNa1WRyDhthcDHnQKniDGLl8WKWO
         hpwTeu9NqAQaStprDmNGuc0dA/m54OHtfLQY2F+wFk66wxhaKtXet9Ahs3RSxTwpxFug
         YFP7OJFut34ge53PV+J84kvI3Sa8152jx6VwG7HGzUS7z/nE9A42REHKBIsH1dtmTReM
         HNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cbEeQ6+qKUMBjET8rK9Wuk1vr0mbkjE2MajA0mYmGrI=;
        b=7g1UtRSV2uUsCYK/ziQdpIqxfdVsB48mvvMdwMXZTDr2+cpuFryjZobGojKtGClZFG
         A5E64LMuNIjRSgQ4qoKzDqOBys8/9QefP5Wp37CVuyPGZKLPQg8QDngOU4OFFDUJN4wQ
         0CQ7iHnbj9hddsUv4ouFDGui+bHjDWtpjLsBINUviQ/F06V0LpPN7c5TpjkdAII+TeDa
         BDGVeJ1KE8DD7uf1MaQraofho9BL5EWZ6xMqt2/XGKbRIR6bwWpq5VRU+osLBvYEm/Ed
         GOv7Hkw2lYRWW4DQMpe/jVsQ6nXbONxwkK83uU6pAXwJvjcov0WxHAvBRPE6ssiYGwcv
         pJ7A==
X-Gm-Message-State: AOAM532B/a1MYuWrT2JMga3c9LC1uiQg4OPC7nu7m04vmeFYsZh38E5C
        vSCeJpgQNkjlmTASn6C44dm+tw==
X-Google-Smtp-Source: ABdhPJwRg7Q+etGKd6JSarWTYmIOQKagR2UAcStiLP99Z3Hp6FNUHXP9DXazRsucMjuzyyf6CLxR2g==
X-Received: by 2002:aa7:96ba:0:b0:49f:c35f:83f8 with SMTP id g26-20020aa796ba000000b0049fc35f83f8mr27050207pfk.47.1636522800306;
        Tue, 09 Nov 2021 21:40:00 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e2b0:9813:5c74:428a])
        by smtp.gmail.com with ESMTPSA id j17sm22234410pfj.55.2021.11.09.21.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 21:39:59 -0800 (PST)
Date:   Tue, 9 Nov 2021 21:39:54 -0800
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, bleung@google.com,
        bleung@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.16
Message-ID: <YYtbKoSFCLzvvOUZ@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czdp0giYUfMFfbLn"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czdp0giYUfMFfbLn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.16

for you to fetch changes up to 297d34e73d491a3edbd6e8c31d33ec90447a908b:

  platform/chrome: cros_ec_proto: Use ec_command for check_features (2021-1=
0-31 15:52:55 -0700)

----------------------------------------------------------------
chrome platform changes for 5.16

cros_ec_typec:
* Clean up use of cros_ec_check_features

cros_ec_*:
* Rename and move cros_ec_pd_command to cros_ec_command, and make changes to
  cros_ec_typec and cros_ec_proto to use the new common command, reducing
  duplication.

sensorhub:
* simplify getting .driver_data in cros_ec_sensors_core and cros_ec_sensorh=
ub

misc:
* Maintainership change. Enric Balletbo i Serra has moved on from Collabora,
  so removing him from chrome/platform maintainers. Thanks for all of your
  hard work maintaining this, Enric, and best of luck to you in your new ro=
le!
* Add Prashant Malani as driver maintainer for cros_ec_typec.c and
  cros_usbpd_notify. He was already principal contributor of these drivers.

----------------------------------------------------------------
Benson Leung (1):
      MAINTAINERS: Add Prashant's maintainership of cros_ec drivers

Colin Ian King (1):
      platform/chrome: cros_ec: Fix spelling mistake "responsed" -> "respon=
se"

Prashant Malani (9):
      platform/chrome: cros_ec_proto: Fix check_features ret val
      platform/chrome: cros-ec-typec: Cleanup use of check_features
      platform/chrome: cros_usbpd_notify: Rename cros_ec_pd_command()
      platform/chrome: cros_usbpd_notify: Move ec_command()
      platform/chrome: cros_ec_proto: Make data pointers void
      platform/chrome: cros_ec_proto: Add version for ec_command
      platform/chrome: cros_ec_typec: Use cros_ec_command()
      platform/chrome: cros_ec_proto: Use EC struct for features
      platform/chrome: cros_ec_proto: Use ec_command for check_features

Uwe Kleine-K=F6nig (1):
      MAINTAINERS: Chrome: Drop Enric Balletbo i Serra

Wolfram Sang (2):
      iio: common: cros_ec_sensors: simplify getting .driver_data
      platform/chrome: cros_ec_sensorhub: simplify getting .driver_data

 MAINTAINERS                                        | 14 +++-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  3 +-
 drivers/mfd/cros_ec_dev.c                          |  4 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  4 +-
 drivers/platform/chrome/cros_ec_proto.c            | 79 ++++++++++++++++--=
----
 drivers/platform/chrome/cros_ec_sensorhub.c        |  6 +-
 drivers/platform/chrome/cros_ec_typec.c            | 74 ++++++------------=
--
 drivers/platform/chrome/cros_usbpd_notify.c        | 50 +-------------
 include/linux/platform_data/cros_ec_proto.h        |  7 +-
 9 files changed, 104 insertions(+), 137 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--czdp0giYUfMFfbLn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYYtbKgAKCRBzbaomhzOw
wpgLAQDvf5UUyAcu3XCvC+1e1Vf2R5/XKqBxJs2B3qUJmwVNKgEAwTPUQ0iOf+Q3
+XMePDSCHqrZ4n81Mby3gcY7j7spgA4=
=Ig3h
-----END PGP SIGNATURE-----

--czdp0giYUfMFfbLn--
