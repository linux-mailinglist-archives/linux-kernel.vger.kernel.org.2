Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67E93D7E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhG0TAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0TAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:00:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BBC061757;
        Tue, 27 Jul 2021 11:59:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id n6so17214072ljp.9;
        Tue, 27 Jul 2021 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JOQya395nUYReFmGXxQsyJfx889KYaEoPMsqJGvNiM=;
        b=R6Awyj9jgKE4B87h7+QTMCEixH9xN3ChUqkE+EeBpQ52r9Q/ZvSMBjdEiPLOOa/Yio
         xjMiZcTB5yGPSBJJyNLWVFUCtYQRObOFWt/UCZrbttGZ90JxSAPNYbTSP777J6rsY91s
         aJKG7dTV6sAC5GSpVSElPaJUc4tmRnu6nF8ivp+t9auAkm0zsA1KQcGZzC8Su0KKlYZK
         TFS+GmVLlIFwyh2fRXjSKiu5/2xB5q2n16ToTOfMO2elACdBeQqJf2hnX9ccBor9CRSL
         9OFaZXlQQqOfyWA+Rup+6rvvuImdbUiaRCteVSB1lax4dMDQkjMkZ2VdYISKPLm4dOI/
         qr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JOQya395nUYReFmGXxQsyJfx889KYaEoPMsqJGvNiM=;
        b=n9CzDJsqyIrsJHFHpgdcaz1s9xIjKUhmAY9153ApKjbvj2VEDbM24afxjtV07Ea7w7
         J4Ju8JrYC0lWhz39Fd042BUPEV7G0LJSsWOhwCOpvSZkHFswdA+w85sdMp8FfX/A3rHV
         DiAi5RULDNXE3DFeiJAG2dx/blr4bRRaa4HjnbHskfnsxojKIdxhCu+oXEDHR0p1nN8M
         VJ4jH4WQMWmGpviy7sXuQ6Y8yQOaJYs+Gd/PqMaMDW3Q/e31Zdprboc50a/BL+X2ym1N
         /IGpZsi8vlPJl2CuMIbGyNgKKKRHBPjxGd0yTGfr8LTqsIElopAyXfBAdWVJltB1scUK
         qkag==
X-Gm-Message-State: AOAM531+ZmWZjLPWCxHvSyI4pahN2tzPL75Wm1JkN5L5O7scG28q4qtE
        uMrpJKFtQEWX7sVd7+pkz54=
X-Google-Smtp-Source: ABdhPJwJ5pQ6iVeRtmb2MxJgYfngOMKCgYJufbfXnFzlNh8quYCuuCbJEhPAt1ipIGvjPE6xyEiSHA==
X-Received: by 2002:a2e:b614:: with SMTP id r20mr13936192ljn.211.1627412398379;
        Tue, 27 Jul 2021 11:59:58 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id l17sm363771lfc.96.2021.07.27.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 11:59:58 -0700 (PDT)
Date:   Tue, 27 Jul 2021 21:59:56 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, sandeen@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_hid: added GET_IDLE and SET_IDLE
 handlers
Message-ID: <20210727215956.23c46546@reki>
In-Reply-To: <YQBUa+YrPc8e07Yv@kroah.com>
References: <20210727183140.42330-1-mdevaev@gmail.com>
        <YQBUa+YrPc8e07Yv@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Greg KH <gregkh@linuxfoundation.org> wrote:
> As I already took your first patch, and I can not drop it as it is a
> public tree, can you just send me the fixup patch?  That would be
> simpler than me reverting the original and then applying a "fixed"
> version, right?

Sure. Sent a fix as ("usb: gadget: f_hid: idle uses the highest byte for duration").
