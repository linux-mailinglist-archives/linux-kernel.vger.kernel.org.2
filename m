Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246AC3DCEE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 05:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhHBD1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhHBD1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:27:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB7DC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 20:27:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k1so18101474plt.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TccySR4d9f6K2bAZSrfCed+rWi5fYVMvW07bdg4ljSg=;
        b=wA5XdmZs04xMdzfn8U8bqGmZGAXLG9rpdrtGI6xEU9M3gkKAEajXWdDTyBRMB9YfYb
         KPaWosNiKdc1rYyKsQZ+qpyEUGNFTBYn2LfEmWQxmGqC7A4q+/d34+uJzmYKryDop33p
         0g1Hb9R2ZCh9rHKAM9wlcRAwn3MJRszFv7VDRVLR4iHeEgjpOI3heVWUD49RO9lYq5Az
         cP5+0ICKtJehdimAQsbm4xuMxLHlcBiaS+pKhJmIsBVlsuIEhJkK2jTR4i6w5VmLW6ON
         rNyn/DlC7ja3csj05f1WbMSZaVQ7+NQr3b7e18XtAbG98QdRJZDdln8+keTvtFGEtiPY
         Rsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TccySR4d9f6K2bAZSrfCed+rWi5fYVMvW07bdg4ljSg=;
        b=Yyk/bRisJP2+H3TQKs3eJXOoZOrPaXOaAa1i362Txej46ED/LAzeDn4SA3Qhx0HTer
         5krTzZC9d/9RP9YCfs7lN10f7lhdY50KQN3oBjGCIxDpl7J/zNZjCguCCL9stJa6aPAH
         8so+riE5DeI4M2N6wAsRWOcjR7v7d03OZhXO65uYUebvcbQgAT+p3/u4oE0SvARsU1a9
         IKkMZS7rDXLu2KbzepwDDX2s3wCyRkz8xKqC/DJ2CW6fZbHLGpBbVlu3ZE0IHDIN0Zk5
         vdTmNUzTBWhJXIkGqqoK+she31fgp8Vz25zQ/+cjB6XeLJUKCF/UsHqXtDByrOD7Ohev
         Xi3g==
X-Gm-Message-State: AOAM5324bNOdb8QTDqjUX6+F1yLCz9OVhEakeoM0ezjuK6+/PGxLHIvY
        wMvNLjIMD86dcFDHszkph/wEIQ==
X-Google-Smtp-Source: ABdhPJxuUMNiBNw7iVAnGTeUxFYDuL3xz++58ek1lZ6xPw5MR9NriVo4l+8Jn6Tf0aqwz0SNLCfyeA==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr14779697pfl.57.1627874828655;
        Sun, 01 Aug 2021 20:27:08 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:4e86:5558:a761:961])
        by smtp.gmail.com with ESMTPSA id a22sm9091534pfv.113.2021.08.01.20.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:27:08 -0700 (PDT)
Date:   Mon, 2 Aug 2021 11:27:05 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Hess <peter.hess@ph-home.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@google.com>
Subject: Re: [PATCH] spi: mediatek: Fix fifo transfer
Message-ID: <YQdmCaySpW4Dpz0t@google.com>
References: <20210802030023.1748777-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802030023.1748777-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 08:00:23PM -0700, Guenter Roeck wrote:
> Fixes: 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode")
> Cc: Peter Hess <peter.hess@ph-home.de>
> Cc: Frank Wunderlich <frank-w@public-files.de>
> Cc: Tzung-Bi Shih <tzungbi@google.com>
> Cc: Hsin-Yi Wang <hsinyi@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Tzung-Bi Shih <tzungbi@google.com>
