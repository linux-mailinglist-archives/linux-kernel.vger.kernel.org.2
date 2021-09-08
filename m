Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821CD403BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348605AbhIHOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhIHOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:46:49 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9BC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:45:41 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x10so2560484ilm.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+eW/ZheKXj4ZX5orDoqEWxFt7XRuMsqdbmkjUkkg0Y=;
        b=fXFb0hn8qw8T9Jg1x1peuRXYSEoCZ7/hzNJMifqcQuxXdfiGk92VPL8zqn7yayp76A
         HZhgCxmXxcKlmHBHH2QTmQmtJkclTo1P8+XJ+PQyjHCtfu/weWuDpRtzLihXwUkcxstO
         KX3Kl7eJr8K0xfN0aQTcwn84dD13SedzA45RtIGwHYSvrDpC9H/P5uofXoCdAZrQqmiv
         HhzjJ2PfoPTMQkXJXjmNcR9WKf0iEFa6qRMuxZmv3lOd3IrfVta/uBQPMqKZMCZgOb8Y
         TZuf29q7GJr3APg3xdTEjfit52YLo44PHV5/I+tc6EXcy130Dj9URPnw5GEp/qJcw+PH
         xr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+eW/ZheKXj4ZX5orDoqEWxFt7XRuMsqdbmkjUkkg0Y=;
        b=wdvKY5H5NpX+IzrEom9DtWk432uY8hV83yQ35XyYb8fFsC/eIOsxuYNaZ5G4lLwHif
         duGhW/O1FQ76ajENmIQjHnlQAURz4hxDAu5xMc/wbFYSJ3a+6opj7E1mQ9N43neRTaDy
         mg6n4rhxrq53sE5k8ScDIxJCYjA/p67Tagvk+ETSLAc/ZXYdw+bj9MzfVA0cV2IRDTrI
         x32q0E7OeVBSagr8ooKzP1JO7hnmMXLhJD3tZtGvvFtmOmHM6RzO0foJQkhHod1qubgw
         qTvr8U2P0dpov6WPxkeB6qiDYc1OM8HXRXCXNES4I9XoJSpdZYzDu9SK5lcRijCc3Utp
         91ZA==
X-Gm-Message-State: AOAM531CmFdIEiPkJJH8zMgkNjg6CaColqBzvTnbsvuREcFV3ehOwt0T
        YO5R65mS3scImOWq8z8xlLKlc7qGlM0JBmpuGKfqgg==
X-Google-Smtp-Source: ABdhPJz8YaQ9sLyJy0cQgutspDJTH9PZxDifyu0mxyEfhPS/VizaquyGfUh/HKcbYv/hXaNK093SulStSwzhVwCnjWE=
X-Received: by 2002:a92:6b0a:: with SMTP id g10mr160726ilc.27.1631112341151;
 Wed, 08 Sep 2021 07:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com> <20210830023849.258839-5-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210830023849.258839-5-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 8 Sep 2021 07:45:29 -0700
Message-ID: <CAD=FV=XzUUdh-hTTg_Pv1P8WHwTTXa7F5m6q1xq=XVdPxyDDpw@mail.gmail.com>
Subject: Re: [v4 4/4] dt-bindngs: display: panel: Add BOE and INX panel bindings
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

On Sun, Aug 29, 2021 at 7:39 PM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Add documentation for boe tv110c9m-ll3, inx hj110iz-01a panel.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)

Not worth re-posting just for this, but when applying we should fix
s/bindngs/bindings/ in ${SUBJECT}. If you end up posting a v5 for some
other reason then you should fix it, of course.

-Doug
