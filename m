Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5D3CE30B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349030AbhGSPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbhGSO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:57:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A13C0225AD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:46:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d15so13156399qte.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3746NMAx+evblPdXjXzmUXFikoL8hz03w+v/pCeVY3I=;
        b=jXKxRHlfW0yhnbdfS86PUv/ab+juGw+NgbaYdoonywpW54ImwYbIHTICKY9zow5NNE
         A82dKsO1D9KDFiCweyFSNY1EkZ+RrrPfpSIvVHLl+phO1LdUPfZ46tXbuTWfghWUQPCz
         ax1C0/bffMDcDTaA1pk9mgtVUu+ITopi1UgjX7F6GGb1j1PSH/HGr/jkR82ypLbUjGaq
         x0sLHMpY6gH9kGUrBrUc+xQl5wOvijAhBqB3CVvqRZpwhifx8G/cXCZre5ErZJF0j4jt
         7jUInXLlQwatocuq0ZSHMMvPow+KhHXVHBkiaRgYDYZK0b0EdDOrtBP2n1+5y8DPO4/W
         d+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3746NMAx+evblPdXjXzmUXFikoL8hz03w+v/pCeVY3I=;
        b=XSQt3p/ahaEhTJhBWwgSe0E5m1a8yl2hFcCHQ843kg1Yrd7OjlEjPWmfwquIMCyNEo
         zz4GowBqMF7vpRJn3Wi/RUrCzjY0MAUT36aTJac2NeY+lDvBcyj7UlfZ1EGMTufmmSFv
         JWcBTqgYwQjfpKNIqDPdCnVpAfNKD5gKYkcSQX3QYe2q/mF2In+S0Zc8uzadll2q5ea1
         +3ZikKHFotIspxG8FlCNfjzTCSjTSWIGZVzW7BV9GCjorlH0cITWl9hgMhj16+4cLFwd
         l4V0upeXr2l1GGGP4yVrFDR4Y8mcTqrtl3y8+WpzKssdcu9rAcQGLitU5TDZRYYcs6w0
         +YmA==
X-Gm-Message-State: AOAM531YCPDCce2ElbHJzoGKDfSnIcMJcawWnQ4BXRwqO1nICco/GYVi
        d2cV0GMYjKIWJ9tJXWpR/OjFyA==
X-Google-Smtp-Source: ABdhPJyNyK6uQ5cKtasc1xpeNhod581xAudwQ5QP5Qro+a80GMum1IJb3o7KsamLji3k3cnKeXYE6Q==
X-Received: by 2002:ac8:5e8c:: with SMTP id r12mr11383921qtx.23.1626707786528;
        Mon, 19 Jul 2021 08:16:26 -0700 (PDT)
Received: from iron-maiden.localnet (50-200-151-121-static.hfc.comcastbusiness.net. [50.200.151.121])
        by smtp.gmail.com with ESMTPSA id s3sm8209427qke.85.2021.07.19.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 08:16:25 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, jianyong.wu@arm.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] include: linux: Reorganize timekeeping and ktime headers
Date:   Mon, 19 Jul 2021 11:16:24 -0400
Message-ID: <11790008.O9o76ZdvQC@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <CAK8P3a0LCZmHjwTjr6bWQ+uuO_3MentMfnHy2M_6iysyN9fP1g@mail.gmail.com>
References: <5729424.lOV4Wx5bFT@iron-maiden> <4331271.LvFx2qVVIh@iron-maiden> <CAK8P3a0LCZmHjwTjr6bWQ+uuO_3MentMfnHy2M_6iysyN9fP1g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 15, 2021 2:57:55 PM EDT Arnd Bergmann wrote: 
> This looks reasonable overall. I'm not sure if Thomas has other plans for
> this header, as he created the timekeeping.h one originally. There is also
> the potential for build regressions when additional files depend on
> timekeeping.h but don't include it directly. Hopefully the kbuild bot will
> warn us about any of those.
> 
>        Arnd

Your intuition was right Arnd. Playing with heavier configurations I have found 
three more files that also needed an update on the header. I am going to send 
the patch again (v2) including those. Please let me know if I should add your 
Reviewed-by or if you want me to do any further checking.

Thanks!

Carlos.



