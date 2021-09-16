Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC4840DA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbhIPMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbhIPMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:39:50 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F171C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:38:30 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id v9so3828484uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vConzKPLEXeSY5isEj44b9ioB3WiTKXOOeH8M/qhMg=;
        b=ZOd3cKON6cosT+oUHSUoX8lYXRB1ivz8ksbhrz2g13ab681NxxqUYouzoyOdApRjHN
         9C7G3gkXybIsaQK6CR0OXJbCoityPI/bsDx9cxeBDryg0SrTlJdsGYQHAjRZcFqHNnep
         w8T/bY5gwyKErMCiBenZMnLf2a/1lO38d9s9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vConzKPLEXeSY5isEj44b9ioB3WiTKXOOeH8M/qhMg=;
        b=otuwC7a0t2SHxwtkOqn5sfrguOPLfwtk2ztHClVsqwcL3/d7fxHJy6A/94Qpbu20+w
         FzK3MG93nalb8joDFjutaEvojfuWs7o9VvUhVgP+83zcOd9ObvkTY/b2OyLwo0vnhJ48
         W48qOjYC4l4Fl2NX4EAsYTnjBo/miWxE7p/ynrikAu3XXlSU/3AsVNGOEDnpXOpt1Wv8
         ZbR7qOdwWvEWwJmr/HPIAXlvdua6k0i6IVXKfUaKNiS+hysYOKxvLsagnttW1CbEu5U6
         aFKrixiXH1p2GHXVu4wtSaVsE4HZ2WYyn3LTZ2Wo/7tieTdaycQraSFcxMCMSb1X1c27
         TJ8g==
X-Gm-Message-State: AOAM533NvHNbya2Jm2xiIFYmA4p3UFaavQA5LwOqs9qihzBlgIHKBVfB
        P3A5c07Vf5vYBg0mpTRPFp+mWXTCwUAgDrI/quxuAA==
X-Google-Smtp-Source: ABdhPJwWiK0lSKm+XTwl96Bf3/5KQdNtghCcUqgRmYvdz8qjWXlQJhdlhbS1vXZu/Mk2fnAln2bQsGBTgBZfLDmB4Dg=
X-Received: by 2002:ab0:10f:: with SMTP id 15mr3588186uak.113.1631795908405;
 Thu, 16 Sep 2021 05:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162324.25513-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20210915162324.25513-1-dafna.hirschfeld@collabora.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 16 Sep 2021 21:38:17 +0900
Message-ID: <CAFr9PXkpEDfa_P_UfTCwrBHOMsqyGm8MQgOsY=_OjFGc4+ApAQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] staging: media: wave5: add wave5 codec driver
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        bob.beckett@collabora.com, kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Thu, 16 Sept 2021 at 01:23, Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> The wave5 codec is a stateful encoder/decoder.
> It is found on the JH7100 SoC.
>

For what it's worth; I think this is also the video decoder block on
the SigmaStar SSD201/SSD202D (32bit ARM..) that have some limited
support in mainline.

Cheers,

Daniel
