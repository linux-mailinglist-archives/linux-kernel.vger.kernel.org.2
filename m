Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11445E884
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353158AbhKZHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbhKZHg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:36:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EBC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:32:06 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n26so8111883pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H8GxqclEr9GMquFQtjl1gpKJQNY7uiPr2ofl1kPxFr8=;
        b=QtX6ktAUTquUbbu/XOyp6jWTVUuSqaNmzTULmqMDfikHAyzqP43gXs0Qiz1+xV1n5X
         ATR9ww7pCysgtrScPJ5/Radq/UKWOxeSOCqA5xNWv/pfGK0sWy0240aVhQUz+upUtD6h
         TATUZrwUNl5/CT3FynWVOWc4prfhgF/8h7WYLdSF6JXRC278QmPNvQrCaJCt4YaQ36JP
         oxjoieXS4Q2tmI3P0nscYNJmSnbKa42ojl9Maut8hucqEZ48Mag6E/RfYcNR3BvnxCtY
         S2eIDcm+I0gHyZoewwhRyDJ89GH+wM69nzAZfg3BoZOxY7Efle4lLQW+aCpm0tqcwCJZ
         ITYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8GxqclEr9GMquFQtjl1gpKJQNY7uiPr2ofl1kPxFr8=;
        b=UHRz6/s+fTAin8fdVICeuivwNGQ4F3g0XJzApDIe33DG5O6ZHkDSaGyJFjgoYJzT63
         Yh50YkDy2tJMKN6CT4Rv/42C72+GCAgjSGw3NG4DWZKUKYM221v/b81U9mUTKDcLSbi8
         dSzsusbhBsnMyQKLb3OItYi2RpnjGWpVS48w8suMU/o7vXvGuQQ+ztaUubfo3Ye51QQY
         TVriO7XkHX5wjVBRxme6yFbyS1Z7nejKzJOgNt8102vlN5KOFxkZdGg4yYNA/syM5v/0
         bAlkRZnt7ilNmmrVmqCkZTuUPWqmDYiv9t6deOBT/zYZiSGHZ67NaVlQB7y7oU458tH4
         lJkg==
X-Gm-Message-State: AOAM532bgxPuG5CSZI33I5ESBlGjz3YmTtUUANRniTEkccwcKz4//d++
        Vjeq9ZORNi8oKbBQqix/PftzYA==
X-Google-Smtp-Source: ABdhPJxcei67hA/Fni82mRFZEub3sKfv3jtMYS4/HzkNPETjajfDoqXCgeZufPfpR7ZM3kGXnFC6sw==
X-Received: by 2002:a63:5526:: with SMTP id j38mr8662880pgb.86.1637911925535;
        Thu, 25 Nov 2021 23:32:05 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5eda:d984:1426:91ca])
        by smtp.gmail.com with ESMTPSA id mv22sm4638283pjb.36.2021.11.25.23.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:32:05 -0800 (PST)
Date:   Fri, 26 Nov 2021 15:32:01 +0800
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
Subject: Re: [PATCH v5 2/3] firmware: mediatek: add adsp ipc protocol
 interface
Message-ID: <YaCNcVjyems1lCX8@google.com>
References: <20211126071432.21990-1-allen-kh.cheng@mediatek.com>
 <20211126071432.21990-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126071432.21990-3-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 03:14:31PM +0800, allen-kh.cheng wrote:
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
