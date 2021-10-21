Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7418436AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJUSmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhJUSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:42:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C77C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:40:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d13so1629705ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=9wIvFY66/uQWTspqneatru5hG7uYgyRnzp2YO0R4wtk=;
        b=G3z7ykO4X+E851ch43bnUaOUol+AD2Au4q7+vF6L6OnedzItcq6j+AyjMJZXgsAm5G
         4NgVlSpK4iGvkeRhMO9xAtHEGdamb8cY8PdA+i1c+0A5VFd2nzixjtDM1AQC22Rs+rEH
         bUBS1kF+LNZPPSXCD2ajaZyd0w2InOGOf1TuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=9wIvFY66/uQWTspqneatru5hG7uYgyRnzp2YO0R4wtk=;
        b=c9QF+PYFlnzKoDLZBpTUeg05a4LU86UDND7hAyMytRa+GfphSHFH5b0YrgBcxgx+ZX
         p6XdEkiP/f6b5afbsinUUFArf2MT5CVvN9Btq8xMBiKucUuI6zbTz7rKMpbP99Uk5lZc
         5ZhHIrP6ThQRA2GLEquPMwEj7NSrqqWhbL9/azECVdzbcvw3rZ2gpWMf1LytM5pjRyD+
         9PX7ThGb3t1QI7dmmEOpda0VRB9huYYm6JK1AbeFuLwlYSYZzhaEIUf/iHJEhTBxP6vm
         ftRtZFa3vZ3RpJxmbCXiG3DdE7nAqZYdgxP4W4DrJtZr6LE5a4zWOJ7ezucoRk/6uWzg
         RcKA==
X-Gm-Message-State: AOAM532LDzUAXEcvfq5L5wNyt6qvechAeELHHYmjjJjG81AeiXHdYYC+
        vZFYKyExC9r8WS7XAGCWeDKZxBnbG/H6nkxYRxFulA==
X-Google-Smtp-Source: ABdhPJxRC3Uf92k15ghzxzXlSSeSrHGQSqtbHF/z5u6aHclpYNvhUUJfMMIi/ktRjLpdoaeaGzmBSam4G9bujYQeCd4=
X-Received: by 2002:a2e:4e1a:: with SMTP id c26mr7489198ljb.351.1634841609244;
 Thu, 21 Oct 2021 11:40:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Oct 2021 11:40:08 -0700
MIME-Version: 1.0
In-Reply-To: <1634738333-3916-2-git-send-email-quic_mkrishn@quicinc.com>
References: <1634738333-3916-1-git-send-email-quic_mkrishn@quicinc.com> <1634738333-3916-2-git-send-email-quic_mkrishn@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 21 Oct 2021 11:40:08 -0700
Message-ID: <CAE-0n52Me9UkR2Fk=x7QKxNy8PdjB8xPNsp3h=gN1ubMEgyzDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sc7280: add display dt nodes
To:     Krishna Manikandan <quic_mkrishn@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kalyan_t@codeaurora.org, sbillaka@codeaurora.org,
        abhinavk@codeaurora.org, robdclark@gmail.com,
        bjorn.andersson@linaro.org, khsieh@codeaurora.org,
        rajeevny@codeaurora.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna Manikandan (2021-10-20 06:58:51)
> Add mdss and mdp DT nodes for sc7280.
>
> Signed-off-by: Krishna Manikandan <quic_mkrishn@quicinc.com>
>
> Changes in v2:
>   - Rename display dt nodes (Stephen Boyd)
>   - Add clock names one per line for readability (Stephen Boyd)
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
