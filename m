Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC8130FCAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbhBDT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhBDTZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:25:47 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E64C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:25:07 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q131so2718926pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1GnUxKkhjneeSJIWMbBvJAykBt2ypw4KIhXpEtHr2Dc=;
        b=Lk/Q2iuq3Jh5IppKh8zwBDaY4bEDz6ah3/EhNzMsSF3MksmjH8TlJXXoYrvn4tikO7
         pmupq+B/Ud0M67vwtJzL+80Q2c3Lj3YJ0OEWbl8lu2UT7k+Rjr7z9M5FXGJS+4R/+of/
         tgukUPOQeqi4C1vQuMOnc+NMezJjUkQxhuqx3bah1lAli4csfEJVVveFPJ2lQsoD0qWt
         XWwtje0yl1zFGzhIpko1YOpkbDgl2Xa3CKkUY1udzNyYVU11MtxCz5phQ/2rr0mHX7DV
         gunD4IbzXnmfL6ZoaXeB1nHseYh6TkYHmTaV95cFrTtS45PtzJtGhlUWrpsbewZ0eSkO
         MAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1GnUxKkhjneeSJIWMbBvJAykBt2ypw4KIhXpEtHr2Dc=;
        b=lRyUxow97ESoCCYUEu7Nz7Addfy2kTyZcT9POCn8NXO3brF+V3jJR9pCNX0YAoIx5X
         vlaUFK8Um5OG5DZysrbECputUVB8/S7tlRRdQSFPYDUGucrZN8U6z+qghs3IJ6X7XMSO
         +cQp7niqF382YFVJsxFciY5kXr6QK6qg7b8T3CS2RqIXgb7lwlYQcFw0qYKtG+OdqmyX
         1+GZh2oWbw6L5nEeHplh2RLgY2XfIILaSBzzrbONABvYTN6j3s7wRRzTX8E2LMLmmT9T
         yyZAXdyg1ot3qqyjWNHvzpCD0Qnrpow7RdX3WbbwenGtOUdYa95mpxGeZ3d/LO0dLsLH
         dCjQ==
X-Gm-Message-State: AOAM532KF3KnZLDbiCa9bBy2w6NowasgdIOOYz33pgK33QxoL3peQIf2
        7um92y4nRPHtuavE532GhssU/A==
X-Google-Smtp-Source: ABdhPJwFCK+6EOqwTuOitk8H1KkcvY1XU7Yz3d19djjGaNOBZuDGqeEWyl5kUXfKTDYcPpuaaWeRaw==
X-Received: by 2002:a63:5309:: with SMTP id h9mr495555pgb.19.1612466706158;
        Thu, 04 Feb 2021 11:25:06 -0800 (PST)
Received: from google.com ([2620:15c:202:201:5cde:5545:a9de:114f])
        by smtp.gmail.com with ESMTPSA id i25sm7225284pgb.33.2021.02.04.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:25:04 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:24:59 -0800
From:   Benson Leung <bleung@google.com>
To:     gregkh@linuxfoundation.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Fix for cros_ec_typec for USB for v5.12 merge window
Message-ID: <YBxKC0IeWBJ/X/wJ@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9eWf2OmYOPdG8cOw"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9eWf2OmYOPdG8cOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I found a bug in the typec driver you pulled earlier this week
and Prashant developed a fix.

The following changes since commit 64eaa0fa66ac55965f793a8b65730299854e55cd:

  platform/chrome: cros_ec_typec: Fix call to typec_partner_set_pd_revision=
 (2021-02-02 19:42:52 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-ib-usb-typec-chrome-platform-cros-ec-typec-clear-pd-discovery-event=
s-for-5.12

for you to fetch changes up to c8ec21c6d25c2a8895614ea38575dadb8570c2f9:

  platform/chrome: cros_ec_typec: Clear Type C disc events (2021-02-04 10:2=
9:30 -0800)

----------------------------------------------------------------
clear-pd-discovery-events

This pair of patches fixes an issue where cros_ec_typec creates stale
cable nodes on detach because of uncleared pd discovery status events.

----------------------------------------------------------------
Prashant Malani (2):
      platform/chrome: cros_ec: Import Type C control command
      platform/chrome: cros_ec_typec: Clear Type C disc events

 drivers/platform/chrome/cros_ec_typec.c        | 29 ++++++++++++++++++++++=
+---
 include/linux/platform_data/cros_ec_commands.h | 26 +++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--9eWf2OmYOPdG8cOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBxKCwAKCRBzbaomhzOw
whVGAQCdvLlEyv/Y8YyQlK/Sgp6pLt+0BOWs8+hLyctYyAnZaQD+NgGhIF2+yWaf
eUvEXs6S0R34UVl1CFgJ1ToVoI9J2go=
=vQlY
-----END PGP SIGNATURE-----

--9eWf2OmYOPdG8cOw--
