Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1FC32A532
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383833AbhCBMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349995AbhCBLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:45:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85BC06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 03:44:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v13so8327699edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 03:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUKuTJ1LDEzVO3XBC3k62B0BGBJI0QRnQDrxQFi6j1A=;
        b=fun8reQZEh6C+pMkSUWS75G0gTGU/orNT/mF4KmgY8W/sw6+nTaMq6jn/LyKbh4g6f
         HUE7VP3xN9V163qzooj6JY33uqVluF1ut5tEr61vs+PXAuvgiReRsDwkkKED/JC38O5K
         Jbd2EC8CWdWyK1ifZGHn07FMmyB4lnNZQLenK3TQBK9u96WHqPKqt+XSOfpVTsC9p1SH
         O0qqn69Xw0cUy5xsak8X/aksGjvbE07aoq06VEwoO2VSH/1sId/K+O4cZ1OYwJSBcHWf
         q69FmAmbwQhiwhro6MY5RPbtxDzw/9Qi9PG1svFs53F4CcTPV69hCKS4jp21DjM8ioeS
         gzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUKuTJ1LDEzVO3XBC3k62B0BGBJI0QRnQDrxQFi6j1A=;
        b=U0FbOfyWdV7vT2lNy/+1ifaynvxfdrZwsTY6/0VRvkKiF/miSB1sPQvZ4WTJdfLK61
         wLekPjoXtznIAwtUsMYaPAqPIZKLE5TLu3DXJ1l+KXVNSYF4ufYAYxEDAllEhQgw27Zi
         ryU9vp1mqa25BGUpwxQvz5kIvCiogIZeqmpyFIlT2NeZaUGSMzL0Lom6qfcGS1B3VZHt
         gWKuUItfZ+1FXO3qGRn1KN0LL+wIedJKQKhJK2ksTk08aMChBya6eyzOt+GNT199EiUA
         WV/8w8EQpDXB89yGeNqf7Cy0vnrhnFfN3t+9Q9XnhcgMPgHxy9/UQDYFi+/eRYhmlv9B
         AcAw==
X-Gm-Message-State: AOAM532qYzaXhq0xOqZo4s055PlAhvdQ4yiiGrAIlPtpRkj1DAH7K45w
        DXVYwAOQGugVDgElg4g42v282i919Vmb1eSe
X-Google-Smtp-Source: ABdhPJw+fo40jeKi+qv6b80N0rf+a2IVpwRJfPE1Z5vpM8bg0CT+NppoS8QsgCzy0Wcaopls37c1LA==
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr11471416edc.94.1614685474801;
        Tue, 02 Mar 2021 03:44:34 -0800 (PST)
Received: from localhost.localdomain (hst-208-217.medicom.bg. [84.238.208.217])
        by smtp.gmail.com with ESMTPSA id x17sm18494897edq.42.2021.03.02.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 03:44:34 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/2] Add decoder conceal color ctrl
Date:   Tue,  2 Mar 2021 13:44:28 +0200
Message-Id: <20210302114430.3594475-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The changes in v2 includes:
 * reformat the table in documetation to define Bits for different
   bit-depths of color formats.

regards,
Stan

Stanimir Varbanov (2):
  v4l2-ctrl: Add decoder conceal color control
  venus: vdec: Add support for conceal control

 .../media/v4l/ext-ctrls-codec.rst             | 33 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 18 ++++++++--
 .../media/platform/qcom/venus/hfi_helper.h    | 10 ++++++
 drivers/media/platform/qcom/venus/vdec.c      | 11 ++++++-
 .../media/platform/qcom/venus/vdec_ctrls.c    |  7 ++++
 drivers/media/v4l2-core/v4l2-ctrls.c          |  9 +++++
 include/uapi/linux/v4l2-controls.h            |  1 +
 8 files changed, 87 insertions(+), 3 deletions(-)

-- 
2.25.1

