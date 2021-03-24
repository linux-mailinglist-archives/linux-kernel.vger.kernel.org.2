Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67229347D22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhCXP5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbhCXP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:56:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9737CC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:56:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l1so8165521plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=YqCR3r8Dk/Ap4w330iydSCj72+uSVcwtjIoa+AHxLQw=;
        b=PgBr5jHLPacqJEItJHNbwwnXuLO5Fk4dgQuOajM71zxKzxbwspBVkJwxlFs+3lPKfQ
         Xnkb8Fzla0JRHAKYRaiSU0gFP7dQD9M8dymba7QMeCF0vttddN1DLOR0QzjoYYFfsCIN
         qIYDbgi8SkVCsZQnepe92B5vpCU8MCbOcGpaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=YqCR3r8Dk/Ap4w330iydSCj72+uSVcwtjIoa+AHxLQw=;
        b=goDcChPTfdbMoA2Wpf1J9/HdlYV600pzfEpkL/xSic3PZzjZBimIVWytlk0148UXav
         XfILEGwzjQoqcfLQBu3djvKTfHkM8qgfjrPQ5Hqgnfovrqz7tgCd7oQyF3KNMVhjS833
         r3LRJ1/bqSLHEZGObg9Ak7SvDSdiV9MuIDGCAGGctTjNapso6Ht/qy+6ENKLBg23ZY6o
         4JBBrHKStbY5IieE6EvzZ+V7HKFFaX88yCCfSDqPzI6dZ9zOqMPlwGDkhQfTdgXT6+ch
         tOuewkh4RqzBWhK8jURKg7iCJDNJRA9076BmYK9JKjS3rFo6P4K4vH5AiY9cUJAlZYo1
         r3rg==
X-Gm-Message-State: AOAM530HwyRsnpJlUKgoHYxDiyD5vWKwifBRVg+kiOTNwHS22oV66tgM
        vSLQ/ZSqNW0c63n7vwiNla7zoQ==
X-Google-Smtp-Source: ABdhPJzx7OBjrFG2Ww7vkGVfIrZEpN8LctAeeiuZX+e+O45XO6EB2L6jNC1/OretyXtMBPzf8n+dGg==
X-Received: by 2002:a17:902:e5ce:b029:e5:dc8a:7490 with SMTP id u14-20020a170902e5ceb02900e5dc8a7490mr4328937plf.37.1616601406141;
        Wed, 24 Mar 2021 08:56:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id a21sm3058055pfk.83.2021.03.24.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:56:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VfM10w60VUuTW5yXdykC8oXuxqq=FLfZYDP2aUh0P0_g@mail.gmail.com>
References: <20210324025534.1837405-1-swboyd@chromium.org> <CAD=FV=VfM10w60VUuTW5yXdykC8oXuxqq=FLfZYDP2aUh0P0_g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: trogdor: Add no-hpd to DSI bridge node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Mar 2021 08:56:44 -0700
Message-ID: <161660140410.3012082.16145667394892749711@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2021-03-24 08:32:00)
> NOTE: if you were feeling charitable you might consider sending a
> patch for "sdm850-lenovo-yoga-c630.dts" as well.  I don't personally
> know if HPD is hooked up on that system, but presumably even if it is
> it's just as useless as it is on other systems where the bridge is
> used for eDP. If nothing else setting it preserves existing behavior.

Ok I can cook up another patch for this one too.
