Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A6930F798
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhBDQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237087AbhBDQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612455585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oniC19vIHs0GOyeonXQqZoxxZ4D9xyTI9e3aNUHMkGA=;
        b=R5sqHcpoZXqq6Minry8Gq9oCmyjiKgnP5frMdGuXL2cIxtzfEaL8Z0d7GrHI3vL08TYG6d
        6vMQQiOqL6JNnFzMV7ZWomJ41x20ZLU/jzPr87BsWBq066qTnBD/QsOrgzeBqzqgy7IhR4
        xWrt3PYXwNaEEsf8OWRVAUZsvudk4Kc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-hCIkd8OuM6KxG4En1Nc5ow-1; Thu, 04 Feb 2021 11:19:43 -0500
X-MC-Unique: hCIkd8OuM6KxG4En1Nc5ow-1
Received: by mail-ed1-f72.google.com with SMTP id i4so3250395edt.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oniC19vIHs0GOyeonXQqZoxxZ4D9xyTI9e3aNUHMkGA=;
        b=eM0bUXQZeIwSeJwWH+y3h7ILGTNFEWCkp6swmH3agYdt+t6ICDoJDoqsBwipSRxYho
         uV7i82QeNXs6Ik0A2pjCAdjTcShkvavgie70oEd7rUG5VN8E8RarN3/jXmVEFwnyeSXA
         G8HRU7sn5INmEtQ/3uzpCrAkGcOge6M9Xf0bv7mRLfhN941Z8ASfHh7WXVSArMYrjM5F
         g7TRWALQtS6UN+f+cRmhgjaOUKk4hVsFbSRudj2CbhLP7J+iol8hQJf9SDPApley31bt
         8XInXi0jikZg1Y0Wv2zon0i3KI0xs8Mc1gmMz8jHQ/hpkK3lFR3tgfBvhusmFVST+Vxu
         yrVg==
X-Gm-Message-State: AOAM533tN7EU9idDp5X3TqIExVPk6wZuyrY58hc6HbFKR4KMYOfUhueN
        9nUrYI95qK2t8TedMUQEdbHITIZ2lxHlzknAhHlNIyEhWA9/80tG/n4ChWbR/Ihe0cOeqUU1nHr
        lpVVzl29woJpMciYN3fwlY2XD
X-Received: by 2002:aa7:cd61:: with SMTP id ca1mr3134596edb.76.1612455582594;
        Thu, 04 Feb 2021 08:19:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAArxXtNfuS5wkH6IxZvH0OCR4b34syfGKiK4rM9d9z+bZoBZJMjdTHD93a8h+1YeN761Ljw==
X-Received: by 2002:aa7:cd61:: with SMTP id ca1mr3134572edb.76.1612455582282;
        Thu, 04 Feb 2021 08:19:42 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id t3sm2709511eds.89.2021.02.04.08.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 08:19:41 -0800 (PST)
Subject: Re: [PATCH] platform/x86: ideapad-laptop/thinkpad_acpi: mark
 conflicting symbols static
To:     Arnd Bergmann <arnd@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nitin Joshi <njoshi1@lenovo.com>, Tom Rix <trix@redhat.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net
References: <20210204153924.1534813-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2c686820-817a-8728-66e0-cbf1b3e64e2d@redhat.com>
Date:   Thu, 4 Feb 2021 17:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204153924.1534813-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2/4/21 4:38 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Three of the newly added functions are accidently not marked 'static' which
> causes a warning when building with W=1
> 
> drivers/platform/x86/thinkpad_acpi.c:10081:5: warning: no previous prototype for function 'dytc_profile_get' [-Wmissing-prototypes]
> drivers/platform/x86/thinkpad_acpi.c:10095:5: warning: no previous prototype for function 'dytc_cql_command' [-Wmissing-prototypes]
> drivers/platform/x86/thinkpad_acpi.c:10133:5: warning: no previous prototype for function 'dytc_profile_set' [-Wmissing-prototypes]
> 
> The functions are also present in two files, causing a link error when
> both are built into the kernel:

Thank you for your patch, but the issue has already been fixed in both drivers
in my review-hans branch (which will become for-next soon):

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

(note the ideapad fix is part of the big set of ideapad cleanups)

Regards,

Hans




> 
> ld.lld: error: duplicate symbol: dytc_cql_command
>>>> defined at ideapad-laptop.c
>>>>            platform/x86/ideapad-laptop.o:(dytc_cql_command) in archive drivers/built-in.a
>>>> defined at thinkpad_acpi.c
>>>>            platform/x86/thinkpad_acpi.o:(.text+0x20) in archive drivers/built-in.a
> 
> ld.lld: error: duplicate symbol: dytc_profile_get
>>>> defined at ideapad-laptop.c
>>>>            platform/x86/ideapad-laptop.o:(dytc_profile_get) in archive drivers/built-in.a
>>>> defined at thinkpad_acpi.c
>>>>            platform/x86/thinkpad_acpi.o:(.text+0x0) in archive drivers/built-in.a
> 
> ld.lld: error: duplicate symbol: dytc_profile_set
>>>> defined at ideapad-laptop.c
>>>>            platform/x86/ideapad-laptop.o:(dytc_profile_set) in archive drivers/built-in.a
>>>> defined at thinkpad_acpi.c
>>>>            platform/x86/thinkpad_acpi.o:(.text+0x220) in archive drivers/built-in.a
> 
> Mark these all as static to avoid both problems.
> 
> Fixes: eabe533904cb ("platform/x86: ideapad-laptop: DYTC Platform profile support")
> Fixes: c3bfcd4c6762 ("platform/x86: thinkpad_acpi: Add platform profile support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 11 ++++++-----
>  drivers/platform/x86/thinkpad_acpi.c  | 10 +++++-----
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index cc42af2a0a98..6095a4d54881 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -656,8 +656,8 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>   * dytc_profile_get: Function to register with platform_profile
>   * handler. Returns current platform profile.
>   */
> -int dytc_profile_get(struct platform_profile_handler *pprof,
> -			enum platform_profile_option *profile)
> +static int dytc_profile_get(struct platform_profile_handler *pprof,
> +			    enum platform_profile_option *profile)
>  {
>  	struct ideapad_dytc_priv *dytc;
>  
> @@ -673,7 +673,8 @@ int dytc_profile_get(struct platform_profile_handler *pprof,
>   *  - enable CQL
>   *  If not in CQL mode, just run the command
>   */
> -int dytc_cql_command(struct ideapad_private *priv, int command, int *output)
> +static int dytc_cql_command(struct ideapad_private *priv, int command,
> +			    int *output)
>  {
>  	int err, cmd_err, dummy;
>  	int cur_funcmode;
> @@ -710,8 +711,8 @@ int dytc_cql_command(struct ideapad_private *priv, int command, int *output)
>   * dytc_profile_set: Function to register with platform_profile
>   * handler. Sets current platform profile.
>   */
> -int dytc_profile_set(struct platform_profile_handler *pprof,
> -			enum platform_profile_option profile)
> +static int dytc_profile_set(struct platform_profile_handler *pprof,
> +			    enum platform_profile_option profile)
>  {
>  	struct ideapad_dytc_priv *dytc;
>  	struct ideapad_private *priv;
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 18b390153e7f..42e0a497d69e 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10078,8 +10078,8 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
>   * dytc_profile_get: Function to register with platform_profile
>   * handler. Returns current platform profile.
>   */
> -int dytc_profile_get(struct platform_profile_handler *pprof,
> -			enum platform_profile_option *profile)
> +static int dytc_profile_get(struct platform_profile_handler *pprof,
> +			    enum platform_profile_option *profile)
>  {
>  	*profile = dytc_current_profile;
>  	return 0;
> @@ -10092,7 +10092,7 @@ int dytc_profile_get(struct platform_profile_handler *pprof,
>   *  - enable CQL
>   *  If not in CQL mode, just run the command
>   */
> -int dytc_cql_command(int command, int *output)
> +static int dytc_cql_command(int command, int *output)
>  {
>  	int err, cmd_err, dummy;
>  	int cur_funcmode;
> @@ -10130,8 +10130,8 @@ int dytc_cql_command(int command, int *output)
>   * dytc_profile_set: Function to register with platform_profile
>   * handler. Sets current platform profile.
>   */
> -int dytc_profile_set(struct platform_profile_handler *pprof,
> -			enum platform_profile_option profile)
> +static int dytc_profile_set(struct platform_profile_handler *pprof,
> +			    enum platform_profile_option profile)
>  {
>  	int output;
>  	int err;
> 

