Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E93340A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhCRQrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhCRQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:47:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:47:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so6264478wrn.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rYt0I16oRFS0NsPEP100JsgSME0aNFfmHdNQ1qKQYCs=;
        b=dYYXDOw6Q9BjYoaAX2YdXn7Z6R8S6kiULth/Ap8qFOG/JDB77ngt4agPDCsZhvSdtq
         ZDD7E2amOPHuwj7sXHu1OvgXhUmEOIY+4DdVvdhnG6Wo7mRWfYOxC4euCEYTWQ/MdVc3
         ym9WtDUmZOCayt0s14mxlXlKyED9UtFuO+pC+rE13aEsTBoI0tFDdoIVkGBHSFnt5Ed5
         c2cdPvrqr8ucmXv8++YvRv6vpHpGYFTfH3aC8sR62MNEobvWOAz3FXEDxLMDOZhgnxwN
         t0K8PISG4/bEb5jaL7qf8c0/dXBg5ps3HW23uEkX+kwqICS5OH0RQGCVGqfyASsPOeP0
         3GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rYt0I16oRFS0NsPEP100JsgSME0aNFfmHdNQ1qKQYCs=;
        b=E7rV2QWqiJ4a6iTnCK0xkA1VsYkqoa6IwLJMLTG6aNZ0gNE7CFkOqItVDuHqVz5zcW
         9Ug8euqb+t3ujvL4jnVA6kzgFbUOMU3SVrFtX4jbxM6/Eic/mSUeqJeefdO7oC2IZoZe
         1cYuEEUSUkITCe5DBWdG67wER3cuOt0mWrMkDU0fLthnKQFmwaLZ0lLIR8WVUp9o8RjN
         PvTmgWs1yte0jlmaT8t6ATVsls/gsgag+o+200uhCW/bKte+Xa+tdKlxLyYfXFq7rJfk
         8/heTGCQLkB7YbK3yswjqTRhxJSpzgFwZs8T0XZtVZuS0knoz+rPLbXqS5JmaZ3PvBg/
         deCw==
X-Gm-Message-State: AOAM532+wb35nAm9eD2LanKsjX86PFSSZD3e/OeqKNm2cxL2F5okqfnT
        j5guvb6k0KDuD1Znva2Mq3M4eX7npEOjjRfMDhA=
X-Google-Smtp-Source: ABdhPJzyDf4QYBpHs/UZ49O8ZFftU0mlWXLHYLVk9EZalplUiBAvjXd/BIKDZ5EX/t97SPLyNwYt6HMJMgBbUh0m8bw=
X-Received: by 2002:adf:828e:: with SMTP id 14mr167634wrc.123.1616086063527;
 Thu, 18 Mar 2021 09:47:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 18 Mar 2021 22:17:32 +0530
Message-ID: <CABJPP5AjUJ+OWqUy7cR1Ar2zcs6QuLizciGf64WVQ-027rS=bA@mail.gmail.com>
Subject: Checkpatch still worries about include/asm/ ?
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
include/asm/ got removed a long time back (probably v1.1.45).
Checkpatch still worries about that:

if ($realfile =~ m@^include/asm/@) {
ERROR("MODIFIED_INCLUDE_ASM",
"do not modify files in include/asm, change architecture specific
files in include/asm-<architecture>\n" . "$here$rawline\n");
}

Can we remove this check?

Thanks,
Dwaipayan.
