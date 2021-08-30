Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6993FAF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhH3ALq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3ALm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:11:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32987C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:10:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x16so10826649pfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZkYaX04SJTyAmZBjQ/RTl7EwzMqBzGjroEaq47D3eg=;
        b=j8xlsQ7+PPpnH6Xv+zC1Lfs4ooIwmE0wnR3RPVEFTaSE5pCSs4qbaQrQ6JE5eeR07U
         mDbwRnSjnlkiINnueu+4McCKH7Som4jjpgTl8CMKApXSm1rvMSOW7P3/PARgn6a3RHDk
         jOxPIaCB6TcGZZgZtgeDqsmfb1TVbnzGF7vq+61FmB7GCo3b+s98QscO1cr3qpeM9TYy
         q2ttzwZGGRri3UkkDRsItpAMSzRYmYOEQ39Vs2sBuvHpos0BfGK/bZr+joUkeBPEbwxJ
         PNkHz2joSIMUghlZs2s8LgDyHKV9NK+A2JT4m7pbXLgWKjFRCGfNYGRTzjMmOzf8SG6z
         r3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZkYaX04SJTyAmZBjQ/RTl7EwzMqBzGjroEaq47D3eg=;
        b=VEphabZq3pNP3DkKp4ZNIiboLyHnEN+WKC4ky/gL6VTNrnPnfuQMQWLJob0bSIDghp
         XGt9IFYX5OEKkLUIx4GsTT+hYc63V7vQJE7eazK5pFWj7RiL/Jm46EzbFmsFibkOnKNf
         ycSK9WpIXd7Ctyty+bokLGdBdQeOzWGrRLmDivuT3VK9RgsvIG/h0jxHMG8r3lZOCEXz
         18MX0YVAvWr/higaB+HTDSfUYL2iuzSRKnoSvyjXwDeQglyiMCArxSagLtvFjw4m/47N
         tufS+vDAWVQR67qHONCFGKMzeDrgEAXp7CZ+XbxcSF9pChKABS1eOJQF/T9NFA1XUEnk
         cdpg==
X-Gm-Message-State: AOAM5333HMvuhDRvfwH2Y8giU4Psm87iCcEQr8j8Q5cYlbEOb+AzEmyo
        OlyyVViQZHuU9s0wWa1726Kykr8bCOZO3mctYzHNWr5hZ9Q=
X-Google-Smtp-Source: ABdhPJyu6/3V9eKmnpx2uQta51qEI07S6kAqMlt2R+lW/WPOU77bfxXCGRpKT3w0b+0RdjidcXTvmhVpMGNvOQvBXJ4=
X-Received: by 2002:a63:aa43:: with SMTP id x3mr19197570pgo.208.1630282249796;
 Sun, 29 Aug 2021 17:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210829092502.3658-1-straube.linux@gmail.com>
In-Reply-To: <20210829092502.3658-1-straube.linux@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 30 Aug 2021 01:10:39 +0100
Message-ID: <CAA=Fs0mWAf9T=QtMA6=kF2kYNb96teAYG=zeg7SRNhJqWcMxHg@mail.gmail.com>
Subject: Re: [PATCH 0/6] staging: r8188eu: remove unused functions
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 at 10:25, Michael Straube <straube.linux@gmail.com> wrote:
>
> This series removes unused functions from core/rtw_wlan_util.c.
>
> Michael Straube (6):
>   staging: r8188eu: remove rtw_get_oper_bw()
>   staging: r8188eu: remove rtw_get_oper_choffset()
>   staging: r8188eu: remove get_bsstype()
>   staging: r8188eu: remove CAM_empty_entry()
>   staging: r8188eu: remove is_ap_in_wep()
>   staging: r8188eu: remove should_forbid_n_rate()
>
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  | 91 -------------------
>  .../staging/r8188eu/include/rtw_mlme_ext.h    |  6 --
>  2 files changed, 97 deletions(-)
>
> --
> 2.32.0
>

Dear Michael,

Looks good and builds/runs fine for me, many thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
