Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F773D2FED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 00:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhGVV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhGVV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:59:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64597C061760
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 15:39:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so1231616pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=464kg1T68pC5HwMKv9Atpe0ec1sq9kytcANNnpthBek=;
        b=yS/hsbwawQ19QCicvuWG6QDZq0p315I7hOo/EtTmA9IHLQNCHUWlv+iOFl/Ly8W4T5
         0At4dkxFnyw1F5/AMAwjsjEFAkxOfYyPOBGS68vy6pk+r1+FsG+aiaoCRqPDaUOgvOYR
         umlEpbfBd0uf4HJQW1eWcFo0U/E7ZEKM7dhGKoTKtOhLFRsvJuzYzCPTTHqUDYYn3v0w
         eQJ/PNeDz9gPOhSvqVHwbuSjw3XMo39aqPtmFh5bz0IRu7dxG1b4MNwJXV98y3vClhJL
         CBDYyPrdKoijtYt2L8LNvOzvKuOX8msDMvBPxhomXUOhvDxXbB9/YJjywRsXe0l8PMht
         Q3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=464kg1T68pC5HwMKv9Atpe0ec1sq9kytcANNnpthBek=;
        b=l4u4l/c5KoeQAFY1EGMOUS1akkcz3OE8pD32krRNqp8GliRXI2EI8CPpaPOox5op9W
         9vk9c1Vh+jZW3WFtCuy1vq4pKqKFzxT3caelCIgb6JWo8MIDIG8P2KP3V7VCPXfVzRqy
         6cge94LOkdCOSlSBBmTUMYwt/o+Pbzti4b+cvMoGHa6enXDWEpcUGFJrDyd+EBQDy7Bs
         xw57bgsAUWebk5v++sPPUGOA8QDlAeaG2PuIfQg447d1kyJNIuWFpLXE1QdI8DBDGWJK
         QFeUGOwU7mcpoqNgGnZQq7KMj4p7gGKoFsIeVgp/sF0nsrm64aNgN8HL+U3IGjwONiNR
         SGfA==
X-Gm-Message-State: AOAM532iobsR20XfyWGzTos40YvxlprvBTv76NjbGN0TKBDD+PpZICNr
        zh0XfhQCjdNxaBNcnRextclp2Q==
X-Google-Smtp-Source: ABdhPJyDUgyzv99y/lDZIzirOw2rLLLDML8ftb5T/FAs9qRdcruNT4j6gmNAEv7kfBkJ19Tk0Oil2w==
X-Received: by 2002:a63:1718:: with SMTP id x24mr2084278pgl.416.1626993583767;
        Thu, 22 Jul 2021 15:39:43 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id g123sm30673812pfb.187.2021.07.22.15.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:39:43 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:39:39 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, shuah@kernel.org,
        akpm@linux-foundation.org, rafael@kernel.org, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        minchan@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: add documentation for try_module_get()
Message-ID: <20210722153939.08a6853c@hermes.local>
In-Reply-To: <20210722221905.1718213-1-mcgrof@kernel.org>
References: <20210722221905.1718213-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 15:19:05 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> +/**
> + * try_module_get - yields to module removal and bumps reference count otherwise
> + * @module: the module we should check for

You have the right intentions, but this patch needs some work.

This looks like a docbook comment format but isn't that format.

The first couple of lines need to be reworded to be a complete sentence like
the rest.

In general best to make new comments the same as existing comments
in the same area.

It would be better to put this description in the header file where other
docbook comments for module API are. See example around module_init() and module_exit().

Ideally, all the api's around module reference counts would be documented there.
