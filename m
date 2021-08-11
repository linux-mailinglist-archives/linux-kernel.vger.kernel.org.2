Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106803E9AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhHKWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhHKWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:20:54 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A4AC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:20:30 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c23-20020a0568301af7b029050cd611fb72so5271799otd.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=aM5pemF/hjXeqJxnJV2c9famIH51MxpG7DrVSw40DgI=;
        b=TSEtzyPQ7rnKwybhlxpAnZoLWZU0GEZ4A8A9dT3JgPttpZFdHdk6D44igcgA+3+7RB
         0qIJjQCBXMYFkYZ2F9UEkMUvqjBaerpIO7TACCTaRTX0xsbvhARRO7GenKvIW3EqpJYJ
         NiO9WQTOEwWqpGOMgJmlIvdnj2OMnJS9t/hpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=aM5pemF/hjXeqJxnJV2c9famIH51MxpG7DrVSw40DgI=;
        b=A1TgJ1BMYh6xuD9BvCl9jxMFlS8YLhDE6YDQbyE8Viv+Eb+4nKP40Qksnp3hm+WmRc
         VZT4dRJo2WwwzyPGYotmgQKjTnpeTqxvj+1lLj/znW+8H68RrFems5RlpohHDN7siU9x
         lvEOKZs541lbtm5tPnHGrfiBl86otk75rci239yjkMtzROdIzNjRlchQ84wEtq0TSbFW
         gv3ydG7nyH+nei32Jl98AMl/WCF2gNAntzsvb0p5eXnT/nJPoCXN8A070Ul8omYdCdIF
         FVGdZKME7L5RBPYB4MKWknqwz6ci+HSfJlKZC+GoNXFSzNtyn0hZanJ0fB9yYUQVK9zl
         hNUA==
X-Gm-Message-State: AOAM533Eihw+olTv53WHeUMEV31sOy4s030T6eqlhoumeJEVI+WgCVX/
        SMSRYTSIfhplguljHu/tJMKa9fWVI2Or0+51l8cuCg==
X-Google-Smtp-Source: ABdhPJxlM5E6UvFsJ5SXlrT4XmymBfGA3kbwPWgC7qKnSZ1DmZLK/zjiuiAwcmwjOmYCunqtLCaq1bfGnpXuuRXb+nM=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr920120otq.233.1628720430342;
 Wed, 11 Aug 2021 15:20:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Aug 2021 15:20:29 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VgwLNiAZKur7PPpB=_mOnZrkBa2cG1DZYsCxQRAd42NA@mail.gmail.com>
References: <20210721080549.28822-1-srivasam@qti.qualcomm.com>
 <20210721080549.28822-3-srivasam@qti.qualcomm.com> <CAE-0n52hdv0ehzQi2si3rPumBiO+=stoU3kkK=0e7fU_5+xUZw@mail.gmail.com>
 <CAD=FV=VgwLNiAZKur7PPpB=_mOnZrkBa2cG1DZYsCxQRAd42NA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 11 Aug 2021 15:20:29 -0700
Message-ID: <CAE-0n53C9z12zW5C-fZoaPzT8QeNNpvYhVq-M85hwRFeWUMzzQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai
 link for HDMI
To:     Doug Anderson <dianders@chromium.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2021-08-11 15:10:09)
>
> I swear I provided feedback just like that. Yeah, here:
>
> https://lore.kernel.org/r/CAD=FV=W3X8W90vPdrDAymzTKj-J7QPyn4ukaLSOhEkCme3+r_Q@mail.gmail.com
>
> I think the problem is that the wrong patch landed. The one I see that
> landed last week was v4 but I also see v7 of the same patch:
>
> https://lore.kernel.org/r/20210726120910.20335-3-srivasam@codeaurora.org/

Yep. See https://lore.kernel.org/r/20210811194719.856593-1-swboyd@chromium.org
