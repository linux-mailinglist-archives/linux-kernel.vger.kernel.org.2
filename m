Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2426139D555
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFGGtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGGtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:49:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224EBC061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 23:47:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f17so9265953wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LyNlPC6SvU+YECxldU/+nmnU2jmNOyDHdj+cAyQpUdQ=;
        b=VNnDBdIbSunXj3BlZ20vTALlSHAbmEgZ0P4e7WN+Fz05Uvxt8m8HGXKiGwkzzpCE3X
         CxLs8IjCq+tUrreQj+uBMoejPEv/58BXgxKqa6lq50AKlUNyS6P1jNIujZ2xccnLIjQB
         GpbR0zi83u2ihVdCFzb83nw80R9uvgl8j80kiTE0p+aedodkKd1WONg5u5NVbKXeoQIH
         LPp6uQP4Z13v/g4GMSY667/PUOW0RFxd5IH+8t3L2en+sH2JEaVx5cpFSj1ZnM5oMaFz
         hbQMxetCdXkk9rZfP/S3i9o3PeElGEIa2TagZzlMsfcFu1En6pimn6Ybd5hwo1lUM6Rz
         Maug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LyNlPC6SvU+YECxldU/+nmnU2jmNOyDHdj+cAyQpUdQ=;
        b=S8ErFfMJ3MQCfvwwT/79euFcXwdkuXeSvPq9N71xzu9wpXp8yVsA64jYR2FFNaJjT7
         ZUrjPqm3mA6Ll/wk+0ibSHjWpiM0VWulHMRE6zrDfdcwT7AXrxKHBOjlJ0yQ3Us4nuPr
         nXKSO0oUAPcIoMiAGu0CyWr4QLXT6ZUf+6FD0oxFv00zLXaWQggkS7fvrnUFVm0AfI2/
         eOo8Ms0jI71pPH4mvM7qsq+uXxXwSlur45/Lp/ui+IZiuFX/GeCXGM6pIdzWl9MYz/Ue
         zsobbM1Y6c84eg2CRpTUhs3R3+vr/7WqKxzf+MYJwbHhkWajU/O9AKMl1K1NFo4SSM38
         CaIw==
X-Gm-Message-State: AOAM531NVy6Ny00pzgs8JRNh14O7IlxXwurIlFUXnz61PBoVl1v71CEk
        GTlPBTaJlPxkj0SeAeGpj3MMJqu61TTg2L1g
X-Google-Smtp-Source: ABdhPJw5EbYL7clbh4WzOVLWSO8ZoKWq7YxoCQjQVjk/WAJdMjJGM4XQe8l11NIDxs+AOBU4fst2Cg==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr15133013wmp.162.1623048419104;
        Sun, 06 Jun 2021 23:46:59 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:7c1f:1c9f:555e:7398? ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l31sm1655289wms.31.2021.06.06.23.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 23:46:58 -0700 (PDT)
Subject: Re: [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is
 disabled
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210601084830.260196-1-narmstrong@baylibre.com>
 <YLoHSJIOSRTyF0r1@kroah.com> <20210604150742.bssvnhm4gv72uw4h@nitro.local>
 <20210604164601.hrlgkrsghhqtho6m@nitro.local>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <66daad75-3340-bc11-1f6f-32bbb0b2e3fa@baylibre.com>
Date:   Mon, 7 Jun 2021 08:46:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604164601.hrlgkrsghhqtho6m@nitro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2021 18:46, Konstantin Ryabitsev wrote:
> On Fri, Jun 04, 2021 at 11:07:42AM -0400, Konstantin Ryabitsev wrote:
>>> Odd that DKIM didn't work for baylibre-com, but hey, I'll take a real
>>> signature over DKIM anyday!
>>
>> That lookup happened to grab the thread from linux-amlogic, which is
>> mailman2-managed and is known to break DKIM. I'll try to fix our configuration
>> so that known-DKIM-friendly sources are given priority. This way, when a thread
>> exists on multiple lists, you'll get the one more likely to pass DKIM checks.
> 
> This is now in place -- lore will now prefer results from DKIM-friendly
> sources. E.g. grabbing the same message-id will now return the thread from
> linux-usb (via vger) instead of linux-amlogic (via infradead).
> 
>     $ b4 am -o/tmp 20210601084830.260196-1-narmstrong@baylibre.com
>     Looking up https://lore.kernel.org/r/20210601084830.260196-1-narmstrong%40baylibre.com
>     Grabbing thread from lore.kernel.org/linux-usb/20210601084830.260196-1-narmstrong%40baylibre.com/t.mbox.gz
>     Analyzing 4 messages in the thread
>     Checking attestation on all messages, may take a moment...
>     ---
>       ✓ [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
>         + Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> (✓ DKIM/googlemail.com)
>       ---
>       ✓ Signed: openpgp/narmstrong@baylibre.com
>       ✓ Signed: DKIM/baylibre-com.20150623.gappssmtp.com (From: narmstrong@baylibre.com)
>     ---
>     Total patches: 1
>     ---
>      Link: https://lore.kernel.org/r/20210601084830.260196-1-narmstrong@baylibre.com
>      Base: not found
>            git am /tmp/20210601_narmstrong_usb_dwc3_meson_g12a_fix_usb2_phy_glue_init_when_phy0_is_disabled.mbx
> 
> -K
> 

Nice, thanks for this !

Neil
