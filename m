Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78A13F2FED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbhHTPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhHTPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:46:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31DC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:45:42 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a15so12846655iot.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jG0is8q04G4No7iVp51Nm6RxWzS7meHDr4YzqKJBfEA=;
        b=PP6k/9RYzXUlkTfc50ROUtr1LKoy6RXBaDB9f62RibGA1DzZF20C2XZ2mZIf7mCfAm
         xT/qF4WUj4IqB8L0bMhyPJhW5OhrsBJ6eonZdSsSGrph3rhqceLsMbk3vcO8h23y+Ynn
         u6ROpxxAZMhxS9oOvVYqogoDNACM804//hYk9GU42B/rxiBtEGR9HKnGmRy/uTts/n5R
         +KjoD2d+2zBR1JDeB6cNi4B4/NzmSWbF1axyE2+vhqv79bfV27QvMEvJyb/aqz97Xbaz
         Ri6ibP3UM6w0CjmFDQx7W2zCBph4Fm9jG3PanvqYRboXy0Q3IlsvL26rTFRmR1iIbp9w
         en6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jG0is8q04G4No7iVp51Nm6RxWzS7meHDr4YzqKJBfEA=;
        b=SOlP6VoDn+FM7waqmiPrLyDvC7Tq1B6uBmekZpmRmDwzGRAI7olJFaNHzl0aaCSZxi
         C1/4dDn1usS/brMuPDLWHp8JnXYwUJ4yDuA9y/nnPntw9mfeuXywvlxi0Qu1N0WDPC5W
         x+zU04/61FNzrgfTQcrtX0/67VIwdEsAlAkSnuKLnxlBus5JIFmHR8G4qVCUUdic9jxk
         HmnJeIZREX3cgvsXIR8yP9kiQcRFSZEHQ2KBN0vUWWZhTJ7Ufez7+2FiRdJ4tdJn+Y0U
         EOjVCL13F+Fxbo1b1aTv9r5LlrJx3a0DcnpbRkkQn04+H2qAfiMNzkf5jLVh86/hfkuf
         ycyA==
X-Gm-Message-State: AOAM5318XuuiJyopp8oQAVvbxkcwPeMfJaFa10r1RqML2zSZJsbxdvv4
        r2uq7IekqfVXIMBJTpYB9ayyxvGSHdXfJa2kSBa9IA==
X-Google-Smtp-Source: ABdhPJwxXuqszLUo7soyfPQwdUNIXwfFEuhZ0Hjek6KxH//hCiC6j/0C6kYQLTZqqcs5czNxRg1wQF4UiIHClVgRnvQ=
X-Received: by 2002:a02:cb45:: with SMTP id k5mr17979205jap.112.1629474341466;
 Fri, 20 Aug 2021 08:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
 <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com> <20210820070113.45191-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210820070113.45191-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 20 Aug 2021 08:45:29 -0700
Message-ID: <CAD=FV=UAD1dM9EqGDr1zLDUmrLMPxmAp7-da+ifqXvDcRbpqdQ@mail.gmail.com>
Subject: Re: [v2 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support
 enabling a 3.3V rail
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 20, 2021 at 12:01 AM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The auo,b101uan08.3 panel (already supported by this driver) has
> a 3.3V rail that needs to be turned on. For previous users of
> this panel this voltage was directly output by pmic. On a new
> user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
> to turn the 3.3V rail on.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml    | 3 +++
>  1 file changed, 3 insertions(+)


However you're sending your patches is really confusing my email
client. I think part of the problem is that you sent "v2" as
"In-Reply-To" your "v1". You shouldn't do that. You also seem to be
sending duplicates. :(

Might I suggest using "patman" to simplify things for you?

https://source.denx.de/u-boot/u-boot/blob/master/tools/patman/README

> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> index 38bc1d1b511e..a7091ae0f791 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -36,6 +36,9 @@ properties:
>    pp1800-supply:
>      description: core voltage supply
>
> +  pp3300-supply:
> +    description: core voltage supply

This would probably be slightly better if it said "3.3 V supply"
instead of "core voltage supply", but it doesn't matter a ton to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
