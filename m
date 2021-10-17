Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6899143099F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbhJQONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhJQONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:13:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F7C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:11:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so59864798edc.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFCZcjfiwZ8em2bIUvohm03NYCpTEjorljOS0YSyBrY=;
        b=jyL+eQd1lDG5gD4XlP4OaD12opfHM0/RsKh49LhSGymnyGvYmVc3aog7skDbwDMQ1k
         d9Q6mJtHDKPo6RS3CrnPtE5yTpy+n5yoNWjC+tKaKd7BBREgYiqqf4WAfOhfGa+tgaf1
         Ncmiq1nqZb7rN32XwAwQuIuZbBhfe4TIoI2zumppHmYvyuMVIm2oIyn2g9eHJGe/xJBo
         MQH3jdIv/9y7oF5gLSX3yN40/fr29lR7atjxc6er9AYY3/fiQstlpcD7JrZDLaLdnGSC
         srUlMpXMemnWZmCN4ySrPEKreMxAq7wpCXPdE4sC327BKczBI+JQTFHZjWy3GsE9eDSv
         oPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFCZcjfiwZ8em2bIUvohm03NYCpTEjorljOS0YSyBrY=;
        b=LHsyPFUBdDxt0msz76xMOM2W3LMdewVPPZkZT6iGHaQgBPs2BpQ40H4vyeS/ygjPB6
         /PiFxzVxVMAp4g4+hzjxVQsK4r/pfd0q8qJb2JnBqWK52lAHje16y8cHfSiZID3DX1tZ
         NuGy1mR5w3tOHOyAgTBxWkwv8b5PaTY1U0Tl8PAksbM7ugBVt3T8hwsgsDts6bKqk1oe
         p+W8MZlssVhsG/N3NYWJeWEkUOc8NRikks+yHeUeuWrAtBhm04ZwUTEMe99bIX/Sm/Lg
         y00ubnsalHHC8X+EbQTVzKZSs6Zc4DxDiF6yZxf9bbg6IuatkpKNVwg5lYMstz3FXDc9
         xmDA==
X-Gm-Message-State: AOAM530QK6veTm39/e+4EfskC4Om02kHOvJqkjp67vgtWHOHICXkXuRg
        Ms8nxBzLX5Z1XQVNxX69iTQ=
X-Google-Smtp-Source: ABdhPJyHNZPrGHC30R/aqnz+L0gTWqrzvLrTbxGZUrLAyZRwf+G70fgxJ1IXej/lgcvXNUoIsnA0MQ==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr36321575edz.304.1634479896562;
        Sun, 17 Oct 2021 07:11:36 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id u2sm8109222eda.32.2021.10.17.07.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:11:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: don't accept SIGTERM for cmd thread
Date:   Sun, 17 Oct 2021 16:11:14 +0200
Message-ID: <2278807.iFymIpo3Sk@localhost.localdomain>
In-Reply-To: <14217682.9BgDuDnfkJ@localhost.localdomain>
References: <20211016181343.3686-1-martin@kaiser.cx> <YWv67ozbJGxMa69t@equinox> <14217682.9BgDuDnfkJ@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 17, 2021 3:14:49 PM CEST Fabio M. De Francesco wrote:
> On Sunday, October 17, 2021 12:29:02 PM CEST Phillip Potter wrote:

Please disregard this email. It's a duplicate due to some weird crashes of 
KMail.

Fabio

> @Phil, Correct.
> @Martin, Please correct me if I'm missing something in what follows...



