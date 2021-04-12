Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9035C528
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhDLLbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbhDLLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:31:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:30:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p67so4066179pfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2H1dHzjG9++vpaR1h3ZcbIOSqQZ6IZBP72GvimFc41o=;
        b=dnUs6jq4EB0TdLddiy+IhoZ6JBO78wplsi4VOhYMkFaGm0n4VYQs62fgk7KGugdEH0
         X4b7C6Uj25pWDKEum2GAi2cAiKoTF6Vgyh+TcyVrqsphGRJqkpidgw6td1veyl1XBUnf
         +pdaCvdaiJpbkqJhMqvLnF+bSsDTLwGre7ABc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2H1dHzjG9++vpaR1h3ZcbIOSqQZ6IZBP72GvimFc41o=;
        b=bqP3VPsNtfF0/yVjAL/yTyDDDV1T9MuFqEWZGrzTP3sr8Gy9AVpueFToDHAWYfZ6uz
         zJFdTbQr/j2GexNyIRCX0ztJjnYOJvTmASbyEJShB8dwraS4xREMa5JKrJqrCyfTKRTC
         tYgepaWjhWjvnElWiG3JLLEcbg6tqI7mTAyfkaFZZcRA5O55yZ3fgG3HPxlijd98PJhp
         gRrIoi4F/6UWcAkOnRKwFmeGnJUL5//OjxnW2AiQos05QaP6r0P895VtpaUy+ghQSNPv
         xNxejR46z/6gEr4QIzLWLtj/8vNQaVVw5NroThSr5qca4UOG34XxUwCceMLpzCZv6Mij
         Y3eA==
X-Gm-Message-State: AOAM530GDrl5j8KSG/k+m7r9WomVpST63GXzVU33fWXZTsc+vA/9T92f
        lVmCLR8Kfx38oPLPl9W45taCeLZHtoTO/Q==
X-Google-Smtp-Source: ABdhPJzFAkyENqxUzj6WRmREwNhQtf3d9RvbOOy5M8VuJMIxbnLdwPmnh3nofAVb40RXoZYhdrBt7g==
X-Received: by 2002:a63:eb0a:: with SMTP id t10mr27084582pgh.385.1618227047366;
        Mon, 12 Apr 2021 04:30:47 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:32f1:1e05:984e:e039])
        by smtp.gmail.com with ESMTPSA id 129sm1572413pfv.159.2021.04.12.04.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:30:47 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] HID: google: add device tree bindings for Whiskers switch device
Date:   Mon, 12 Apr 2021 19:30:18 +0800
Message-Id: <20210412113020.2724134-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device a tree binding for a "cros-cbas" switch device of
ChromeOS tablets with Whiskers base board.

Changes in v4:
Define cros-cbase bindings inside google,cros-ec.yaml instead of
a seperated binding document.

Ikjoon Jang (2):
  mfd: google,cros-ec: add DT bindings for a baseboard's switch device
  HID: google: Add of_match table to Whiskers switch device.

 .../devicetree/bindings/mfd/google,cros-ec.yaml  | 16 ++++++++++++++++
 drivers/hid/hid-google-hammer.c                  | 10 ++++++++++
 2 files changed, 26 insertions(+)

-- 
2.31.1.295.g9ea45b61b8-goog

