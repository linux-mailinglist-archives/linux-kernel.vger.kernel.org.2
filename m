Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CB630B93B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBBIHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhBBIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:06:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C26C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:06:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w18so13796193pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xdsSCNqRT6pmI8PDRatFSJJyOi2y+t4BEGL1p6JdYS8=;
        b=a2gcKjdkHx8c5T+5arN64AbLg0NvYBu4Sfj9M0yHD+WYIg/Bby4oyC5Q68bCkO5I+b
         lXKAgMFgqWc0FbcSzErQN8kWk6a2OLzO6BNHhv7AqpzsuFfsYduFtA+5TqKlKRVqZk3r
         0kpmhWxMVNkSuLRJ9koWskTQMPJozqu+01TKbsHrZj/DoIKAQsJrH0rgcYashy+sqXZ+
         lmq8BBDo8veAWmf9ZMtNxTsRTOQSovTXrJqVxf1gL6GUTqLV/UEFROSzaFvx5abwem8v
         7lTgAghagOzruYDqaKpfGcXilVYGXOXRgrQ7zDT1P8FaWwWXzMOKp1JN5unnnIpAq7PH
         EDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xdsSCNqRT6pmI8PDRatFSJJyOi2y+t4BEGL1p6JdYS8=;
        b=B40TBk6RdmwkJ1e08DJXWK+HElYiXD+pjuVRw/xJElXLIG1OV3jEe0xdKVOXxPPOkx
         FeCLYXl1a4yz3v6gZjn5Ld9UbIOkZEkCgEcUuqrQuKW4cvzAxGdZUKNa0UgjW0LKn7s2
         3abOiJXliOFk5P/7Vwn5m6m0YymiC7Se+ZlpfVur2t4tBG/g71nk/tEYJX/VT43gMfrS
         1wBz8TJw4tFRWvrWfJOyMCclDBVh6g5QhmpPz5WPT5nsIorimzuslNrY90tsx9I/CLQ+
         dHPwmjEERLLvsOtuN/s06FIZlwZfVEKTr7iTBqlkQOagsCAIQ0WfMbPnskVq+/aretwn
         E2XQ==
X-Gm-Message-State: AOAM531GcgKw2wNLPqRLC2zbHuobhNOeVFeCpL95Y3JTOeV4C/RvJxOc
        4ro7LShbe536aa/sxWtx0wjBAw==
X-Google-Smtp-Source: ABdhPJyUdQEWpf4FFRm6WDwnXFFSFPzK6zZFwUWld1lUJv6xNRPgEZvQKCPEep5fxzL1x6uYyvEylg==
X-Received: by 2002:a62:18d6:0:b029:1bf:1c5f:bfa4 with SMTP id 205-20020a6218d60000b02901bf1c5fbfa4mr20095420pfy.24.1612253169862;
        Tue, 02 Feb 2021 00:06:09 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id gb12sm1876180pjb.51.2021.02.02.00.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:06:08 -0800 (PST)
Date:   Tue, 2 Feb 2021 00:06:03 -0800
From:   Benson Leung <bleung@google.com>
To:     gregkh@linuxfoundation.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable Branch between platform/chrome and USB for
 v5.12 merge window
Message-ID: <YBkH6wO07sxRDBDo@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C9BBXJRw27joBAeF"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C9BBXJRw27joBAeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

The following changes since commit 29b01295a829fba7399ee84afff4e64660e49f04:

  usb: typec: Add typec_partner_set_pd_revision (2021-02-01 15:31:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-ib-usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12

for you to fetch changes up to 0371616d8bef6926e9aa05757f35b901268d3724:

  platform/chrome: cros_ec_typec: Set opmode to PD on SOP connected (2021-0=
2-01 23:49:54 -0800)

----------------------------------------------------------------
cros-ec-typec changes for usb for v5.12

Chrome OS EC Type-C driver features implemented this round:
* Registration of cable plug information
* Support for SOP' plug registration and altmodes
* Support for reporting number of altmodes supported by partners and plugs
* Send mux configuration ack to EC via a new host command
* Reporting SOP' and Partner PD revisions

----------------------------------------------------------------
Benson Leung (4):
      Merge remote-tracking branch 'origin/cros-ec-typec-for-5.12' into ib-=
usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12
      platform/chrome: cros_ec_typec: Report SOP' PD revision from status
      platform/chrome: cros_ec_typec: Set Partner PD revision from status
      platform/chrome: cros_ec_typec: Set opmode to PD on SOP connected

Prashant Malani (8):
      platform/chrome: cros_ec_typec: Make disc_done flag partner-only
      platform/chrome: cros_ec_typec: Factor out PD identity parsing
      platform/chrome: cros_ec_typec: Rename discovery struct
      platform/chrome: cros_ec_typec: Register cable
      platform/chrome: cros_ec_typec: Store cable plug type
      platform/chrome: cros_ec_typec: Set partner num_altmodes
      platform/chrome: cros_ec_typec: Register SOP' cable plug
      platform/chrome: cros_ec_typec: Register plug altmodes

Utkarsh Patel (2):
      platform/chrome: cros_ec_typec: Parameterize cros_typec_cmds_supporte=
d()
      platform/chrome: cros_ec_typec: Send mux configuration acknowledgment=
 to EC

 drivers/platform/chrome/cros_ec_typec.c        | 269 +++++++++++++++++++++=
----
 include/linux/platform_data/cros_ec_commands.h |  17 ++
 2 files changed, 243 insertions(+), 43 deletions(-)

Thanks so much!
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--C9BBXJRw27joBAeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBkH6wAKCRBzbaomhzOw
wj1lAQDnRgRncRPJhHWmERmpxnQFxE3azjZ9cWS8RO4t/WM3FwD/QCydiGm66QIw
jykhYBCWv3N9Qea6EuReeRWHOlrS0g8=
=s5kQ
-----END PGP SIGNATURE-----

--C9BBXJRw27joBAeF--
