Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3DD3280C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhCAO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbhCAO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:26:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E8C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:25:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h98so16333528wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X2/PgO5ix3NUkBOmnRuFwm8LNnKDiRK1SIKp9wGbngw=;
        b=ENGRTt2txV8DN3YdjMyB6zQJIttWsGlUE//WgTQOqYriJkWJoHOxQ5XIAXcIMXfjut
         pnk1VqJN4a70t9V1TXlOsruqGoOYm+k83jdF6hhzWbyUhFOXnuOmUb0T6AkYgRiWoJbe
         oU6mP8olWTsiUTeBhai7hVSgVz/f8wOdsdfDn54ajji3AlCXFz0rcxWqMtlQdAW5JnXv
         s85dsh9JpsrJbpD+Mjj90iZMfhoCB1eEC0J/OlyPpAvLP0NwrzOEjUmvP/xvXUFW5KCc
         5qDsI8asyRDDtm8AE6K+ljdRP2q30WPYcfuG+2rGBBzQ2yvbBGBPSYiSB0uIska1/Fz0
         7w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X2/PgO5ix3NUkBOmnRuFwm8LNnKDiRK1SIKp9wGbngw=;
        b=dB6y4DndHcWdWozneRZJEIqdjltBogjqNxvwzvLWckeGlM2dXqb+CXgpcETV60t292
         YG9ovgzTTxFjFels5h5Lqzgetm9F+hlJd/xUQMWnLAzmkLQOe3DmeRSFPfvlVngT5YGD
         ll53gZf9ekPlThM+aSdSkZpTu1H6fOwGCwi6XpF2um7pu4Pup/hlLsXqFe3SOT90m89y
         4f7XUpEV5M0OWIAGvOybJP1I3eLDHK8HIZZhyYaaasg89+LVSx9iPKA5KcfO6NpoQ+8h
         rN+G17wWfinqlj2dBKPKiQas5FkuNz1QDM+SQKjziMtmEhBWr1agSYxfUZvCYg49mYuK
         G0Nw==
X-Gm-Message-State: AOAM531bNqRD+4oHQMJcJKF2oC3cFCqDmWfNCqXTE3OKb/aQy9nWaIlf
        SffNOtIKMhhbH6cOyTI7POw42Q==
X-Google-Smtp-Source: ABdhPJzjKF6y/gkvaarT/Sdr82Z3e1yRwOlOrfxh7GZ3WMftiA2dP/d3TrTZfKBVnJjxoeEgUamXqQ==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr17106581wrm.291.1614608728182;
        Mon, 01 Mar 2021 06:25:28 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id 1sm2822651wmj.2.2021.03.01.06.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 06:25:27 -0800 (PST)
Subject: Re: [PATCH v2 08/10] clocksource/drivers/hyper-v: Handle sched_clock
 differences inline
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-9-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2c320759-4e0e-752f-f3e8-7594cc1d544f@linaro.org>
Date:   Mon, 1 Mar 2021 15:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614561332-2523-9-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2021 02:15, Michael Kelley wrote:
> While the Hyper-V Reference TSC code is architecture neutral, the
> pv_ops.time.sched_clock() function is implemented for x86/x64, but not
> for ARM64. Current code calls a utility function under arch/x86 (and
> coming, under arch/arm64) to handle the difference.
> 
> Change this approach to handle the difference inline based on whether
> GENERIC_SCHED_CLOCK is present.  The new approach removes code under
> arch/* since the difference is tied more to the specifics of the Linux
> implementation than to the architecture.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---

[ ... ]

> +/*
> + * Reference to pv_ops must be inline so objtool
> + * detection of noinstr violations can work correctly.
> + */
> +static __always_inline void hv_setup_sched_clock(void *sched_clock)
> +{
> +#ifdef CONFIG_GENERIC_SCHED_CLOCK
> +	/*
> +	 * We're on an architecture with generic sched clock (not x86/x64).
> +	 * The Hyper-V sched clock read function returns nanoseconds, not
> +	 * the normal 100ns units of the Hyper-V synthetic clock.
> +	 */
> +	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
> +#else
> +#ifdef CONFIG_PARAVIRT
> +	/* We're on x86/x64 *and* using PV ops */
> +	pv_ops.time.sched_clock = sched_clock;
> +#endif
> +#endif
> +}
Please refer to:

Documentation/process/coding-style.rst

Section 21)

[ ... ]

Prefer to compile out entire functions, rather than portions of
functions or portions of expressions.

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
