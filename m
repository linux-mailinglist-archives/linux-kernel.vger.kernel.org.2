Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136B1305E56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhA0ObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhA0ObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:31:07 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA53C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:30:26 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id 186so1188477vsz.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0OciNgCIzSI2IY36uVRRwblVcbGfdple6Q4mhsom/w=;
        b=a4pBXI0XVAC/4j3m8gIClrjBFsO0ql8zs6gR5wcURRqaYPhmAjCgPxYxF8r9xrFTbE
         ffVnpnR+inv69JB6Rffd2Tgagex2byG9t5dsRb3gSzgiAHfQ/U7uIbq0mfElDBfQ8DLs
         8lTiwuz3zjoerRUHLSQx0oQMuduoN3elBv9Nq5TjEl8H8/J+k40WQlHSAk2A8dQbA/Xc
         VQbVASosByEdFZno39YUeod2MymSJ4w/JDbzwUAsD7q5MXS+Oce8f/B5zh7TaBucmGLA
         556gDhHKdPE/j5KfwsfhtbpBhqyz1wjpCOpW+DtTekIOJAPaiHmASRAbkCjhp/mem4Uz
         JgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0OciNgCIzSI2IY36uVRRwblVcbGfdple6Q4mhsom/w=;
        b=nDY2hH+S8yJQrV8QETrPansipX8moMeZLjMCaxz/p7V3WlfBa6TQkdVy3c68fP2hnZ
         O7cX/rGqSOSQNBQTVkSt0FhDq6c4PYua2HECZ1/PH4c4nuCwiUgny6QLp/S9I+gfj6Vs
         P6gNBNBOG25kFch5uU+DXRuWVKixnXa2NCYH0DTe/UAkGupED+yjfMT4ZLCozISAvcBj
         RPb0AMXrqFs1eU+U9T19/NVLmzJqSZ0me3EbvJydp3XoRhJp1odg0I5XHcYXw8cvuLap
         MbFHTu/hMgpu7ty9ImwSD7kpxMbmHxnQL9WeuHpgJwWvOJE6BFUtSqN9Yyc7CQWSMzyj
         D6gw==
X-Gm-Message-State: AOAM531W4LFnLLM+nWA/IMi0rt9qcMUtmanaBqh/b/lJlAvFyMEyL9oQ
        la9XJdFGvFnMs8XMVQvPeV5k+e4OIEY=
X-Google-Smtp-Source: ABdhPJz4FmDxcXjTVM6WH2pzAiMpZeQ1FdqpXIK9pRDFtv0OC5To3kM5zA36VXDo7zFCSlT9KjcnMA==
X-Received: by 2002:a05:6102:96:: with SMTP id t22mr7910934vsp.22.1611757826139;
        Wed, 27 Jan 2021 06:30:26 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 30sm260966uab.18.2021.01.27.06.29.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 06:29:54 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id v19so1198722vsf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:29:45 -0800 (PST)
X-Received: by 2002:a67:c10f:: with SMTP id d15mr8063009vsj.14.1611757784589;
 Wed, 27 Jan 2021 06:29:44 -0800 (PST)
MIME-Version: 1.0
References: <1611741189-45892-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611741189-45892-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 27 Jan 2021 09:29:08 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfERdgtzb4QGrWgCw4Y_t8kCvA5rjokA2YfrSn9qwmn-w@mail.gmail.com>
Message-ID: <CA+FuTSfERdgtzb4QGrWgCw4Y_t8kCvA5rjokA2YfrSn9qwmn-w@mail.gmail.com>
Subject: Re: [PATCH] rtlwifi: halbtc8723b2ant: Remove redundant code
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     pkshih@realtek.com, Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>, lee.jones@linaro.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:05 AM Abaci Team
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:
> 1876:11-13: WARNING: possible condition with no effect (if == else).
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>

Signed-off-by lines need to have a real name. See
Documentation/process/submitting-patches.rst

With that change

Acked-by: Willem de Bruijn <willemb@google.com>
