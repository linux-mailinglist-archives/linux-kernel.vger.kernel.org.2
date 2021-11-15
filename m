Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4E451C35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354630AbhKPAOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353633AbhKOWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:45:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F13C03541C;
        Mon, 15 Nov 2021 13:57:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so3306916edd.13;
        Mon, 15 Nov 2021 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvyiadRjQFwMqBDW2HZACcIdD60C/136xSZs3Xg+PHM=;
        b=FPDltK+otNSvuYyZEki/zSdAvNkqiObWvMh+ivnYS7uVr6q/d0kST+4hbf6MzuR05i
         q15o9gTDL1CH1LC1wXxLgNs7sJM3ufwi3xw32K/AWxqroncrf79KIiTmVZlwy2J+l6rE
         7XPH7KwFfWst2ccP91lKL9I6i7ocj1XMhopOInZ8ElcxCEiUQ+kST3xvFrXe2xJTXlSk
         sLOg0fZMadvkkBsog1QlFSSED3u+YZ8iqpD6XLoVdcP5HNo4Z9QNXSgAOcHV2TIZytcD
         NOHxEgmi9KruZC1vK2KaBVyY6Nw0wm0hHRMDouhhWPIuw9Z5BoP2A6lI2i3G91Vut9oL
         rbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvyiadRjQFwMqBDW2HZACcIdD60C/136xSZs3Xg+PHM=;
        b=Y3iXES0qDUCEvKJ4vgfC2FogmkNXDcak8j42Pkvv1dgbGi3SnRkQy+i93dtqhBbXmm
         fmjwj8kstKIfqyZNorTCyrNn11TbhQojXCmLADR6N33ApRG1zyRbluw6qahXB/+y3WvX
         THU+D9ZxjK/p4E8B6kx6oenVUlQbRTH7zcd1OjvDadRe7uge/zJgbLLvp2EDsNaIv94c
         F9M8nZJJmf0UCpA2YfXByUr8HwYfjyScyuQiNOogqGny4Alt7Gj0r4kN+1NnbaU3d3Fq
         OflyLMt/Lrt19CxFWNJxVsRjHTWZGcrOte69If9edCNxD2MAmbDGCbkz/OJhZ9YuyBpM
         pRuQ==
X-Gm-Message-State: AOAM532rB9qRX++U5OmEG++/tgEa7owKs7pE5+Zg6QhXqDlrs+liou93
        ktEoOIEWhbmq3d4vLL/YSGfadWyFNFoKyOUuNopkE2kGUo8=
X-Google-Smtp-Source: ABdhPJzVBj5iBxwoNYmyvUFm6rLK/oL7LbNivZi73ZzN9kWZAqKp6LJ/3PpvXHnSgShRj5C2YT40ifVpiFtlOgYm05I=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr2864383ejb.69.1637013448795;
 Mon, 15 Nov 2021 13:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20211115210842.11972-1-pauk.denis@gmail.com>
In-Reply-To: <20211115210842.11972-1-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 23:56:52 +0200
Message-ID: <CAHp75VejhcYarbMLir6H1TUfSkCzS7vNDipwj1eppRHoeP2PaA@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] Update ASUS WMI supported boards
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:09 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Add support by WMI interface provided by Asus for B550/X570 boards:
> * PRIME X570-PRO,
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-I GAMING
> * ROG STRIX B550-E GAMING
>
> Add support by WMI interface provided by Asus for X370/X470/
> B450/X399 boards:
> * ROG CROSSHAIR VI HERO,
> * PRIME X399-A,
> * PRIME X470-PRO,
> * ROG CROSSHAIR VI EXTREME,
> * ROG CROSSHAIR VI HERO (WI-FI AC),
> * ROG CROSSHAIR VII HERO,
> * ROG CROSSHAIR VII HERO (WI-FI),
> * ROG STRIX Z390-F GAMING
> * ROG STRIX B450-E GAMING,
> * ROG STRIX B450-F GAMING,
> * ROG STRIX B450-I GAMING,
> * ROG STRIX X399-E GAMING,
> * ROG STRIX X470-F GAMING,
> * ROG STRIX X470-I GAMING,
> * ROG ZENITH EXTREME,
> * ROG ZENITH EXTREME ALPHA.
>
> I have added "ROG STRIX Z390-F GAMING" to list of supported boards in
> asus_wmi_sensors.
>
> Could you please review?

> Changes in v11:
> - Add "ROG STRIX Z390-F GAMING" to list of supported boards in
>   asus_wmi_sensors.

Is it rebased on top of v5.16-rc1?

-- 
With Best Regards,
Andy Shevchenko
