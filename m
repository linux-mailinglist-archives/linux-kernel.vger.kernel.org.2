Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C152403CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349610AbhIHPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhIHPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:40:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BE8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:38:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q22so2429891pfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Vpz6e1WKU4LXjJF3lrKdyF1rW9gJRdJOps3VOqWFWPo=;
        b=cO7bBaqCS2jEOH8ZwBxPPJb+JlhG5jVUOhovJMNdmfKP/xHPnUxSrwzAcZ8RXAbgkn
         yOTpS8mr+s2oINCKVdvjY2Khep3vu5a17ZMYT5BNnCWvEBEGOTtViHUbfsfiE34jlqLF
         ofKFeFh1/+J3/x6AMGcd+6ilV67X5XIIIBFSnXBP2XGGdIng2wymRH5LXrv6V6DaS0vW
         MQSMTZ/FzCLzq+W2SWV90uZSZftBGw56dJI5LZbkpBcxiCrBq4ha2dqDw15/14MQmazf
         Yye9iK8sVMfttBOocEzyM6eYzrGbyCz8NBv7+EGUJgpfR2naJ5STtLQWMVKW9IsQPGVG
         cQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Vpz6e1WKU4LXjJF3lrKdyF1rW9gJRdJOps3VOqWFWPo=;
        b=W0glj2DivYljlzxBWyW6ni4J8fz/NnggJykyRzXEK19pO1EkoRKrMQ3mlvVMxtE28C
         6Gfevocp02920mFMD1ipgjJQ5c+BnBFPp4gE5SbJe9X9cu1GMyyBxab8sFABn2nK4sSr
         c1CZzyvYyTg9flS1NEsPwBIfEnL7/GkM1wfpbHta9fgWA9bM+hd8bvF8Jk9FXRdg+cJN
         lVlJn5tZFNrDgZO1tZvq1N+bDoE0z4cqVzJ168i3/Ule6QMJn9q9/+blbnL7nYviMQbZ
         aNf+s/mNBlm71IHx0FAS3TMkEgijKijfjKln0hSntQTZE3Lscp9bIWKr+I8ehIbcDjn3
         sbLg==
X-Gm-Message-State: AOAM530ecYV2xiiI0+PRl0xrVrPvQ0BbhvwO5E9WD8ohSs/lByy71wcR
        jC0UmNKHxcTTfCIuDlo5QOD2wA==
X-Google-Smtp-Source: ABdhPJwX86tpsplQR7pXVfsBKG049IMANvQez/QKiZ+Q6psk+L7vlX9P4Syj5R7XoaZIYSdLVEKnYg==
X-Received: by 2002:a05:6a00:21c7:b0:412:bb0b:850d with SMTP id t7-20020a056a0021c700b00412bb0b850dmr4373665pfj.33.1631115536629;
        Wed, 08 Sep 2021 08:38:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8525:5337:1a6c:f8af])
        by smtp.gmail.com with ESMTPSA id v8sm2572343pjh.24.2021.09.08.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:38:55 -0700 (PDT)
Date:   Wed, 8 Sep 2021 08:38:49 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@google.com, bleung@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.15
Message-ID: <YTjZCfR7SfEMDYAP@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E7/Ts4XUbIIfzOqv"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E7/Ts4XUbIIfzOqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.15

for you to fetch changes up to 4665584888ad2175831c972c004115741ec799e9:

  platform/chrome: cros_ec_trace: Fix format warnings (2021-08-30 17:46:55 =
-0700)

----------------------------------------------------------------
chrome platform changes for 5.15

cros_ec_typec:
* Changes the cros_ec_typec driver to use the pre-existing
  cros_ec_check_features() function

sensorhub:
* Add trace events for sample

misc:
* cros_ec_proto - send commands again in the event of a timeout (for the FP=
MCU)
* Fix warnings in cros_ec_trace related to format output

----------------------------------------------------------------
Gwendal Grignou (2):
      platform/chrome: sensorhub: Add trace events for sample
      platform/chrome: cros_ec_trace: Fix format warnings

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Send command again when timeout occurs

Prashant Malani (1):
      platform/chrome: cros_ec_typec: Use existing feature check

 drivers/platform/chrome/Makefile                 |  2 +-
 drivers/platform/chrome/cros_ec_proto.c          |  9 +++
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 14 ++++
 drivers/platform/chrome/cros_ec_trace.h          | 94 ++++++++++++++++++++=
++++
 drivers/platform/chrome/cros_ec_typec.c          | 27 ++-----
 5 files changed, 123 insertions(+), 23 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--E7/Ts4XUbIIfzOqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYTjZCQAKCRBzbaomhzOw
wtd5AP9LVfrG0py6yd7T1jYZW+h48vdrBajaNBUNHWnVaOhDJQD/bCl15VzgKBus
8QuHM5t1z4L6BN+Ho7rYbI6QrPo8aQw=
=GFvY
-----END PGP SIGNATURE-----

--E7/Ts4XUbIIfzOqv--
