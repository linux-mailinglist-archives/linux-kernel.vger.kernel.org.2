Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162C738C85C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhEUNjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbhEUNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:39:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r4so19418571iol.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=KtETHqZDAe0bJjmaAIYzTN/XHe7zUKB4VbFuegX6nBkxmWG5ohFKpBq8WIAM4LXtdS
         7QemHJe42YQXMZdex6MBXYh5wnhr363+ZnRQBUyg/UDkHhdTqJKaR0BBPhsjIGBU7dRd
         nhzszn98cpFyveOVBYMaiBR25mix2cYwQlxzgxlnIMUyVp7QMgG6RamNqkyCsU8HyRF5
         NiL2J9z+S9m++uMBY2ci8baBBo7xNe5pz0utcvSR9g/2y3oYoB8LndiQzNguoMIpTHo1
         H+NRK4f3O9T4nOkH8ZYODufUe7qifKUTQtVP+hB8i6JNA4jfYOX9ZK7LMZrUgfKLn1bz
         Gshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enWZHbTX+1ralsrB94tU0j8mRNIc2ViVpX6p57Tm5zE=;
        b=GkKs1H1Cgp75g+h4NeoBfYOYVwKEzas1jw8kiLBkE8kMVxg37xFvPO2ZJ+HeT+87g5
         GMNTTCnnFmH20ZHKq0a0FrZ4cHVTo/ELp4K46zrs+DBiix7M/UewpwWYm2cPf1IPUUaq
         tqyV7wM45KmCZF0Z9S3QvMdFwUOtdHVbRzH6685oMBM4BcXIj2VxY3RT5U1GDHu1iBxf
         tON3LvAKcEuS3+9Z2qRoJJ41DJAswb0DtR9dg2QJLq5JCNbtXgHNmJm5EiVQdFerAP6Q
         XzLqV1xzFPL6O1hZV41DmmnVdtE66P7VTurGJVAR0uESsBAG6YgnQRmEV6XLBPeyn8X/
         isdA==
X-Gm-Message-State: AOAM5335NGHSOORpoAKNZP5GbYhO3jDsM4qtmw3ELimH6l3BIFAxdVHv
        IO5aBGLx4xtE250QVdD9dex9PfkruWEv1oslwZjZCw==
X-Google-Smtp-Source: ABdhPJxjJ3OhiEaMgnj0+LP0FY7WxmjA9Xv80M0Ki+88S6bhxNx6ra6pMlVDuKgWNIA6QOd4QDCiQsFR0wThZxSrLtI=
X-Received: by 2002:a05:6638:44b:: with SMTP id r11mr4423545jap.85.1621604283084;
 Fri, 21 May 2021 06:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-9-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-9-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:37:52 +0800
Message-ID: <CA+Px+wWod_E9_UcytNwybrvPGujMVV+XUkJQXQKJsUjO9t1yNQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] media: mtk-vcodec: support version 2 of decoder
 firmware ABI
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
