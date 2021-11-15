Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06E4451C36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356207AbhKPAOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhKOWuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:50:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B7C03AA22;
        Mon, 15 Nov 2021 14:01:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m14so78583695edd.0;
        Mon, 15 Nov 2021 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5HscGTHZr6+xi1a6alcJPyjhjUoDbOBDFHoUw2L51o=;
        b=lIwqy+vraVBs9t40KMt6lhKFZG5nM6cLoF5A3AalVN0hTJVgNQuGGORQjwEvumUGle
         3cBQqlcv3mrjNG4FORxmkRbj40heghE0+RhCPQKKTD6lhlmZoFqjGg4wNUp8ZnWgycRY
         VsEQ2BtXzKXDyd4CAynzjijP4NH5DJ0zidKOLplWjaY8mm4YB8HjiZpAycdaGTsO4nsY
         bbr8nrgw4lIoLE4KhmUO/UHtoRbNv0OEFhBv3N118wQZKlF2o0BO9mRQuLP/AXXx4Zmv
         GNOR1UehG3cqPMbiuzhj5PziQmILouBLerjvgdVW02Pq2oPz5WfmtGT6d/ZnPTlE7xBu
         G9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5HscGTHZr6+xi1a6alcJPyjhjUoDbOBDFHoUw2L51o=;
        b=zpt/zCPr30PQzij03dyQc6LIOl08FJqeM5Y9pQhlv33I9YBa7SBSh+9+jwfKK84s1k
         JQn5Q/Zd6/pL8RwVjJ2YNBUga+pFeavGLXBYeVUt1h8n8KAtdXOio5VXqbztkkISdidw
         Whu4U9XvONGbw2o1ZpKFFrGWlsqXdUrkTsu88Abh28QymZtlD/wq9y4Nq/ZaEgL8rC+q
         LRV187tXrZq/nxyNH740VMA3Cv6LshQs7AZCwf+ikDXpW4z6HpsLe5RuYLjcfeN8rcJ9
         y6+jmy/HTKYDuc8HlmRUB9hGIrCKoUweHlr0G+yZS5gtXVsAxiy1GW0rlTm0NYHaG2Cz
         dr7A==
X-Gm-Message-State: AOAM5331GVX9yVWry9be2hHZ8IIhGWVOU+hLmsnaeNtxONzR7e9wZMGg
        oRUvGUBLAFPTVWe72zFVgMR1ef4xt/TZAJtqzRdTR10xpfc=
X-Google-Smtp-Source: ABdhPJz3pWyThL+n+5rrtc+iEasNam2xwC2mel1/qlNmbMzGVGsIC0sscKWK8fGf4NLo2ipGveze1EYD5q0o+3rvvGM=
X-Received: by 2002:a05:6402:26d4:: with SMTP id x20mr745600edd.119.1637013718460;
 Mon, 15 Nov 2021 14:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20211115210842.11972-1-pauk.denis@gmail.com>
In-Reply-To: <20211115210842.11972-1-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 00:01:22 +0200
Message-ID: <CAHp75VcPHi1XyZr=CFbUhiUXK0q-10iBx5U3d==aG8pMG27k1Q@mail.gmail.com>
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

Guenter, what is your plan about this patch series? It seems it
missed, by unknown (?) reason, the v5.16-rc1 (I remember seeing it in
some of your tree branches at some point).

-- 
With Best Regards,
Andy Shevchenko
