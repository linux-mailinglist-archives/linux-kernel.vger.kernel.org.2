Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47A43BB76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhJZUUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhJZUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:20:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4491C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:17:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w23so836634lje.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yQ6Z3Z0g61pqCis/uuv07HaN60SDD6t3x64tUVmCrc=;
        b=zVCrpwgUCuyf/C/hkbrads+BfQnT2aOkSDLVcafimfed1MwT5sWMYIL1fDHi327fmc
         yZr5S10TVZ9lSekV/f5fd024O7WjINB4gAbL97xJQfepU3sIKJY2k58acEJh4pnEXHyc
         aubeuVwppfadgHeFDktIU0WsaAwHAUdHyrNmXFxNyJxcadiHha4aHaJjHe9vxz1S4nY7
         tYgHulsz5D/GAThBdbColkQ7I3IopOLLOnyrJzKFFALA6vVR2G2ykslyEotN2igARpDl
         B9YaBJH9y2CIPgpZdlvrq7NAHoIMkPcTJaa6Avddt33o74PLKpQmKWHYHaMhbqnxcEFc
         nN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yQ6Z3Z0g61pqCis/uuv07HaN60SDD6t3x64tUVmCrc=;
        b=4ZhHbzLJeVOEt46CyKCRaqsg5lBIivm7/5ZNOelRxYF3lLxnyJ/RNsEyxM4RJrIQDm
         TnVMiWZqYw7964degZfcn7O7EfzDdcpXL3DST3aMWrAwHJ5+b4vegHVucPOHsWzQ80sK
         zk+fUcp8PxooUJ2hu+FXZBSoBM/tU9AocTUiYobCMKLFHPy0jFPV0TjO3dkiO3f8OGif
         9rEaWsSYvTPAbKq9L1hOrrq0a9kgiXsP+QqjXKc09w/4HpnpU/rrBZzFnNNOffJyh1GA
         op5/43lYZ9IuPxCUsjO1FYOgXLPNRerQJ4jobKFRAVGScdtWzPhjRJICI9mXLOpvu1sS
         j4HA==
X-Gm-Message-State: AOAM53182vn+omzY94NmEOxrLy3TSFd0H/2VlzTpgYdgGDZ4Ja2P7S0N
        yWdlM6pDFtiedbVFLxaxWWcdGcrPrWJy5S75vhWbnA==
X-Google-Smtp-Source: ABdhPJzTLrslTFjnjrXfDz6oWJkFGCqP8GQsr4oBSanlHxtW3tmVL4ftXeaKjFPGzpseH8QTkdSkw0bhgm48Elqp/o8=
X-Received: by 2002:a2e:9c0b:: with SMTP id s11mr28696128lji.259.1635279465127;
 Tue, 26 Oct 2021 13:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211026191703.1174086-1-clabbe@baylibre.com>
In-Reply-To: <20211026191703.1174086-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Oct 2021 22:17:33 +0200
Message-ID: <CACRpkda-hh98yx7TQ9cmgXrQ+6uPf01gBzRddir0PYYcc5+uaw@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: cortina: permit to set mac address in DT
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 9:17 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Add ability of setting mac address in DT for cortina ethernet driver.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

That looks useful!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
