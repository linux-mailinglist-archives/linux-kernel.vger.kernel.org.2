Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5596388219
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhERV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhERV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:28:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FFEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:27:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b26so7491lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yq66EOFTE3KRowHKWchwUg+sRn03C/iAH0DpjtlmwwA=;
        b=lbe3tVEZF3bf4ofQpWHktP6cfisd1oE7LA39QhhbdQjbakjMFGhOVKYWhpBpvX1EJp
         ysRjbDTbPSu4nO7kn2stpcaZzDV+8xJUrXTzh+738Nnpovc3b92eFYab3dURRe5n5lCk
         eZr1uA96p7Dxv0kLbK+9PEF9TKGlBrjZkSrQbk26KQ0/aWQ9CIVVXNMNvMqpEr6CK0Lj
         vkjb7ph6cxQEnlPxtwjSL9LZU9SJZDt4oNQrCt1fwSWXtxbmCPfn9dCno/K/xI3R2QWf
         m5gLZ6hj4rRzsRFDYvrj/6fM6A/gd7oKsSo13Ns8zUvzHlar3TDq6FnajVrOtDNbk2Uv
         dwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yq66EOFTE3KRowHKWchwUg+sRn03C/iAH0DpjtlmwwA=;
        b=JwvvUfxJTmw83fX9kAiJxvAyRUCrZ6R9LxpIzBRMp3AHoxcbhqW4NxTObPWaxgr50J
         8Y39069rDYQTxS4RBPjS4tSRWhYDIHKc4rX+Mm0zJVd8cj0sWLZIs5MS2WVb6y2BH/A9
         gp68TGzpaPEFgT8qyQH2N1jRGXLdhh5zlSOAbCXGK9Q+MQwk0j+UGyk5sPhClIUoDZYZ
         jqBxNhXhPclWSz3xVKMp72taEu9AYNqPn2ZIbjrBAoZC7CYuhCHaJ5s7YgZiw6jZEw1p
         PKEd25qQLoT8LsEa17sBbv2iQr6AOanFf6uzjIerlPRhTALo7AeiUcInK3lwyeZFDM7d
         6oZw==
X-Gm-Message-State: AOAM5322crLYPNXtDSoS3ob+ohreLAo8sYipR/+D4LCt1aIxRqKQo3FL
        Pq/hJTbM/ieq0X8IYU+IGg/ecOSdoxx2h3Tdzp1Ypg==
X-Google-Smtp-Source: ABdhPJytvp4UMxSWihjcIDYPHUG5+ApQIY9lubQNV5E+oo/RN8aQfDBOqcOVsm4UfQKeUxXP7easAc2R2d3wYUKG5Og=
X-Received: by 2002:a05:6512:11ea:: with SMTP id p10mr5301738lfs.157.1621373221557;
 Tue, 18 May 2021 14:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210518185353.3802437-1-clabbe@baylibre.com>
In-Reply-To: <20210518185353.3802437-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 23:26:50 +0200
Message-ID: <CACRpkdaXtuHWbZvRiV5GTf4PAPKfO4--ecu0w+XEyU3xZrEOQQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: gemini: convert obsolete SPI properties
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 8:53 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> gpio-xxx are obsoletes properties, convert them to xxx-gpios.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied!

Yours,
Linus Walleij
