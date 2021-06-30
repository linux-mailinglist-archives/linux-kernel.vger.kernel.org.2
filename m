Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1BD3B817A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhF3LyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhF3LyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:54:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C30C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 04:51:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so240770wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version:reference
         :content-transfer-encoding;
        bh=PWiS/nPxKILQeyhMNnQeDFga8xP52KuTaX23DjbkS40=;
        b=rtOSqTg/gliRa6eeS+iCIdqbrHWN9CRvDf8Fv0ECc1gbIGtasHypKIX2ixR8nbPuH2
         6RBBCZqWpErhDTU7bjCLfeJyyn1wW1MmguLHACn41LDuFQihObB3vkbV5Nw9Qy/Dc21q
         Pujq5l6Xc1Pr1HMYuj80wp8Mpy2BT0aV0kcS0NMx3I+Lx2rvglT8MfC4r79bWKVY1kHD
         dE/FOUvwi9y94IX63RrniEOVQZF6x4Aa1/6ZyIHyCdP4Y/ViskqBy3lxtpM/dAyQMg16
         79CdTS3TmLUyNivhpovLLPAhueFBSUHelgXN5ZhVXPRS+F3GC6Jq6+z+57wDqWyctA7a
         dUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :reference:content-transfer-encoding;
        bh=PWiS/nPxKILQeyhMNnQeDFga8xP52KuTaX23DjbkS40=;
        b=q1uHZTFmXdbCJ4sfdAAMKVY+7e1TBW6/LLxeEtpsJoJlNtt1sfEBiXhyg9TTCqhSN/
         shX+P7CyEDTOAsJBfUXMCEWaE/ZiQUEm15ShpHnQoAY7bFC2JSRRRUZVjk9cky7aPvSE
         yt+2RwypIwYtZGa/VUTvU6zZkZab0vzV/V14dZASarSrQn5g7fF2He8Qa9AxlI8+WZQR
         rlonu1eR/ZDmSyPs31gNactjwDSRv2j7FuYNVzpaSg2rOxAZGLXEYMuKYDuJZDtYOVq3
         CW/oo+MOvMNH3ToCcEECvWtG/r1WcLi8i0W7ene68B3dgJUcIC2bl7yaVaGRGCxTlwfS
         glqA==
X-Gm-Message-State: AOAM531bXuov7sXbaIOs6Qj6OzGo6KJqhgYuGEgWuMCauKZiNMihMUu1
        bQnlECA7smtWI3P5Px02AfZNyyLFXqstcA==
X-Google-Smtp-Source: ABdhPJyt4mv6IR8fQYDF486F6uLzJgoxwOX9kbPQejew+U1g/S/B1fzJ2urkp+iN4Z2nZ21oTYreig==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr4198654wmf.110.1625053903299;
        Wed, 30 Jun 2021 04:51:43 -0700 (PDT)
Received: from localhost.localdomain (91-167-148-192.subs.proxad.net. [91.167.148.192])
        by smtp.gmail.com with ESMTPSA id o2sm22107777wrp.53.2021.06.30.04.51.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 04:51:42 -0700 (PDT)
From:   Greg Depoire--Ferrer <greg.depoire@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: No way to set FS independent mount flags for rootfs
Date:   Wed, 30 Jun 2021 13:51:27 +0200
Message-Id: <20210630115128.3878-1-greg.depoire@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Reference: https://lore.kernel.org/lkml/200308121855.h7CIt6St002437@turing-police.cc.vt.edu
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This old thread[1] describes the issue:
* The kernel already supports setting filesystem dependent mount data using
  rootflags=... but it doesn't support setting the filesystem independent mount
  flags (the fourth parameter in mount(2)).
* Fortunately, most initrds have custom parsing for rootflags= and understand
  additional flags: for instance they convert noatime into MS_NOATIME.
* But even then there is the issue of flags that can't be reset later by initrd
  like MS_NODEV or MS_NOSUID (not sure if this changed since then).

It seems like it would make sense for the kernel to add a command line parameter
for this because for those that don't use an initrd, it seems arbitrary that the
kernel already supports setting one type of flags (the fifth parameter in
mount(2)) for rootfs but not the other.

In reply to this message, there is a patch that implements what was suggested
in that thread: adding a 'rootopts=' parameter that takes a bitmap value for
the mount flags. The name is not ideal: it would make more sense for it to be
named rootflags= and the actual rootflags= to be named rootdata= according to
mount(2). It works for me but I don't know if this is the right solution.

[1]: https://lkml.org/lkml/2003/8/12/203

