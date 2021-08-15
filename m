Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A505C3EC9BA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 16:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhHOOzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 10:55:45 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:44882 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhHOOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:55:44 -0400
Received: by mail-oo1-f46.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so4246878ooa.11;
        Sun, 15 Aug 2021 07:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f8l9oZv28TiqI6VRulUBTT8+qVD3OhbbMEck62PbzKM=;
        b=ljegjj5iK4Rcj9gxtDr8dmihoz2MzsffREeCu1UrAlVhTFIrcaYdQ1kJJu/hjSr0+C
         g8fCigNstjtb0LF3ArPspHMQwjLrr+jHumauh77zChgjJq6Qj1EYp4tO8d1ojX8rvmyb
         SZqUfbx27ET4cb1pLwl28TFtKnA0KAqXUSbYAqkr3YbR++TIr3PQV8QTiTQdPYW5g6Rs
         0xk39Vbo8hKlh/oNNzYfkjh6EkcXIC0to3H03+dB3BTOROKBrmyobQsuXauGOHqcIn1K
         1nhc3LLMW6Z+Pv5TFK/3m9KiToBKPvcr6917m2YHpvdkjWpA9EzqzgSi87uTgvnbtbaa
         sf1w==
X-Gm-Message-State: AOAM531rVk55BaNWVi0RT2yZOCZff3wwZrfssZiooflXOxAJGf6SCOf+
        JkBmeEKF2NvqseU5bJckww==
X-Google-Smtp-Source: ABdhPJylIN5hf+T+hqQYVqEk2flejPOi+qgupn5GswXu8ylLQjJO8MfZKOdxJBHm4ww+njk23lCLtQ==
X-Received: by 2002:a4a:9464:: with SMTP id j33mr8544958ooi.5.1629039313737;
        Sun, 15 Aug 2021 07:55:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q13sm1464600oov.6.2021.08.15.07.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 07:55:13 -0700 (PDT)
Received: (nullmailer pid 3721188 invoked by uid 1000);
        Sun, 15 Aug 2021 14:55:12 -0000
Date:   Sun, 15 Aug 2021 09:55:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: fdt: Remove early_init_dt_reserve_memory_arch()
 override capability
Message-ID: <YRkq0BqS0u5eNcHG@robh.at.kernel.org>
References: <be0140a0183ecfd0a3afa4fe6d2d77ed418102f9.1628671897.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be0140a0183ecfd0a3afa4fe6d2d77ed418102f9.1628671897.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 10:52:28 +0200, Geert Uytterhoeven wrote:
> Commit e7ae8d174eec0b3b ("MIPS: replace add_memory_region with
> memblock") removed the last architecture-specific override of
> early_init_dt_reserve_memory_arch().
> Convert the common implementation from a weak global function to a
> static function.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Should the "_arch" suffix be removed?
> Similar commit 0fa1c579349fdd90 ("of/fdt: use memblock_virt_alloc for
> early alloc") did not.
> ---
>  drivers/of/fdt.c       | 32 ++++++++++++++++----------------
>  include/linux/of_fdt.h |  2 --
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 

Applied, thanks!
