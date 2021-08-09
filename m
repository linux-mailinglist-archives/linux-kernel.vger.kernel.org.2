Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28783E4510
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhHILxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhHILxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:53:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D6C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:52:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l11so4428523plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fzut7q427dSOMHdk5iq9A2Chh3pUPNn9lZszq3eYTWI=;
        b=mt0s1/wtipC2vRki5poZMn2c0acjsgZK+wMMtk9LKr+5vsKRMpr9Alnj+vC+CMxit2
         lVUezSLQsxGwVKqJgBCbil1efK53xNiew52i2ZpVyJCu/eV/l9UFA9KxExAPe7Q9O9Em
         vKZ2LnXngjuTpDSAwd0aKL+Ra2b25u2cZscTk93U32kcBjkUQw0wBtMOOffgQ1G/RdXV
         UKamvyT9EKSgidd5Xd0hWEHCEg7ZszMQHHIrMuP55I/v+iGFREvh/a+86GwROHjjfFhJ
         KXQue7RWVc6X+UTiz0OUCgaEzcYlntyRGDCaUmcOSmq+1bAkW+16Cr4nRFuAO0NPEpG2
         T6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fzut7q427dSOMHdk5iq9A2Chh3pUPNn9lZszq3eYTWI=;
        b=QGO2/LdEhLdxtmGlyN3SfiyPMfjOCEISKYc78xgs/oKHegXblXPWHWSsMAudf/Vqtl
         4mogwq7fPgoaFxvBfDxhLXfqFCHGVjPOP/9ycbCx8gUUADywUdW77KLIzJme22mXiiy1
         xeiOwfxES4qrYLeDjmb8m/7i2b2NDFXwRGCAw2npOXBA3Bp63kaunkf2AJDyeQ++duYp
         a3qBlL72sv7Pu7FN1tERHix69D8W3z09lw8m96B+7h2lgBfmvPk2f4ToEfqlqyBNqBAU
         dNrWlOQWTIfVXMkRCP7P69VP6XwvZdRRct4Nb+iunHxLtKO3vlP2XDpXwKee6ChSuIae
         d4kQ==
X-Gm-Message-State: AOAM530hqAyg4JqwS5xKstqj5w8tQqACW+zcCl2cGqwzRA8vLJAS3d0J
        Cs45b5OTG8wYgqahrdrC/DA=
X-Google-Smtp-Source: ABdhPJzmOjK4/VELetmNsOHZV1yNIIT63XGlS0PTInKXGmGUL0H/hj2y5zipAq0+I2akHuPMs9/rYg==
X-Received: by 2002:a17:90b:802:: with SMTP id bk2mr25458580pjb.51.1628509966114;
        Mon, 09 Aug 2021 04:52:46 -0700 (PDT)
Received: from localhost.localdomain ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id u129sm20622778pfc.59.2021.08.09.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:52:45 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     mhocko@suse.com
Cc:     akpm@linux-foundation.org, chenguanyou9338@gmail.com,
        chenguanyou@xiaomi.com, gpiccoli@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, vbabka@suse.cz
Subject: Re:[PATCH v2] hungtask: add filter kthread
Date:   Mon,  9 Aug 2021 19:52:38 +0800
Message-Id: <20210809115238.4044-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YRDyquuwshpHNdz0@dhcp22.suse.cz>
References: <YRDyquuwshpHNdz0@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This still suggests that the primary purpose of the interface is to
> paper over real problems that should be fixed instead.

I know, but i don't care kernel threads state because of it doesn't neet to fixed.
The API only for debugging.

Guanyou.Chen
