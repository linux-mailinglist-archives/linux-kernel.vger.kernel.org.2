Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279DF43E52C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJ1PeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJ1PeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:34:11 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:31:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bi29so6181472qkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/lP7m9bbtZLyZMl0xJejkjX8uxw1IBdpAgTmoTpUPo=;
        b=I3TQsGq0VpPhQ805uRgShUYrWSAvwSSBInQuey7BQboUtWdtj1Zr/V9CEbMJMs/smC
         +SMGqBX+xvVZZfiS3Bp3SkDHKbAqmpJXuTDpyhI04KEIbHdaaasA3xygdfAf9PF4cMRg
         iy0JfEESSGd6wKIpieJGJt+oYSsXvZpgA+pEu+uexDXP24qTGos+Qsf0Gr6VA746K1nB
         zSp7O4es3lRqlbmj3f/IW6RtpEhRKuhFhhouIm88jJ8Z4/QwAoMw+aChTrfuNI/hsN8N
         Zhygep4RIFZttBmpA4st9UbrUXdGPUgJNG66KYgeML1P1kUoIK1MZnlCzSbayVS73GYi
         s+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y/lP7m9bbtZLyZMl0xJejkjX8uxw1IBdpAgTmoTpUPo=;
        b=wACSu4YJKlYJkGJPmmYhduS8l0/a8aIAFKXfXKMlYsG9brLSxLk7jRv0gmiYCmqc1S
         3rknakALyNVVKuIadrCXIpst9A+QCVOjuvuwHO/hGms2JzNoqYbTKog/Ro6wOZfDWJ9w
         JSuh2RQOWoPFKK/BN0PwP41W7gdKavCiqVhdnjgp0Unp0B5214GG7900eENUu85fDx5Y
         2WDFMZAkvDRVMOqgdagbYlaO/mewMWIS/VsPUhjmI4kpa4uVp+Jamru15cKrtkfeTmHW
         +x75OW4HLAIW3J1cKpyrjqOeUbPx26lVuw7CCcWXyngzXeNuAtVRRICQi/69rq+aiP7h
         TWIA==
X-Gm-Message-State: AOAM530OSvB/DrZLac24y7oH0zTS+i2f/+OEXPl6AykEgl0sjxSiM0cy
        5PlcPVkckVOW0oHcKwK4Evnq7QfLVLuEy8NETI0=
X-Google-Smtp-Source: ABdhPJzUm0SFvgE1v+CNg4ecX/n6nOxLRysU/p4DGZ2CYuoo8oKnw4YkZkZTicWfWUl11JjrSkbG/g==
X-Received: by 2002:a05:620a:1a88:: with SMTP id bl8mr4130188qkb.252.1635435102954;
        Thu, 28 Oct 2021 08:31:42 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id b2sm2101304qtg.88.2021.10.28.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:31:42 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     vijendar.mukunda@amd.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        fazilyildiran@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Subject: Re: [PATCH RESEND] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_DMIC
Date:   Thu, 28 Oct 2021 11:31:41 -0400
Message-ID: <13689627.qBTK4F9haW@ubuntu-mate-laptop>
In-Reply-To: <6ff76018-309d-349e-691a-f504ca29420e@amd.com>
References: <20211027184835.112916-1-julianbraha@gmail.com> <6ff76018-309d-349e-691a-f504ca29420e@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For Renoir platform, DMIC driver selected for registering codec dai with
> ASOC. No additional functionality handled related to GPIO.
> Do you still see necessity adding GPIOLIB dependency?

Hi Vijendar,

While most users are unlikely to encounter this, we still do not want unmet
dependency bugs in the build system. Adding the GPIOLIB dependency just ensures
that nobody tries to build an "illegal configuration" of the kernel.

- Julian Braha
 





