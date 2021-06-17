Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91A3ABC03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhFQSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhFQSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:45:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF048C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:43:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso5886591pjx.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyq5AgwNRarelbVfRJu9j7YFTw4ZYndkdd1MENGMpcM=;
        b=gWZpP3zIwfIurArUQbxL6x26k6M7NQMGOIoXhczSoFTIX4xSC63tPJIwWmXBQZNEv8
         lW0gkj3uUkR5MJwga3sRLggmt5RWp9pCYEenDsV2ZNARm8piT/1jTTELCoWIW7nKgSHt
         8PHT2Y5ldyNTLAulKlpHT3mEx8SuiatezkEwn3pzNLoyQfLNxdH26AUhQKv9cl8pVNLz
         ZA6lvwb0EZBYSU1nngjEfSlfLjbA8Ne7uPddGLMO3IwdyOXDlOjpLz0irregyDDYnv9h
         D8L2RpuxTDRKPAAqGt+F7OXA3lrgJ0q+oWoSGIVH4IHfVUedllnaY+OkUzoeTvPdCQ0y
         52/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyq5AgwNRarelbVfRJu9j7YFTw4ZYndkdd1MENGMpcM=;
        b=UMeXI+HJboJ0NgswOPOeIuSR9SzTStgZEmmr85TBxyHEq9PMQvr+JtY5v7ZShX+eNg
         g6F/ssw0LuefPTjYKim4hHnUW8QXLWvCc/7Y+sbg6apyz8V5XB3TtCnTBQjmArMCJtav
         8rfPvP8tpnBqfwRq4IM7R41XKYc1iTwx+xlK900T6Yo109q2tPQa7Q5vN6+NfHCFHNAX
         uS/CS+aSZpidm9DczpU2/saDAq/RKkn2SEq3bZh5k1ouJ17m8mrwjuXP59BQ3McZLrsC
         nWiWFIwuEKdhpb/UNQ5TbHcir/yT7N2Y3vBIudNRM0N4c8hmdfo35UXb0r1W0CIpPo3H
         3UXQ==
X-Gm-Message-State: AOAM532CdbhEXFQHDNh2+Z2IbyT6VogTTiiM0eIa5cBN7xlwM+2MfaP8
        Bjdrkjl1yAn5wum3uMw9K9pcx+lR08FkY8JqCqOWiMkeQNw=
X-Google-Smtp-Source: ABdhPJwaFJAmgOEgRjD4cfEhmU2a7t5ghngCbSCJl04mt6VLW3ywaJLVGu0DAyE8Tgaw+glmV72oZ6LAJ0ypfw30jJM=
X-Received: by 2002:a17:90b:1bc4:: with SMTP id oa4mr6993795pjb.18.1623955408330;
 Thu, 17 Jun 2021 11:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <1623954233-32092-1-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1623954233-32092-1-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 17 Jun 2021 20:52:26 +0200
Message-ID: <CAMZdPi-r5CiuPT9vR+Pt3Q0nvy31m_NXW7fb7yJ3jPBSQBVH9A@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci_generic: Apply no-op for wake using inband
 wake support flag
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2FybCBZaW4o5q635byg5oiQKQ==?= <carl.yin@quectel.com>,
        Naveen Kumar <naveen.kumar@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 20:24, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> Devices such as SDX24 do not have the provision for inband wake
> doorbell in the form of channel 127. Newer devices such as SDX55
> or SDX65 have it by default. Ensure the functionality is used
> based on this such that device wake stays held when a client
> driver uses mhi_device_get() API or the equivalent debugfs entry.
>
> Fixes: e3e5e6508fc1 ("bus: mhi: pci_generic: No-Op for device_wake operations")
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
