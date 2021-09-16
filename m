Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF640D379
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhIPGyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhIPGyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:54:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4901C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:52:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z94so12818200ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OdrM/iiRAa2mLO47fTc0KFXqouWSlZ3tYOWnNQ5Uftg=;
        b=lRqXZKvfx5Eb53QfCYoEl95vcbE+eNc3pSwPgef/T0VchMK9NciuhIG0KsfJGvS8P3
         Xq8/erbBt5XUHDAz3NrzckkDg2g4T9f9psWJmqpddh63NGTpEf+pZCOJR+lREHLtwF+i
         iHNbzxpd1sWZ5eBWITGO4VS6TeqlYPbW9oayMh7RnggHfQRl+Hj60Udwh6UKNeP79sJx
         n0bUDD8dvEf3Rzb5bhFJvj4hRs3nA3KM/PcP53pt2ylhNmH0AQ+GIzHxvOE6XgOt3GIq
         GZ/oznO7QH4uR8abGzNT36/58/iuhIOt9mlCGfxwLbvHuREMwyrZ99jqrwWxzCeF6WPX
         tuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OdrM/iiRAa2mLO47fTc0KFXqouWSlZ3tYOWnNQ5Uftg=;
        b=m6SxiWJYDfVQ1lhE5RtcJJm1UNFl3e3LQjwkvctedHrtkjE/b2/rM4eXYlqWlpa0Ss
         4QWbZY+xIzYezIIFVhONzg+AOm0s3zVeC2ayXRTS0aNcXCMuCRoihwD6pT5Ab6SzTacp
         jz2hInRABRTqK4DWmYHy5a+iPajpfs3SptMaQ2CT9il/blLZa8MneiSI5B8nKfCSDNir
         3P30r2wbfP7YwfmAMUdcN2gSZnOqGK5UpD0evSh1yPFlxEBW9uIr9WzrBPGTfBah6mn6
         Q2hmnkLiXZFdaEH60bSW4SJCQ9qD9czUK+dIjcIOUG4oMDPd/ozNQ3KMDyDs2QkMoMdZ
         +X1w==
X-Gm-Message-State: AOAM531NM31JosDrShcC2f+JKZ10IBj2oEraSvAqpiyUolmqs99cWAQm
        D4TsYe/ShvbWwawLrDJFoe4=
X-Google-Smtp-Source: ABdhPJzPY17v1/b6F1EtWmb+FNDwoylW2KlUq5kzL9L7Pyu2MPSqsMrNhUM9VxzLeKzBunSazRaqbA==
X-Received: by 2002:aa7:db4d:: with SMTP id n13mr4793605edt.398.1631775172585;
        Wed, 15 Sep 2021 23:52:52 -0700 (PDT)
Received: from agape.jhs ([5.171.81.56])
        by smtp.gmail.com with ESMTPSA id k6sm949201edv.77.2021.09.15.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 23:52:52 -0700 (PDT)
Date:   Thu, 16 Sep 2021 08:52:50 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] extcon: extcon-axp288: use low level P-Unit semaphore
 lock for axp288 register accesses
Message-ID: <20210916065248.GB1365@agape.jhs>
References: <20210910073440.2190-1-fabioaiuto83@gmail.com>
 <95e1aed4-944e-9e8e-f7b5-dcefb6e39147@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e1aed4-944e-9e8e-f7b5-dcefb6e39147@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chanwoo,

On Thu, Sep 16, 2021 at 02:14:35AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> If not critical, you better to write the patch title within 75 char.

no problem, will fix this

> 
> Regards,
> Chanwoo Choi

thank you,

fabio
