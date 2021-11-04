Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035D2445188
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 11:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKDKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKDKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 06:23:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 03:20:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y1so6385346plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iI+yFGltrW+06mguQHc9k6iWJ/LtyIDZvg2aS6FlbI=;
        b=vByyAndzTW6mzuIoNib020TqkRvaFsT8d9tTW9wo5B95xp3j1s2++/Ub4aok4aNpFw
         phr/qS7k2KdIrM2YVaJbBRYgaDHKUWrNWWY3079+PabzfES4VqYGHMW8zysSvWCbvpcg
         g9i7kxZm71akabWh4xqkojc6H6lDdcV+3Pw7mrk0yaWtXFWqOnFz5x+WfJ4d/lKkFQ9D
         PNm/5kwDHG3Eb1UxzrXaiHFziTtFuss9nGh+rxwLhryqdEksLGZ2OlWd1WcZiIVezvwL
         y2vPBvRfNyMs7fjZG0x16qS6UGku5uMYmXJxJclSFZnmFVR//rmbv6ocAGDd3g9Z5KUi
         nGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iI+yFGltrW+06mguQHc9k6iWJ/LtyIDZvg2aS6FlbI=;
        b=UkqObIxemvL+lEt2OZ8zB2fpA82eX0aGrFB4InPf/QS5okTGLoqI9OYEjYz9SkISvq
         qQ0GqNbUYtvUZoytJX/BvF6VC4wyLAYPcj6vOZ0Ll21wykt4zL2E7/oHO9BnvUIHJFOD
         mKkAU1+G+/V94PGuaQ/UjWXvEAPIxFNPusiok54SROg8Lib9a5eJnBuXZu+PIEzKNwGv
         Sf5fOB2rWyAD1AimHcNHDqtUnsUBHW71uczwPnn1/MqrM4qoz43TQfvziW5ILr9wbJv4
         soAb8qYIdGktLcdRm30yhrd3FlBp32khhlhyZOMbNaMvYvTAcL5UpiNUhYCT3rxrjYqW
         wfqQ==
X-Gm-Message-State: AOAM532c1Mx/vM86CYq22LT0oHOx8TRPMc46YxDpS0ASU+GRtIyC/n9h
        Csbsoau/kvU5RTEt0cWWi8dyMgUculVD9HiXqAknjskVd+VViYNV
X-Google-Smtp-Source: ABdhPJw6qviQc/jm3Zx+oWk3YXSxKea6cIuLJPDMQLXoCm9GAH1sbwWu+GdEcoHT4o51yjXS8/3lk1/uvwaZIVqdcuA=
X-Received: by 2002:a17:902:d505:b0:141:f5f7:848e with SMTP id
 b5-20020a170902d50500b00141f5f7848emr22312139plg.72.1636021232689; Thu, 04
 Nov 2021 03:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211104033331.2634341-1-xji@analogixsemi.com>
In-Reply-To: <20211104033331.2634341-1-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 4 Nov 2021 11:20:21 +0100
Message-ID: <CAG3jFyuKEdbCptFHSSeGRwyDF_D844NAJXhUdcsiaFC2WvUTeA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] Add MIPI rx DPI support
To:     Xin Ji <xji@analogixsemi.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        dan.carpenter@oracle.com, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, sam@ravnborg.org, pihsun@chromium.org,
        tzungbi@google.com, maxime@cerno.tech, drinkcat@google.com,
        hsinyi@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

Applied to drm-misc-next.

The way this series was submitted to the mailing list is not correct
and is breaking a lot of tooling. It seems like you used git
send-email, but the individual patches of the series are not connected
properly and both b4 and the patchwork tools are not able to handle
this series properly.

Please try to use git send-email along the lines of this:
git send-email -$NBR_PATCHES_IN_SERIES -v$VERSION_OF_SERIES --annotate --to=....


Rob.
