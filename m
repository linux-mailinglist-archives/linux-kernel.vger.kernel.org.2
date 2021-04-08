Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1932358136
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhDHLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhDHLAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:00:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FC7C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:00:14 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z10so1638718qkz.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+TrzxkT4/pA7rMQQxNc7F6VDz/UlBkQcXIzCh88OTA=;
        b=D3UR9940CV9rltT6/fFsIjXanARdK/eK85Xf8Au4dYngOeXc7iHwoqKr5YlY92TDdi
         CmXxtFy95BqX1L1vdxjzhirGsSEIGHdcUg9yZmO/P5ndhRKF8zaIWNNzrfN47WbplYxL
         QRWEG1Vgi7SjMC/TjOtT4DxcUq6mOfjvggdxqHnFZUMDIgex08jvXKif3futWNAznzUg
         XH1XFsOmWn5tfKwiAl+JXxSYrT4WBiUR8EvQNd3QK8sjHoXWvV6YKchOHpeltywcqJf2
         THIfUK5haKrl9jHE8k0VZ7/j3GeMF7/kTj2ePOmNO+HxZnQAf/MXUjinJrzUF4U4kTkH
         dGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+TrzxkT4/pA7rMQQxNc7F6VDz/UlBkQcXIzCh88OTA=;
        b=Z9H9HYRgpLA9OzBjJAmsntm+3u3MXa4nksJEBqDsZzALVTfTAK68VXR0mPWlk8rXqp
         BbcpD42ZoDHGzjTbu4FkyU2dwAxM3K1DwVe1wkyYbnF5sLx/nBaY6Xp+2Fhw/VQznKbE
         7pmrQOxPAlDs20p1hXYlEuNTk9C0GIe5RC8MT76FWzhC2a14hc+TVO4LWfR5uVSIIDmE
         eW+SrfS+2QbxMLDb3c4C6afb1WulCvPnEmQwkie8bzaIYYgWoAGtyeXOxZeR9yJeHAsa
         /8M7S6uplYY/d0m4wtS6KZW4GVIRdgzw0lg/rQc87s/w3GXBT2HpY1M8xAeI8EY7Cifl
         OdQw==
X-Gm-Message-State: AOAM533ibmi0dLRee7nZDaOeCDpktoa/odT/vi91eeb7Iz/JkwaAznL9
        niAJc+t1a97qK4hNOjjDOGJO0lHY6POGKmXbsHQ=
X-Google-Smtp-Source: ABdhPJwyvhz/YUOWJ7RzFYYV0oYX078qwfM/1ORcl08CB6mnDlEx7PbfhbtOQV3ArrOjadzM5yjVGggRhcCCEvPyx/8=
X-Received: by 2002:a37:b947:: with SMTP id j68mr1922844qkf.108.1617879613854;
 Thu, 08 Apr 2021 04:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210405152935.148129-1-rsalvaterra@gmail.com>
In-Reply-To: <20210405152935.148129-1-rsalvaterra@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 8 Apr 2021 13:00:02 +0200
Message-ID: <CAFLxGvwhtRY-6kT-sN=AgjvyssHb5qdTS6WQHkhKu3YrPuTkdw@mail.gmail.com>
Subject: Re: [PATCH] ubifs: default to zstd compression
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 5:36 PM Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Compared to lzo and zlib, zstd is the best all-around performer, both in terms
> of speed and compression ratio. Set it as the default, if available.

I was about to NACK this patch but by looking at the diff I realized
that you change
the default compressor only for the default filesystem as created by
UBIFS itself.
Queued for the merge window. :-)

-- 
Thanks,
//richard
