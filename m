Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A63EF893
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhHRDc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhHRDcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:32:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AC5C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:31:51 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id o20so2466561oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WN4dMj5d20fATkNAOc2ycF2zHpaO1GPJJSRhHXja7SE=;
        b=eJhaLJfma1JQ5TUG+s2ia19ac669B2P5fCw2l5SDt2KfGVOg1G/GKqJAYkhZzznN9Q
         UvWMan8aRQfSlT7BNpfBpHgxCWb0o9zNEXZ1uXG7A8CFAbmqDYq217zaJ9MQYYEYV4kk
         Bf0KiLDGuI7NTTpmQUBmgeAinkn3u+emo+SMlcq3UxJ+aJKECzaO2YWSZsE3F1Im+oGa
         qf3qq9JDCN6Mac93pWOo7YsLJDQKaN3JG+kpPj15+HiCxJfTFrGUCv+BD9uyry//6hh9
         qFSX12EoEuSVqSYU5RDr0SrjRWdF+ov9DvIZHpjGWSfj7IuFAgJ+S8j7B9qX2QQ/9KA5
         rWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WN4dMj5d20fATkNAOc2ycF2zHpaO1GPJJSRhHXja7SE=;
        b=Lf5SBdKiXC1q21AFvvJoAP8QZH9KlUfd80I9XYNtpvo3cqETgjvAgLYQt5VBFpUNmS
         QQc3Y0pBmxDQd7vLaOTzjNYxX4mz/0INPVTz0TVDoR2hAK9E7UaoHhUy6wI6N3ic7JEI
         eO+a25oqEU1zCYeVYCGXRVbiTsPLRpqdPvPAVcMdPHLf2gYcSUre0hWlk1VeFgwibG9o
         uw1b0q7Pye8tPbtAAgZ2vdfj+0EFamASWlNGrrEUvm1F0OT2MZGMKdTa35+Pl8QJPWsm
         WEg0YHs/889/vqGqrGaTm8OXWToURhQeKHykiC9EOVZRmubbQtkYlRoSgoMiTeIMZp2V
         qbmg==
X-Gm-Message-State: AOAM532knjtd1JzDy1xBLIJfd8idMuj9QamKvPI/9lIfFyCEjy5oyelv
        cJS1snaE3luMNo+c6Ett4Se2NA==
X-Google-Smtp-Source: ABdhPJzgyuYUy7LVLHvBOog++sY2NASP245ebr4tWB0Ur51NO1QI5VJ1GtOePi85x+y/FKUpgfHKfw==
X-Received: by 2002:a05:6808:2020:: with SMTP id q32mr5157063oiw.30.1629257510865;
        Tue, 17 Aug 2021 20:31:50 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q187sm1026923oif.2.2021.08.17.20.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 20:31:50 -0700 (PDT)
Date:   Tue, 17 Aug 2021 22:31:48 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] interconnect: qcom: Add MSM8996 interconnect
 provider driver
Message-ID: <YRx/JFLXHvIlKgOR@builder.lan>
References: <20210811043451.189776-1-y.oudjana@protonmail.com>
 <20210811043451.189776-6-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811043451.189776-6-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Aug 23:37 CDT 2021, Yassine Oudjana wrote:
[..]
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
[..]
> +DEFINE_QNODE(mas_cnoc_a1noc, MSM8996_MASTER_CNOC_A1NOC, 8, 116, -1, true, -1, 0, -1, MSM8996_SLAVE_A1NOC_SNOC);

Unless there's strong reasons against, I really would like for us to
follow sc7280 and avoid the DEFINE_QNODE() macro for defining the nodes.


That said, I really appreciate your work on bringing us an interconnect
provider for MSM8996!

Regards,
Bjorn
