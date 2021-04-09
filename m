Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E5359288
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhDIDJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhDIDJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:09:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20FCC061761;
        Thu,  8 Apr 2021 20:08:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g24so3198947qts.6;
        Thu, 08 Apr 2021 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/n1jA6zNk8gdIHeJ8nhU86J4mDdpXxzEPJOuy1wUlc=;
        b=rIsKw1ENtPcbL48DVJyo1CKR3QYexYc86FcP9z/gwi17SPgFSCV5TTuaJgcu95xmpw
         y142O6FALBZ668vboFKhWyCDrOy6Y2NH/iJiO+NkQQgXF+H58iFg9Zq3rZPsviOJJO7d
         biXE1GeLDU3uE42hu7hZgjSjws2LDCjTEHG+Ce2hp99/2SLyGrqcAO9y7c1ciKaevr+2
         KJojJbl0/MwOQ/uBSF3C/q4MTwN0Fr8D2biRagyebRAnQKTHSNJ+f6adfSRRnM8jB5Kd
         FWhsD6ieDmIdzMW32rWf1qH3mofNw5apeX1utoLmpWkxI6rhZeik0HkdaA+Blbmfe4Kj
         vT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/n1jA6zNk8gdIHeJ8nhU86J4mDdpXxzEPJOuy1wUlc=;
        b=AMD4B1/Anw8EtUibPQD1BgcsIIW6VHjWOeD/1/z4G6hLMjke92vsdMhgWPC3IE17EA
         XjwxbX5izjWzqIbRYG92s5E0xsBS0D2HLtajuv6uW4afQXiAijo0OJ25nqbl8ASYCJRY
         5q/E5v1cXNjtcXPkhV4+EQHxyLDW6EBdH/G9DH/OtPHzfyNYKsamWuTnk80iu5L0zCkF
         HZWcfBIMNSHk6rh8pStjXevLDCcteSDvAOTA/Ex/dRYfKwnHeRADnvIKhSyAZxtjjW0A
         ni3JOwYHNlZj+kN9e5C5o9zQqWZJOQOF5GBwMD/w9Y/+ZpeubKYO59vglI4LrjUScCcY
         Q5Og==
X-Gm-Message-State: AOAM53385RbLspK2LHGWb3Tc2BDpOfOoTCljTMBO3Too1AsEehqOTKm4
        VFHxBQ7PkfvbB5GSKZ2/78k=
X-Google-Smtp-Source: ABdhPJyOsfwZR81EdqwdmG0xK2VoE3k6LfDNZvv7zK6ldo23Xm6y3wsxY+4jEgmnwt4pEhtbcJoo7Q==
X-Received: by 2002:a05:622a:14c:: with SMTP id v12mr10598144qtw.46.1617937737024;
        Thu, 08 Apr 2021 20:08:57 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5c21:af45:3b27:576c:7dde:37f1])
        by smtp.gmail.com with ESMTPSA id c5sm925408qkl.21.2021.04.08.20.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:08:56 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v5 0/9] w1: ds2438: adding support for calibration of current measurements
Date:   Fri,  9 Apr 2021 00:09:36 -0300
Message-Id: <20210409030942.441830-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches aim to make a user able to calibrate the current
measurement of the DS2438. This chip uses a offset register in page1, which
is added to the current register to give the user the current measurement.
If this value is wrong, the user will get an offset current value, even if
the current is zero, for instance. This patch gives support for reading the
page1 registers (including the offset register) and for writing to the
offset register. The DS2438 datasheet shows a calibration routine, and with
this patch, the user can do this quickly by writing the correct value to
the offset register. This patch was tested on real hardware using a power
supply and an electronic load.
Please help to review this series of patches.

Best regards!
Sampaio
---
Changes in v5:
- Merged all brackets coding style issue in one patch
- Changing from BIN_ATTR to BIN_ATTR_RW in w1_ds2438.c
- Wrapping email lines
- Addind Documentation/ABI/

Changes in v4:
- Fixing different patches with identical subject lines as requested

Changes in v3:
- I accidentally added a wrong line that would not compile. I'm sorry. Fixed it.

Changes in v2:
- Using git send-email to send the patches
- Adding documentation as requested
- Separating the coding style changes in different patches as requested

Luiz Sampaio (9):
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixed a coding style issue
  w1: ds2438: fixing bug that would always get page0
  w1: ds2438: adding support for reading page1
  w1: ds2438: support for writing to offset register

 Documentation/w1/slaves/w1_ds2438.rst |  19 +++-
 drivers/w1/slaves/w1_ds2438.c         | 122 ++++++++++++++++++++++----
 2 files changed, 124 insertions(+), 17 deletions(-)

-- 
2.30.1

