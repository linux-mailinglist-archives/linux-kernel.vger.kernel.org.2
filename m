Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAC388701
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhESFwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbhESFwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:52:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62BEC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:51:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q2so9111706pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hIce4Sab2WHJdY/Swtpl8EVUwcjzs30ShL3uKQAPv4Q=;
        b=bY0gEpNI9wdmgQlkmfmh4/zJHX1NDu5BcloRUZfgTQi2VtFFwPQDDtPiTQcgTMcsHE
         JMdLS3pGhcqmipuIESjVbHUvivGt9Fl583s3Wss2UrlYDyVtuYBN4vXoWb/SX92OdChC
         Sp+ONzVcXONMLDpnCvXeI4RHsCwwFZjm6LwDfkSNapkrRFjj+XW49KpU8ZhDUoI59e/W
         2Ldv35We6jySKA2qJHngshS7fYpfQSSg2DIdMVQLdlPR5WKImhwg3ucdTNBgpz7yoDpz
         VW7SS0viKqnsRw5Tu/25LSix0Zgu5u5Gnh+JoVmak3LovY4WCAKZGYf7edEcmFHvxVTY
         W+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hIce4Sab2WHJdY/Swtpl8EVUwcjzs30ShL3uKQAPv4Q=;
        b=ZP6wLSyCh4djSNLnvmjNNQPHQH4z7iL9231kONY738JQpyY5/Ov+hN9mvseIYnFifR
         Bxfnm3RgtgbYtwf8V0msFLNZo8onQiY5TTvgimdk/rW7071eNXDJjQfnmDb/KYtWpdhI
         O8K9cEYJS58c/Vlx6iT6Zquu2/NKrR1fakmJX2pjCAfkgQpeE3WxGLeKljN5+CKTRUzv
         0qBEDiSkh3IiwC/TH8L2CxOyUlSZ6jAdn62tvBynKdpU3p6+2JOoX+gUoV++9HmvKOij
         kkzQDMsWEa9EstLxUEKlf2cK5NgzCtTwfdPCPhwmzV8gs9dVDS29j5v290KoySnaMkFf
         EDUg==
X-Gm-Message-State: AOAM531nC8rkcRPcwgpX6lNN9v/6A5Cterpn3cKvA/8GctcuZRr1yJRr
        nrzP1brjaIDzcJsXMQBEqzY=
X-Google-Smtp-Source: ABdhPJzVWlqsbvRLM9AIgGousVrHGs2s5NJ44AQgxcguCO8uuTP4I63p5kRF91TQt4NM6R8Sul30hA==
X-Received: by 2002:aa7:8484:0:b029:2d8:a014:a0fc with SMTP id u4-20020aa784840000b02902d8a014a0fcmr9032707pfn.24.1621403460230;
        Tue, 18 May 2021 22:51:00 -0700 (PDT)
Received: from devbox.home ([50.39.96.2])
        by smtp.gmail.com with ESMTPSA id w1sm12525230pjk.10.2021.05.18.22.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 22:50:59 -0700 (PDT)
Date:   Tue, 18 May 2021 22:50:01 -0700
From:   Pawan Gupta <writetopawan@gmail.com>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
 Forwarding
Message-ID: <20210519055001.jtos5a4nu6j6kum2@devbox.home>
References: <20210517220059.6452-1-rsaripal@amd.com>
 <20210517220059.6452-2-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210517220059.6452-2-rsaripal@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2021 17:00, Ramakrishna Saripalli wrote:
>From: Ramakrishna Saripalli <rk.saripalli@amd.com>
[...]
>--- a/arch/x86/include/asm/nospec-branch.h
>+++ b/arch/x86/include/asm/nospec-branch.h
>@@ -198,6 +198,12 @@ enum ssb_mitigation {
> 	SPEC_STORE_BYPASS_SECCOMP,
> };
>
>+/* The Predictive Store forward control variant */
>+enum psf_mitigation {
>+	PREDICTIVE_STORE_FORWARD_NONE,
>+	PREDICTIVE_STORE_FORWARD_DISABLE,
>+};
>+

This can be moved to bugs.c which is the only user of psf_mitigation.

Thanks,
Pawan
