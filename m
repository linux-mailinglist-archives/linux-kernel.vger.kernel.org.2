Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C89376BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhEGVlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:41:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D896C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 14:40:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so6204248pjd.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=heBShxPKsWyHOPMr3E9Pq9ytp7o/FJlhqYNiMv9oyMs=;
        b=MKYsYXSnu5Pu9NWy301Uo4CswCZhvRE960GZONYOpHkqvcx/L1BduwD7LfATeJLTfX
         +abIfq0zOuNuswRh5OKBegxWGtzKQCO9LCNy4N9ZXi219jYtSDSLCu9nvyl4Uw5ciDXp
         6AyPlQujdFEcUUQ6W6MkWsQh/uMZmXo3D99NntDItRZlcsGKABNPMqtMI1O7zcY9ohMt
         /bOHn19Edsl8PT/wVAqFxWPOvYVrmuQJ2Uc3L/tMcbF8OTgz6imYV/RMABjsd6z7yxgu
         vxX3dcBaQ/swD1QfEGY8alokJZWUUV0IpwHE8FneLWbkew1E0QIFK1QsvyPq4RXOMPBX
         2xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=heBShxPKsWyHOPMr3E9Pq9ytp7o/FJlhqYNiMv9oyMs=;
        b=VmR9QYXWBihDr5TNAn3GiT2D7mCObbZWfZyB2L7nih8sPFdVtqL1HDxxoowsCWKE3N
         KneV6xA8E2nfFbICOpc9gKDiCJlxorfyZ9xHIsRR5OIA+ojlu6Obgt+nNgGl4cvqNFY/
         bAJ42aeU3UNJzzOfEsdNqVcfrffC2iW9/qagBoz4wiMJmYxbdHqw43AeGqAXWiStMg+6
         kkQArpMLOwmGFmssgahWcvbi29UdP4y857T3x4y8lbUvyAQNpjNsS1UGCFiMKg2L6e0+
         4rF7hrRC1yvP5exenOjB/ZyEHFeArdkdW/z/9/ZNN6qtHmXr4vT+4upcL2sA0thSII/o
         2/3Q==
X-Gm-Message-State: AOAM530aRswG1qG0X0YNl9HRxwC+8al8vE01MTbMxhUpshs3GF8PfryW
        jcogEIKi10uhmxZ64plWvpwN2A==
X-Google-Smtp-Source: ABdhPJyWC9O/dQ3xCDNb7KbkAcEdr6g1R41NYEREsgjB0LqGfsB9Pq3oN5AR8dR+247TGuvnP34ptg==
X-Received: by 2002:a17:902:70c5:b029:ec:9a57:9cc8 with SMTP id l5-20020a17090270c5b02900ec9a579cc8mr12167253plt.73.1620423606211;
        Fri, 07 May 2021 14:40:06 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fad3:ac6c:7eeb:331a])
        by smtp.gmail.com with ESMTPSA id q19sm6081919pfl.171.2021.05.07.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 14:40:05 -0700 (PDT)
Date:   Fri, 7 May 2021 14:39:58 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.13
Message-ID: <YJWzrs7pu38YD6G7@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RfbyHblOmKMsJT/+"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RfbyHblOmKMsJT/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.13

for you to fetch changes up to d61b3f9b91be32f714b218377ab5081932e3ebc2:

  platform/chrome: cros_ec_lpc: Use DEFINE_MUTEX() for mutex lock (2021-04-=
21 10:00:30 +0200)

----------------------------------------------------------------
chrome platform changes for 5.13

cros_ec_typec:
* Changes around DP mode check, hard reset, tracking port change.

cros_ec misc:
* wilco_ec: Convert stream-like files from nonseekable to stream open
* cros_usbpd_notify: Listen to EC_HSOT_EVENT_USB_MUX host event
* fix format warning in cros_ec_typec

----------------------------------------------------------------
Arnd Bergmann (1):
      platform/chrome: cros_ec_typec: fix clang -Wformat warning

Pi-Hsun Shih (1):
      platform/chrome: cros_usbpd_notify: Listen to EC_HOST_EVENT_USB_MUX h=
ost event

Prashant Malani (5):
      platform/chrome: cros_ec_typec: Check for device within remove functi=
on
      platform/chrome: cros_ec_typec: Track port role
      platform/chrome: cros_ec: Add Type C hard reset
      platform/chrome: cros_ec_typec: Handle hard reset
      platform/chrome: cros_ec_typec: Add DP mode check

Yang Li (1):
      platform/chrome: wilco_ec: convert stream-like files from nonseekable=
_open -> stream_open

Ye Bin (1):
      platform/chrome: cros_ec_lpc: Use DEFINE_MUTEX() for mutex lock

 drivers/platform/chrome/cros_ec_lpc_mec.c      |  3 +-
 drivers/platform/chrome/cros_ec_typec.c        | 47 +++++++++++++++++++---=
----
 drivers/platform/chrome/cros_usbpd_notify.c    |  3 +-
 drivers/platform/chrome/wilco_ec/telemetry.c   |  2 +-
 include/linux/platform_data/cros_ec_commands.h |  1 +
 5 files changed, 39 insertions(+), 17 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--RfbyHblOmKMsJT/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYJWzrgAKCRBzbaomhzOw
wnLjAP9UpLPFEywkeA/sqXoLIIqY94e7HbUK3AOEpgS0RU4PYAD8DA0yzL+OQ1Fh
GovHeNDrWZ8Sn7vV2M4d7V6DFhcMwgQ=
=BS2Q
-----END PGP SIGNATURE-----

--RfbyHblOmKMsJT/+--
