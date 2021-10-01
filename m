Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711FE41E7D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352373AbhJAHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJAHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:01:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F0C06176A;
        Thu, 30 Sep 2021 23:59:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t16-20020a1c7710000000b003049690d882so10330539wmi.5;
        Thu, 30 Sep 2021 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XXpkelYmDSrAGY7mbAVw7dRb96ULGaDVqN48wQu0aew=;
        b=MWerl7wdgHZhbLwjp3JlRRyZ1qJLkainUkOqwf5orP1uqyueHebFnBB/5RbLneDQ3B
         ymeADXBKdCSy4Z4k/3m/+HRS4yuuFvlVjjjfupzcWujdnn5CJqasvMAc/ZmKi1Ngjrrs
         vgUWYiTnojt+qYXPRiyBpL8lzB0Kg0ldNOQTMv3wZBz08D4NUjQjs/zlBmPnx1zv8tIO
         5FUXdez/HbazbFzbwciDkFOac7epCZehyXINNlrlBx5kUzMZIZKXHN0sB0b746YYPtY7
         1k4eDmFnlPsNU18IqmyvXvOYGYAsAn9AeQo33fbtYSXPGB4kc5hnxDyWKeetrQBdHa6U
         vspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XXpkelYmDSrAGY7mbAVw7dRb96ULGaDVqN48wQu0aew=;
        b=A5g/ldccgPX/q9lm3IUQ6GuiUS1IPt9Mu1/gmFjzJTaGUISYM59cy0FhJcZRjgDxof
         OKl+njuwUvr73+Kgnj1EoacGGyobH6iIwrzYajXyPY6Gzkjyr7m2AoFB6QzrWUtcGn3X
         caILOoNrQJI7NXPskn6XO63LxE+vOAhB/y1gqTO0KFsjR9/9EMpm3maFHTNVby5gyKz9
         ZrGZzV3m6ueuFLUCCOo6YDajJTjFoPT0GaImMzKZH+e36DeI30JPC0AHw9XW0kTbLX5i
         05EqoMDy7i9JwPXfAmK95CHbPDnx/Bc2yPR3Y2gNXRoJmisyFmO4VERgTSO6nMlyexaJ
         LIww==
X-Gm-Message-State: AOAM531XvwpHDLtmw6HgbKkOIPiy6566FAkuILR8nxOPTDBUMcVCQgXQ
        dLJ7shEj3b5gVdDQYUZK4jDdM91lrYo=
X-Google-Smtp-Source: ABdhPJwd2UewZhtx+W5ZTASOdpYIp0DScsW56puJbvY2t9IPnBiVRqU+2sBwdgkFrQsjT1FzoPRENw==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr2668774wmh.171.1633071595328;
        Thu, 30 Sep 2021 23:59:55 -0700 (PDT)
Received: from localhost.localdomain (eth-east-parth2-46-193-64-114.wb.wifirst.net. [46.193.64.114])
        by smtp.gmail.com with ESMTPSA id 15sm6782000wmk.48.2021.09.30.23.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:59:54 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH v3 0/2] USB: serial: use wrappers for usb_control_msg()
Date:   Fri,  1 Oct 2021 08:57:18 +0200
Message-Id: <20211001065720.21330-1-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many usages of usb_control_msg() that can instead use the new
wrapper functions usb_contro_msg_send() & usb_control_msg_recv() for
better error checks on short reads. The wrappers also handle the
allocation of dma buffers and callers don't need to manage them
explicitly.

This is a follow up on v2 with 6 patches. 4 of them are already applied
so v3 only includes the two remaining patches. The patches are
compile-tested only.

Changes in v3:
 - Rephrase commit messages
 - Add notes on omitting the logs for short read sizes

Changes in v2:
 - Drop unnecessary use of wrappers
 - Drop unrelated style changes

Himadri Pandya (2):
  USB: serial: ch314: use usb_control_msg_recv() and
    usb_control_msg_send()
  USB: serial: cp210x: use usb_control_msg_recv() and
    usb_control_msg_send()

 drivers/usb/serial/ch341.c  |  90 ++++++++----------------------
 drivers/usb/serial/cp210x.c | 106 ++++++++++--------------------------
 2 files changed, 54 insertions(+), 142 deletions(-)

-- 
2.17.1

