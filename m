Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2306A319980
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 06:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhBLFU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 00:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLFU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 00:20:56 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 21:20:15 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a17so10198433ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 21:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gogFQozvbBeLcEC89/kgzG7875Ff5Yr9iitoytQmZ4w=;
        b=Y+3Xmfuh7u2ZV+k2O6sFQemUV3Ar4730t1vtQ4hcAGDUYjdYp7NrxjyUi/TDfEqOO6
         pNQmAOKJUxoLDeUjPc6kl2AMtemA6CjjomDQFvUmYSCAcs/hp4XKkeN0GX1/0gpord0n
         qvKE9qAMHEZhFT51gLGIVASLcusixfCBeD+fOAOXH9t5v4rNCXifC+NSyUZqa0nxKXTt
         VPAcEJeuV6+OnsKb1kyYIIEjMoLdkcD9/uqwYFQ5hdySZ4k64RrV6i2eUYjXbYUGkVmF
         NCnbyIqafPX8/WgfXEgIC8J7/Bhd+dqWtvE09ofLUoWtg/RHUL2DkkT4iugxSnsNgo1O
         od0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gogFQozvbBeLcEC89/kgzG7875Ff5Yr9iitoytQmZ4w=;
        b=VsyFbzewDP059CUnQwK8jz5CylnQyxM5mMIdPHhIf3cnp3RNaujy4eAcONX7jYlcU3
         yPzmjAN76KDffPretdcAW0PPFHM27hb+A3LFFS5mic2gyf2Qq/Xn1IwfAZeVtVkfOhtY
         hPsdU216DNNNhtC9h3Ik0J8qMdcSeaBCBJ0MDRyxgNUsGElgdl964rb/mN2MoR3wvNoU
         TAijqjUEtb7gFjfhhH4FWXc30DdhHArNbWTKZ8Px+4w9dFefhKVG1W/JNGEBejJ8ZaEp
         c/S/4la6Yo0DD0dgDGeFcio0HZCZ/mN8DEmHTqujFr/qOVjh/c35WKVAlJJFuDz4JV3T
         G5Kg==
X-Gm-Message-State: AOAM530clIDhSL7kbnF3lBsOnP+MWNptVmrnQgK/ScmCsAms5tt0ant1
        0OOIzAA78E5+H7EfVeU4JJSHaXv7eft55v3eNtY=
X-Google-Smtp-Source: ABdhPJxEaIWSMlHCLTs77E1r6b86PR7NKhr24F5HVEFJzIyTN8CBkcqE8reCZNh3RoALVpIYBnIHv0rj7ReRED1WvZU=
X-Received: by 2002:a2e:145d:: with SMTP id 29mr691341lju.391.1613107214438;
 Thu, 11 Feb 2021 21:20:14 -0800 (PST)
MIME-Version: 1.0
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Fri, 12 Feb 2021 14:19:37 +0900
Message-ID: <CAGTfZH1o6zdN_42KJkVcA++QpSyY4_tMMFJSQFmWhKv7PWrghA@mail.gmail.com>
Subject: [GIT PULL v2] extcon next for v5.12
To:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, chanwoo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.12. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Changes from v1:
- Add missing committer information

Best Regards,
Chanwoo Choi


The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
tags/extcon-next-for-5.12-v2

for you to fetch changes up to bd30a35764e136dc372e74c4856de633cb7ed8de:

  extcon: sm5502: Detect OTG when USB_ID is connected to ground
(2021-02-10 08:15:28 +0900)

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      extcon: Add stubs for extcon_register_notifier_all() functions

Nikita Travkin (1):
      extcon: sm5502: Detect OTG when USB_ID is connected to ground

Timon Baetz (1):
      extcon: max8997: Add CHGINS and CHGRM interrupt handling
