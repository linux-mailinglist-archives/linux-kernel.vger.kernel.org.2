Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692E538C86B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhEUNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhEUNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:40:02 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2EC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:35 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id g11so14237239ilq.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QraQWaDbrIyFsDMVDfzA8DAF+rb0LcMH/Egy8Qs4g6M=;
        b=NDr61RfLLnF+gQBIiMtqzi7vpbFZjTAEQ/3snixCdg1v/fEnAITaDrsuFLzVjPCdhd
         Lmzrnxe9Halzpk0OlPiHVvJthHoZhrECa3Q3BLCOpC1LuNqyOKRaAeJTL5rtPeL1i1ej
         CzBGsLziVQgkGuT5f2q8JI8zWMkMzjTLPtZrBcLt07IWpu03LiJhUz7pfM2vyco362dF
         bJESuQwJc8CPrw9DK3P/gOs6s/WU07rNftjUU/WWGpMijP1jIvGdkBnMZts8k6SW/elN
         sX/ZnvCC6SW9U1rnkRAmmHVeBGL0bT/0u+T/HmLlS3VCwov+oxESpTAJbi18cUHNdlLe
         1tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QraQWaDbrIyFsDMVDfzA8DAF+rb0LcMH/Egy8Qs4g6M=;
        b=q0Eq0FDAYqjYpozWU6eBv5v+RYMn6fsEWg65wFTgiI2Ldvls284Q5P0P4Af5MwXO8s
         lT66FtIaqKYLXBIcmZCJZVC5xgYXdEFxacXMTc4dv9SM8niyDeHEcWZA1ooC1Zm8+FND
         6f/6TDJLaRGT5LA9HOL4w6DDkmvillwVWszqoni2RvHIxvSDus4F/AJgArNNkj5vReU7
         5A3REdsyrpeXSzKZ+nFm2zDxB1IoNJE7YVyTXCo1vGtsf9P+6D0pvagkj/lM8RBkm7b4
         iN3h2cRKP3Qv0Jvj+T+ist3GQa/HWln+Rn/RIwsV3tO62rRXbBAhx/2uo6wcuIWfBtox
         o/Aw==
X-Gm-Message-State: AOAM531fh14A2ixat48E6lbe2ZKEjRdsRyCdfihJWRsl2tDEa1Pi/R83
        Kz/pW72TY4TyQWKkV/evAZUalEu5s4xajw3x0Hk0ig==
X-Google-Smtp-Source: ABdhPJy/pKbvVZY2/ULXOE3xI/TcxMMBcvpBSC+29wPkgzlKokgXyeEvamPfYmJfaNpUd1aCuAwQoKJVrbi12TOABqk=
X-Received: by 2002:a92:c74b:: with SMTP id y11mr13202440ilp.302.1621604314599;
 Fri, 21 May 2021 06:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-15-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-15-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:38:23 +0800
Message-ID: <CA+Px+wWAZE2ea7pfMEF3Xg_w+H4n8QAK6qcOyA2TAOkYd5_GBg@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] media: mtk-vcodec: enable MT8183 decoder
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> [acourbot: refactor, cleanup and split]
> Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
