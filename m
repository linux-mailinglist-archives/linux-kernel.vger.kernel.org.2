Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3279443F33B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 01:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhJ1W5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhJ1W5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:57:50 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9746C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:55:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h81so1425030iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIO8z6g5pnThmN6nY1IAWvuZN7+8+z/gyR0WIdP+6Nw=;
        b=hmXjgoKYJzjjMMBsX9LnJxl/pAFVPf56QIHmBYftUTr7StooYQW7HSDt+rjq9ozQzr
         70MTu3sgwn/pm/25Y62tLpZQqgbVWMArRKLBzlMXfYeuEBjp26SRu6Qv24ngPs/hn49F
         JYTj3L2leuBCEPLbPSB7xfi4CTSY3fnmRMwUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIO8z6g5pnThmN6nY1IAWvuZN7+8+z/gyR0WIdP+6Nw=;
        b=Ji3yDya+BC3ciHy7YVRGInExvXcsxSVjc+iLscn0o38z4c5y3j+Hwt172VdLqDW4ta
         mQnq9kwLThJQW0p4RK2IODx1H45HSM2b7ULPawu0hKYzpJgtq4gWa89KWYNHX/cGD0tT
         Dq3JRsdrPjHFsWe4aHTnfOox8UkdMUXAwYI4VidZH9+GzerfgI+qCFLu3EA+6RbVroU+
         vW26BbAW4TbcDJJ6+wtQtWd7JZj518GlI98MfPxNH3/SE3Kia/eLwiGZ3WwATF2q+ZuV
         gTXK/99yBIFsXbI+VCP8MLgzevzjoAgcbbg0ONuC0MdMvyu7fxIgAXK3vOiZfVoXmXHo
         kI/A==
X-Gm-Message-State: AOAM533PrLDkUVASKKnCi6WgWNRfM5Zvr5a3rThzzbsxoWRDGHf8+izK
        OUILRZYjz90GyK2wvbH9FArnnSsWDTwm7A==
X-Google-Smtp-Source: ABdhPJwyIoQWP21lpl4c8X8YEGnFVetAfqjiAJcoh0p9g7qWVwcWnG/xYfHiK8EKZSIIhTIaSpkPoQ==
X-Received: by 2002:a5d:9d9c:: with SMTP id ay28mr5404196iob.206.1635461722064;
        Thu, 28 Oct 2021 15:55:22 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id a15sm2444044ilj.81.2021.10.28.15.55.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 15:55:21 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id s3so8733881ild.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:55:21 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c21:: with SMTP id m1mr4940355ilh.165.1635461721219;
 Thu, 28 Oct 2021 15:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211028151022.1.Ie56f55924f5c7706fe3194e710bbef6fdb8b5bc6@changeid>
 <20211028151022.2.Ib9070172c8173d8e44c10352f68f2f507a151782@changeid>
In-Reply-To: <20211028151022.2.Ib9070172c8173d8e44c10352f68f2f507a151782@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Oct 2021 15:55:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK0KABr5NchZgrjSFa+7G7Ez_JPcgCVnsN0K1q++O-AA@mail.gmail.com>
Message-ID: <CAD=FV=UK0KABr5NchZgrjSFa+7G7Ez_JPcgCVnsN0K1q++O-AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sc7180: Support Homestar rev4
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 28, 2021 at 3:11 PM Philip Chen <philipchen@chromium.org> wrote:
>
> Support Homestar rev4 board where Parade ps8640 is added as the
> second source edp bridge.

Similar suggestion about mentioning why the include of "sc7180.dtsi"
moved around, but otherwise looks good.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
