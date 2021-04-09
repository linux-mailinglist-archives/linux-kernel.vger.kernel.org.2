Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08F935A4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhDIRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDIRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:47:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB8C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:47:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t140so4453761pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZ38wMLWnbJz0hpouQN/zu48i4kRaiW3kMlLIO403fs=;
        b=HhN/GlGSREUnzukUXPOaytoI9XhJTfoo0GUniJ9sq7e1Vo/ky6ng6L9f4zRGfEPG65
         KnN9yQDBMs60EJXajEn+AonaoZnw8Ex+EoUgQPK+KUSilGs7TsH2svWgsW9AW39H59kL
         z9ztewBj4ckNGpXUQX1fpxFHAhZKhvl2uosksw3h2Qct1mj35cpNXFKfWyMSAfWq5bdv
         VgJQJpS1iBMhLFOirLAUFTTA+c/ZqcIhEoIBDdyB707qAA1kwGQASJKY1zQf2i9CQc51
         np8gdR/yJF7L6UxhvGCZA1cAUVbLKFzP7VNt0MaQJlMBtcIauvHMenE21mMNIb3mYQhp
         5wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZ38wMLWnbJz0hpouQN/zu48i4kRaiW3kMlLIO403fs=;
        b=k0DTVRs8BEJVcoYq4DsXi/Iiv8ET3QsVekLZli4sLzNOHZg0/aEtj/uWMeozzmd+wI
         k40TWAC0EzzOrRYdmaJ3/hlaatDgQEs9XI3xx5wOrlMI1j8Zb64BDpTM0PsGRad8trgI
         8HpCkpTPzqsFI9acgStJQU2bEMrAyoNwQjNh/p9wjIRVyx8P+38kgmWCbUg85W8fiB8g
         bMtK+02xdOvodOxn+gtpJqjVZY5GIW3wyjE14LNwGEDegnDXu8gQ5H10lI7axGhgDM7B
         MN5prpkp4kXGNPFz/fkVEdZwAAJy0DvAoEPuqk5nRqUxoj+zYdVj3Tt1xd0whu8QLhSf
         yN/Q==
X-Gm-Message-State: AOAM533qqOAby5rCTUdRXOn+J0S9tc7mM5AWAIh+V4VuY56xSqLuwy2N
        e/Ba79tb1efjxrTq16xVFo3Wn2krPCw=
X-Google-Smtp-Source: ABdhPJyMfqsXiO2TdFBuT/jnfkAc0aCGun4YpqfVZRHKxYiUpn1JXg6Uv9fjxs4pmUTKOFEb8XjRLA==
X-Received: by 2002:a62:b403:0:b029:20c:cbd5:5be1 with SMTP id h3-20020a62b4030000b029020ccbd55be1mr13630642pfn.53.1617990442908;
        Fri, 09 Apr 2021 10:47:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l191sm3089285pfd.36.2021.04.09.10.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 10:47:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com
Subject: Re: [PATCH] mailmap: Update email address for Nicolas Saenz
Date:   Fri,  9 Apr 2021 10:47:21 -0700
Message-Id: <20210409174721.3050449-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111453.28121-1-nsaenz@kernel.org>
References: <20210409111453.28121-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Apr 2021 13:14:53 +0200, Nicolas Saenz Julienne <nsaenz@kernel.org> wrote:
> Add my kernel.org address for old email address.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---

Applied to maintainers/next, thanks!
--
Florian
