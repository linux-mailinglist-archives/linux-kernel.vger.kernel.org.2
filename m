Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00713FCF97
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhHaWdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:33:42 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:44712 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhHaWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:33:41 -0400
Received: by mail-oi1-f169.google.com with SMTP id c79so1207746oib.11;
        Tue, 31 Aug 2021 15:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g6D38exB/Nb9kQ3rq5Ht426/g7o8xbXiI53vXw3Leoo=;
        b=bpWeEgwpxsdF4j68YCdQoxB2tD9Y6Bt9LdhCbo0fc2HAatyKB0PiTxV+16BWW4nO8d
         6mCgIIXXoI+4QOnabg4RmKKmVBr+VhIsImU2jQB6g5K98R59WRSWdHkEST/bTsxBmOGG
         K1ASqxBm/3IDMpeB4ii3pWdcKWz4gFZ+KtDMUR7X1bq4Y8K6QKNkCbTkWbjkm9f7htnp
         KJML7psbtSJOpGD78U138poX/l0XFajiXBF8iTK0fzmsuEKdmtviXLehVNS2M6iPjzOc
         sHnXnfFUb927y2axAtD5vr6MGg6sOkmNoE4jtGDKtUaTirWYkUUnF0Z+O/BJjrrgzQ4Y
         0h0Q==
X-Gm-Message-State: AOAM531dj8Cny0ggEQl3iJUuVa7lfTP8LOtWgBg02OUrpbMsm1a/vGby
        N8Hs0229Hw+9+a9gu65Eaw==
X-Google-Smtp-Source: ABdhPJy/LrzRncvMJD8g1bJs+UutiJZ7WjP/8yf47rdUTkA6whSbhnEbeH51oAPVboJp2H4aaVmrog==
X-Received: by 2002:a05:6808:2cd:: with SMTP id a13mr5040179oid.3.1630449165761;
        Tue, 31 Aug 2021 15:32:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k8sm3832850oom.20.2021.08.31.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 15:32:45 -0700 (PDT)
Received: (nullmailer pid 762341 invoked by uid 1000);
        Tue, 31 Aug 2021 22:32:44 -0000
Date:   Tue, 31 Aug 2021 17:32:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        airlied@linux.ie, dianders@google.com, devicetree@vger.kernel.org,
        daniel@ffwll.ch, Douglas Anderson <dianders@chromium.org>
Subject: Re: [v4 4/4] dt-bindngs: display: panel: Add BOE and INX panel
 bindings
Message-ID: <YS6uDL6X1CJeJaNX@robh.at.kernel.org>
References: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com>
 <20210830023849.258839-5-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830023849.258839-5-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 10:38:49 +0800, yangcong wrote:
> Add documentation for boe tv110c9m-ll3, inx hj110iz-01a panel.
> 
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
