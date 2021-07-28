Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE03D87AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhG1GJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhG1GJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:09:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA5C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:09:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k4-20020a17090a5144b02901731c776526so8360449pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqOm8dR3/Z3FMMfb4CCcRYLnM7xQyfTbgeYY457K44I=;
        b=Cr91iegMyQBs958cDlJb4sCpJPeyXEXt4yl4uPRSb4+qmeNpi56ciedzIKFri8UeVw
         CiJMLwHsBhyDJDGWPwEZQHX2gpb+awqkq2ZIsBJfrqO4+8yFXb4LpgX+fnSNQzVjlsa+
         ifMaARxJH67i2DELDi0BAh0b0iAdg4l3DtEXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqOm8dR3/Z3FMMfb4CCcRYLnM7xQyfTbgeYY457K44I=;
        b=EcYnGxE9oEG3GocP+Wf2U5lOs5OPd/iraD+e5IQuyvXKyWA6SXfDLxTpk2MGZHKqrc
         8YppoPKjiaklT2W+FshQwyWmODFO012nvpGZbrnEsoENMxpEP4UqqbzJIUfmqM1JyFq5
         aPyokOkBxoYwEZsOBNjK9007PsKNNKi0w9eT6nJ3DOp9j3gRqtD6sxr9XyrrtYwEfWiM
         yO6Su17E5s/TXO9UcI1+ivNVqqd5dRZxm0vMjM7gQhL16LHZOowtH/PKFMIJhVe1OXSp
         9hFOFpBXPnthWdtPhz+2FEnJYstvavYPyalNzQDVooKehNIADQJOUO/I+d/e7rpglPcd
         4n0g==
X-Gm-Message-State: AOAM531WKYAs5l7qpmyxDuSu05euiQs+bGz4dZK27W8nedGNlbgX+OzX
        NeT+VBMQY+DiErShjYH0PhGIROktln8xqjSD5vfefA==
X-Google-Smtp-Source: ABdhPJxL3dHmMPX1HBiqROlD3Z3DE/tD6dTpa67uwocKIXnMWICioviIBBaG9Oi8aaMGBlkgrVZE/Ta4mUKUmk3Q6sg=
X-Received: by 2002:a62:79c2:0:b029:3a3:8e69:ca97 with SMTP id
 u185-20020a6279c20000b02903a38e69ca97mr3542522pfc.55.1627452551900; Tue, 27
 Jul 2021 23:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210727023205.20319-1-chun-jie.chen@mediatek.com> <20210727023205.20319-2-chun-jie.chen@mediatek.com>
In-Reply-To: <20210727023205.20319-2-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 28 Jul 2021 14:09:01 +0800
Message-ID: <CAATdQgCd710rxipjDNha+d25g744wEPg9Gqc-OamJNnRXpw8aQ@mail.gmail.com>
Subject: Re: [v6 1/2] arm64: dts: mediatek: Add mt8192 clock controllers
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 27, 2021 at 10:33 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add clock controller nodes for SoC mt8192
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
