Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7730145EB35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345640AbhKZKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353256AbhKZKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:22:12 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209BEC061748
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:09:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h63so7709591pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4W2I5kuwpM2lqQ0SftJKxJYAD53bRmdrJ6iZIfgDzkg=;
        b=IPkErYmmP/MP79xguXU0HZSMDDIrG2wd7US1TxW/lxQfYNasxnfDdJc1Fqr8E9aXxS
         vszY6dfUJQzI0hMkvNQpjC4t/XTiL7rEQ1JWt8ontYmbu+VFFU0dqE2uCBFL0zRXjsU2
         rG5AsTcwffVpz2uKA55Ef79HwxOOeQnMuQC0jyaY2tbHSZ2w9NN0133sDpmaDdv2+kXC
         OGjnyPpGKdF6gl6JZVoaijU5R6+Dt+laQixKm9HgeAwTd6mQ2XXp2GpTSGXaC9CI9dtE
         9GEFFGI9Y6P498ovhEiNrHBGxLZ8P+pXgGG9wWOsDtlPdUBnTQovSuLGpW1SUzq3KHDj
         lV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4W2I5kuwpM2lqQ0SftJKxJYAD53bRmdrJ6iZIfgDzkg=;
        b=0IjPrXhRPoIwAwR4VK5Zl0BV6BIJCKFQv4hdYo41w5AfpPTNGeYaUhex2H6YE+YcFi
         E6pbQ8lSAACAtBTZDygDyxMF6hsUjCeI882x/tQOUd9WhI4LaZ1JN5vW8zPLpRXT0Ob8
         hUpuop70Oh6qYgUHkcDsMIV0/gRrxwH2a+KSUjVOrgDRX1qCMwX9h7uwo58nHk+Ulkbu
         5gtazh9P+ijgkFt6zIRnQNk12VwvOtdqSaRsR1dfNI/RE/pzHj20j6vA9CjlCD79BYn5
         qbFEZ12JdahC9vD4BXsE0f54NhdYDboYlsAiDMF1r0l8915Gdozy7+G8IUdbLcQ1coyp
         bJhQ==
X-Gm-Message-State: AOAM531xe7qXxpkxNVKKyFHpJlnBsX1SqPVaW5SQu0zP8yUs4R+SLbP9
        ssWnFSpbrTtKyQrnJVIxsV/adg==
X-Google-Smtp-Source: ABdhPJxVejTdV/NyrWHwGiaTysIUv3zOhCVavwvpUaitec33azBmmuhOyA8uIgkTF6FDl0OeFLILPw==
X-Received: by 2002:a05:6a00:2349:b0:49f:db1d:c378 with SMTP id j9-20020a056a00234900b0049fdb1dc378mr19747281pfj.53.1637921344428;
        Fri, 26 Nov 2021 02:09:04 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5eda:d984:1426:91ca])
        by smtp.gmail.com with ESMTPSA id lj15sm5238017pjb.12.2021.11.26.02.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:09:04 -0800 (PST)
Date:   Fri, 26 Nov 2021 18:08:59 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, cujomalainey@google.com,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v6 2/3] firmware: mediatek: add adsp ipc protocol
 interface
Message-ID: <YaCyO9kKWJ8oog/h@google.com>
References: <20211126093021.25462-1-allen-kh.cheng@mediatek.com>
 <20211126093021.25462-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126093021.25462-3-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:30:20PM +0800, allen-kh.cheng wrote:
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

I have provided the tag in v5.  If your have no major updates for the newer patches, you should carry the tags in the commit message.
