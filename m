Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D58941F9F3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 07:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhJBF1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 01:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJBF1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 01:27:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2896DC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 22:25:17 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id z11so14182475oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 22:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=IgtTj7o3xWitFQk3UimI4ubG/5dzvlK98CvjtOHM1LQ=;
        b=S/GbNUMB1ugczsQiz1Gm8SqV0O9+hSBBjodwqKzmXF163yePd4+bZjqqACbJgNUo/H
         WTIUibsgAS7wKzolcdwMJZL4Y+I3UOMb3frYzRulHz1LYV4kh42XrVnxSAmznAOU88gZ
         2w+L/drTr2F1NRQQYAbMQTXLxZnL1+ORIR7cKZ0rQSqELsQ3Iki6n3LTDKQd5VhJwa9r
         MftAjgXyO5nurKKbyOFCiy9hZZBpW9Wrv/xkEdTZS6sW9Tw/9rS9qrdUNr4TI8/19fsB
         fcnRYAHZE8GPvFWHOOMGNXfVS/MPAMZpa68899SLes6MARJTe015HRDEzcq9YP3RtlY3
         lVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IgtTj7o3xWitFQk3UimI4ubG/5dzvlK98CvjtOHM1LQ=;
        b=wkHc686hWtSAP1dOW8FnI89X+fw7nL1lppr3EW/3k7w/zei19+luOdKF+8C5FSloQe
         7FPJorD9BhrapkAInxdykcDW+7Yjaq949XGQmeWXhkDHASztOUpbJ+hXcCbb85fcoV7S
         I9Qws7ijbCEEasLjArKGbzwKzFLAbSQbaYC7547C0pUy8DrmwW8ZjpmvzYJ7owZv0KGX
         u87jBMj6Y8QpCDjxoWco2XvFsReZqfJA0BlahiyBdpjQqBofcn6XvR06onGkDmnXVlVo
         MQehxPjTlpau5uyihbBTSKWNaK83RE9d+eUVKQ58lYLxsTOrTAVFT/Zt88Cnn2BTiMAC
         mMpw==
X-Gm-Message-State: AOAM530fnOYPwozFMQ7Q4iy9+r4+Kv7mnHznDMOgARbFqIXRE5uexL6L
        lcBupBbyPI4csWjsJhgAxt40Wu3E/U9DzN3n6xY+si0B79I=
X-Google-Smtp-Source: ABdhPJxeRyByeao+rf/p07uKPiwGeTNlHXDH5c8YziNixBtdcgFWVuL1BTEZcNh/42Hj3cXLLr6UNrBrC48M5/62a/U=
X-Received: by 2002:a54:4f15:: with SMTP id e21mr6909062oiy.71.1633152316274;
 Fri, 01 Oct 2021 22:25:16 -0700 (PDT)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 2 Oct 2021 10:55:05 +0530
Message-ID: <CAHP4M8XpFCrhmWw2PO6D1aSMgW=EX-N6drcCGj5_vDEHGzYTWw@mail.gmail.com>
Subject: Upstream-Patching for iommu (intel)
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

What is the upstream list, wherein patches for iommu (intel) might be posted?
Is it iommu@lists.linux-foundation.org?


Thanks and Regards,
Ajay
