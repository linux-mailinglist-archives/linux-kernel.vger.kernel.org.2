Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CDE31EDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhBRRxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhBRPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:09:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02500C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 07:07:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a9so1401163plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3pLO0/SwxZGyRGh+XhMOs8gNDabWvX5rt4SJCVa39ww=;
        b=EYg36vUluH6aNryevcdeTNmFOsskHwJeOWDlvobPHXFgwT1EQl1D9sRLjKUSGV9nTw
         Gd79AKLCZysFvj0IUngWOAfP+nABiLLkKlCPy5xWjGKxqvsuHBlVVF5MJRSHOPwbJqiz
         q5InDBe/wXNyKlcqMENOfD07W9wGNxYcseSD/bhlm5uFWrCEWVQeaeWhCuu5RwKFpHai
         W5St8SndqmL17KM0PFjBbI0qb4I22c6D39VfxzocNXVJmIeYu5u7koTHcftSObYSVXXk
         Dwzap/RWqTHFtnKpfY2ZscFAEkdPziZlGx2bx8gUv5LUG/mUutz240etAqUm6YSqvmOU
         jMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3pLO0/SwxZGyRGh+XhMOs8gNDabWvX5rt4SJCVa39ww=;
        b=DOfU4d0N+KamnoeczV6ur2Pmi4swGCyqwta/ykwhrGMLym4ue1111O+aKicUUYoAMz
         dIiQ6jo1KRcSbAey63n1TV/A+JPjNxZ9T9P0J/JZ3S0mn+oRyN+rqcy7F2WP9gCUf51Q
         aFTpCz7Oxl7IKAG1zA1F0jc64G6RK8XGo2k1XQ0JiuFKE8TtNmm8RJ6mpe/H/mt90V32
         FLImrVUvOpCpLeK63AzqdjQ7Wz8f2qKFHth+dTj8tbmhFKAaTm4ngOWmTFeUIayZEVqt
         JTleNYL9O/uIgB0YvCXCR6MJvXyMyutB1HAHLlfbj/BJ349O78hV9hutjgstfd+YTHMy
         J+Sg==
X-Gm-Message-State: AOAM5324LZk+79x0DNNqpavV7V3zGXhNHhLUmpjtH3A/+tTPkpf9Avcv
        1fyOQ/2eJ9oDE3osDHAcrV+mjQ==
X-Google-Smtp-Source: ABdhPJzpRizCW2ZCIgNSqXCsnIk0bCYAdFDuhHsLhnE/F0WNaGoY36BRLDxBsO8C+BC572RHnWfY7A==
X-Received: by 2002:a17:903:114:b029:e2:f8fb:b6a1 with SMTP id y20-20020a1709030114b02900e2f8fbb6a1mr4404299plc.77.1613660837991;
        Thu, 18 Feb 2021 07:07:17 -0800 (PST)
Received: from google.com ([2620:15c:202:201:dd7e:e039:9b47:214f])
        by smtp.gmail.com with ESMTPSA id b187sm6214033pgc.23.2021.02.18.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 07:07:16 -0800 (PST)
Date:   Thu, 18 Feb 2021 07:07:10 -0800
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.12
Message-ID: <YC6CnuV/F5c5dFQ1@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kCAkTxum+inCV2Oh"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kCAkTxum+inCV2Oh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.12

for you to fetch changes up to a59e12218c4f5498d5669a0ee0c725101ca89d52:

  platform/chrome: cros_ec_typec: Flush pending work (2021-02-11 13:18:46 -=
0800)

----------------------------------------------------------------
chrome platform changes for 5.12

Lots of changes to the cros_ec_typec driver for 5.12.
A portion of this this set of cros_ec_typec driver's changes
(up to 8553a979fcd0  platform/chrome: cros_ec_typec: Send mux configuration=
 acknowledgment to EC)
was merged through GregKH's USB tree in immutable branch
tag-ib-usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12
in order to satisfy cros_ec_typec driver and typec connector class subsystem
dependencies of subsequent changes. Please see greg's usb-5.12-rc1.

cros_ec_typec:
* Registration of cable plug information
* Support for SOP' plug registration and altmodes
* Support for reporting number of altmodes supported by partners and plugs
* Send mux configuration ack to EC via a new host command
* Support mux control with no port partner present
* Decouple cable removal from partner removal

cros_ec misc:
* Fix some event masking in cros_ec_proto.
* Gwendal reworked cros_ec's top and bottom half for consistency in ishtp a=
nd
  rpmsg
* Constify static attribute_group structs

----------------------------------------------------------------
Evan Benn (2):
      platform/chrome: cros_ec_proto: Use EC_HOST_EVENT_MASK not BIT
      platform/chrome: cros_ec_proto: Add LID and BATTERY to default mask

Gwendal Grignou (2):
      platform/chrome: cros_ec: Call interrupt bottom half in ISH or RPMSG =
mode
      platform/chrome: cros_ec: Call interrupt bottom half at probe time

Pi-Hsun Shih (2):
      platform/chrome: cros_ec_commands: Add host command to keep AP off af=
ter EC reset.
      platform/chrome: cros_ec_sysfs: Add cold-ap-off to sysfs reboot.

Prashant Malani (10):
      platform/chrome: cros_ec_typec: Make disc_done flag partner-only
      platform/chrome: cros_ec_typec: Factor out PD identity parsing
      platform/chrome: cros_ec_typec: Rename discovery struct
      platform/chrome: cros_ec_typec: Register cable
      platform/chrome: cros_ec_typec: Store cable plug type
      platform/chrome: cros_ec_typec: Set partner num_altmodes
      platform/chrome: cros_ec_typec: Register SOP' cable plug
      platform/chrome: cros_ec_typec: Register plug altmodes
      platform/chrome: cros_ec_typec: Decouple partner removal
      platform/chrome: cros_ec_typec: Flush pending work

Rajmohan Mani (2):
      platform/chrome: cros_ec_typec: Skip port partner check in configure_=
mux()
      platform/chrome: cros_ec_types: Support disconnect events without par=
tners

Rikard Falkeborn (1):
      platform/chrome: Constify static attribute_group structs

Utkarsh Patel (2):
      platform/chrome: cros_ec_typec: Parameterize cros_typec_cmds_supporte=
d()
      platform/chrome: cros_ec_typec: Send mux configuration acknowledgment=
 to EC

 drivers/platform/chrome/cros_ec.c              |  33 ++-
 drivers/platform/chrome/cros_ec.h              |   4 +-
 drivers/platform/chrome/cros_ec_ishtp.c        |   6 +-
 drivers/platform/chrome/cros_ec_lightbar.c     |   2 +-
 drivers/platform/chrome/cros_ec_proto.c        |  12 +-
 drivers/platform/chrome/cros_ec_rpmsg.c        |   6 +-
 drivers/platform/chrome/cros_ec_sysfs.c        |   5 +-
 drivers/platform/chrome/cros_ec_typec.c        | 278 ++++++++++++++++++++-=
----
 drivers/platform/chrome/cros_ec_vbc.c          |   2 +-
 drivers/platform/chrome/wilco_ec/sysfs.c       |   2 +-
 include/linux/platform_data/cros_ec_commands.h |  18 ++
 11 files changed, 289 insertions(+), 79 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--kCAkTxum+inCV2Oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYC6CngAKCRBzbaomhzOw
wmErAP0YpmKJHu7q4OVuVWRLlIAuvFUTPz8LcKcusA7P8rvTHwD/UPP6WLCH6rrg
9e3Tep1cOmtfa93V1/37uZCJqeEvuwY=
=Pahe
-----END PGP SIGNATURE-----

--kCAkTxum+inCV2Oh--
