Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8926345547B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 06:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbhKRF6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 00:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKRF6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 00:58:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F9C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:55:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q17so4281264plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+LR/apPrtZKwX6W08eJakocjLm3Seep1Fatf1AgQePE=;
        b=WczWOO1s1XTU4qJAIKd234QMOX1cq2L4vu4MeG5F0oiY0ZpKWJC9OrpLq+8JJqpEeB
         nGDoz8QYuloO/gaGIUc3NFyL5sPJU5eRawPT7FnaUHnySMUX8IMueKpOKpMMENQGQVN2
         VqZ3CvkiyTKzPG29KaIQVSwJzDxHf/dq4yyoHRArFNV1IS5iLXyAZvFqMaPeOgyVoYer
         qnSeCmnXvmmEKSWdBOTuLemf7Y3DgfNH1a9ilXjXpG8+SK6GUZ+geCR9C/cSnzur94SN
         KUXyZuFq5kc2O4oYQLQhJDw1DMB3R7fm4AYmZE/3nVk5jrKgsa40daUJw26YfSVW7/Qk
         3isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+LR/apPrtZKwX6W08eJakocjLm3Seep1Fatf1AgQePE=;
        b=rwhLSdLKIcqtLyhb9khTj24BwOAXcFo0gYzB1nmuiBODaTl0O9MiyiQtuylaSqCkfM
         acYRXEXy2Vp3G5p7tri27tceR6EFNzzN2AKEssgr/hQWlvu16G1HKEjwm1jvPsir7QYm
         u6/0pHRGpIyY1HfsryhmhrV1/ovdMzvBnI349QuGR4qFl6VWeMHqBqqLbN3v0QWI9eWK
         YayWKR53jZBGY/5IzTU8Ui4tN0jXV3UzDA1YfppAMVCQZ3SZKqfVwBT3GN1R5//3UFQV
         KmK86oTCM+UnxE3j5cInb/q9PBelxzZ1eabyDMdK6ru+HyzuyMU42IQjKSFR3wJ8MVZN
         0Obg==
X-Gm-Message-State: AOAM531ubZd6QOvQ/eIaLz6IFvQsr0Z+x0X2OCi1y8NoVLhkklKaaas4
        3KMzuH7Xa6m8QKhwpcYRysM8YQ==
X-Google-Smtp-Source: ABdhPJwQu46s7ekkE9XfTwzdQPD0BH1cjVXVpoAOyFEXdDui27VB7CUt0BHK6NpvxLu2wbCzqw6+Vw==
X-Received: by 2002:a17:90b:4a89:: with SMTP id lp9mr7478443pjb.6.1637214921042;
        Wed, 17 Nov 2021 21:55:21 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:8f8:11d:a96a:74d2])
        by smtp.gmail.com with ESMTPSA id j6sm1180718pgf.60.2021.11.17.21.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 21:55:20 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:55:17 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hsinyi@chromium.org, fshao@chromium.org, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
Subject: Re: [PATCH 1/3] mialbox: move cmdq suspend,resume and remove after
 cmdq_mbox_flush
Message-ID: <YZXqxaVANvrv53t3@google.com>
References: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
 <20211117064158.27451-2-jason-jh.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117064158.27451-2-jason-jh.lin@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:41:56PM +0800, jason-jh.lin wrote:

Typo in the commit title "mialbox: move cmdq suspend,resume and remove after cmdq_mbox_flush".

s/mialbox/mailbox/
