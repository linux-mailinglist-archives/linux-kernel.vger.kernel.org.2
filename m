Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D34561FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhKRSMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhKRSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:12:45 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0921CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:09:45 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h63so6079544pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xlr8/9jdTTcKRDI4drRmlYUB7JGZiHjD5lSETKckpwM=;
        b=EcL45fGRuSvD/CSKS2/iXr+xLip1rRwsvpWzgxkZIkioJnVpKyp1VZ+6Vz9WF698HZ
         QDXYElkWRB3INlkmIzX/w+ApoVTO4QSIEi+18plGAQZe6+YXHji5TILcdfVRS/remG1W
         B6usaGzQcPaVIuOebF9IMFocIgML9Vr1xXBUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xlr8/9jdTTcKRDI4drRmlYUB7JGZiHjD5lSETKckpwM=;
        b=vouisc/YKww1Rr3gEKF48WjL+Daj9vHgbqWhXfFjh3yoZ94hNBOT1x00jr+W+duGBm
         di81HJP6x+q9Cf/3kbkJCRebcfHPgKpo1qBwuAvEMl60XhCLWmuoFqtLN+AIJ+N5xcLO
         L31z2fPcym+3gUGusKkvRT5RaR0wVWEFxQBByP47WFEV7DhIyO+ep9NavUzEofJAuNis
         r4FDXyr0zRlam+L1JX4x+a3M4AUWPREYBbKgDto0joDsolDXViE72EAcJkaFt39wimiw
         3OjYp+naXhY6pvv16UIFDHiV12NXI90+hzzB5Ic6menUsfCmHOJ2KiXHYPzhktDe2qTy
         cHJQ==
X-Gm-Message-State: AOAM532dxPhfCd/ThmCByAkJGld2rPQ7CfNS0xxUMuKZmEo5nnc+nLY2
        5PT+lSU79VTkvxIvC/+cQ1B3cQ==
X-Google-Smtp-Source: ABdhPJxyHCLK9Y73MJGzlT9oyXLqZq/T3u+w72IDms+04AER4eljXNAF5eQoJBWhoyLcthPNVwWeUQ==
X-Received: by 2002:a62:31c5:0:b0:447:cd37:61f8 with SMTP id x188-20020a6231c5000000b00447cd3761f8mr16891829pfx.29.1637258984270;
        Thu, 18 Nov 2021 10:09:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k14sm256403pga.65.2021.11.18.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:09:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Luck <tony.luck@intel.com>, Colin Cross <ccross@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Vorontsov <anton@enomsg.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore recording
Date:   Thu, 18 Nov 2021 10:08:38 -0800
Message-Id: <163725891549.1179817.6546871118396864090.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 10:21:34 +0200, Uwe Kleine-König wrote:
> With this knob you can enable pstore recording early enough to debug
> hangs happening during the boot process before userspace is up enough to
> enable it via sysfs.
> 
> 

I refactored this patch a fair bit so it would use a common enable/disable
routine, but otherwise the original intent remains. :)

Applied to for-next/pstore, thanks!

[1/1] pstore/ftrace: add a kernel parameter to start pstore recording
      https://git.kernel.org/kees/c/8d74118c9441

-- 
Kees Cook

