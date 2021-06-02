Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11012398F40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhFBPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhFBPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:52:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358AEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:50:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b11so3521239edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XXLS9quJYSdKdIiMeGsFhQHlWdWbcTpTzZCWli1GVXM=;
        b=qvKCqx6xmfjpDnl5BXsndwLvICSuLhjm9l4tJAabpzvUDs3NgyG8MGtagtyxLJk5pG
         td0+9hdt4XWLlGcWDoTqRb8gCbxEsgfruwLg0oJ74V3wduQEyN2oI18fG1+bs3loy/UC
         loRKiClSz4Qao8SvXGdlltWIrEzurjxAQsDz15yzy9ievW++Eyb+0gpUz/Muy9NKQjbq
         jWA+umaBSkPsNT5V64+5mOj+otrrJ6bUpLvBYrAJHHbCtuNKCer7qmFs3IavSHlQaz4n
         JSUhPhmYC1Xc616MxOFygpGBGR6MRzuJB78AP68gIdOyGPAwKVSL39/Mb4BDWjR85MWZ
         Tk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=XXLS9quJYSdKdIiMeGsFhQHlWdWbcTpTzZCWli1GVXM=;
        b=CW1Yswd5Oib2+xIMTu4hAajyGhccQK0FhFdnk7YI8Ad8M6MYvRK8IhfyFPjyRMBpxN
         2yY2JmSd1P65Uulvy7MFNCFNrxsn8yMnPBKKLP/p1PPY6a/g7ImsBVHfvTGXRi/OKmAa
         EwcfH7iFv3a8IJvJFqsaKSsuNA/nSNUuPy/QSYd+SGjIQFfY9EGIEm2N00I2nLf7igHm
         kCUyeTLZJrDpZ1pP/zT3zC92CSyP8WZjnPHHRuFSzRd5TDf3J80at8wdc0H9pI2yk8oe
         IpZotIh5wndogkwtT0Q3aE44m9ws2Ylp46zoWbyicAOESaV1c9HFIMfZ5ZtHP+zDn+yn
         Ajzw==
X-Gm-Message-State: AOAM532S+PTKoUyNeZonUZvSMBK0K5Nj38ijW/hPdmp48Et3byznIgri
        ksbYHTarCLuzrwp5pEwkGps=
X-Google-Smtp-Source: ABdhPJw0DBHL4d0wBxUTxzrFIupOQwoBkAq1zvc5ZTjeDFMndBEaqmMhz84uxPgnvu0QytfYD4x9aw==
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr33124348edo.228.1622649017883;
        Wed, 02 Jun 2021 08:50:17 -0700 (PDT)
Received: from gmail.com (563BAF3B.dsl.pool.telekom.hu. [86.59.175.59])
        by smtp.gmail.com with ESMTPSA id dy19sm172225edb.68.2021.06.02.08.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:50:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 2 Jun 2021 17:50:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org
Subject: kbuild: Ctrl-C of parallel kernel build sometimes corrupts .o.cmd
 files permanently
Message-ID: <YLeot94yAaM4xbMY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There's a sporadic kbuild bug that's been happening for years, maybe you 
guys can think of where it comes from.

Sometimes when I Ctrl-C a kernel build job, the .o.cmd file becomes 
corrupted and this breaks the build:


   kernel/.panic.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.

   ...

   drivers/gpu/drm/.drm_blend.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.

The file was just partially created and didn't get cleaned up:

  kepler:~/tip> ls -l drivers/gpu/drm/.drm_blend.o.cmd.corrupted drivers/gpu/drm/.drm_blend.o.cmd.good
  -rw-rw-r-- 1 mingo mingo 28672 Jun  2 17:46 drivers/gpu/drm/.drm_blend.o.cmd.corrupted
  -rw-rw-r-- 1 mingo mingo 51331 Jun  2 17:46 drivers/gpu/drm/.drm_blend.o.cmd.good

The file just got cut in half due to the Ctrl-C:

 --- drivers/gpu/drm/.drm_blend.o.cmd.corrupted  2021-06-02 17:46:16.951428326 +0200
 +++ drivers/gpu/drm/.drm_blend.o.cmd.good       2021-06-02 17:46:34.391111668 +0200
 @@ -646,4 +646,578 @@ deps_drivers/gpu/drm/drm_blend.o := \
      $(wildcard include/config/OF_OVERLAY) \
    include/linux/kobject.h \
      $(wildcard include/config/UEVENT_HELPER) \
 -    $(wildcard include
 \ No newline at end of file
 +    $(wildcard include/config/DEBUG_KOBJECT_RELEASE) \
 +  include/linux/sysfs.h \
 +  include/linux/kernfs.h \
 +    $(wildcard include/config/KERNFS) \


... but once in this state it can only be fixed by 'make clean' (which 
loses all build progress), or by removing the stale file manually.

It happens more frequently on systems with a lot of CPUs.

Thanks,

	Ingo
