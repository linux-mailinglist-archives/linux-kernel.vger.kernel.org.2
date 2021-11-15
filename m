Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0C450A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhKORFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhKORFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:05:30 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D772C061766
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:02:33 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id w15so17438569ill.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nijsmPQc+akyPlfu7TNZEY9OJhbTBh6O7p9FQtmiIsM=;
        b=PJKhHv4pOrxh6HCO/0IYzIl/6cVowP78JFfCGVk8hz+SQDYnRSi0cNyw2LGWj8QMiO
         YqKZo6UDKpxGdnw13mPS6rN+v38ODpjK93ldosKXzJ3vMXYal1s2oXgQgOVstZklrxuF
         aXFtsSosPGwAcyZXk+kqxzBwKnV8D70BmvINk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nijsmPQc+akyPlfu7TNZEY9OJhbTBh6O7p9FQtmiIsM=;
        b=j6b8hEbWeGAcndam68p3zrd2WLsdpQnqXPmXGtzDP5Sog3OXK9KE1inh/G90knxCXi
         kzbDhx+fJ5PDeu/13HY/CnBLPcIaMMArOC4iaKAhO4lDcV8KLT02IDlDdoKxEcjibokM
         d2k2Ly3ceo83m8qi9DPsWB5ur2ggKOO4m/5SCbl+KfqJjCIWSd1UQsVf76ZUMa/X0s7l
         vZLyM53hz6ZtYJBoSKGjZ35fcI+TMXQSTpXnhrTelk901NZRbaoWuXaoqrqQLt/bFf+j
         ZVkOxxLHZ91ry8Np8oIWYWxOsLukjfZcjSMUSvq1FSxXmooQvTq8p+lN0HJ0Hqu+yNhI
         lVdA==
X-Gm-Message-State: AOAM5306CoBCZpOrrU9Oe0W2g2exAIweo7kyfRbYAnEQcIFALiVu3TvI
        d8Bw5ulfIVTtC+saBnJE9d4HAodnY9Lvog==
X-Google-Smtp-Source: ABdhPJxT73JV65O5hw4K92QmvZ3ZxqunE7u+DrUouwBGZl7JSHWiOOytclVxjrv5IgIbQvGdoOzA9g==
X-Received: by 2002:a05:6e02:180b:: with SMTP id a11mr269479ilv.82.1636995752233;
        Mon, 15 Nov 2021 09:02:32 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id h14sm9109839ils.75.2021.11.15.09.02.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:02:31 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id i9so17429770ilu.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:02:31 -0800 (PST)
X-Received: by 2002:a05:6e02:1c46:: with SMTP id d6mr224481ilg.79.1636995751375;
 Mon, 15 Nov 2021 09:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20211115154201.46579-1-andriy.shevchenko@linux.intel.com> <20211115154201.46579-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211115154201.46579-3-andriy.shevchenko@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 15 Nov 2021 09:01:55 -0800
X-Gmail-Original-Message-ID: <CAE=gft7+a2hW-EZz33=ApFAGA4HSOfQS_LGH9YMvDtM0=F0uww@mail.gmail.com>
Message-ID: <CAE=gft7+a2hW-EZz33=ApFAGA4HSOfQS_LGH9YMvDtM0=F0uww@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] i2c: mux: gpio: Use array_size() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 7:42 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use array_size() helper to aid in 2-factor allocation instances.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the cleanup series!

Reviewed-by: Evan Green <evgreen@chromium.org>
