Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC02543515A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJTRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhJTRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:36:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDBC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:33:52 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so7336134ott.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdaRz+/HIqoZ+D6ASe4LTEi6mTmOeWkSvY06s8Isgz0=;
        b=dxr9ZT1SPRYkdpGZIuvRMH2pBK3dL8EwUNYym6mFO4Zteaqbxx45lA4PG5/RqNnACG
         aqlkFhP6xgZ8zOz9Hw+Rg1pIdSF7d41jbaI+QJzqSgtDqI0lz3L+8cS3Vou1Q9ah4Qyt
         BJxnV7DRjHZvXSXYNOuhPXGh4Bnp17F2LUU2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdaRz+/HIqoZ+D6ASe4LTEi6mTmOeWkSvY06s8Isgz0=;
        b=QhrRl24y4J8/6jJSUS77mNkYVX0Jlv9gQGT2VUbBIOe64pudjdW1sfLHtRmWQzU/qc
         vQLOiCcaxr4lsa1NiUvbsw6dbOkml55ZkWRzOee7a1QbfCf9SpikRPcYp3uj0LwW5Al+
         ENRvWELORJaMppnBXGm+jUyjTCnemFA3ZXf5pkiVbu2yzhdKKhON4JacI1GtX3QDbfT7
         AzIn/03pre6lgMFXQLkUbFZyk10h4nqhpX3vxoSoHdu787Bf1RSrtnJLL9B54FyST9Lp
         mEJFIRPoBfN+io0q0hHwf3V1LHXv5PItDePM6fupKdFUdDAzDI+94K9Fh/Nh7w5p/riF
         drAA==
X-Gm-Message-State: AOAM533Hq9GvaCrW6F6M8rX42m6xBbfHENuGfnZbpoIg/ycBd103otgU
        El0dyqiFIy/hDDXG+9x6hv51DipmT3t1BQ==
X-Google-Smtp-Source: ABdhPJzcUzCyXivefvAIY8HODLQ750k6TE27Iy9y5JVJswFjk6wdCJ03fK2XpnodZbuq3112pdp3cQ==
X-Received: by 2002:a9d:7153:: with SMTP id y19mr502331otj.41.1634751231375;
        Wed, 20 Oct 2021 10:33:51 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id 3sm563768oif.12.2021.10.20.10.33.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:33:49 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id v77so10535354oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 10:33:48 -0700 (PDT)
X-Received: by 2002:a05:6808:1892:: with SMTP id bi18mr621637oib.105.1634751228418;
 Wed, 20 Oct 2021 10:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211020120345.2016045-1-wanghai38@huawei.com>
In-Reply-To: <20211020120345.2016045-1-wanghai38@huawei.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 20 Oct 2021 10:33:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNUY_HevQm12Q0MZrYzcbb7br94xO6fkuFi0EuzdV_LjQ@mail.gmail.com>
Message-ID: <CA+ASDXNUY_HevQm12Q0MZrYzcbb7br94xO6fkuFi0EuzdV_LjQ@mail.gmail.com>
Subject: Re: [PATCH v2 wireless-drivers 0/2] libertas: Fix some memory leak bugs
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, shenyang39@huawei.com,
        marcelo@kvack.org, linville@tuxdriver.com, luisca@cozybit.com,
        libertas-dev@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 5:04 AM Wang Hai <wanghai38@huawei.com> wrote:
> This patchset fixes some memory leak bugs by adding the missing kfree().

You could probably just as well switch the kzalloc()'s to be
devm_kzalloc()'s, but either way works I guess.

Reviewed-by: Brian Norris <briannorris@chromium.org>
