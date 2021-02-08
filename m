Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7731424E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhBHVwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbhBHVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:48:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4061EC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 13:47:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fa16so352778pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 13:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uyNRXjP8PoRzxJ3b9CeeV9gZlL+DbiBOjxyKvOLiT9U=;
        b=PPjXg9RdmQyMqlqIQ2hrpgRRc0/akV0XWh2LKe6EZdlOnZTgFN3I9qtS0VLJpiZXLH
         hsPXTdjvu6lc1xmlEQea9UfVKPDStCntBuOSjmZAxdEhXlpVaRz+0fWg8lqI0bf9u0yO
         1ZgTcYW8QaiW3sbEBLzJtL0fKZ78WrVcMNnHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyNRXjP8PoRzxJ3b9CeeV9gZlL+DbiBOjxyKvOLiT9U=;
        b=gzJUcFYmUlSuZn1aGPsEPKtB4+w2ETCmQWB13h6CX8bLV0HVLjSjmuUpK8plcZ/TGC
         wCsiymBTQjEsMhQvYYo9xFIn8G/Ux/qpXBw7JiOO8mpzvK/dyHOXV0esbzYNwU8VOtuj
         9h/0N864xXmOn/B6cgPrvvWDZIJFt8jMRXzddCfvHNimBmvMFYhQLUhM+KwKCrld7M2+
         ObVnHsrsNXbLpjnu10bh2lTHawznwvLq0lFrhJUbkb5NVIOGtsbGN5BKVa8pEvRkpGv7
         dpapAUhKqpfnj1S8b6w4zOddQL63MWyfcXA76UnQZEztecTw4Q++pFZ7rfcWOzA3GHQR
         uKmQ==
X-Gm-Message-State: AOAM5317yZQvy0Ty734xJapnb1QeN8pm4eCSkjfxGI+Bo0QXnXlQH6AM
        NJI8jv/QqUexHnN0wwY7hQf6qA==
X-Google-Smtp-Source: ABdhPJxo7tZRzAXqarznBn9pYuK5Gyeaoi4Qmhb48GKwiUzFoMK0j0T6XGfDfxf/Xi+I4HwBhtJ+Ig==
X-Received: by 2002:a17:90b:945:: with SMTP id dw5mr877847pjb.34.1612820851861;
        Mon, 08 Feb 2021 13:47:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm19675698pgy.53.2021.02.08.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:47:31 -0800 (PST)
Date:   Mon, 8 Feb 2021 13:47:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch 00/12] x86/irq/64: Inline irq stack switching
Message-ID: <202102081346.37FE3A0@keescook>
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204204903.350275743@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:03PM +0100, Thomas Gleixner wrote:
>   - The fact that the stack switching code ended up being an easy to find
>     exploit gadget.

Thanks for cleaning this up! It looks much much safer now. :)

> The patches have been tested with gcc8, gcc10 and clang-13 (fresh from
> git). The difference between the output of these compilers is minimal.
> gcc8 being slightly worse due to stupid register selection and random
> NOPs injected.

Awesome. Please consider the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
