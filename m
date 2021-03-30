Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153A534E29F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhC3H4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhC3Hzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:55:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13451C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:55:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so908261pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/c3GASuuPMBQglyP8lkfmM8q4ruB4dYk26XBHy6dn94=;
        b=b/mKdnOi6RfiHabB6Qo0oOdn+udskSQkriHCYcOmDuR0e9x+J+Lkpi95iTeCGeGyZw
         YErIKP3SVb0AoWKzhk1JQN5MYa5aW9Mn3H1T3ioJLInLSjpT8sjHiob9p7ARpCoHi0g9
         EMdqELL+d77fv5s2tm2/l8TGsSvS4kDGTQHYi7EWKscq0oV0zCWt+ERW6YjkU7WzWx4J
         LyigO7vSLWvlarDbXAJUwp4i2ECASIy9ZP+2p90oQ9P8ANwHJKfik1utedQLn5avzzqA
         Hfnddw+F6zWvL1ZYtEtHHqTelSTtNheGDY188dW7I1FiF6wdd/KGuYHxHbJ8lCnt0gn7
         iyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/c3GASuuPMBQglyP8lkfmM8q4ruB4dYk26XBHy6dn94=;
        b=RGXaNhME6/iFnlB9JVazjWIn8JCkBwsRvGNMbNEBU7mEo5pnwjuQMuUeDVy/ihyoky
         OcDyml4TSoOHOA/3I6560l9cZMn77Aib6p0IBeuVERkLk0gi8iKWP9F/09cc1bonq2Zw
         XA0GU9jV3qjjYgAxmRulaxG40NOa+PFUCuhftU/YvJmWvL+uITtvUsBe3QP8e5DMu3ma
         EoxemzS4HiVwwLC/PFxxmr4NQUsrIqkreRoRpKhF+FjFsBjYPRkPctfUqcsUBLKMYasp
         fAwzPwWI8gHSAgd9W+noXeRm6sU3ieEiYVxo4HVj34a+mt+bqwfn5QpHwvA+2VjvBfqm
         9oBQ==
X-Gm-Message-State: AOAM533OcddBqTtAscMvzvq7WeAE9ro0CTuuMDvoeRgWrxlkvjprHX7w
        flWKNFUmbFOP1IzMqY56eBFuvVbexgWT0UILqHgABMZL6dewmQc7
X-Google-Smtp-Source: ABdhPJx+5pezFSSeWqNkADQyGDP8qtmVf0mbPcVYSfpv3XD7QsDX/2Vfnxo/gsmtGXbovQoH5Dkg+KL1Gks5TArbAw0=
X-Received: by 2002:a17:902:b088:b029:e6:e1d8:20cc with SMTP id
 p8-20020a170902b088b02900e6e1d820ccmr32129126plr.27.1617090949609; Tue, 30
 Mar 2021 00:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org> <1617067704-28850-8-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1617067704-28850-8-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 30 Mar 2021 10:03:58 +0200
Message-ID: <CAMZdPi9PujJ-ZC22TvOdyyG0g9k6G2z+LRx+drvhQn7GG-Fi0w@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] bus: mhi: core: Improve state strings for debug messages
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2FybCBZaW4o5q635byg5oiQKQ==?= <carl.yin@quectel.com>,
        Naveen Kumar <naveen.kumar@quectel.com>,
        abickett@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 03:28, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> As of now abbreviations are being used for many state and
> execution environment strings. Improve and expand those such that
> debug messages are clear.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
