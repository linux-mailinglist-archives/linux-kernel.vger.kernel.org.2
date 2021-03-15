Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C755633C981
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhCOWpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhCOWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:45:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46BCC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:45:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n17so12471584plc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yf4vO2b+lTKzWfzfbp51qupLwQASo1gnl28vzzbgt9k=;
        b=S11dJ5n6BohDMT5neZVRzhpqx5VgRSeGWiVMwwVg+mhb8xwzirUc3zk19j3bD934J3
         ZW1eyzEZ8KHRyxOIXRSarJPwDQF9O/UEwCqZ3eCIhdgC+pEEKOe6lEqhWigTM0TsN/55
         yP9OrwC0wl3QYUgFxK3xS5JpD62fpfkh5gnW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yf4vO2b+lTKzWfzfbp51qupLwQASo1gnl28vzzbgt9k=;
        b=Mg6BTkvzq1bmGT/6084LL8WIg97uKVEGAmMv2IAHaiYf3WYqorR6H/7b7NbCzati3d
         5e/SOhXJ1Z+FzSP9ibRHgvQdAGQPAOvSogaRD7rBgTNd1a9/sJ1B40Nu2fzjEV+Iv0QC
         e0xOrJ9X3391c98BWRAJXUzFTJpYStj68CAA+xdDtxZ6OTzN8KUZGXRxL8+GGtf3fcKS
         xDlur/DGRhdu+IhUaOULNWl64exXC0XDC+vZ+VALYLC6Xl9HyflzUcVMciJDrltml5JY
         l0F9KWBVzWG1HQ3Wczv2/yLAMqKuq2cY7q+1ICI4MMf6d4aZhpuqkwQgBOgZECQduP5X
         cvQQ==
X-Gm-Message-State: AOAM531uONBB2zeyHEJ57gTgIjIwTa3vxkgU5xDW5rr/i5xmeLWdHiF2
        S1N10ADKbIXrm/GkavH5VV5TZA==
X-Google-Smtp-Source: ABdhPJweQ8WTz2oc0TexZGPKvx/4ySquJAeSp1iPIu+k4Gq6dXx+xr/0gIFUwHXoCjcqQRKqLdLDhA==
X-Received: by 2002:a17:90b:108f:: with SMTP id gj15mr1406327pjb.177.1615848332229;
        Mon, 15 Mar 2021 15:45:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:9867:b969:5d4f:e017])
        by smtp.gmail.com with UTF8SMTPSA id d8sm15598951pfq.27.2021.03.15.15.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 15:45:31 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:45:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7180: Add pompom rev3
Message-ID: <YE/jihnCSbMJ9qO3@google.com>
References: <20210312183228.550779-1-mka@chromium.org>
 <20210312103211.v2.2.I4138c3edee23d1efa637eef51e841d9d2e266659@changeid>
 <CAD=FV=U6xNaTLaP5Hz4EVTd3EY-ptTCaLJ84X6=C_6E9Gdq03w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=U6xNaTLaP5Hz4EVTd3EY-ptTCaLJ84X6=C_6E9Gdq03w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 02:48:55PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Mar 12, 2021 at 10:32 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > +       linux,keymap = <
> > +               MATRIX_KEY(0x00, 0x02, KEY_BACK)
> > +               MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> > +               MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> > +               MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> > +               MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> > +               MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> > +               MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> > +               MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> > +               MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> > +               MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> > +
> > +               MATRIX_KEY(0x03, 0x09, KEY_SLEEP)       /* LOCK key */
> 
> I don't think you want the LOCK key. See <https://crrev.com/c/2719075>

ack, thanks!
