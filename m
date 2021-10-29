Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65638440179
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ2RyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2RyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:54:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0533C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:51:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w8so9842651qts.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nMF1V6BCwjlzSpPh1jKw+VpyNLXokFgQZynS9/OsMg=;
        b=SZy3iI1x6UqOI0yZ46Lm4kpVmHNb0gTREnWO/KILOdRNn9W1nXXcEskLPaayzv8Dcl
         fBTJT4nZBAFtWCp+iJNFKPGJ7+ew3ofvWA1/k/uSTBeYsBSCUXY9DqSVbJQO5a0y3RfJ
         ZKZVWgE5jHAh3kbMiGUbI+8uw6n4E637EuJdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nMF1V6BCwjlzSpPh1jKw+VpyNLXokFgQZynS9/OsMg=;
        b=T1dALVkcCKWx0Hn73npXyrUrQKZ6dgyqxxLOmMnZceT7Z4myHnGIKmOcrXtLkKbAIT
         beWfHlmHohIVNyBs75rWBTTuit/pW0AYnewqU2srpvnu3xNAnxKPxiyYU6WiKfo7ggnX
         MQyqKB2llz5q4IBGJspb94XXTwp+QmUbXbcTXzKSsZyi5hT64hVKnuK9rrKH5WPsBLd4
         feEgFBpHVBduTQEHhFFcA17vaAZ0/xosJ2r71tLlQsktpgWPtcWcyY18M9Dz7KcrOCZd
         V7M/tXgdLmar/RWWQZ7RzfPTUEnzoFN57AMg5T6g0IsqVe6zqwmpa4D5iTA8xyTwekGr
         Cexg==
X-Gm-Message-State: AOAM530eLNExDla05fbBqDO3bOjh8sFa2Btwv3P/XWw2au5MN2isaiNB
        l7L7SmVD+T+4Yc2VQpbWMgpx8W7eRdq06OJrD+DS7Q==
X-Google-Smtp-Source: ABdhPJy/LIk2FlF3YFx6sUj9oMHMPK2rorcoFjhjLsoz/JSfc85V3sjXobjyqNSwBgJwZBwpBEEBcQUWg0sIxVKCktw=
X-Received: by 2002:a05:622a:4d2:: with SMTP id q18mr13590760qtx.84.1635529897819;
 Fri, 29 Oct 2021 10:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <3a8ea720b28ec4574648012d2a00208f1144eff5.1635527693.git.leonro@nvidia.com>
In-Reply-To: <3a8ea720b28ec4574648012d2a00208f1144eff5.1635527693.git.leonro@nvidia.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Fri, 29 Oct 2021 10:51:27 -0700
Message-ID: <CACKFLinnFQS3izf=GV1Zxzt3qVRj1nDzz7c5gXnWTRdLFeswOg@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Remove not used other ULP define
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:18 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> There is only one bnxt ULP in the upstream kernel and definition
> for other ULP can be safely removed.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
