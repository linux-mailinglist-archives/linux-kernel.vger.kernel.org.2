Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39173C1CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 02:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhGIAjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhGIAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 20:39:15 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DEC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 17:36:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso7697261otq.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=tuF3IuVNzqSNHva85jiAQLO3B1aho/MneB4ZBDZXRy8=;
        b=jpIHei6yaeR9akW+Y2UzwS3BRvAlIRfRrFNZhvlYnqWDx7G9nDGozYWuVtpWL/BHM3
         AfduFwh+mXRuS511r5CPbsQLpr3d+wy4/CKTpAB0UONTXs6Umz++imz9TOtz+faqMw3e
         A8AwypOmuQO/6PYrPosJ0P+dgDSl0gaE8YheE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=tuF3IuVNzqSNHva85jiAQLO3B1aho/MneB4ZBDZXRy8=;
        b=Bzz4/zboydoc7uRO3ZlrilJMhtD8hcTNYUNFdyfPmuy0prokhwt5g2XD2CQMCJxtQe
         EzUe6HZdrjXrkk5D+VpkyZO270OgJsTBgTEi7oZBZs8nBYnvDA4N3sdrTBZ1nHaRFmlX
         qp2QcAIG91Lc6ZLL+4kAH/gBSEngCPIuMKZD5Jb789TU8I3digjDIagcjCwGUc5Lnrhc
         lbKylTnP7ak/nRjdw28bzUdxMTJonLldQ8KI4aZIHg4N+PxLK1UaXS9u80lrlFwo/sc8
         hPfvDXK55SGk2yD+15CYXAxcDPPhAW1cSnmSJqxvJ3XPfEHBEr/6iXo2wRbGRjv8hlbG
         9Lqg==
X-Gm-Message-State: AOAM533NSpZEW0dKxQzf5FHiVa4k0ovVKNpndLPtvQ4QxxNZh2+3gWLT
        HXpcsQrOAL2W0MLcZac5WIMsUq0Ef7WDzt5hrVnDEg==
X-Google-Smtp-Source: ABdhPJx8hj2gTCj9PYRTgACjYv7kxabHym1eg1FH9L7bh5Agk44u+REO6GOw2ek1V3BqEZO2n50wOS9SKzQHTosBO2I=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr26372930otf.25.1625790992061;
 Thu, 08 Jul 2021 17:36:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Jul 2021 00:36:31 +0000
MIME-Version: 1.0
In-Reply-To: <1625576413-12324-4-git-send-email-sanm@codeaurora.org>
References: <1625576413-12324-1-git-send-email-sanm@codeaurora.org> <1625576413-12324-4-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 9 Jul 2021 00:36:31 +0000
Message-ID: <CAE-0n520agdVS4H9Lfrs8agF4T6+P8665YTXjWcr_aqEDcRy4Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: sc7280: Add USB nodes for IDP board
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2021-07-06 06:00:13)
> Add USB nodes for sc7280 IDP board.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
