Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59D532CE91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhCDIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbhCDIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:34:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2914C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 00:33:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e9so6389627pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 00:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vK6Lt8euuS8LNbKtC7Id3+j0iAnrBmyT5nqiNFGSlaI=;
        b=Cqgg7gGsyU8uRWO/DFpkff6fKBYjCKzePX33EjsPDWkQYATWodr4lr+Z7r6wR6Nv+G
         66hz3o85sJMvaSDz49GL5eGVMrxA3U5xpW4M/YpppFnNPtICfxd7Uy793TsnBW9FbpgC
         AixIc3Bo37r+qkTat2Zql4RSENpQNjnjI0Gt3xadmpBJWgTmHGZkQP6n5bkcZGvTcu9h
         0M/VUS7SoYH4dHsDroE0oEZWQvtDAVs6Nkggg4+hGqJEg3gjFE+pzTQD3lvz75qGFadB
         B7iXDXSZEz5yLMUt0CGQyfSerPH7Wi3+Y5beRaBqRah5tS5hR7jN7vRyO2EHhRdmWss0
         u+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vK6Lt8euuS8LNbKtC7Id3+j0iAnrBmyT5nqiNFGSlaI=;
        b=GSqRwrX0zS7NDyzwwSLPoKKlKa8+BbpN15VUkEc/o0q80b4R2TtwbIrDYcg6XIWh3o
         ewNlp0oKTRGOltS2/hW8OZ5shHXouYfBGt/Q2nUrydoHk5acNJ17Fl9jdGRPA2RvuaAP
         NFJMCz7UD8/e4gOSw1feKCj7O81YJJOVUDoyEb/aBMb5tMSGstnUl3PgDCqnp9NURoi/
         eF+ypfwWKFXMSHzagga2nKaOTY1lSS9vCr0RR8/6H31KGW9xqgyqbRzSTmdKrJ/TTx2F
         hBbQ0NmiCeI8btO8KEfG19B0gk/lVr9m/phFrEk+DCkuxkYyANifYTCXbUJeg8/W4Gun
         YabQ==
X-Gm-Message-State: AOAM533RVPaB/R5GXy6QirIMsNd6JTtHK47W2QH09YEG7t3KuTmDTs8r
        PLL28q6si4XjimXP05H85V41PRSvevQjrfq6ewJaY/0twmnz5w==
X-Google-Smtp-Source: ABdhPJwpVyWNISZE9LFWgFblMnlxdc8ClJrcBBvyNsSqmUamMjZT8dfLQRdFlxwe8z7C8zdPbWrockdM0TsIzYTdkVk=
X-Received: by 2002:a17:902:b697:b029:e5:d83e:3757 with SMTP id
 c23-20020a170902b697b02900e5d83e3757mr2779703pls.67.1614846813340; Thu, 04
 Mar 2021 00:33:33 -0800 (PST)
MIME-Version: 1.0
References: <1614208985-20851-1-git-send-email-bbhatt@codeaurora.org> <1614208985-20851-2-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1614208985-20851-2-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 4 Mar 2021 09:41:12 +0100
Message-ID: <CAMZdPi98VBe5R=zVv+bXyi44N2gsDa1WiYQk5oYHnsxRTfDMYA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] bus: mhi: core: Destroy SBL devices when moving to
 mission mode
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

On Thu, 25 Feb 2021 at 00:23, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> Currently, client devices are created in SBL or AMSS (mission
> mode) and only destroyed after power down or SYS ERROR. When
> moving between certain execution environments, such as from SBL
> to AMSS, no clean-up is required. This presents an issue where
> SBL-specific channels are left open and client drivers now run in
> an execution environment where they cannot operate. Fix this by
> expanding the mhi_destroy_device() to do an execution environment
> specific clean-up if one is requested. Close the gap and destroy
> devices in such scenarios that allow SBL client drivers to clean
> up once device enters mission mode.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
