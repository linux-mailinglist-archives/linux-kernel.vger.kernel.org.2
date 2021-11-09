Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36D44AC0C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245489AbhKIK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245470AbhKIK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:59:41 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EC4C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 02:56:55 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so30247486otf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGtrT+gnnpsR0/gVYlOIaWpMhonGwBEUrxBXQSHrjhU=;
        b=NIl34nVU4mG/qNE+35FGntC+uTk/zkkV7JBjLzvzXUNEjWb64bvqJzP83W40Q6qrrj
         mIXsXwEX3p0BRDfLOob3dDi9zOBjCJUDAhv0PZN1N8pl4Xc9tXaHxiOx9daTafWdsen8
         HuyOR6Lmtft2JQhH9QS5+OP80VeSlH7PzdyEwECdXz2siyhAsqsWwNhERdeD/SqKrd+m
         F0U6ipagYbbBCsNjHxMW1b5qYOIYbzuQRB9N/CLWZVzGaDDZWFoPyr/X2iiK4UrJBTRV
         Oguwx7oUNwN3CklUNN+YLN6t4zLA5HE0qZWJ2jXfWj08RB+cBvvndsh300WthoUsdcr2
         x58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGtrT+gnnpsR0/gVYlOIaWpMhonGwBEUrxBXQSHrjhU=;
        b=Nn9/Pl30czMLnfLwh+hyswfmlL3BU44vdTNzTz3INI6+kqUjyZK/5BVJ68/aYSgImU
         rzBVnpCi1CxkQYHVlxRGrhsSh/1JGR3z7+77T5zX7K6aLO/thQotE7JUcEClc+TAP1c9
         YHU2CX8pji8A3ZxM0GNO5YNk9tvJXUQRKoe9beh+mrAj8Tgj4s5yzd+ILCDblQNfHkKJ
         sncwLjqXqVevkm2h0wW2GxpJUhKBi4GqMcxyb4c9UzS8p8aUCPOW4hPBWD9v8mltIKRM
         SPNVUDvY0BZfwaoIHweUyfvoIVs8xtbd1fz6GptBn9jumxV0ZyJTkuqXc2DERJCQf/wA
         m2aQ==
X-Gm-Message-State: AOAM530wyhMvO5HW1KtkHWvL+B2Nlg1wVCO+PJvodEF8sMEsuk26B0rp
        5KfklS4rX4eoeIXwGJG65ybdcDADwvAk+/17XDEAJg==
X-Google-Smtp-Source: ABdhPJw1vDnzJxJSL3+aJKMbdb8O/s8SxhL6LE4Xs5UeZxJAC981kXaeEazfyqWtipnMjgFbO0RnWP5BVqUnDbWPfGY=
X-Received: by 2002:a05:6830:2809:: with SMTP id w9mr5074019otu.237.1636455414603;
 Tue, 09 Nov 2021 02:56:54 -0800 (PST)
MIME-Version: 1.0
References: <1635552191-16505-1-git-send-email-quic_vamslank@quicinc.com>
In-Reply-To: <1635552191-16505-1-git-send-email-quic_vamslank@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 11:56:42 +0100
Message-ID: <CACRpkdawbTdb4BsvKVn_oSs1Az9PPXG=MqoqtSRtx=ftQU54_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add pinctrl support for SDX65
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 2:03 AM <quic_vamslank@quicinc.com> wrote:

> Changes from v2:
>  - Addressed comments from Bjorn
>  - Collected Reviewed-by for the patches

v2 looks good to me and I think there is timeout if anyone wants to
look at the DT bindings so I want to merge this, but it does not
apply to Torvalds master.

Can you please rebase the series on v5.16-rc1 when it is out
(should be monday) and resend?

Yours,
Linus Walleij
