Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943AD30D055
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhBCAeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhBCAeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:34:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA833C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 16:33:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b9so13275241ejy.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z+13UOGCC7I+iljuuHXBZA6fphrD3cnMtJ966bWAe3g=;
        b=L87PxLNy3JVeC8VgaY4K6vYiAWo1G859Ngjl11rO1vgIE+Q927EVX8nWD8PXvIDmTw
         KF+qo3Jske7uyXdDaq4Qv86iy+TpPjMFNeadxFHvS1sEH3a/jnqxxNWNdBJ0SKiKk7tV
         mdBYoKgGq1kd0Gywr5xWzHYJzD9u7HD2X1aOUwHQ1YKap1gSKY3xhbSicU9UVOPCdJaX
         +TnjoNq9b+OZTMvFvLQiWk3yF3P809NQnmwDTIqU26DIJYSS66eHIJc8OGnQW6Gyc1EU
         rX3hTwxdg3gdnoNg50ntpFVKeYLhk9I7ca0e8RJA+d48yaS1cT/nvfPFclyWm7SHb0TF
         9pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+13UOGCC7I+iljuuHXBZA6fphrD3cnMtJ966bWAe3g=;
        b=hkApq3lcFh56KU1zw6Ml4Qahr0a4Koq9If+oiA441U/T/IlFPxB87i+3l+oKWUiTxE
         3nY69F09QaAKxXLDIeroajb5IBJL+WaDDjqZkVk8OSb9DkxW9ovhVNJlefY9YQta2c4K
         Bxw4GFGnkPfwAVLUwSbRCoO8ycpYzIR8BPDIPLtzNggM3H86dVIyrnAYp1d0/68bRfDe
         4wnVjg1WwhxBIXhbrRSxXTYOGoJX6dbmfYpAJk+4Cg0k03B7CkjVo0XFUvWGDXVKlQ2Z
         9smmMaUP7YTIQWWOLAYH+9Zvn7mRfSt0EsOqcftmApFrVKA0YAG0hM6C4gKBR01+38t7
         9sQg==
X-Gm-Message-State: AOAM530PHBV1t8AS8PBEK00JqSpyIT8VTC4O5wY0U2Sg+N3OhjJ2wQCY
        KX9POIEc6amhBbs/6tVhhoD4ZarctyxpM01xJJY=
X-Google-Smtp-Source: ABdhPJzbDVdYiWc6xmBFTMIEEpr2atHpxPzwcj5CyseOV1v3Bm60OiC0TKbqos0bNluJExG0dUR+CAKHxhTcJEdwLWY=
X-Received: by 2002:a17:906:3ad0:: with SMTP id z16mr587105ejd.72.1612312405694;
 Tue, 02 Feb 2021 16:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20210122084321.24012-1-a.fatoum@pengutronix.de>
In-Reply-To: <20210122084321.24012-1-a.fatoum@pengutronix.de>
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
Date:   Wed, 3 Feb 2021 03:33:14 +0300
Message-ID: <CALT56yMudd0jKx8TiWvSrsE-Y3efhnFwNYcgkDiExcZONNBt3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm crypt: replaced #if defined with IS_ENABLED
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 22 =D1=8F=D0=BD=D0=B2. 2021 =D0=B3. =D0=B2 11:43, Ahmad Fatou=
m <a.fatoum@pengutronix.de>:
>
> IS_ENABLED(CONFIG_ENCRYPTED_KEYS) is true whether the option is built-in
> or a module, so use it instead of #if defined checking for each
> separately.
>
> The other #if was to avoid a static function defined, but unused
> warning. As we now always build the callsite when the function
> is defined, we can remove that first #if guard.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


--=20
With best wishes
Dmitry
