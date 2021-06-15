Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6A3A880C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhFORs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhFORsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:48:25 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C68CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:46:20 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id x13so10279141vsf.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyGASXjZK6+KaCFSY7M57pQho7eXR3tu7GtXUlEdjrI=;
        b=L/qX46GD8snGzvccBZlifarMswFYhBDW1qSLHsFffckOgg/GzJ9C1qZ2SlxXCnbF3n
         aCAGRoAuHyruQsWR0hf0CwR9tUuPFMOuIOc+X6R32nl1hJrf9gNNSXI2ldriRak6CcrA
         ldORFDeCc5ect6ffiKNvx9xS24m4v2ncV6hULVja935vO1q0otxWMuI+fWY4nDaRA/65
         ANfSnKLKO1CMeop3L99hLm59yObrVS/8nneMIFyxD1pNveTGvr2PE04sXtzo8p7+Kwaa
         i9D9H4ugxuTV9VBZ+e3jDKSfzGDXVrVFZTt8xJQFzxwyFfYwB4V5u9Mlv71Hq0pQQvj7
         uo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyGASXjZK6+KaCFSY7M57pQho7eXR3tu7GtXUlEdjrI=;
        b=TDh+lamLUN8kNWZ3vlVPLiSQO/olxpJK+I/s69np77mWvGnXpXKMHlUJQtS6pY/M12
         gWjGGx8i2ttOfuzHq5jh4ONE9XI3tKCEiOz0I8LZOGUGQBEf73KniukYD8XnFrPo3aF+
         W13Xy1NmmGV+HHZ/VrHJUlHNGpH2o9uiGq3kZx8SgH9o6UN5s5sPoNSf1V/vG3/87zOB
         CpYLG61yjh13moaZwuymD3f9zRSbEZlAgMAv9aj1d9XwwcNRgaC96R+3HTx8x+2hgMSa
         wQe4csDYAsoBYlf2eoHSuVlF4rpQbLK7goBvi7U/a0rZVk7cG5/1VfDz4XlpHAeJHqHz
         kcpA==
X-Gm-Message-State: AOAM530zIhK5/i2hhR42sK0DmE15wF5Ir6KUXn5g/cIn9X5MXvXmeBvC
        SUi+hzCdsZC559p04fn0TejPbsQHI+tz0AP3hUnidg==
X-Google-Smtp-Source: ABdhPJxAHcDuOVlus4gjMRwSFbeAYLv4eiEq85ZPvI766hdWcE2C0hfBadGUAp2NzI/VRs4/2rcp1fFkxQfkI1hZ3OA=
X-Received: by 2002:a67:df93:: with SMTP id x19mr6894195vsk.49.1623779179091;
 Tue, 15 Jun 2021 10:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210615173206.1646477-1-kyletso@google.com>
In-Reply-To: <20210615173206.1646477-1-kyletso@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 15 Jun 2021 10:45:42 -0700
Message-ID: <CAPTae5KaCiXEOdNY-Ct3a0uaCDd8onmtM_bSaGzy0fkooJMC1g@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Ignore Vsafe0v in PR_SWAP_SNK_SRC_SOURCE_ON
 state
To:     Kyle Tso <kyletso@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 10:32 AM Kyle Tso <kyletso@google.com> wrote:
>
> In PR_SWAP_SNK_SRC_SOURCE_ON state, Vsafe0v is expected as well so do
> nothing here to avoid state machine going into SNK_UNATTACHED.
>
> Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
> Signed-off-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 197556038ba4..e11e9227107d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5212,6 +5212,7 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
>                 }
>                 break;
>         case PR_SWAP_SNK_SRC_SINK_OFF:
> +       case PR_SWAP_SNK_SRC_SOURCE_ON:
>                 /* Do nothing, vsafe0v is expected during transition */
>                 break;
>         default:
> --
> 2.32.0.272.g935e593368-goog
>
