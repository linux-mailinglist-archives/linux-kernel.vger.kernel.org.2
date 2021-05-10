Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B69377F29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhEJJOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:14:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DED2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:13:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l14so15791085wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ca1hFTYQqONxjpjSelmNqH8WT2mDhiZTvqWqe+QIj8k=;
        b=FaCsxFSSWlHe8SXp9oxbF6c+80zFYppwPlY7t8w3mo2V+w1doErKIBYW+QSssWIEyd
         CwWskEtC07nDle7UKodp2GD0iVNqslRhrOm2A+GEfFIlaxnIcMJgUpRp6fj1lg2+6xNK
         HmgTn8Wtba/gnfvX4+vlSovoPWEuD8fhRZpQpbJeoRvZ3pPw0z4sWXkrQftni6ec5flX
         UgQd8svUZ41DWDXmG0uWDfnGzlBdwApG2+EQny+zfTfgVbPGcGaHlwUxP37KBJ7Z861H
         +DdIlKkSMFZ5IKRdyj44PIh4u/muCv7+rw2tCAchjlzUPIHvdNZFd9TU5MNatJ9GawPp
         j4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ca1hFTYQqONxjpjSelmNqH8WT2mDhiZTvqWqe+QIj8k=;
        b=lf8GEw4Hp/DMHsU0llHj4V6eTDfYU2lf/HqPwfPBbdqZ5TWwA93jZnftOpv3KWzF7H
         nDI99NCgd+z74BjdLQqp8Doq6Y3EaxgydSkAaoVi7Lo9N6jmQr9FYKT87K8uxoi8l9u7
         1QW/0GlhUsKkmos3nEzlN86btPCQK9Zc+LfG1uuY0XI+LNHFJ33vE0U/fuMsdcVS9pre
         gcgCmsByuXuiP5XiWT8yTwc7VvDyMGic91UYVA8Oy71RMsbDVekNnU+uF4n2Hvfsku5P
         rd1Spz5cHV6sftiHFD8f6LaO4OcHAHVuhs/nadXg/ynDOfO51Zm/v01Vr7opQHf7qk5P
         yrbA==
X-Gm-Message-State: AOAM531wXRZZ7f0TUA11Tc5syQLvZjowB1mtPyO5Ntpyicog8zI7DMUi
        NXrC/7Lxm+Dn3+q2itdxxSUtajmnuXFfL2Uy
X-Google-Smtp-Source: ABdhPJyxE+YaeeKknh+YwcJKukDjSKCysy5C/GfuRTuc6XEZcKF/7fAeDY/j3+0C4f7ngDG0uk7b/Q==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr29112647wrq.59.1620637989398;
        Mon, 10 May 2021 02:13:09 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id s5sm19040575wmh.37.2021.05.10.02.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 02:13:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] mfd: wcd934x: add mbhc interrupts
Date:   Mon, 10 May 2021 10:12:37 +0100
Message-Id: <20210510091239.2442-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds interrupts required to enable MBHC (Mulit Button
Headset Control) support for Jack and headset button detection
in WCD938x Codec.

Codec side patches are sent in a separate patch set.

Tested it on Lenovo Yoga C630.

--srini

Srinivas Kandagatla (2):
  mfd: wcd934x: add macro for adding new interrupts
  mfd: wcd934x: add additional interrupts required for MBHC support

 drivers/mfd/wcd934x.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

-- 
2.21.0

