Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB241A11C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbhI0VGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhI0VGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:06:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F920C061769
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:04:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bj3-20020a17090b088300b0019e6603fe89so138808pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnO+Kxz+eK2Jo/jQpSsvJ9y8KywrRvL0i5UVxm4Xzxs=;
        b=FeqzsHdl1p2zFbYqmqy0CaznyR6QXwleQ6fCcmL05XTLoGFVKaE+6kP7DSEsiryYRQ
         oaJHuGT5DNb3zdDJOteO0FhsnuUwpYOTT+nkXBOLc+ETmLZ661MUbACJjQHezIlFzjzE
         NlcCqkp3h0LKx9zQ+bRMFj/JFqzZpza2RyZvNu4zzewgiX2KOZtL06CgPA3FkK2lZrH4
         qxCKq6EtUfWvK5cchOcseKuIQ7MpsGqc+hIADhUSFdKQom6+NZoFmDKwTcm1+TeOSZeu
         v2BAn0xS7l/T/E8IxFqtOl5CqDePBnOCR1NOCn1+VbwySjXzOiiwAbOfVq3om+yUHzT0
         sH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnO+Kxz+eK2Jo/jQpSsvJ9y8KywrRvL0i5UVxm4Xzxs=;
        b=dXFLqluD0qiSwJ801hdPbII2RACi3oTbw3zFTxjia1t0Q6r623lWLdx2IU2G/syxWg
         Hr5CJ+dkFtRsgR5r71PExgFIjf20wtUgJjSjTpMEWDEP7QS8WyGXYd1sL2FpIx1o0NCB
         9NOcZ4LzKMwNk0yQ0emko/7/PW6PLtw2pnGzrXef+9hZB5eM902oQltCm49OsWvUTtJq
         PNy3WfgI1qyrb8Q5D1V+zDARZS7VqK/W3AWce2347CuZmQMf9XtoWjVb6RKK3iBIjf17
         rGoPGiycnGDR8OOjXATjaY/pulJHflEWJgMWtw1MMCeLkIHzpAcI+NOJixYmobFPkAob
         hmoA==
X-Gm-Message-State: AOAM5302rMMIrX2VFSRqqa9x+kPtpoYkoHAHG47UOvgGgo3wzueNtCXk
        ql2Psq7y7DcHDolm5ZkUEGs=
X-Google-Smtp-Source: ABdhPJzXgG4XESHpTVRcXoaG9YVBE1BWirwtEgfQvEGDvebE43iDNhALPomNb9YXSxYRE1fZgCNGWQ==
X-Received: by 2002:a17:903:1112:b0:13d:ce49:e275 with SMTP id n18-20020a170903111200b0013dce49e275mr1789957plh.5.1632776656956;
        Mon, 27 Sep 2021 14:04:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e20sm311726pjt.14.2021.09.27.14.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 14:04:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] bus: brcmstb_gisb: Allow building as module
Date:   Mon, 27 Sep 2021 14:04:09 -0700
Message-Id: <20210927210409.3217254-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924191035.1032106-1-f.fainelli@gmail.com>
References: <20210924191035.1032106-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 12:10:34 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Allow building the Broadcom STB GISB arbiter driver as a module, however
> similar to interrupt controller drivers, don't allow its unbind/removal
> since it is not quite prepared for that and we want it to catch bus
> errors all the time.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
